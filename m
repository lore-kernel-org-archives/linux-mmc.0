From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 13/23] mmc: sdhci-esdhc-imx: restore watermark level
 setting after resume
Date: Tue, 31 May 2016 15:18:37 +0800
Message-ID: <20160531071837.GA4096@shlinux2>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-14-git-send-email-aisheng.dong@nxp.com>
 <5731AA28.9030304@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35128 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbcEaHYE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2016 03:24:04 -0400
Received: by mail-pf0-f195.google.com with SMTP id f144so18006427pfa.2
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2016 00:24:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5731AA28.9030304@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com

On Tue, May 10, 2016 at 12:30:16PM +0300, Adrian Hunter wrote:
> On 15/04/16 20:29, Dong Aisheng wrote:
> > Currently, we config the watermark_level register only in probe.
> > This will cause the mmc write operation timeout issue after system
> > resume back in LPSR mode. Because in LPSR mode, after system resume
> > back, the watermark_level register(0x44) changes to 0x08000880, which
> > set the write watermark level as 0, and set the read watermark level
> > as 128. This value is incorrect.
> > 
> > This patch restores the setting of watermark level register after
> > system resume back.
> 
> In sdhci_esdhc_imx_probe() the watermark setting is conditional on
> esdhc_is_usdhc(imx_data), but in the resume it is not.  Is that intended?
> If so, maybe explain that in the commit message.
> 

Good catch!
I think we'd probably better keep that condition check.
Will update it in V2.


> Might be worth pulling out the constant 0x10401040 and #defining it since it
> is used in more than one place too.
> 

Good point!
Will do it.

Regards
Dong Aisheng

> > 
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 6fef6bc..4c28fbb 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -1261,6 +1261,11 @@ static int sdhci_esdhc_suspend(struct device *dev)
> >  
> >  static int sdhci_esdhc_resume(struct device *dev)
> >  {
> > +	struct sdhci_host *host = dev_get_drvdata(dev);
> > +
> > +	/* restore watermark setting in case it's lost in low power mode */
> > +	writel(0x10401040, host->ioaddr + ESDHC_WTMK_LVL);
> > +
> >  	return sdhci_pltfm_resume(dev);
> >  }
> >  
> > 
> 
