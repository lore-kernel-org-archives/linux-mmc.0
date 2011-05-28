From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: support sdhci-mmp2
Date: Sat, 28 May 2011 10:52:39 +0200
Message-ID: <201105281052.39803.arnd@arndb.de>
References: <1306156882-12124-1-git-send-email-zhangfei.gao@marvell.com> <F4CA7B04-7898-4C6A-814E-DE84588E3C94@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56013 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab1E1Iwt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 28 May 2011 04:52:49 -0400
In-Reply-To: <F4CA7B04-7898-4C6A-814E-DE84588E3C94@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Zhangfei Gao <zgao6@marvell.com>, Nicolas Pitre <nico@fluxnic.net>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <mark.brown314@gmail.com>, Shawn Guo <shawn.guo@linaro.org>

On Saturday 28 May 2011 07:00:38 Philip Rakity wrote:
> In some sense all of this is backwards.  Once the SoC is known (pxa910 or mmp2),
> it knows that SDHCI controller it supports.  It should set a config option
> like USES_MRVL_V3_SD_CONTROLLER.  The Kconfig entry in mmc/host should
> depend on THAT selection to allow the user to enable the SD option.
 
I would actually prefer in general if the Kconfig file listed only
the strictly necessary dependencies for building the driver.
If this driver can be built anywhere, I would list no dependency at
all. If it depends on something ARM specific, I'd make it depend
on CONFIG_ARM.

Then change the defconfig for the particular board to enable the
driver.

The main advantage of this is to increase build coverage on test
building machines doing an allyesconfig and randconfig once we
get there (right now, these have too many build errors, but we
have plans to work on that). 
 
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-mmp2.c
> 
> It is probably better to NOT name the file sdhci-mmp2.c but
> something like sdchi-pxaV3.c since other SoC's may use this controller.

Good point.

> > +       pxa = kzalloc(sizeof(struct sdhci_pxa), GFP_KERNEL);
> > +       if (!pxa) {
> > +               ret = -ENOMEM;
> > +               goto out;
> > +       }
> > +       pxa->ops = kzalloc(sizeof(struct sdhci_ops), GFP_KERNEL);
> why is  pxa->ops needed ?

I guess the idea was to be able to free the structure later. I already
commented that it should be statically allocation instead of kzalloc,
so that would make the pointer unnecessary.

	Arnd
