From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: Check the return value from
 clk_prepare_enable()
Date: Sat, 12 Oct 2013 15:38:59 +0800
Message-ID: <20131012073857.GD21305@S2101-09.ap.freescale.net>
References: <1381351059-30650-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [213.199.154.248] ([213.199.154.248]:59741 "EHLO
	db9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751805Ab3JLHjf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Oct 2013 03:39:35 -0400
Content-Disposition: inline
In-Reply-To: <1381351059-30650-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Wed, Oct 09, 2013 at 05:37:39PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> clk_prepare_enable() may fail, so let's check its return value and propagate it
> in the case of error.
> 
> Also, fix the sequence for disabling the clock in the probe error path and
> also in the remove funct
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

