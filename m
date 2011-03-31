From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 0/5] consolidate sdhci pltfm & OF drivers and get them
	self registered
Date: Wed, 30 Mar 2011 22:56:39 -0600
Message-ID: <AANLkTi=uUYYXrxX9e9hyQ7YxPTumZsV-7y_A8w7rogAt@mail.gmail.com>
References: <1301042931-4869-1-git-send-email-shawn.guo@linaro.org>
	<20110331042507.GA21846@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6905358534379876771=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110331042507.GA21846-+NayF8gZjK2ctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

--===============6905358534379876771==
Content-Type: multipart/alternative; boundary=000e0cd4d3de6cca6d049fc01eaf

--000e0cd4d3de6cca6d049fc01eaf
Content-Type: text/plain; charset=ISO-8859-1

On Mar 30, 2011 10:23 PM, "Shawn Guo" <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
>
> On Fri, Mar 25, 2011 at 04:48:46PM +0800, Shawn Guo wrote:
> > Here are what the patch set does.
> >
> > * Remove .probe and .remove hooks from sdhci-pltfm.c and make it be
> >   a pure common helper function providers.
> > * Add .probe and .remove hooks for sdhci pltfm drivers sdhci-cns3xxx,
> >   sdhci-dove, sdhci-tegra, and sdhci-esdhc-imx to make them self
> >   registered with calling helper functions created above.
> > * Migrate the use of sdhci_of_host and sdhci_of_data to
> >   sdhci_pltfm_host and sdhci_pltfm_data, so that OF version host and
> >   data structure works can be saved, and pltfm version works for both
> >   cases.
> > * Add OF common helper stuff into sdhci-pltfm.c, and make OF version
> >   sdhci drivers sdhci-of-esdhc and sdhci-of-hlwd become self
> >   registered as well, so that sdhci-of-core.c and sdhci-of.h can be
> >   removed.
> > * Consolidate the OF and pltfm esdhc drivers into one with sharing
> >   the same pair of .probe and .remove hooks.  As a result,
> >   sdhci-esdhc-imx.c and sdhci-of-esdhc.c go away, while
> >   sdhci-esdhc.c comes in and works for both MPCxxx and i.MX.
> > * Eliminate include/linux/mmc/sdhci-pltfm.h with moving stuff into
> >   drivers/mmc/host/sdhci-pltfm.h.
> >
> > And the benefits we gain from the changes are:
> >
> > * Get the sdhci device driver follow the Linux trend that driver
> >   makes the registration by its own.
> > * sdhci-pltfm.c becomes simple and clean as it only has common helper
> >   stuff there now.
> > * All sdhci device specific things are going back its own driver.
> > * The dt and non-dt drivers are consolidated to use the same pair of
> >   .probe and .remove hooks.
> > * SDHCI driver for Freescale eSDHC controller found on both MPCxxx
> >   and i.MX platforms is consolidated to use the same one .probe
> >   function.
> >
> > The patch set works against the tree below, and was only tested on
> > i.mx51 babbage board, all other targets were build tested.
> >
> >   git://git.secretlab.ca/git/linux-2.6.git devicetree/test
> >
> > Comments are welcomed and appreciated.
> >
> > Regards,
> > Shawn
> >
> > PS: The first patch is a squashing of the patch set below, which was
> > posted for review a few days back.
> >
> >   [PATCH 0/5] make sdhci device drivers self registered
> >
> > Some patches in this series are relatively large, involving more
> > changes than expected, I chose to not split considering they are
> > logically integral, and doing so can reduce the patch quantity much,
> > and make bisect much easier.  But sorry for that it makes reviewers'
> > life harder.
> >
> > Shawn Guo (5):
> >       mmc: sdhci: make sdhci-pltfm device drivers self registered
> >       mmc: sdhci: eliminate sdhci_of_host and sdhci_of_data
> >       mmc: sdhci: make sdhci-of device drivers self registered
> >       mmc: sdhci: consolidate sdhci-of-esdhc and sdhci-esdhc-imx
> >       mmc: sdhci: merge two sdhci-pltfm.h into one
> >
> >  drivers/mmc/host/Kconfig           |   71 ++++---
> >  drivers/mmc/host/Makefile          |   17 +-
> >  drivers/mmc/host/sdhci-cns3xxx.c   |   68 ++++++-
> >  drivers/mmc/host/sdhci-dove.c      |   69 ++++++-
> >  drivers/mmc/host/sdhci-esdhc-imx.c |  149 -------------
> >  drivers/mmc/host/sdhci-esdhc.c     |  412
++++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-of-core.c   |  247 ---------------------
> >  drivers/mmc/host/sdhci-of-esdhc.c  |   89 --------
> >  drivers/mmc/host/sdhci-of-hlwd.c   |   89 +++++++-
> >  drivers/mmc/host/sdhci-of.h        |   42 ----
> >  drivers/mmc/host/sdhci-pltfm.c     |  251 +++++++++-------------
> >  drivers/mmc/host/sdhci-pltfm.h     |   36 +++-
> >  drivers/mmc/host/sdhci-tegra.c     |  187 ++++++++++-------
> >  include/linux/mmc/sdhci-pltfm.h    |   35 ---
> >  14 files changed, 912 insertions(+), 850 deletions(-)
> > --
>
> Any comments?  Is this the right direction to move?

