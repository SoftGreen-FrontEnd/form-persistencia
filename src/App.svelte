<script>

	let past;

	// this function fetch the information to supply the form 
	const fetchResponse = (async () => {
		  const response = await fetch("https://json-static-api-eight.vercel.app/formSupplier.json")
    	  return await response.json()
	})();

    // get the json that is returned when the onBlur in inputs is activated
	const postValue = (async (term) => {
		const response = await fetch(`http://localhost:8080/form/retorno.jsp?term=${term}`)
		const retorno = await response.json();
		console.log(retorno);
		if(JSON.parse(retorno.status) === true){
			document.getElementById(retorno.field).innerHTML = retorno.value;
		}
	})


</script>


<main>
	{#await fetchResponse}
	    <p>...waiting</p>
	{:then data}
	<div>
		<form>
		<fieldset>
		<legend>{data.name}</legend>
	{#each data.datasets as {label, type, value, placeholder, options, status }, i}
		<label for="job">{label}</label>
		{#if type === "select"}
    		<select on:focus={(e) => past = e.target.value} on:blur={(e) => {
				if(past != e.target.value){
					postValue(i+1);
					console.log([{"name": label}, {"value": options[e.target.value].label},])
				}
			}}>
        		{#each options as {label, value, selected}}
        			<option value={value} selected={selected}>{label}</option>
        		{/each}
    		</select>
    {:else if type === "checkbox"}
    	<input type="checkbox" on:focus={() => past = status} on:blur={() => {
			if (status != past){
				postValue(i+1);
				console.log([{"name": label}, {"value": status},]);
			}
		}} bind:checked={status} placeholder={placeholder}>
    {:else if type === "textarea"}
    	<textarea bind:value={value} on:focus={() => past = value} on:blur={() => {
			if(past.localeCompare(value) != 0){
				postValue(i+1);
				console.log([{"name": label}, {"value": value},]);
			}
		}} placeholder={placeholder}></textarea>
    {:else if type === "text"}
    	<input type="text" bind:value={value} on:focus={() => past = value} on:blur={() => {
        	if(past.localeCompare(value) != 0){
				postValue(i+1);
				console.log([{"name": label}, {"value": value},]);
			}
		}} placeholder={placeholder}>
    {:else if type === "number"}
    	<input type="number" bind:value={value} on:focus={() => past = value} on:blur={() => {
			if(past != value){
				postValue(i+1);
				console.log([{"name": label}, {"value": value},]);
			}
		}} placeholder={placeholder}>
	{:else if type === "radio"}
		<input type="radio"  value={value}>
    {:else}
    	<input type={type} placeholder={placeholder}>
    {/if}
	{/each}
		<p id="total"></p>
		</form>
	</div>
	{/await}

</main>
