From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pxamci: fix card detect threaded interrupt
Date: Wed, 16 Sep 2015 09:24:19 +0200
Message-ID: <CAPDyKFr6-hjiUUrcbZzmkykasMFDSXUPvpPvyM=UfaOX48cdwA@mail.gmail.com>
References: <1442048611-23314-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38669 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbbIPHYV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Sep 2015 03:24:21 -0400
Received: by wiclk2 with SMTP id lk2so57391859wic.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2015 00:24:20 -0700 (PDT)
In-Reply-To: <1442048611-23314-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Cvek <petr.cvek@tul.cz>

On 12 September 2015 at 11:03, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Change the interrupt flavor of the card detection, from a hard interrupt
> to a threaded interrupt. There is no strong requirement for a hard
> interrupt.
>
> It fixes the case where the card detection is on a gpio expander, on I2C
> for example on zylonite board. In this case, the card detect netsted
> interrupt is called from a threaded interrupt. The request_irq() fails,
> because a hard irq cannot be a nested interrupt from a threaded
> interrupt (set __setup_irq()).
>
> This was tested on zylonite and mioa701 boards.

This may indeed fix that separate issue, but looking into pxamci
driver I realize that the card detect configuration suffers from other
issues as well.

1. The irq shouldn't be requested until after the host has been added.
Else an IRQ will call mmc_detect_change() with a non-added mmc host,
which is really a bad idea. :-)
2. The host_ops->get_cd() callback isn't assigned. Thus not allowing
the mmc core to find out whether the card is inserted or not.

So instead of this quick-fix, I suggest that pxamci convert to use the
mmc slot-gpio API, which means calling mmc_gpio[d]_request_cd() from
->probe() and assign the ->get_cd() callback, which use
mmc_gpio_get_cd().

What do you think?

Kind regards
Uffe

>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Petr Cvek <petr.cvek@tul.cz>
> ---
>  drivers/mmc/host/pxamci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 1420f29628c7..67c9d1443597 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -814,8 +814,10 @@ static int pxamci_probe(struct platform_device *pdev)
>                 }
>                 gpio_direction_input(gpio_cd);
>
> -               ret = request_irq(gpio_to_irq(gpio_cd), pxamci_detect_irq,
> -                                 IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +               ret = request_threaded_irq(gpio_to_irq(gpio_cd), NULL,
> +                                 pxamci_detect_irq,
> +                                 IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
> +                                 IRQF_ONESHOT,
>                                   "mmc card detect", mmc);
>                 if (ret) {
>                         dev_err(&pdev->dev, "failed to request card detect IRQ\n");
> --
> 2.1.4
>
