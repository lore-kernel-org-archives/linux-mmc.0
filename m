From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH 1/2] sdio: add function to enable and disable
 sdio_single_irq optimization
Date: Wed, 1 Jun 2011 09:39:09 +0200
Message-ID: <BANLkTi=pa1hC_nm1HmWRLO+vw_set=py0g@mail.gmail.com>
References: <1306874008-28867-1-git-send-email-per.forlin@linaro.org>
	<1306874008-28867-2-git-send-email-per.forlin@linaro.org>
	<BANLkTinUEq_tvCtXWjg3t6L589y80nPPog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34702 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488Ab1FAHjK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2011 03:39:10 -0400
Received: by iwn34 with SMTP id 34so4230122iwn.19
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2011 00:39:09 -0700 (PDT)
In-Reply-To: <BANLkTinUEq_tvCtXWjg3t6L589y80nPPog@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Daniel Drake <dsd@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org

On 1 June 2011 09:30, Linus Walleij <linus.walleij@linaro.org> wrote:
> 2011/5/31 Per Forlin <per.forlin@linaro.org>:
>
>> +/**
>> + * =A0 =A0 sdio_single_irq_enable - enable or disable SDIO single I=
RQ function
>> + * =A0 =A0 @card: card to enable SDIO single irq
>> + * =A0 =A0 @value: true to enable SDIO single irq function, false t=
o disable
>> + *
>> + * =A0 =A0 If there is only 1 function interrupt registered and SDI=
O single IRQ
>> + * =A0 =A0 is enable, the irq handler is called directly without re=
ading
>> + * =A0 =A0 the CCCR registers
>> + */
>> +void sdio_single_irq_enable(struct mmc_card *card, bool value)
>> +{
>> + =A0 =A0 =A0 card->sdio_single_irq_en =3D value;
>> +}
>> +EXPORT_SYMBOL_GPL(sdio_single_irq_enable);
>
> Can we use a quirk for implementing this for the specific problematic
> card instead?
>
Yes, quirks is the thing I should use.
I'll remove this function and replace it with a quirk. The default
state could then be sdio_single_irq enable and for all none supported
hardware (device ID) sdio_single_irq will be disable.

> Daniel, do you have the vendor and device ID for the problematic
> Libertas card you're working on so this can be quirked explicitly
> in drivers/mmc/core/quirks.c?
>
Even if Daniel fix this issue in libertas it is still good to have a
sdio_single_irq quirk in place for other SDIO devices with the same
hardware issue.

> Yours,
> Linus Walleij
>
Thanks,
Per
