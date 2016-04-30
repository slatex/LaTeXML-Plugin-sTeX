# Profiles
Profiles are used during `latexmlc` startup time to preload stylesheets and specify some other options such as the post-processor, package options and source tex formats. Specifying a profile when processing many different files can accelerate the transformation process.

# Usage for different profiles
* `stexml`: for a stand-alone stex document into an xml file.
* `stexml-module`: for stex documents that are separated into `pre.tex`, `content.tex`, and `post.tex` into an xml file. The profile
also preloads the stylesheets.
* `stex`: for a standalone stex document into an omdoc file.
* `stex-module`: similar to texml-module, stex-module is for fragmented stex documents into an omdoc file.
* `stex-smglom-module`, `stex-omdoc-modules`, `stex-slides-module`: for fragmented `smglom`, `omdoc`, `mikoslides` class stex into
omdoc files
* `migration`: for a stand-alone stex document using the `migration.xsl` postprocessor.