I think it is, but I'll try to get you a full review tomorrow.

g.

>
> --
> Regards,
> Shawn
>
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev

--000e0cd4d3de6cca6d049fc01eaf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p><br>
On Mar 30, 2011 10:23 PM, &quot;Shawn Guo&quot; &lt;<a href=3D"mailto:shawn=
.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org">shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On Fri, Mar 25, 2011 at 04:48:46PM +0800, Shawn Guo wrote:<br>
&gt; &gt; Here are what the patch set does.<br>
&gt; &gt;<br>
&gt; &gt; * Remove .probe and .remove hooks from sdhci-pltfm.c and make it =
be<br>
&gt; &gt; =A0 a pure common helper function providers.<br>
&gt; &gt; * Add .probe and .remove hooks for sdhci pltfm drivers sdhci-cns3=
xxx,<br>
&gt; &gt; =A0 sdhci-dove, sdhci-tegra, and sdhci-esdhc-imx to make them sel=
f<br>
&gt; &gt; =A0 registered with calling helper functions created above.<br>
&gt; &gt; * Migrate the use of sdhci_of_host and sdhci_of_data to<br>
&gt; &gt; =A0 sdhci_pltfm_host and sdhci_pltfm_data, so that OF version hos=
t and<br>
&gt; &gt; =A0 data structure works can be saved, and pltfm version works fo=
r both<br>
&gt; &gt; =A0 cases.<br>
&gt; &gt; * Add OF common helper stuff into sdhci-pltfm.c, and make OF vers=
ion<br>
&gt; &gt; =A0 sdhci drivers sdhci-of-esdhc and sdhci-of-hlwd become self<br=
>
&gt; &gt; =A0 registered as well, so that sdhci-of-core.c and sdhci-of.h ca=
n be<br>
&gt; &gt; =A0 removed.<br>
&gt; &gt; * Consolidate the OF and pltfm esdhc drivers into one with sharin=
g<br>
&gt; &gt; =A0 the same pair of .probe and .remove hooks. =A0As a result,<br=
>
&gt; &gt; =A0 sdhci-esdhc-imx.c and sdhci-of-esdhc.c go away, while<br>
&gt; &gt; =A0 sdhci-esdhc.c comes in and works for both MPCxxx and i.MX.<br=
>
&gt; &gt; * Eliminate include/linux/mmc/sdhci-pltfm.h with moving stuff int=
o<br>
&gt; &gt; =A0 drivers/mmc/host/sdhci-pltfm.h.<br>
&gt; &gt;<br>
&gt; &gt; And the benefits we gain from the changes are:<br>
&gt; &gt;<br>
&gt; &gt; * Get the sdhci device driver follow the Linux trend that driver<=
br>
&gt; &gt; =A0 makes the registration by its own.<br>
&gt; &gt; * sdhci-pltfm.c becomes simple and clean as it only has common he=
lper<br>
&gt; &gt; =A0 stuff there now.<br>
&gt; &gt; * All sdhci device specific things are going back its own driver.=
<br>
&gt; &gt; * The dt and non-dt drivers are consolidated to use the same pair=
 of<br>
