From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 4/7] mmc: sh_mmcif: clarify DDR timing mode between SD-UHS
 and eMMC
Date: Fri, 17 Jan 2014 23:36:46 +0900
Message-ID: <000501cf1391$8cb40f30$a61c2d90$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <002201cf11fb$c63ffee0$52bffca0$%jun@samsung.com>
 <CAPDyKFoA9P8ggVx3EkFUpKotMHdvWO7GWe5QrBi89VkGXS7tEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48971 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbaAQOgt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jan 2014 09:36:49 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZJ00M8JV9BLV10@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 17 Jan 2014 23:36:47 +0900 (KST)
In-reply-to: <CAPDyKFoA9P8ggVx3EkFUpKotMHdvWO7GWe5QrBi89VkGXS7tEw@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@linaro.org>
Cc: 'Chris Ball' <chris@printf.net>, 'Guennadi Liakhovetski' <g.liakhovetski@gmx.de>, 'linux-mmc' <linux-mmc@vger.kernel.org>

On Thu, January 16, 2014, Ulf Hansson wrote:
> On 15 January 2014 15:12, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > Replaced UHS_DDR50 with MMC_DDR52.
> >
> > CC: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> >  drivers/mmc/host/sh_mmcif.c |    9 +++++----
> >  1 files changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> > index 54730f4..656fbba 100644
> > --- a/drivers/mmc/host/sh_mmcif.c
> > +++ b/drivers/mmc/host/sh_mmcif.c
> > @@ -803,12 +803,13 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
> >                         break;
> >                 }
> >                 switch (host->timing) {
> > -               case MMC_TIMING_UHS_DDR50:
> > +               case MMC_TIMING_MMC_DDR52:
> 
> What about UHS SD cards?
I guess that there is no implementation related to voltage switch for UHS support.
MMC_TIMING_UHS_DDR50 looks like pointing eMMC's DDR.

Guennadi,
Can you check this more?

Thanks,
Seungwon Jeon

> 
> Kind regards
> Ulf Hansson
> 
> >                         /*
> >                          * MMC core will only set this timing, if the host
> > -                        * advertises the MMC_CAP_UHS_DDR50 capability. MMCIF
> > -                        * implementations with this capability, e.g. sh73a0,
> > -                        * will have to set it in their platform data.
> > +                        * advertises the MMC_CAP_1_8V_DDR/MMC_CAP_1_2V_DDR
> > +                        * capability. MMCIF implementations with this
> > +                        * capability, e.g. sh73a0, will have to set it
> > +                        * in their platform data.
> >                          */
> >                         tmp |= CMD_SET_DARS;
> >                         break;
> > --
> > 1.7.0.4
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

