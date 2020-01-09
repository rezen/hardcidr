# hardcidr
One thing annoying about [hardcidr](https://github.com/trustedsec/hardcidr) is the args are set via prompts. This remedies that, adding a script that makes the args settable via environment variables.

## Usage
```sh
cp .env.tmpl .env
vim .env
docker build -t hardcidr .
docker run -it -v $(pwd)/data:/tmp/ --env-file .env --rm hardcidr /app/hardCIDR_env.sh
```

## Variables

- `ARG_ORGINPUT` Name of organization  
- `ARG_EMAILDOMAIN` Domain for organization  
- `ARG_CCUSED` Use country code? (Y|N)  
- `ARG_CCPOS` Country code position  
- `ARG_OVERWRITE` Overwrite data  

