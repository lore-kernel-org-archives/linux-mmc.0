From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 0/4] Add device tree probe for sdhci-esdhc-imx
Date: Sat, 09 Jul 2011 18:14:43 -0400
Message-ID: <m2pqljje3w.fsf@bob.laptop.org>
References: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58442 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754827Ab1GIWO4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 9 Jul 2011 18:14:56 -0400
In-Reply-To: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org> (Shawn
	Guo's message of "Thu, 7 Jul 2011 00:47:46 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Hi Shawn,

On Wed, Jul 06 2011, Shawn Guo wrote:
> The first patch copies platform data into driver private data, and
> do not reference platform data after probe.  The second one removes
> the uses of cpu_is_mx().  The third one makes a dt related fix on
> sdhci-pltfm.c, and the last one adds actual device tree probe for
> sdhci-esdhc-imx driver.
>
> Changes since v2:
>  * Add patch #1
>  * Do not use Linux details of cd-type and wp-type for binding
>
> Changes since v1:
>  * Address review comments given by Grant
>
> Shawn Guo (4):
>       mmc: sdhci-esdhc-imx: do not reference platform data after probe
>       mmc: sdhci-esdhc-imx: get rid of the uses of cpu_is_mx()
>       mmc: sdhci-pltfm: dt device does not pass parent to sdhci_alloc_host
>       mmc: sdhci-esdhc-imx: add device tree probe support

These don't apply against mmc-next -- what is your tree based on?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
