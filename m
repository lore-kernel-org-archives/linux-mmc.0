From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND 2/3] mmc: mvsdio: workaround for spurious irqs
Date: Mon, 28 Apr 2014 13:02:42 +0200
Message-ID: <CAPDyKFrd0zeUy-Umm6GQ0oVonFU4VRcwGL5zYqVYmMSPeEmogg@mail.gmail.com>
References: <1398540855-27367-1-git-send-email-sebastian.hesselbarth@gmail.com>
	<1398540855-27367-3-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:54578 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212AbaD1LCn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Apr 2014 07:02:43 -0400
Received: by mail-qa0-f49.google.com with SMTP id dc16so2831278qab.36
        for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2014 04:02:42 -0700 (PDT)
In-Reply-To: <1398540855-27367-3-git-send-email-sebastian.hesselbarth@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Chris Ball <chris@printf.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 26 April 2014 21:34, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> SDIO controllers found on Marvell Kirkwood SoCs seem to cause a late,
> spurious irq although all interrupts have been disabled. This irq
> doesn't do any harm, neither to HW nor driver. To avoid some
> "unexpected irq" warning later, we workaround above issue by bailing
> out of irq handler early, if we didn't expect any.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> ---
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Chris Ball <chris@printf.net>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/host/mvsdio.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index 41aca7f28c23..9377284f8544 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -354,6 +354,20 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>                 intr_status, mvsd_read(MVSD_NOR_INTR_EN),
>                 mvsd_read(MVSD_HW_STATE));
>
> +       /*
> +        * It looks like, SDIO IP can issue one late, spurious irq
> +        * although all irqs should be disabled. To work around this,
> +        * bail out early, if we didn't expect any irqs to occur.
> +        */
> +       if (!mvsd_read(MVSD_NOR_INTR_EN) && !mvsd_read(MVSD_ERR_INTR_EN)) {
> +               dev_dbg(host->dev, "spurious irq detected intr 0x%04x intr_en 0x%04x erri 0x%04x erri_en 0x%04x\n",
> +                       mvsd_read(MVSD_NOR_INTR_STATUS),
> +                       mvsd_read(MVSD_NOR_INTR_EN),
> +                       mvsd_read(MVSD_ERR_INTR_STATUS),
> +                       mvsd_read(MVSD_ERR_INTR_EN));
> +               return IRQ_HANDLED;
> +       }
> +
>         spin_lock(&host->lock);
>
>         /* PIO handling, if needed. Messy business... */
> --
> 1.9.1
>
