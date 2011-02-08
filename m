From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/5] OMAP3: hwmod data: Add HSMMC
Date: Tue, 08 Feb 2011 14:30:34 -0800
Message-ID: <87mxm6jh11.fsf@ti.com>
References: <1296660462-28489-1-git-send-email-kishore.kadiyala@ti.com>
	<1296660462-28489-4-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:37310 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754091Ab1BHWai (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Feb 2011 17:30:38 -0500
In-Reply-To: <1296660462-28489-4-git-send-email-kishore.kadiyala@ti.com>
	(Kishore Kadiyala's message of "Wed, 2 Feb 2011 20:57:40 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>

Kishore Kadiyala <kishore.kadiyala@ti.com> writes:

> From: Paul Walmsley <paul@pwsan.com>
>
> Update the omap3 hwmod data with the HSMMC info.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>

[...]

Just notcied a minor issue below, which was probably inherited from my
original hacks on this code...

> +static struct omap_hwmod omap3xxx_mmc1_hwmod = {
> +	.name		= "mmc1_hwmod",
> +	.mpu_irqs	= mmc1_mpu_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(mmc1_mpu_irqs),
> +	.sdma_reqs	= mmc1_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(mmc1_sdma_reqs),
> +	.opt_clks	= mmc1_opt_clks,
> +	.opt_clks_cnt	= ARRAY_SIZE(mmc1_opt_clks),
> +	.main_clk	= "mmchs1_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.module_offs = CORE_MOD,
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP3430_GRPSEL_MMC1_SHIFT,

Thee GRPSEL bit isn't the right bit here, and should be the
EN_MMC1_SHIFT value.  I realize, they're probably the same bitfield, but
this should be consistent with the other hwmods.

Same issue with other MMC hwmods.

Kevin
