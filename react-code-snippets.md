React code snippets

### File upload

```tsx
const inputRef: RefObject<HTMLInputElement> = React.useRef(null);

const handleUploadClick = () => inputRef.current?.click();

const handleInputChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    if (!e.target.files) {
      return;
    }

    const file = e.target.files[0];

    try {
      await doSomethingAsync({ file });
    } catch {

    }
  };
  
  <Button onClick={() => handleUploadClick(fieldName)}>
    {t('ssl_manager.uploader.upload_txt_file')}
  </Button>
  
  <input ref={inputRef} type="file" hidden onChange={handleInputChange} data-qa="fileUpload" />
  ```
