From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/3] mmc: support sdhci-mmp2
Date: Mon, 30 May 2011 09:11:53 +0200
Message-ID: <201105300911.54084.arnd@arndb.de>
References: <1306315367-15602-1-git-send-email-zhangfei.gao@marvell.com> <201105271746.04775.arnd@arndb.de> <BANLkTi=S=Q+AdKECCHg2u6X=VWEOtEox_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63565 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab1E3HL5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2011 03:11:57 -0400
In-Reply-To: <BANLkTi=S=Q+AdKECCHg2u6X=VWEOtEox_w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, Nicolas Pitre <nico@fluxnic.net>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Monday 30 May 2011 07:42:04 zhangfei gao wrote:
> On Fri, May 27, 2011 at 11:46 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 25 May 2011, Zhangfei Gao wrote:
> >> +static unsigned int mmp2_get_ro(struct sdhci_host *host)
> >> +{
> >> +     /* Micro SD does not support write-protect feature */
> >> +     return 0;
> >> +}
> >
> > You shouldn't need to provide an empty get_ro function, the
> > default is that there is no write-protect.
> 
> Thanks Arnd for review.
> The reason to put get_ro here is some board use micro sd, while some
> board design is general sd card.
> The micro sd do not use write-protect, while SDHCI_WRITE_PROTECT will
> return 1 in our controller, so it shows read only.
> So add one call back for the board with micro sd card via flag.

Ok, I see.
 
> >> +     pxa = kzalloc(sizeof(struct sdhci_pxa), GFP_KERNEL);
> >> +     if (!pxa) {
> >> +             ret = -ENOMEM;
> >> +             goto out;
> >> +     }
> >> +     pxa->ops = kzalloc(sizeof(struct sdhci_ops), GFP_KERNEL);
> >> +     if (!pxa->ops) {
> >> +             ret = -ENOMEM;
> >> +             goto out;
> >> +     }
> >
> > I think you really shouldn't allocate the sdhci_ops dynamically.
> > In fact, it would be much better if we were able to mark them
> > as const in all drivers.
> 
> We found some issues when supporting multi-slot, each slot may have
> different ops.
> So use the method of allocating the sdhci_ops dynamically instead of
> using static ops.
> For example, emmc has 74_clocks call back, while mmc and sdio slot
> does not have such ops.
> If not dynamically allocate sdhci_ops, all slot ops may become same,
> and 74_clocks may be called for every slot.
> Also, some board may have get_ro, while other board may not, so
> transfer the ops via flags.
> 
> Not sure whether it is worthy to add additional common files to share
> probe and remove function.
> Also the init the ops part are different.

IMHO, we should try much harder to keep the ops constant. For the
two examples you gave, I would probably put a flag into private data for
the get_ro operation to signify that it's never read-only, and provide
a second set of operations for emmc, so that in the probe function
you check the type of device and then set the appropriate one.

You could also do the same for all three cases:

	if (emmc)
		host->ops = &sdhci_mmp2_emmc_ops;
	else if (!has_ro_switch)
		host->ops = &sdhci_mmp2_rw_ops;
	else
		host->ops = &sdhci_mmp2_default_ops;

> >> +
> >> +#ifdef CONFIG_PM
> >> +static int sdhci_mmp2_suspend(struct platform_device *dev, pm_message_t state)
> >> +{
> >> +     struct sdhci_host *host = platform_get_drvdata(dev);
> >> +
> >> +     return sdhci_suspend_host(host, state);
> >> +}
> >> +
> >> +static int sdhci_mmp2_resume(struct platform_device *dev)
> >> +{
> >> +     struct sdhci_host *host = platform_get_drvdata(dev);
> >> +
> >> +     return sdhci_resume_host(host);
> >> +}
> >> +#else
> >> +#define sdhci_mmp2_suspend   NULL
> >> +#define sdhci_mmp2_resume    NULL
> >> +#endif
> >
> > Similarly, I think it would be good if sdhci-pltfm.c would simply
> > export these functions so you could refer to them in your driver.
> > There is no need to have identical copies in each variant.
> >
> 
> There are some additional code for suspend and resume, so
> sdhci_pltfm_suspend may not enough.
> For example, when enable wifi host sleep feature, additional register
> have to be configured.

Well, not all drivers would have to use the common functions, but
right now there are a number of identical copies, so it's certainly
worth sharing.

Note that this comment wasn't directed at your patch as much as at
the overall design of the sdhci sub-drivers.

	Arnd
