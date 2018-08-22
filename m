From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 04/11] mmc: use SPDX identifier for Renesas drivers
Date: Wed, 22 Aug 2018 11:49:09 +0200
Message-ID: <CAPDyKFpb3kOYh5tms8Q=f=M-+597jyFZSj8dwr5cRz+VHqs_OA@mail.gmail.com>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com> <20180821220233.9202-5-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821220233.9202-5-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 22 August 2018 at 00:02, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, queued for v4.20!

> ---
>
> To be applied individually per subsystem tree. Morimoto-san, could you maybe
> ack this with your Renesas address?

I will add his ack when he sends it.

Kind regards
Uffe

>
>  drivers/mmc/host/renesas_sdhi.h               | 5 +----
>  drivers/mmc/host/renesas_sdhi_core.c          | 5 +----
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 5 +----
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 5 +----
>  drivers/mmc/host/sh_mmcif.c                   | 7 ++-----
>  drivers/mmc/host/tmio_mmc.c                   | 5 +----
>  drivers/mmc/host/tmio_mmc.h                   | 6 +-----
>  drivers/mmc/host/tmio_mmc_core.c              | 5 +----
>  drivers/mmc/host/usdhi6rol0.c                 | 5 +----
>  9 files changed, 10 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
> index f13f798d8506..da1e49c45bec 100644
> --- a/drivers/mmc/host/renesas_sdhi.h
> +++ b/drivers/mmc/host/renesas_sdhi.h
> @@ -1,12 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Renesas Mobile SDHI
>   *
>   * Copyright (C) 2017 Horms Solutions Ltd., Simon Horman
>   * Copyright (C) 2017 Renesas Electronics Corporation
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>
>  #ifndef RENESAS_SDHI_H
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 777e32b0e410..68ece2f183cf 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Renesas SDHI
>   *
> @@ -6,10 +7,6 @@
>   * Copyright (C) 2016-17 Horms Solutions, Simon Horman
>   * Copyright (C) 2009 Magnus Damm
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   * Based on "Compaq ASIC3 support":
>   *
>   * Copyright 2001 Compaq Computer Corporation.
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 35cc0de6be67..a3e03c473bb2 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * DMA support for Internal DMAC with SDHI SD/SDIO controller
>   *
>   * Copyright (C) 2016-17 Renesas Electronics Corporation
>   * Copyright (C) 2016-17 Horms Solutions, Simon Horman
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>
>  #include <linux/bitops.h>
> diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> index 890f192dedbd..f5fcbb5dc8cd 100644
> --- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * DMA support use of SYS DMAC with SDHI SD/SDIO controller
>   *
> @@ -5,10 +6,6 @@
>   * Copyright (C) 2016-17 Sang Engineering, Wolfram Sang
>   * Copyright (C) 2017 Horms Solutions, Simon Horman
>   * Copyright (C) 2010-2011 Guennadi Liakhovetski
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>
>  #include <linux/device.h>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 4c2a1f8ddbf3..81bd9afb0980 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * MMCIF eMMC driver.
>   *
>   * Copyright (C) 2010 Renesas Solutions Corp.
>   * Yusuke Goda <yusuke.goda.sx@renesas.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License.
>   */
>
>  /*
> @@ -1573,6 +1570,6 @@ static struct platform_driver sh_mmcif_driver = {
>  module_platform_driver(sh_mmcif_driver);
>
>  MODULE_DESCRIPTION("SuperH on-chip MMC/eMMC interface driver");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:" DRIVER_NAME);
>  MODULE_AUTHOR("Yusuke Goda <yusuke.goda.sx@renesas.com>");
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> index 43a2ea5cff24..36d8e7db00e6 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Driver for the MMC / SD / SDIO cell found in:
>   *
> @@ -7,10 +8,6 @@
>   * Copyright (C) 2017 Horms Solutions, Simon Horman
>   * Copyright (C) 2007 Ian Molton
>   * Copyright (C) 2004 Ian Molton
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>
>  #include <linux/device.h>
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 5d141f79e175..efa5a1e3e5af 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Driver for the MMC / SD / SDIO cell found in:
>   *
> @@ -8,11 +9,6 @@
>   * Copyright (C) 2016-17 Horms Solutions, Simon Horman
>   * Copyright (C) 2007 Ian Molton
>   * Copyright (C) 2004 Ian Molton
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>
>  #ifndef TMIO_MMC_H
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 261b4d62d2b1..b750f6372dc2 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Driver for the MMC / SD / SDIO IP found in:
>   *
> @@ -10,10 +11,6 @@
>   * Copyright (C) 2007 Ian Molton
>   * Copyright (C) 2004 Ian Molton
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   * This driver draws mainly on scattered spec sheets, Reverse engineering
>   * of the toshiba e800  SD driver and some parts of the 2.4 ASIC3 driver (4 bit
>   * support). (Further 4 bit support from a later datasheet).
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index cdfeb15b6f05..cd8b1b9d4d8a 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1,10 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2013-2014 Renesas Electronics Europe Ltd.
>   * Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
>   */
>
>  #include <linux/clk.h>
> --
> 2.11.0
>
