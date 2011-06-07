From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH 2/2] sdio: report error if pending IRQ but none function bits
Date: Tue, 7 Jun 2011 09:02:58 +0200
Message-ID: <BANLkTimhzdAoXSCD0xfGwOMDE9+gbrt53A@mail.gmail.com>
References: <1306874008-28867-1-git-send-email-per.forlin@linaro.org>
	<1306874008-28867-3-git-send-email-per.forlin@linaro.org>
	<alpine.LFD.2.00.1106011029390.30544@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:50828 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab1FGHC7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2011 03:02:59 -0400
Received: by qyk7 with SMTP id 7so1176609qyk.19
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2011 00:02:58 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1106011029390.30544@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, Daniel Drake <dsd@laptop.org>, Chris Ball <cjb@laptop.org>

On 1 June 2011 16:30, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 31 May 2011, Per Forlin wrote:
>
>> Return error in case of pending IRQ but none functions bits
>> in CCCR_INTx is set.
>>
>> Signed-off-by: Per Forlin <per.forlin@linaro.org>
>> ---
>> =A0drivers/mmc/core/sdio_irq.c | =A0 =A05 +++++
>> =A01 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq=
=2Ec
>> index 2f81ddc..8184b6e 100644
>> --- a/drivers/mmc/core/sdio_irq.c
>> +++ b/drivers/mmc/core/sdio_irq.c
>> @@ -50,6 +50,11 @@ static int process_sdio_pending_irqs(struct mmc_c=
ard *card)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (!pending) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: pending IRQ but n=
one function bits\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_card_id(card));
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 }
>
> Nope, this won't work with the polled interrupt mode.
I'll drop this patch.

Thanks for your comment,
Per
