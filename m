From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: My outstanding MMC / SDHI/TMIO / MMCIF patches for 3.6
Date: Fri, 29 Jun 2012 17:03:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206291701110.9084@axis700.grange>
References: <Pine.LNX.4.64.1206281029270.31813@axis700.grange>
 <87sjdf8q8h.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63570 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab2F2PDO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jun 2012 11:03:14 -0400
In-Reply-To: <87sjdf8q8h.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Chris

On Thu, 28 Jun 2012, Chris Ball wrote:

> Hi Guennadi,
> 
> On Thu, Jun 28 2012, Guennadi Liakhovetski wrote:
> > There are a number of MMC patches from me outstanding for 3.6. 
> > Appreciating, that it might not be very easy to keep on overview - what 
> > latest versions are and in which order they should be applied - would you 
> > like me to either assemble a list of patches with links to ML archives or 
> > maybe set up a git branch somewhere on github? In the latter case - would 
> > you require some signing process - if it is at all supported on github. 
> > No, I never used one, but I'd have a look if you prefer me to use one.
> >
> > We still have some time until 3.6 merge window, but it would be nice to 
> > let patches simmer for a while in -next.
> 
> Thanks, a github branch based on mmc-next would be great, and you don't
> need to sign it.
> 
> If you have gpg setup but don't want to learn how to use git signed tags
> yet, something you could do is sign the e-mail that "git request-pull"
> generates that says "pull from url <foo> to go from commit <hash>
> to a new HEAD hash of <hash>".
> 
> (This effectively signs all the commits, because applying all of the
> correct commits is the only way to get to that new hash, and I can
> verify that I have that hash as my new HEAD after pulling.)

Ok, let's try, no guarantee though :) Let me know if there are any 
problems with my signing exercise.

The following changes since commit ed99260f748d4c1894a23a4519fd59156a27a308:

  mmc: tmio: remove a duplicated comment line (2012-06-26 16:10:40 -0400)

are available in the git repository at:
  https://github.com/lyakh/linux.git mmc-for-3.6

Guennadi Liakhovetski (19):
      mmc: always save error codes in mmc_regulator_get_supply()
      mmc: sh_mmcif: simplify and use meaningful label names in error-handling
      mmc: sh_mmcif: fix clock management
      mmc: sh_mmcif: re-read the clock frequency every time the clock is turned on
      mmc: sh_mmcif: remove redundant .down_pwr() callback
      mmc: sh_mmcif: add regulator support
      mmc: extend and rename cd-gpio helpers to handle more slot GPIO functions
      mmc: use a more generic name for slot function types and fields
      mmc: add two capability flags for CD and WP signal polarity
      mmc: add CD GPIO polling support to slot functions
      mmc: convert slot functions to managed allocation
      mmc: add WP pin handler to slot functions
      mmc: tmio: support caps2 flags
      mmc: sh_mobile_sdhi: support caps2 flags
      mmc: tmio: use generic GPIO CD and WP handlers
      mmc: sdhi: add OF support, make platform data optional
      mmc: sh-mmcif: add OF support, make platform data optional
      mmc: prohibit card detection when host is not ready
      mmc: sh_mmcif: support generic card-detection

 drivers/mmc/core/Makefile          |    2 +-
 drivers/mmc/core/cd-gpio.c         |   83 ----------------
 drivers/mmc/core/core.c            |    7 +-
 drivers/mmc/core/host.c            |    6 +
 drivers/mmc/core/slot-gpio.c       |  188 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sh_mmcif.c        |  171 ++++++++++++++++++++++----------
 drivers/mmc/host/sh_mobile_sdhi.c  |   36 +++++---
 drivers/mmc/host/tmio_mmc_pio.c    |   13 ++-
 include/linux/mfd/tmio.h           |    1 +
 include/linux/mmc/cd-gpio.h        |   18 ----
 include/linux/mmc/host.h           |   22 ++++-
 include/linux/mmc/sh_mmcif.h       |    2 +
 include/linux/mmc/sh_mobile_sdhi.h |    1 +
 include/linux/mmc/slot-gpio.h      |   24 +++++
 14 files changed, 398 insertions(+), 176 deletions(-)
 delete mode 100644 drivers/mmc/core/cd-gpio.c
 create mode 100644 drivers/mmc/core/slot-gpio.c
 delete mode 100644 include/linux/mmc/cd-gpio.h
 create mode 100644 include/linux/mmc/slot-gpio.h

Thanks
Guennadi

> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> 

- ---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk/tw60ACgkQU6Nrc+zHHwhG1QCghrAxwVEmedkIoQPpwfH9de5k
/90An2Ww9OeOxayGnUr9pbtACcLZwS5G
=UtWG
-----END PGP SIGNATURE-----