&gt; &gt; =A0 .probe and .remove hooks.<br>
&gt; &gt; * SDHCI driver for Freescale eSDHC controller found on both MPCxx=
x<br>
&gt; &gt; =A0 and i.MX platforms is consolidated to use the same one .probe=
<br>
&gt; &gt; =A0 function.<br>
&gt; &gt;<br>
&gt; &gt; The patch set works against the tree below, and was only tested o=
n<br>
&gt; &gt; i.mx51 babbage board, all other targets were build tested.<br>
&gt; &gt;<br>
&gt; &gt; =A0 git://<a href=3D"http://git.secretlab.ca/git/linux-2.6.git">g=
it.secretlab.ca/git/linux-2.6.git</a> devicetree/test<br>
&gt; &gt;<br>
&gt; &gt; Comments are welcomed and appreciated.<br>
&gt; &gt;<br>
&gt; &gt; Regards,<br>
&gt; &gt; Shawn<br>
&gt; &gt;<br>
&gt; &gt; PS: The first patch is a squashing of the patch set below, which =
was<br>
&gt; &gt; posted for review a few days back.<br>
&gt; &gt;<br>
&gt; &gt; =A0 [PATCH 0/5] make sdhci device drivers self registered<br>
&gt; &gt;<br>
&gt; &gt; Some patches in this series are relatively large, involving more<=
br>
&gt; &gt; changes than expected, I chose to not split considering they are<=
br>
&gt; &gt; logically integral, and doing so can reduce the patch quantity mu=
ch,<br>
&gt; &gt; and make bisect much easier. =A0But sorry for that it makes revie=
wers&#39;<br>
&gt; &gt; life harder.<br>
&gt; &gt;<br>
&gt; &gt; Shawn Guo (5):<br>
&gt; &gt; =A0 =A0 =A0 mmc: sdhci: make sdhci-pltfm device drivers self regi=
stered<br>
&gt; &gt; =A0 =A0 =A0 mmc: sdhci: eliminate sdhci_of_host and sdhci_of_data=
<br>
&gt; &gt; =A0 =A0 =A0 mmc: sdhci: make sdhci-of device drivers self registe=
red<br>
&gt; &gt; =A0 =A0 =A0 mmc: sdhci: consolidate sdhci-of-esdhc and sdhci-esdh=
c-imx<br>
&gt; &gt; =A0 =A0 =A0 mmc: sdhci: merge two sdhci-pltfm.h into one<br>
&gt; &gt;<br>
&gt; &gt; =A0drivers/mmc/host/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 71 ++++---<=
br>
&gt; &gt; =A0drivers/mmc/host/Makefile =A0 =A0 =A0 =A0 =A0| =A0 17 +-<br>
&gt; &gt; =A0drivers/mmc/host/sdhci-cns3xxx.c =A0 | =A0 68 ++++++-<br>
&gt; &gt; =A0drivers/mmc/host/sdhci-dove.c =A0 =A0 =A0| =A0 69 ++++++-<br>
&gt; &gt; =A0drivers/mmc/host/sdhci-esdhc-imx.c | =A0149 -------------<br>
&gt; &gt; =A0drivers/mmc/host/sdhci-esdhc.c =A0 =A0 | =A0412 ++++++++++++++=
++++++++++++++++++++++<br>
&gt; &gt; =A0drivers/mmc/host/sdhci-of-core.c =A0 | =A0247 ----------------=
-----<br>
&gt; &gt; =A0drivers/mmc/host/sdhci-of-esdhc.c =A0| =A0 89 --------<br>
&gt; &gt; =A0drivers/mmc/host/sdhci-of-hlwd.c =A0 | =A0 89 +++++++-<br>
&gt; &gt; =A0drivers/mmc/host/sdhci-of.h =A0 =A0 =A0 =A0| =A0 42 ----<br>
&gt; &gt; =A0drivers/mmc/host/sdhci-pltfm.c =A0 =A0 | =A0251 +++++++++-----=
--------<br>
&gt; &gt; =A0drivers/mmc/host/sdhci-pltfm.h =A0 =A0 | =A0 36 +++-<br>
&gt; &gt; =A0drivers/mmc/host/sdhci-tegra.c =A0 =A0 | =A0187 ++++++++++----=
---<br>
&gt; &gt; =A0include/linux/mmc/sdhci-pltfm.h =A0 =A0| =A0 35 ---<br>
&gt; &gt; =A014 files changed, 912 insertions(+), 850 deletions(-)<br>
&gt; &gt; --<br>
&gt;<br>
&gt; Any comments? =A0Is this the right direction to move?</p>
<p>I think it is, but I&#39;ll try to get you a full review tomorrow.</p>
<p>g.</p>
<p>&gt;<br>
&gt; --<br>
&gt; Regards,<br>
&gt; Shawn<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; linaro-dev mailing list<br>
&gt; <a href=3D"mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org">linaro-dev-cunTk1MwBs9c5DDRkUg1lw@public.gmane.org=
.org</a><br>
&gt; <a href=3D"http://lists.linaro.org/mailman/listinfo/linaro-dev">http:/=
/lists.linaro.org/mailman/listinfo/linaro-dev</a><br>
</p>

--000e0cd4d3de6cca6d049fc01eaf--

--===============6905358534379876771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6905358534379876771==--
