# mypost
```
curl -s  https://raw.githubusercontent.com/citaty-svyatyh/mypost/master/post_install.sh -o post_install.sh && sh post_install.sh
```

## REACTJS

Чтобы заработал eslint как в атоме надо прописать в папке проекта, в файле package.json 
Вроде это уже по умолчанию есть.
```
  "eslintConfig": {                                                                                                                                          
    "extends": "react-app"                                                                                                                                   
  },
```

## JQUERY
Надо добавить в .eslintrc.js  следующие строки
```
"env": {
  "browser": true,
  "commonjs": true,
  "es6": true,
  "jquery": true
},
```
И возможно, но не точно поставить: https://github.com/jquery/eslint-config-jquery
