From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH mmc/next v3 0/4] mmc: renesas_sdhi: add support for R-Car
 Gen3 SDHI DMAC
Date: Tue, 11 Jul 2017 16:43:00 +0200
Message-ID: <CAPDyKFqBUi36_AAOHmNhH-0p4jD9wNLOor19k0g0H3s78_geyg@mail.gmail.com>
References: <1498053630-7780-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:36581 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933330AbdGKOnL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jul 2017 10:43:11 -0400
Received: by mail-yw0-f170.google.com with SMTP id a12so1439545ywh.3
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jul 2017 07:43:11 -0700 (PDT)
In-Reply-To: <1498053630-7780-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 21 June 2017 at 16:00, Simon Horman <horms+renesas@verge.net.au> wrote:
> Hi,
>
> this series adds support for the internal DMAC used by r8a779[56] SoCs.
> This is achieved by adding a new variant of the SDHI driver for this
> DMA controller with compat strings for the r8a779[56] SoCs.
> Compat strings for these SoCs are also removed from the existing SYS DMAC
> variant of the SDHI driver.
>
> Based on mmc/next
>
> Headline performance boost: 9.5MB/s -> 39.7MB/s
> Details below.
>
> Simon Horman (3):
>   mmc: tmio, renesas-sdhi: add dataend to DMA ops
>   mmc: renesas-sdhi: add support for R-Car Gen3 SDHI DMAC
>   mmc: renesas-sdhi: remove gen3 support from SYS-DMAC driver
>
> Yoshihiro Shimoda (1):
>   mmc: tmio, renesas-sdhi: add max_{segs,blk_count} to tmio_mmc_data
>
>  drivers/mmc/host/Kconfig                      |  19 ++
>  drivers/mmc/host/Makefile                     |   8 +-
>  drivers/mmc/host/renesas_sdhi.h               |   2 +
>  drivers/mmc/host/renesas_sdhi_core.c          |   2 +
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 271 ++++++++++++++++++++++++++
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  29 +--
>  drivers/mmc/host/tmio_mmc.h                   |   2 +
>  drivers/mmc/host/tmio_mmc_core.c              |  16 +-
>  include/linux/mfd/tmio.h                      |   2 +
>  9 files changed, 323 insertions(+), 28 deletions(-)
>  create mode 100644 drivers/mmc/host/renesas_sdhi_internal_dmac.c

Thanks, applied patch 1->3 for next!

[...]

Kind regards
Uffe
