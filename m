From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH v5 0/5] Add intial support to DW MMC host on ZTE SoC
Date: Mon, 14 Nov 2016 11:21:13 +0800
Message-ID: <CABymUCMfZwzvkZvOFCCsic46A1t-SD8uFqBBRyqnTgmFbTikzQ@mail.gmail.com>
References: <1478568298-18380-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36625 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932822AbcKNDVP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Nov 2016 22:21:15 -0500
Received: by mail-qk0-f171.google.com with SMTP id n21so81853900qka.3
        for <linux-mmc@vger.kernel.org>; Sun, 13 Nov 2016 19:21:14 -0800 (PST)
In-Reply-To: <1478568298-18380-1-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, "xie.baoyou" <xie.baoyou@zte.com.cn>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Jason Liu <jason.liu@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Jun Nie <jun.nie@linaro.org>

2016-11-08 9:24 GMT+08:00 Jun Nie <jun.nie@linaro.org>:
> Add intial support to DW MMC host on ZTE SoC. It include platform
> specific wrapper driver and workarounds for fifo quirk.
>
> Patches are prepared based on latest dw mmc runtime change:
>    https://github.com/jh80chung/dw-mmc.git for-ulf
>
> Changes vs version 4:
>   - Fix missing empty dts compatible element in the end of compatible array.
>
> Changes vs version 3:
>   - Fix brace error in document.
>
> Changes vs version 2:
>   - Change dt property fifo-addr to data-addr and fifo-watermark-quirk to
>     fifo-watermark-aligned.
>   - Polish ZX MMC driver on minor coding style issues.
>
> Changes vs version 1:
>   - Change fifo-addr-override to fifo-addr and remove its workaround tag in comments.
>   - Remove ZX DW MMC driver reset cap in driver, which can be added in dt nodes.
>
> Jun Nie (5):
>   mmc: dt-bindings: add ZTE ZX296718 MMC bindings
>   mmc: zx: Initial support for ZX mmc controller
>   Documentation: synopsys-dw-mshc: add binding for fifo quirks
>   mmc: dw: Add fifo address property
>   mmc: dw: Add fifo watermark alignment property
>
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  13 ++
>  .../devicetree/bindings/mmc/zx-dw-mshc.txt         |  34 +++
>  drivers/mmc/host/Kconfig                           |   9 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/dw_mmc-zx.c                       | 242 +++++++++++++++++++++
>  drivers/mmc/host/dw_mmc-zx.h                       |  31 +++
>  drivers/mmc/host/dw_mmc.c                          |  17 +-
>  include/linux/mmc/dw_mmc.h                         |   5 +
>  8 files changed, 349 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
>  create mode 100644 drivers/mmc/host/dw_mmc-zx.c
>  create mode 100644 drivers/mmc/host/dw_mmc-zx.h
>
> --
> 1.9.1
>

Jaehoon Chung,

I assume you do not have more comments on this serial patches, neither
from community. If so, could you help merge them to your trees so that
it can go to mainline later?

Thank you!
Jun
