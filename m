From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 0/4] Extend sdhci-esdhc-imx card_detect and write_protect
 support for mx5
Date: Tue, 14 Jun 2011 14:48:42 +0800
Message-ID: <20110614064841.GB30295@S2100-06.ap.freescale.net>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:48954
	"EHLO CH1EHSOBE016.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753730Ab1FNGnQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2011 02:43:16 -0400
Content-Disposition: inline
In-Reply-To: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>, Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Eric Benard <eric@eukrea.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Fri, Jun 10, 2011 at 06:42:48PM +0800, Shawn Guo wrote:
> The card-present polling within sdhci based driver is very expensive
> in terms of the impact to system performance.  We observe a few
> system performance issues from Freescale and Linaro on mx5 platforms,
> which have been proved card polling related.
> 
> The patch set extends the current sdhci-esdhc-imx card_detect and
> write_protect support to cover mx5 platforms, and solves above
> performance issues.
> 
> Shawn Guo (4):
>       mmc: sdhci: fix interrupt storm from card detection
>       mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not get cleared
>       mmc: sdhci-esdhc-imx: remove "WP" from flag ESDHC_FLAG_GPIO_FOR_CD_WP
>       mmc: sdhci-esdhc-imx: extend card_detect and write_protect support
> 
Hi Arnaud,

Any chance to play with it yet?

Hi Wolfram,

Any comment?

-- 
Regards,
Shawn

