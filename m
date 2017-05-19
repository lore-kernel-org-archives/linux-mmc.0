From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: core: Use device_property_read instead of of_property_read
Date: Fri, 19 May 2017 10:23:54 +0200
Message-ID: <CAPDyKFq-LSBr79ej06p2F_GcJeOMnuuJvOO0XgjaGCHoU1RpUQ@mail.gmail.com>
References: <1495059429-15247-1-git-send-email-dwoods@mellanox.com> <1495059429-15247-2-git-send-email-dwoods@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35478 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755671AbdESIYB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 May 2017 04:24:01 -0400
Received: by mail-qk0-f174.google.com with SMTP id a72so55297813qkj.2
        for <linux-mmc@vger.kernel.org>; Fri, 19 May 2017 01:24:00 -0700 (PDT)
In-Reply-To: <1495059429-15247-2-git-send-email-dwoods@mellanox.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Woods <dwoods@mellanox.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Heiner Kallweit <hkallweit1@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, cmetcalf@mellanox.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable@vger.linux.org

On 18 May 2017 at 00:17, David Woods <dwoods@mellanox.com> wrote:
> Using the device_property interfaces allows mmc drivers to work
> on platforms which run on either device tree or ACPI.
>
> Signed-off-by: David Woods <dwoods@mellanox.com>
> Reviewed-by: Chris Metcalf <cmetcalf@mellanox.com>
> Cc: stable@vger.linux.org
> ---
>  drivers/mmc/core/host.c | 72 ++++++++++++++++++++++++-------------------------
>  1 file changed, 35 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 3f8c85d..d2c059e 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -176,19 +176,17 @@ static void mmc_retune_timer(unsigned long data)
>   */
>  int mmc_of_parse(struct mmc_host *host)
>  {
> -       struct device_node *np;
> +       struct device *dev = host->parent;
>         u32 bus_width;
>         int ret;
>         bool cd_cap_invert, cd_gpio_invert = false;
>         bool ro_cap_invert, ro_gpio_invert = false;
>
> -       if (!host->parent || !host->parent->of_node)
> +       if (!dev)
>                 return 0;
>

So earlier we stopped executing the OF parsing at this point, unless
we had valid a of_node pointer. To be safe, I think we need to do
something similar here.

In other words, perhaps check the result from dev_fwnode(), before continue.

[...]

mmc_pwrseq_alloc() is called from mmc_of_parse() which currently only
supports OF parsing. I assume you would like to convert that as well?
Perhaps that should even be the first step?

Kind regards
Uffe
