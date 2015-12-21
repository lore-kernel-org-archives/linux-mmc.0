From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 01/17] mmc: core: shut up "voltage-ranges unspecified" pr_info()
Date: Mon, 21 Dec 2015 11:18:15 +0100
Message-ID: <CAPDyKFqcZf+AsfDKSupVdrxcbwifQiYgyPkypaSYWu4vpqz4dg@mail.gmail.com>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
	<E1aAO8O-0007xP-Do@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:32888 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbbLUKSQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 05:18:16 -0500
Received: by mail-yk0-f180.google.com with SMTP id 140so126132275ykp.0
        for <linux-mmc@vger.kernel.org>; Mon, 21 Dec 2015 02:18:16 -0800 (PST)
In-Reply-To: <E1aAO8O-0007xP-Do@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>

On 19 December 2015 at 21:29, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> Each time a driver such as sdhci-esdhc-imx is probed, we get a info
> printk complaining that the DT voltage-ranges property has not been
> specified.
>
> However, the DT binding specifically says that the voltage-ranges
> property is optional.  That means we should not be complaining that
> DT hasn't specified this property: by indicating that it's optional,
> it is valid not to have the property in DT.

Agree!

>
> Silence the warning if the property is missing.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/mmc/core/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 5ae89e48fd85..b5e663b67cb5 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1220,8 +1220,12 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
>
>         voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
>         num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
> -       if (!voltage_ranges || !num_ranges) {
> -               pr_info("%s: voltage-ranges unspecified\n", np->full_name);
> +       if (!voltage_ranges) {
> +               pr_debug("%s: voltage-ranges unspecified\n", np->full_name);
> +               return -EINVAL;

Because it's optional, I don't think we should return an error code here.

> +       }
> +       if (!num_ranges) {
> +               pr_err("%s: voltage-ranges empty\n", np->full_name);
>                 return -EINVAL;

Ditto.

>         }
>
> --
> 2.1.0
>

Kind regards
Uffe
