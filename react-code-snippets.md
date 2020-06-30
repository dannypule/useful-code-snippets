React code snippets

### File upload

```tsx
const inputRef: RefObject<HTMLInputElement> = React.useRef(null);
const [uploading, setUploading] = useState(false);

const handleUploadClick = () => inputRef.current?.click();

const handleInputChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    if (!e.target.files) {
      return;
    }

    setUploading(true);

    const file = e.target.files[0];

    try {
      await doSomethingAsync({ file });
    } catch {

    }

    setUploading(false);
  };
  
  {!uploading && <input ref={inputRef} type="file" hidden onChange={handleInputChange} data-qa="fileUpload" />}
  ```
