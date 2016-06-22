From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V7 0/2] Add SDHCI driver for Broadcom BRCMSTB/BMIPS Soc's
Date: Wed, 22 Jun 2016 17:23:36 +0200
Message-ID: <CAPDyKFrh=+xOT1AnYayRpAkK1vUyDzP5hpezWTf6KNAvi0tpww@mail.gmail.com>
References: <1466095637-27895-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36512 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbcFVPXk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2016 11:23:40 -0400
Received: by mail-wm0-f41.google.com with SMTP id f126so92381153wma.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jun 2016 08:23:39 -0700 (PDT)
In-Reply-To: <1466095637-27895-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Al Cooper <alcooperx@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com

On 16 June 2016 at 18:47, Al Cooper <alcooperx@gmail.com> wrote:
> V7 - Don't select SDHCI I/O ACCESSORS in Kconfig for MMC_SDHCI_BRCMSTB
>      because they are no longer used.
> V6 - Call clk_disable_unprepare() on errors in probe function.
>      Improve commit message.
> V5 - Don't create new device tree properties to disable broken UHS
>      modes. Use devm_clk_get() to get clk and change
>      clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
> V4 - Change the DT compatible property to "brcm,bcm7425-sdhci".
>      Add "clocks" property to DT bindings document.
> V3 - Don't add new QUIRKS to workaround Host Controller issues.
>      It turns out that all the issues could be solved by using
>      SDHCI_QUIRK_MISSING_CAPS to supply modified "caps" and "caps1"
>      Host Controller registers.
>
> Al Cooper (2):
>   mmc: sdhci-brcmstb: Add driver for Broadcom BRCMSTB SoCs
>   mmc: DT: sdhci-brcmstb: Add device tree bindings
>
>  .../devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt |  36 ++++++
>  MAINTAINERS                                        |   7 +
>  drivers/mmc/host/Kconfig                           |  10 ++
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/sdhci-brcmstb.c                   | 143 +++++++++++++++++++++
>  5 files changed, 197 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt
>  create mode 100644 drivers/mmc/host/sdhci-brcmstb.c
>
> --
> 1.9.0.138.g2de3478
>

Thanks, applied for next!

Kind regards
Uffe
