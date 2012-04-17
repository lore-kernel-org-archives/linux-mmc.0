From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] mmc: cd-gpio.c: Include header to pickup exported symbol prototypes
Date: Tue, 17 Apr 2012 13:47:46 +0530
Message-ID: <CANfBPZ_AhMpgX5L+Z62LekBLnsFytLAJi9pN6fRPcujh95iK+A@mail.gmail.com>
References: <201204161824.26879.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:46609 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755061Ab2DQISJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 Apr 2012 04:18:09 -0400
Received: by bkwj10 with SMTP id j10so4521884bkw.10
        for <linux-mmc@vger.kernel.org>; Tue, 17 Apr 2012 01:18:07 -0700 (PDT)
In-Reply-To: <201204161824.26879.hartleys@visionengravers.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, cjb@laptop.org, g.liakhovetski@gmx.de

On Tue, Apr 17, 2012 at 6:54 AM, H Hartley Sweeten
<hartleys@visionengravers.com> wrote:
> Include the linux/mmc/cd-gpio.h header to pickup the prototypes
> for the two exported symbols.
>
> This quiets the sparse warnings:
>
> warning: symbol 'mmc_cd_gpio_request' was not declared. Should it be =
static?
> warning: symbol 'mmc_cd_gpio_free' was not declared. Should it be sta=
tic?
>
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>
I posted a similar patch on friday. But yours has a more verbose commit=
 log.
Acked-by: Venkatraman S <svenkatr@ti.com>

> ---
>
> diff --git a/drivers/mmc/core/cd-gpio.c b/drivers/mmc/core/cd-gpio.c
> index 29de31e..da7c3f9 100644
> --- a/drivers/mmc/core/cd-gpio.c
> +++ b/drivers/mmc/core/cd-gpio.c
> @@ -13,6 +13,7 @@
> =A0#include <linux/interrupt.h>
> =A0#include <linux/jiffies.h>
> =A0#include <linux/mmc/host.h>
> +#include <linux/mmc/cd-gpio.h>
> =A0#include <linux/module.h>
> =A0#include <linux/slab.h>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
