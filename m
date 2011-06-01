From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] sdio: add function to enable and disable
 sdio_single_irq optimization
Date: Wed, 1 Jun 2011 09:30:58 +0200
Message-ID: <BANLkTinUEq_tvCtXWjg3t6L589y80nPPog@mail.gmail.com>
References: <1306874008-28867-1-git-send-email-per.forlin@linaro.org>
	<1306874008-28867-2-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57261 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab1FAHa7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2011 03:30:59 -0400
Received: by iyb14 with SMTP id 14so4251861iyb.19
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2011 00:30:59 -0700 (PDT)
In-Reply-To: <1306874008-28867-2-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>, Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org

2011/5/31 Per Forlin <per.forlin@linaro.org>:

> +/**
> + * =A0 =A0 sdio_single_irq_enable - enable or disable SDIO single IR=
Q function
> + * =A0 =A0 @card: card to enable SDIO single irq
> + * =A0 =A0 @value: true to enable SDIO single irq function, false to=
 disable
> + *
> + * =A0 =A0 If there is only 1 function interrupt registered and SDIO=
 single IRQ
> + * =A0 =A0 is enable, the irq handler is called directly without rea=
ding
> + * =A0 =A0 the CCCR registers
> + */
> +void sdio_single_irq_enable(struct mmc_card *card, bool value)
> +{
> + =A0 =A0 =A0 card->sdio_single_irq_en =3D value;
> +}
> +EXPORT_SYMBOL_GPL(sdio_single_irq_enable);

Can we use a quirk for implementing this for the specific problematic
card instead?

Daniel, do you have the vendor and device ID for the problematic
Libertas card you're working on so this can be quirked explicitly
in drivers/mmc/core/quirks.c?

Yours,
Linus Walleij
