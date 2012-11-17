From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] dt: Document: Add optional dw_mmc pm bindings
Date: Sat, 17 Nov 2012 16:05:43 -0500
Message-ID: <87txso7xeg.fsf@octavius.laptop.org>
References: <1352286460-13925-1-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41788 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137Ab2KQVFs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 17 Nov 2012 16:05:48 -0500
In-Reply-To: <1352286460-13925-1-git-send-email-a.kesavan@samsung.com>
	(Abhilash Kesavan's message of "Wed, 07 Nov 2012 16:37:39 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, linux-mmc@vger.kernel.org, will.newton@imgtec.com

Hi Abhilash,

On Wed, Nov 07 2012, Abhilash Kesavan wrote:
> Add documentation for pm capabilties such as MMC_PM_KEEP_POWER
> and MMC_PM_WAKE_SDIO_IRQ.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  .../devicetree/bindings/mmc/synposis-dw-mshc.txt   |    7 +++++++

(Ugh, I just noticed the typo in that filename.  We should fix that.)

>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
> index 06cd32d..fa6806d 100644
> --- a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
> @@ -47,6 +47,11 @@ Optional properties:
>  
>  * broken-cd: as documented in mmc core bindings.
>  
> +* keep-power-in-suspend: Preserves card power during a suspend/resume cycle.
> +
> +* enable-sdio-wakeup: Enables wake up of host system on SDIO IRQ assertion.
> +
> + Samsung Exynos5250 specific properties:
>  Aliases:
>  
>  - All the MSHC controller nodes should be represented in the aliases node using
> @@ -69,6 +74,8 @@ board specific portions as listed below.
>  		num-slots = <1>;
>  		supports-highspeed;
>  		broken-cd;
> +		keep-power-in-suspend;
> +		enable-sdio-wakeup;
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;

Let's make these core optional properties, documented in
Documentation/devicetree/bindings/mmc/mmc.txt instead of in
synposis-dw-mshc.txt, and also add support for them in sdhci_pltfm.c
by adding your "host->pm_caps |= .." lines to sdhci_get_of_property().

Please could you do that and resend?  The dw_mmc patch looks fine.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
