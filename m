From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/3] mmc: sdhci-imx-esdhc: convert to use pinctrl
 subsystem
Date: Fri, 11 May 2012 15:36:56 +0800
Message-ID: <20120511073653.GX17875@S2101-09.ap.freescale.net>
References: <1335958282-3068-1-git-send-email-b29396@freescale.com>
 <1335958282-3068-3-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34503 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab2EKHg4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 May 2012 03:36:56 -0400
Received: by pbbrp8 with SMTP id rp8so2955263pbb.19
        for <linux-mmc@vger.kernel.org>; Fri, 11 May 2012 00:36:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1335958282-3068-3-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linus.walleij@stericsson.com, swarren@wwwdotorg.org, s.hauer@pengutronix.de, shawn.guo@freescale.com, kernel@pengutronix.de, grant.likely@secretlab.ca, rob.herring@calxeda.com, cjb@laptop.org, w.sang@pengutronix.de, linux-mmc@vger.kernel.org

On Wed, May 02, 2012 at 07:31:22PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
> ChangeLog v4->v5:
>  *split arch/arm/mach-imx/* changes into a separate patch
> ChangeLog v3->v4:
>  * call provide dummies in imx*_soc_init().
> ChangeLog v2->v3:
>  * patch name updated.
>    v1 name is ARM: imx6q: switch to use pinctrl driver
>  * using pinctrl dummy state to avoid breaking other platforms to use this
>    driver.
> ChangeLog v1->v2:
>  * using updated binding
> ---
>  arch/arm/boot/dts/imx6q-arm2.dts   |    4 ++++
>  arch/arm/boot/dts/imx6q.dtsi       |   32 ++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-esdhc-imx.c |    9 +++++++++
>  3 files changed, 45 insertions(+), 0 deletions(-)

Since we now have dummy state enabled for imx6q as well, I just split
the patches into following two for better separation, with first one
on my imx/pinctrl/for-3.5 and the second one on imx/dt/for-3.5 branch
respectively.

commit e62d8b8fe73518d1875371a2ee9c5fdd31eba6f8
Author: Dong Aisheng <dong.aisheng@linaro.org>
Date:   Fri May 11 14:56:01 2012 +0800

    mmc: sdhci-imx-esdhc: adopt pinctrl support

    Cc: linux-mmc@vger.kernel.org
    Cc: Chris Ball <cjb@laptop.org>
    Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
    Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
    Acked-by: Stephen Warren <swarren@wwwdotorg.org>

 drivers/mmc/host/sdhci-esdhc-imx.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

commit 551fd208f204780bac1ca5bce1748ba7a6f7ee6e
Author: Dong Aisheng <dong.aisheng@linaro.org>
Date:   Fri May 11 14:58:00 2012 +0800

    ARM: dts: imx6q-arm2: add pinctrl state for usdhc

    Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
    Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

 arch/arm/boot/dts/imx6q-arm2.dts |    4 ++++
 arch/arm/boot/dts/imx6q.dtsi     |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

Please have a check to see if everything is correct.

-- 
Regards,
Shawn
