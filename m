From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH V2 00/15] a few sdhci/imx clean up and fix patches
Date: Thu, 21 Jul 2016 18:23:31 +0800
Message-ID: <20160721102330.GA20072@shlinux2>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
 <579096B5.2030509@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35958 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbcGUKbs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jul 2016 06:31:48 -0400
Received: by mail-pf0-f195.google.com with SMTP id y134so5250446pfg.3
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jul 2016 03:31:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <579096B5.2030509@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com

On Thu, Jul 21, 2016 at 12:32:37PM +0300, Adrian Hunter wrote:
> On 12/07/16 10:46, Dong Aisheng wrote:
> > Patch 1~10 are mainly sdhci cleanup patches while patch 7,9,10
> > are fixes which seems needed for stable tree as well.
> 
> I have ack'ed all the sdhci-related patches. i.e. all but patch 7 the dt
> bindings change.
> 
> I am not sure what needs to be done for stable.  I would suggest these
> patches are queued for 4.8, then Dong can send the relevant patches to the
> linux-stable mailing list separately after -rc1.
> 

Good suggestion!
I also think that would be a better way due to many updates recently which
may cause trouble on the simply back porting.

Regards
Dong Aisheng

> > 
> > The main work is:
> > 1) using more robust mmc_regulator_set_vqmmc 
> > 2) add auto retune support
> > 3) improve sdhci-esdhc-imx stability
> > 4) add state save and restore for low power mode
> > 
> > Change Log:
> > v1->v2:
> >  * address all Adrian's comments
> >  * below patches are dropped
> >   mmc: sdhci: move sdhci_get_cd() forward to avoid declaration
> >   mmc: core: fix a comment typo
> >   mmc: sdhci: re-factor sdhci_start_signal_voltage()
> >   mmc: core: mmc_regulator_set_vqmmc not return error if vqmmc/vmmc not
> >     exist
> >   mmc: sdhci: check SDHCI_QUIRK2_NO_1_8_V when do voltage switch
> >   mmc: sdhci: rename quirk SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12
> > 	Above clean up is not needed so far according to Adrian.
> > 
> >   mmc: sdhci: fix incorrect get data interrupt during no data transfer
> > 	This one is not needed anymore cause Adrian had another fix
> > 	already in tree.
> > 	(commit 0e0a35d2d4058 mmc: sdhci: Track whether a reset is pending)
> > 
> >   mmc: core: disable auto retune during card detection process
> > 	This one will sent out in another patch series to fix in CORE.
> > 
> > v1:
> > http://www.spinics.net/lists/linux-mmc/msg36316.html
> > 
> > Dong Aisheng (15):
> >   mmc: sdhci: using common mmc_regulator_set_vqmmc()
> >   mmc: sdhci-esdhc-imx: remove SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
> >   mmc: sdhci-esdhc-imx: add esdhc specific suspend resume callback
> >   mmc: sdhci-esdhc-imx: restore watermark level setting after resume
> >   mmc: sdhci-esdhci-imx: disable DLL delay line settings explicitly
> >   mmc: sdhci-esdhc-imx: support setting tuning start point
> >   doc: dt: fsl-imx-esdhc: add set tuning start point binding
> >   mmc: sdhci: add standard hw auto retuning support
> >   mmc: sdhci-esdhc-imx: enable hw auto retuning for STD_TUNING
> >   mmc: sdhci-esdhc-imx: enable hw auto retuning for MAN_TUNING
> >   mmc: sdhci-esdhc-imx: fix strobe DLL lock wrong clock issue
> >   mmc: sdhci-esdhc-imx: factor out hw related initialization into
> >     function
> >   mmc: sdhci-esdhc-imx: move tuning static configuration into hwinit
> >     function
> >   mmc: sdhci-esdhci-imx: re-initialize hw state after resume
> >   mmc: sdhci-esdhc-imx: clear tuning bits during driver probe
> > 
> >  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   2 +
> >  drivers/mmc/host/sdhci-esdhc-imx.c                 | 149 ++++++++++++++-------
> >  drivers/mmc/host/sdhci.c                           |  24 ++--
> >  drivers/mmc/host/sdhci.h                           |   3 +
> >  include/linux/platform_data/mmc-esdhc-imx.h        |   1 +
> >  5 files changed, 122 insertions(+), 57 deletions(-)
> > 
> 
