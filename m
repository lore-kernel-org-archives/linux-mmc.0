From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 0/5] mmc: sdhci: a few fixes on timeout and
 max_discard_to
Date: Tue, 17 Dec 2013 22:30:28 +0800
Message-ID: <20131217143025.GX6691@S2101-09.ap.freescale.net>
References: <1387268191-19859-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:15499
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752726Ab3LQO32 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 09:29:28 -0500
Content-Disposition: inline
In-Reply-To: <1387268191-19859-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, s.hauer@pengutronix.de, ulf.hansson@linaro.org, adrian.hunter@intel.com, vladimir_zapolskiy@mentor.com, ed.sutter@alcatel-lucent.com

On Tue, Dec 17, 2013 at 04:16:26PM +0800, Dong Aisheng wrote:
> Dong Aisheng (5):
>   mmc: sdhci: add platfrom get_max_timeout_count hook
>   mmc: sdhci-esdhc-imx: fix incorrect max_discard_to for uSDHC
>   mmc: sdhci: add platform set_timeout hook
>   mmc: sdhci-esdhc-imx: set the correct max timeout value for uSDHC
>   mmc: sdhci: calculate max_discard_to dynamically for
>     SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK

For all,

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

