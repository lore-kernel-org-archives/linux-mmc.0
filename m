From: Per Forlin <per.forlin@stericsson.com>
Subject: Re: [PATCH 3/5] MMC: mmci: Add generic Device Tree bindings to mmci
 core code
Date: Thu, 15 Mar 2012 16:12:21 +0100
Message-ID: <CAFEEs1mQr4hDC6RuvchfWe7HNq67Eh2bPtwyWN-tukw32-V0rg@mail.gmail.com>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
	<1331734803-17954-4-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34577 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964859Ab2COPMV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 11:12:21 -0400
Received: by gghe5 with SMTP id e5so3142523ggh.19
        for <linux-mmc@vger.kernel.org>; Thu, 15 Mar 2012 08:12:21 -0700 (PDT)
In-Reply-To: <1331734803-17954-4-git-send-email-lee.jones@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, arnd@arndb.de, niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org

On Wed, Mar 14, 2012 at 3:20 PM, Lee Jones <lee.jones@linaro.org> wrote=
:
> This adds the necessary bindings for collection of shared
> attributes used in the mmci driver.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> =A0drivers/mmc/host/mmci.c | =A0 43 +++++++++++++++++++++++++++++++++=
++++++++++
> =A01 files changed, 43 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 23b41a5..9132ca8 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -30,6 +30,7 @@
> =A0#include <linux/dma-mapping.h>
> =A0#include <linux/amba/mmci.h>
> =A0#include <linux/pm_runtime.h>
> +#include <linux/of_gpio.h>
>
> =A0#include <asm/div64.h>
> =A0#include <asm/io.h>
> @@ -1056,11 +1057,47 @@ static const struct mmc_host_ops mmci_ops =3D=
 {
> =A0 =A0 =A0 =A0.get_cd =A0 =A0 =A0 =A0 =3D mmci_get_cd,
> =A0};
>
> +#ifdef CONFIG_OF
> +static void mmci_dt_populate_generic_pdata(struct device_node *np,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct mmci_platform_data *pdata)
> +{
> + =A0 =A0 =A0 const void *prop;
> + =A0 =A0 =A0 int len;
> +
> + =A0 =A0 =A0 of_property_read_u32(np, "wp-gpios", &pdata->gpio_wp);
> + =A0 =A0 =A0 if (!pdata->gpio_wp)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->gpio_wp =3D -1;
> +
> + =A0 =A0 =A0 of_property_read_u32(np, "cd-gpios", &pdata->gpio_cd);
> + =A0 =A0 =A0 if (!pdata->gpio_cd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->gpio_cd =3D -1;
> +
> + =A0 =A0 =A0 if (of_get_property(np, "cd-invert", NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->cd_invert =3D true;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->cd_invert =3D false;
> +
> + =A0 =A0 =A0 of_property_read_u32(np, "clock_frequency", &pdata->f_m=
ax);
> + =A0 =A0 =A0 if (!pdata->f_max)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s has no 'clock_frequency'=
 property\n", np->full_name);
> +
> + =A0 =A0 =A0 if (of_get_property(np, "mmc_cap_4_bit_data", NULL))
I have no previous experience with DT. Could you please bring some
light on this.
Is it really necessary to represent each bit in the CAP with a string?
To add CAP_ERASE for instance I need to change the code here and
update the DT, right?

BR
Per
