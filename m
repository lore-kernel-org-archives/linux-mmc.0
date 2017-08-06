From: Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [linux-sunxi] [PATCH 2/2] mmc: sunxi: fix new timings mode on A64 EMMC (MMC2) controller
Date: Sun, 06 Aug 2017 11:20:49 +0800
Message-ID: <8F9C9945-2AB8-4E2D-82BE-97D7A9E6DD6A@aosc.io>
References: <20170804213555.6024-1-icenowy@aosc.io> <20170804213555.6024-2-icenowy@aosc.io> <20170806023954.wwaredjwcm2p5pw7@wens.csie.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170806023954.wwaredjwcm2p5pw7@wens.csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-mmc@vger.kernel.org



于 2017年8月6日 GMT+08:00 上午10:39:54, Chen-Yu Tsai <wens@csie.org> 写到:
>On Sat, Aug 05, 2017 at 05:35:55AM +0800, Icenowy Zheng wrote:
>> The configuration struct of A64 EMMC(MMC2) compatible used to
>> have the needs_new_timings variable missing, which lead to NULL
>> pointer dereference now when trying to set up the old timings mode,
>as
>> the old timings mode doesn't exist at all on A64.
>
>I'm not familiar with the A64's eMMC controller. The datasheet says
>it does not have the timing switch register. It does not say whether
>it is always in the old or new timing mode. "needs_new_timings"
>probably meant that the switch has to be set.

As I know, it supports DDR mode, but the CCU has no clk delays.
So it should be the new timings mode.

>
>This fix doesn't really fix the underlying issue, which is the check
>for clk_delays was incorrectly replaced. sun4i/sun5i is also broken.
>
>Could you try this patch instead:
>
><---
>
>From 23b841a11294cb6a0cf1e146616b068f60c2ec7d Mon Sep 17 00:00:00 2001
>From: Chen-Yu Tsai <wens@csie.org>
>Date: Sun, 6 Aug 2017 10:24:47 +0800
>Subject: [PATCH] mmc: sunxi: Fix NULL pointer reference on clk_delays
>
>Some SoCs do not support clk delays for MMC in the clock control unit.
>These include the old controllers in A10/A10s/A13/R8, and the new eMMC
>controller in A64. The config structure for these controllers do not
>specify clk_delays, but the check for this was replaced in commit
>b0600daebf31 ("mmc: sunxi: Support controllers that can use both old
>and new timings").
>
>This patch adds back the check for clk_delays, and also adds comments
>for both checks in sunxi_mmc_clk_set_phase().
>
>Fixes: b0600daebf31 ("mmc: sunxi: Support controllers that can use
>		      both old and new timings")
>Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>---
> drivers/mmc/host/sunxi-mmc.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/drivers/mmc/host/sunxi-mmc.c
>b/drivers/mmc/host/sunxi-mmc.c
>index 3777517982dd..020547e5fa45 100644
>--- a/drivers/mmc/host/sunxi-mmc.c
>+++ b/drivers/mmc/host/sunxi-mmc.c
>@@ -722,9 +722,14 @@ static int sunxi_mmc_clk_set_phase(struct
>sunxi_mmc_host *host,
> {
> 	int index;
> 
>+	/* No need to set clk controller delays under new timings */
> 	if (host->use_new_timings)
> 		return 0;
> 
>+	/* Some old controllers don't support delays */
>+	if (!host->cfg->clk_delays)
>+		return 0;
>+
> 	/* determine delays */
> 	if (rate <= 400000) {
> 		index = SDXC_CLK_400K;
