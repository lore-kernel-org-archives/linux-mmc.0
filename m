From: Christian Daudt <bcm@fixthebug.org>
Subject: Re: [PATCH v2 3/4] rename ARCH_BCM to ARCH_BCM_MOBILE (mmc)
Date: Fri, 13 Dec 2013 09:59:44 -0800
Message-ID: <CAEPRUYoCo9q_xq_0=OqgtmYpchVWGrJkQdnrj5Yk4SkAfNrLiQ@mail.gmail.com>
References: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
	<1379956836-5866-4-git-send-email-bcm@fixthebug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60370 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab3LMR7p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Dec 2013 12:59:45 -0500
Received: by mail-ee0-f46.google.com with SMTP id d49so1026186eek.19
        for <linux-mmc@vger.kernel.org>; Fri, 13 Dec 2013 09:59:44 -0800 (PST)
In-Reply-To: <1379956836-5866-4-git-send-email-bcm@fixthebug.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>
Cc: Domenico Andreoli <cavokz@gmail.com>, Christian Daudt <csd@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>, Matt Porter <matt.porter@linaro.org>, Alex Elder <alex.elder@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Christian Daudt <bcm@fixthebug.org>

On Mon, Sep 23, 2013 at 10:20 AM, Christian Daudt <bcm@fixthebug.org> wrote:
> Currently ARCH_BCM has been used for Broadcom
> Mobile V7 based SoCs. In order to allow other Broadcom
> SoCs to also use mach-bcm directory and files, this patch
> renames the original ARCH_BCM to ARCH_BCM_MOBILE, and
> uses ARCH_BCM to define any Broadcom chip residing
> in mach-bcm directory.
>
> Signed-off-by: Christian Daudt <bcm@fixthebug.org>
> Acked-by: Olof Johansson <olof@lixom.net>
>
> Changes from v1:
>  - fix alpha ordering in dts/Makefile
>  - break into 4 patches for separate subsys
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 7fc5099..7e89650 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -251,7 +251,7 @@ config MMC_SDHCI_S3C_DMA
>
>  config MMC_SDHCI_BCM_KONA
>         tristate "SDHCI support on Broadcom KONA platform"
> -       depends on ARCH_BCM
> +       depends on ARCH_BCM_MOBILE
>         select MMC_SDHCI_PLTFM
>         help
>           This selects the Broadcom Kona Secure Digital Host Controller
> --
> 1.7.10.4
>
Chris,
 This is the last unacked piece of this patchset - could you pls
review it ? Also let me know if you're pulling it in or if you want me
to pull it into bcm to armsoc.

 Thanks,
   csd
