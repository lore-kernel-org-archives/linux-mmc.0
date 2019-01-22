From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 1/1] mmc: dw_mmc-bluefield: : Fix the license information
Date: Tue, 22 Jan 2019 08:48:09 +0100
Message-ID: <CAPDyKFp6nK-cWOHdSARsgU6N0gsV3srL2pH2Y5VYiwC-pkXwpg@mail.gmail.com>
References: <7f45f1c645ec166b25afe51aa9ae1decdae0b600.1547834838.git.lsun@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7f45f1c645ec166b25afe51aa9ae1decdae0b600.1547834838.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liming Sun <lsun@mellanox.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaehoon Chung <jh80.chung@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Greg KH <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, David Woods <dwoods@mellanox.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 18 Jan 2019 at 19:12, Liming Sun <lsun@mellanox.com> wrote:
>
> The SPDX license identifier and the boiler plate text are
> contradicting. Only the SPDX license identifier is needed. The
> other one is removed.
>
> Fixes: 86958dcc5ad7 ("mmc: dw_mmc-bluefield: Add driver extension")
> Cc: stable@vger.kernel.org
> Reviewed-by: David Woods <dwoods@mellanox.com>
> Signed-off-by: Liming Sun <lsun@mellanox.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-bluefield.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
> index ed8f225..aa38b1a 100644
> --- a/drivers/mmc/host/dw_mmc-bluefield.c
> +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> @@ -1,11 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2018 Mellanox Technologies.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>   */
>
>  #include <linux/bitfield.h>
> --
> 1.8.3.1
>
