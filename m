From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [linux-sunxi] [PATCH 2/2] mmc: sunxi: fix new timings mode on
 A64 EMMC (MMC2) controller
Date: Sun, 6 Aug 2017 10:39:54 +0800
Message-ID: <20170806023954.wwaredjwcm2p5pw7@wens.csie.org>
References: <20170804213555.6024-1-icenowy@aosc.io>
 <20170804213555.6024-2-icenowy@aosc.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:45120 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbdHFCj4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 5 Aug 2017 22:39:56 -0400
Content-Disposition: inline
In-Reply-To: <20170804213555.6024-2-icenowy@aosc.io>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com

On Sat, Aug 05, 2017 at 05:35:55AM +0800, Icenowy Zheng wrote:
> The configuration struct of A64 EMMC(MMC2) compatible used to
> have the needs_new_timings variable missing, which lead to NULL
> pointer dereference now when trying to set up the old timings mode, as
> the old timings mode doesn't exist at all on A64.

I'm not familiar with the A64's eMMC controller. The datasheet says
it does not have the timing switch register. It does not say whether
it is always in the old or new timing mode. "needs_new_timings"
probably meant that the switch has to be set.

This fix doesn't really fix the underlying issue, which is the check
for clk_delays was incorrectly replaced. sun4i/sun5i is also broken.

Could you try this patch instead:

<---

>From 23b841a11294cb6a0cf1e146616b068f60c2ec7d Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 6 Aug 2017 10:24:47 +0800
Subject: [PATCH] mmc: sunxi: Fix NULL pointer reference on clk_delays

Some SoCs do not support clk delays for MMC in the clock control unit.
These include the old controllers in A10/A10s/A13/R8, and the new eMMC
controller in A64. The config structure for these controllers do not
specify clk_delays, but the check for this was replaced in commit
b0600daebf31 ("mmc: sunxi: Support controllers that can use both old
and new timings").

This patch adds back the check for clk_delays, and also adds comments
for both checks in sunxi_mmc_clk_set_phase().

Fixes: b0600daebf31 ("mmc: sunxi: Support controllers that can use
		      both old and new timings")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 3777517982dd..020547e5fa45 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -722,9 +722,14 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
 {
 	int index;
 
+	/* No need to set clk controller delays under new timings */
 	if (host->use_new_timings)
 		return 0;
 
+	/* Some old controllers don't support delays */
+	if (!host->cfg->clk_delays)
+		return 0;
+
 	/* determine delays */
 	if (rate <= 400000) {
 		index = SDXC_CLK_400K;
-- 
2.13.3

<---

Separately we should ask what is the proper set of config flags that
describes the A64 EMMC controller.

Regards
ChenYu

> 
> Fix this issue by adding this variable and setting it to true in
> the configuration struct.
> 
> Fixes: 4fb3ce07eafa ("mmc: sunxi: Add EMMC (MMC2) controller compatible")
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 59aba93beffb..4ad643e37014 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1142,6 +1142,7 @@ static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
>  	.idma_des_size_bits = 13,
>  	.clk_delays = NULL,
>  	.can_calibrate = true,
> +	.needs_new_timings = true,
>  };
>  
>  static const struct of_device_id sunxi_mmc_of_match[] = {
> -- 
> 2.13.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
