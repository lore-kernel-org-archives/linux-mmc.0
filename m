From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH V2 0/3] Add SDHCI driver for Broadcom BRCMSTB/BMIPS Soc's
Date: Wed, 11 Nov 2015 17:37:03 -0800
Message-ID: <5643ED3F.7000908@gmail.com>
References: <1446836164-16259-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33514 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbbKLBh5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Nov 2015 20:37:57 -0500
Received: by pabfh17 with SMTP id fh17so47781875pab.0
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2015 17:37:57 -0800 (PST)
In-Reply-To: <1446836164-16259-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Al Cooper <alcooperx@gmail.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

On 06/11/15 10:56, Al Cooper wrote:
> This patchset adds the SDHCI driver for the Broadcom BRCMSTB/BMIPS
> Soc's. A few new Device Tree properties, needed by this driver,
> were added to sdhci-pltfm.c to set various QUIRKS. The mmc.txt
> bindings document was update with the both new and existing
> properties handled by sdhci-pltfm.c

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Looks good to me, thanks!

> 
> V2 - Don't create a new QUIRK to handle broken SDR50 mode in
>      the controller. The functionality was moved into the
>      sdhci-brcmstb driver.
> 
> Al Cooper (3):
>   mmc: sdhci-pltfm: Add DT properties to set various QUIRKS
>   mmc: Add Device Tree binding supported by sdhci-pltfm.c
>   mmc: sdhci-brcmstb: Add sdhci driver for Broadcom BRCMSTB/BMIPS SOCs
> 
>  Documentation/devicetree/bindings/mmc/mmc.txt      |   8 ++
>  .../devicetree/bindings/mmc/sdhci-brcmstb.txt      |  36 +++++
>  drivers/mmc/host/Kconfig                           |  12 ++
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/sdhci-brcmstb.c                   | 158 +++++++++++++++++++++
>  drivers/mmc/host/sdhci-pltfm.c                     |   8 +-
>  6 files changed, 222 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-brcmstb.txt
>  create mode 100644 drivers/mmc/host/sdhci-brcmstb.c
> 


-- 
Florian
