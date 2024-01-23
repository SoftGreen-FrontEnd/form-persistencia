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
	<div >
		<form>
		<fieldset>
		<legend>{data.name}</legend>
		{#each data.datasets as {label, value, placeholder}, i}
		<label for="job">{label}</label>
		<input type="text" bind:value={value} on:focus={() => past = value} on:blur={() => {
			// compare if the past value is different from current so it can send to the data base
			if(past.localeCompare(value) != 0){
				postValue(i+1);
				console.log([{"name": label}, {"value": value},]);
			}
		}} placeholder={placeholder}>
		{/each}
		<p id="total"></p>
		</form>
		</div>
	{/await}

</main>