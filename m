From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v13 0/6] Cavium MMC driver
Date: Mon, 10 Apr 2017 16:50:41 +0200
Message-ID: <CAPDyKFpJus91LyWdwFAn0nYHNBdCTeMd7yW8jUq=gWF94-OyFQ@mail.gmail.com>
References: <20170330153128.22842-1-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:34417 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753645AbdDJOun (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Apr 2017 10:50:43 -0400
Received: by mail-ua0-f170.google.com with SMTP id u103so39834451uau.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 Apr 2017 07:50:43 -0700 (PDT)
In-Reply-To: <20170330153128.22842-1-jglauber@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: David Daney <david.daney@cavium.com>, "Steven J . Hill" <steven.hill@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 30 March 2017 at 17:31, Jan Glauber <jglauber@cavium.com> wrote:
> Hi Ulf,
>
> we have a bug on some Octeon plattforms so I removed the Octeon driver for now
> (but kept the DT bindings for it). We'll submit the Octeon driver later when
> we've fixed the issue.
>
> Changes to v12:
> - dts: use generic "mmc-slot" for slots
> - dts: mention deprecated power gpio
> - Rename driver files
> - Use hardcoded voltage instead of mmc_of_parse_voltage()
> - Phase out gpiod usage from cavium.c
> - Change DT property scan order
> - Clean up bus_width setting
> - Use GPIOLIB depend for ThunderX driver
> - ThunderX: Remove TODO
> - ThunderX: Move platform pointers to host struct
> - Check slot node compatible string
> - Remove gpio includes from ThunderX driver
>
> Changes to v11:
> - Fix build error and kill IS_ENABLED() by using an offset per arch
> - Added Rob's ACK for the DT bindings
> - Removed obsolete voltage-ranges from DT example
> - Replace pci_msix_enable() with pci_alloc_irq_vectors()
> - Remove superior hardware comment
> - Prefixed probe/removal functions with of_
> - Merged OF parsing code into one function, change order of property
>   lookup and simplify code
> - Removed slot->sclock, no need to store it there
> - Substituted now invisible mmc_card_blockaddr()
> - Use new 3.3V CAP for DDR
> - Update Copyright
> - Allow set_ios to set clock to zero
> - Converted bitfields to shift-n-mask logic
> - Improved error codes after receiving error interrupt
> - Added ifndef guards to header
> - Add meaningful interrupt names
> - Remove stale mmc_host_ops prototype
>
> Changes to v10:
> - Renamed files to get a common prefix
> - Select GPIO driver in Kconfig
> - Support a fixed regulator
> - dts: fixed quotes and re-ordered example
> - Use new MMC_CAP_3_3V_DDR instead of 1_8V hack
> - Use blksz instead of now internal mmc_card_blockaddr
> - Added some maintainers
>
> Previous versions:
> v10: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1295316.html
> v9:  http://marc.info/?l=linux-mmc&m=147431759215233&w=2
>
> Cheers,
> Jan

Thanks, applied for next! Amending patch 3 with the fix you posted on top.

Kind regards
Uffe

>
> -------
>
>
> Jan Glauber (6):
>   dt-bindings: mmc: Add Cavium SOCs MMC bindings
>   mmc: cavium: Add core MMC driver for Cavium SOCs
>   mmc: cavium: Add MMC PCI driver for ThunderX SOCs
>   mmc: cavium: Add scatter-gather DMA support
>   mmc: cavium: Support DDR mode for eMMC devices
>   MAINTAINERS: Add entry for Cavium MMC driver
>
>  .../devicetree/bindings/mmc/cavium-mmc.txt         |   57 +
>  MAINTAINERS                                        |    8 +
>  drivers/mmc/host/Kconfig                           |   10 +
>  drivers/mmc/host/Makefile                          |    2 +
>  drivers/mmc/host/cavium-thunderx.c                 |  198 ++++
>  drivers/mmc/host/cavium.c                          | 1090 ++++++++++++++++++++
>  drivers/mmc/host/cavium.h                          |  215 ++++
>  7 files changed, 1580 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/cavium-mmc.txt
>  create mode 100644 drivers/mmc/host/cavium-thunderx.c
>  create mode 100644 drivers/mmc/host/cavium.c
>  create mode 100644 drivers/mmc/host/cavium.h
>
> --
> 2.9.0.rc0.21.g7777322
>
