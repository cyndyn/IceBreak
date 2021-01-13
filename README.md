** Reupload from private gitlab repo **

# icebreak

The official icebreak flutter application

## MobX

This project uses the [MobX](https://mobx.netlify.app) library for state management

MobX uses code generation to produce needed files. To generate these files, enter the following to the terminal at the root of the project:
- `$ flutter packages pub run build_runner build`
or
- `$ flutter packages pub run build_runner watch` to have the files automatically generated on save.

If an error occurs while generating the files, add the `--delete-conflicting-outputs` flag to either command above.

Instead of typing these commands out everytime, you can add the following aliases to your `.bashrc` or `.bash_profile`:
```
alias mobxgen="flutter packages pub run build_runner build"
alias mobxwatch="flutter packages pub run build_runner watch"
alias mobxgen_delete="flutter packages pub run build_runner build --delete-conflicting-outputs"
alias mobxwatch_delete="flutter packages pub run build_runner watch --delete-conflicting-outputs"
```

### Useful tutorials and resources:
- [Android Studio Setup: MobX Store Live Templating](https://www.youtube.com/watch?v=fJ6BT6Ojxcw)
- [Counter tutorial (beginner)](https://mobx.netlify.app/getting-started)
    - [Youtube Tutorial](https://youtu.be/p-MUBLOEkCs)
- [Core Concepts](https://mobx.netlify.app/concepts)
- [Todos tutorial (intermediate)](https://mobx.netlify.app/examples/todos)
- [Reso Coder Flutter MobX Tutorial (article and video) (intermediate)](https://resocoder.com/2019/12/26/flutter-mobx-tutorial-transparent-reactive-state-management/)
- [MobX Store Organization](https://mobx.netlify.app/guides/stores)
