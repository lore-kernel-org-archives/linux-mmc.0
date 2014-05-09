From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: Adding esdhc4 eMMC support on mx6sabresd
Date: Fri, 9 May 2014 11:16:25 +0800
Message-ID: <20140509031624.GL2794@dragon>
References: <CAOMZO5CJEoe_fGLH-Uu9uVwNdWPp940k3WGAkjzkCiGmjAPAXA@mail.gmail.com>
 <20140508091835.78daafbe@ipc1.ka-ro>
 <20140508101730.GA28787@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2lp0238.outbound.protection.outlook.com ([207.46.163.238]:11553
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754777AbaEIDQj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 May 2014 23:16:39 -0400
Content-Disposition: inline
In-Reply-To: <20140508101730.GA28787@shlinux1.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

On Thu, May 08, 2014 at 06:17:32PM +0800, Dong Aisheng wrote:
> I just tested an old Chris/mmc-next tree which is 3.14 rc2 with the top commit is b42b9b.
> The eMMC works well on SabreSD boards.
> But it failed and got the same issue with latest chris/mmc-next tree.
> I noticed there's no changes on sdhci-esdhc-imx.c
> Probably some other changes breaks this function.
> 
> Fabio,
> You may bisect it yourself or i will do it later when i'm a bit free.

The regression is caused by the following commit ...

commit 79f7ae7c45a6ccf04e2908337461dee615f6afb0
Author: Seungwon Jeon <tgih.jun@samsung.com>
Date:   Fri Mar 14 21:11:56 2014 +0900

    mmc: clarify DDR timing mode between SD-UHS and eMMC

    This change distinguishes DDR timing mode of current
    mixed usage to clarify device type.

    Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
    Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
    Signed-off-by: Chris Ball <chris@printf.net>

... and the line below.
 
@@ -1264,7 +1264,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
                                        goto err;
                        }
                        mmc_card_set_ddr_mode(card);
-                       mmc_set_timing(card->host, MMC_TIMING_UHS_DDR50);
+                       mmc_set_timing(card->host, MMC_TIMING_MMC_DDR52);
                        mmc_set_bus_width(card->host, bus_width);
                }
        }


> Shawn,
> I remember this patch should have been upstream through your tree long time ago.
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/206446.html
> It seems somehow missed.

Ah, yes.  It got lost.

Shawn
