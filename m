From: Chip Doc <chipdoc555@gmail.com>
Subject: eMMC issue in linux 3.16 & 3.17
Date: Mon, 20 Oct 2014 13:43:45 -0400
Message-ID: <CAGv=n3em6zj-VcFQXjcGeScrrHVOHSswqjrMRwg+8dxckw=YGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:52142 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbaJTRnq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Oct 2014 13:43:46 -0400
Received: by mail-pa0-f68.google.com with SMTP id kq14so3170371pab.7
        for <linux-mmc@vger.kernel.org>; Mon, 20 Oct 2014 10:43:45 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I am building a custom linux kernel and testing on an ECS LIVA system.
It has a 32GB eMMC flash drive built-in. I tested 3.13.10, 3.14.22 and
3.15.10 kernels and they recognize the device fine, but the 3.16.6 and
3.17.1 kernels do not.

When the kernel works I see this:

mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA

When the kernel doesn't work, I get nothing in the log for the device.

My relevant .config is:

CONFIG_MMC=y
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_CLKGATE is not set

#
# MMC/SD/SDIO Card Drivers
#
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_MMC_BLOCK_BOUNCE=y
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PCI=y
# CONFIG_MMC_RICOH_MMC is not set
CONFIG_MMC_SDHCI_ACPI=y
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_WBSD=m
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_SPI=m
CONFIG_MMC_SDRICOH_CS=m
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
CONFIG_MMC_USDHI6ROL0=m
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y


Are there any known config changes that I might be missing in 3.16? If
so, I would be happy to post the full .config. Please let me know if
there is anything I can do it help narrow this down.


- C
