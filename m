From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH 1/1] mmc: sdhci-esdhc-imx: fix mmc ddr mode regression
 issue
Date: Fri, 9 May 2014 15:30:18 +0800
Message-ID: <20140509073016.GA14502@shlinux1.ap.freescale.net>
References: <1399618395-359-1-git-send-email-b29396@freescale.com>
 <CAPDyKFqp5Pq51hbXG04HEFhMHB7itkWmvD7cqLgBUFwytVv7Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2lp0239.outbound.protection.outlook.com ([207.46.163.239]:13469
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756467AbaEIIos (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 May 2014 04:44:48 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFqp5Pq51hbXG04HEFhMHB7itkWmvD7cqLgBUFwytVv7Hw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>

On Fri, May 09, 2014 at 10:42:42AM +0200, Ulf Hansson wrote:
> On 9 May 2014 08:53, Dong Aisheng <b29396@freescale.com> wrote:
> > The regression is caused by the following commit ...
> >
> > commit 79f7ae7c45a6ccf04e2908337461dee615f6afb0
> > Author: Seungwon Jeon <tgih.jun@samsung.com>
> > Date:   Fri Mar 14 21:11:56 2014 +0900
> >
> > mmc: clarify DDR timing mode between SD-UHS and eMMC
> >
> > This change distinguishes DDR timing mode of current
> > mixed usage to clarify device type.
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Chris Ball <chris@printf.net>
> >
> > ... and the line below.
> >
> > @@ -1264,7 +1264,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> > goto err;
> >         }
> >                 mmc_card_set_ddr_mode(card);
> > -               mmc_set_timing(card->host, MMC_TIMING_UHS_DDR50);
> > +               mmc_set_timing(card->host, MMC_TIMING_MMC_DDR52);
> >                 mmc_set_bus_width(card->host, bus_width);
> >         }
> > }
> >
> > It's caused by the platform driver was still using MMC_TIMING_UHS_DDR50 for MMC DDR
> > mode which needs update too.
> >
> > Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
> > Reported-by: Shawn Guo <shawn.guo@freescale.com>
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> 
> Hi Dong,
> 
> Thanks for the fix. I will include this in the next PR I send to Chris.
> 

Hi Ulf,

Okay, thanks a lot.

Regards
Dong Aisheng

> Kind regards
> Ulf Hansson
