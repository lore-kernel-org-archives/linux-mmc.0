From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 0/5] mmc: sdhci-esdhc-imx: add runtime pm support
Date: Tue, 26 Nov 2013 17:02:20 -0500
Message-ID: <87k3fug6tv.fsf@octavius.laptop.org>
References: <1383554309-29065-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49889 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757988Ab3KZWCd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Nov 2013 17:02:33 -0500
In-Reply-To: <1383554309-29065-1-git-send-email-b29396@freescale.com> (Dong
	Aisheng's message of "Mon, 4 Nov 2013 16:38:24 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, ulf.hansson@linaro.org

Hi Dong,

On Mon, Nov 04 2013, Dong Aisheng wrote:
> We disable root clock in runtime pm to save power.
>
> Patch 2~4 are some fixes needed for enable runtime pm or it may
> break the UHS cards(SD3.0/eMMC4.5).
>
> Below are some tests result i ran which passed mmc_test tool after enable rpm:
> SDHC UHS1 on imx6q sabreauto
> eMMC 4.5 on imx6sl evk
> SDXC UHS1 on imx6sl evk
> eMMC DDR on imx6q sabresd
> SDHC on imx6q sabresd
>
> ChangeLog:
> v1->v2: only patch 5 changed. Add pm_runtime_set_active
> 	based on Ulf's comments.
>
> Dong Aisheng (5):
>   mmc: sdhci-pltfm: export pltfm suspend/resume api
>   mmc: sdhci-esdhc-imx: tuning bits should not be cleared during reset
>   mmc: sdhci-esdhc-imx: clear SDHCI_CTRL_EXEC_TUNING should not affect
>     other bits
>   mmc: sdhci-esdhc-imx: fix runtime pm unblance issue
>   mmc: sdhci-esdhc-imx: add runtime pm support

Thanks, all pushed to mmc-next for 3.14.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
