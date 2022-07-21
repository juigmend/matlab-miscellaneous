# Matlab miscellaneous

Miscellaneous Matlab code. It might also work in Octave.

## Description 


<ul>

<li><a href="software/novelty_2D_DEMO.m">Novelty 2D Demonstration</a> 
Shows the computation of a novelty score from a two-dimensional signal. </li>

<br>
<li><a href="software/diagonal_convolution_kernel_demo.m">Diagonal Convolution Kernel Demonstration</a> 
Convolves a kernel along the diagonal of a matrix, for example to obtain a novelty curve of a distance matrix. </li>

<br>
<li><a href="software/gaussian_tapered_checkerboard_kernel_2D_demo.m">Gaussian Tapered Checkerboard Kernel 2D Demonstration</a> 
Computes a Gaussian Tapered Checkerboard Kernel. </li>

<br>
<li><a href="software/find_peaks_DEMO.m">find_peaks_DEMO</a> </li>

<br>
<li><a href="software/mcwinxcorr.m">mcwinxcorr</a> 
Computes windowed cross correlation of two signals. Useful to measure drift between two measurements made with different devices. 
This function is compatible with the <a href="https://www.jyu.fi/hytk/fi/laitokset/mutku/en/research/materials/mocaptoolbox">Mocap Toolbox (open source, download for free)</a>.</li>

<br>
<li><a href="software/downsampling_data_demo.m">Downsampling Data Demonstration.</a> 
Downsample data with different methods and measure their computing time. 
<a href="software/accel_test_100Hz.txt">Download testing data here. </a></li>

<br>
<li><a href="software/projection_3D_to_2D_demo.m">Projection 3D to 2D Demonstration</a> 
Projects data in 3 dimensions to 2 dimensions, for example motion-captured position. </li>

<br>
<li><a href="software/nextbase36char.m">nextbase36char</a> 
Counts in base 36 (letters of the English alphabet, then digits from 0 to 9). </li>

<br>
<li><a href="software/nextbase26char.m">nextbase26char</a> 
Counts in base 26 (letters of the English alphabet).  </li>

<br>
<li><a href="software/avoid_nested_loops_DEMO.m">Avoid Nested Loops Demonstration</a> 
Shows an alternative to compute nested loops. It uses a while statement and dynamic indexing instead of 'for' loops. 
This makes it easy to resume the process if the program is halted.  </li>

<br>
<li><a href="software/waitbar_DEMO.m">Waitbar Demonstration</a> 
Shows how to make and format a wait bar in nested loops. </li>

<br>
<li><a href="software/change_filename_extensions.m">change_filename_extensions</a> </li>

<br>
<li><a href="software/maketimestamp.m">maketimestamp</a> 
Produces irrepeteable numbers based in system clock, with minimum interval of one second.</li>

<br>
<li><a href="software/AR_file_loader_v0.1.m">Audiofile Rating File Loader</a> 
Reads files produced by <a href="software/Audiofile_Rating_v0.1.2.pd">Audiofile Rating</a> into a Matlab matrix.</li>

</ul>
To make it easy for you to get started with GitLab, here's a list of recommended next steps.

Already a pro? Just edit this README.md and make it your own. Want to make it easy? [Use the template at the bottom](#editing-this-readme)!

## Add your files

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://gitlab.jyu.fi/juigmend/matlab-miscellaneous.git
git branch -M main
git push -uf origin main
```

## Integrate with your tools

- [ ] [Set up project integrations](https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/settings/integrations)

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Automatically merge when pipeline succeeds](https://docs.gitlab.com/ee/user/project/merge_requests/merge_when_pipeline_succeeds.html)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/index.html)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing(SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

***

# Editing this README

When you're ready to make this README your own, just edit this file and use the handy template below (or feel free to structure it however you want - this is just a starting point!). Thank you to [makeareadme.com](https://www.makeareadme.com/) for this template.

## Suggestions for a good README
Every project is different, so consider which of these sections apply to yours. The sections used in the template are suggestions for most open source projects. Also keep in mind that while a README can be too long and detailed, too long is better than too short. If you think your README is too long, consider utilizing another form of documentation rather than cutting out information.

## Name
Choose a self-explaining name for your project.

## Description
Let people know what your project can do specifically. Provide context and add a link to any reference visitors might be unfamiliar with. A list of Features or a Background subsection can also be added here. If there are alternatives to your project, this is a good place to list differentiating factors.

## Badges
On some READMEs, you may see small images that convey metadata, such as whether or not all the tests are passing for the project. You can use Shields to add some to your README. Many services also have instructions for adding a badge.

## Visuals
Depending on what you are making, it can be a good idea to include screenshots or even a video (you'll frequently see GIFs rather than actual videos). Tools like ttygif can help, but check out Asciinema for a more sophisticated method.

## Installation
Within a particular ecosystem, there may be a common way of installing things, such as using Yarn, NuGet, or Homebrew. However, consider the possibility that whoever is reading your README is a novice and would like more guidance. Listing specific steps helps remove ambiguity and gets people to using your project as quickly as possible. If it only runs in a specific context like a particular programming language version or operating system or has dependencies that have to be installed manually, also add a Requirements subsection.

## Usage
Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## Support
Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.

## Roadmap
If you have ideas for releases in the future, it is a good idea to list them in the README.

## Contributing
State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## License
For open source projects, say how it is licensed.

## Project status
If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.
