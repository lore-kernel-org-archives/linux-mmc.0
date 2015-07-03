From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/6] mmc: sdhci-esdhc-imx: add tuning-step seting support
Date: Fri, 3 Jul 2015 19:10:18 +0800
Message-ID: <20150703111017.GA17553@localhost>
References: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
 <1433926244-29244-3-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47689 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754894AbbGCLPS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 3 Jul 2015 07:15:18 -0400
Content-Disposition: inline
In-Reply-To: <1433926244-29244-3-git-send-email-haibo.chen@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@freescale.com>
Cc: linux-mmc@vger.kernel.org, aisheng.dong@freescale.com, ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org

On Wed, Jun 10, 2015 at 04:50:40PM +0800, Haibo Chen wrote:
> @@ -969,6 +976,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  
>  	of_property_read_u32(np, "max-frequency", &boarddata->f_max);
>  
> +	of_property_read_u32(np, "tuning-step", &boarddata->tuning_step);
> +

Where is the binding doc for this device tree property?

Shawn
