From: Per Forlin <per.forlin@linaro.org>
Subject: Re: SDIO single IRQ optimization breaks libertas
Date: Tue, 31 May 2011 17:03:20 +0200
Message-ID: <BANLkTi=EuDmUnOdW0dQVtHUPEq9AGqbZKA@mail.gmail.com>
References: <BANLkTi=xWwWh2z2r3THvf5DzvhUCX_ZB7A@mail.gmail.com>
	<BANLkTi=Y3rq_xnq5m6wj97uHHi5+ZCpURQ@mail.gmail.com>
	<loom.20110530T111921-497@post.gmane.org>
	<alpine.LFD.2.00.1105301028310.30544@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62947 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265Ab1EaPDX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2011 11:03:23 -0400
Received: by iwn34 with SMTP id 34so3690520iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2011 08:03:22 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1105301028310.30544@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: linux-mmc@vger.kernel.org

On 30 May 2011 16:38, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Mon, 30 May 2011, Per Forlin wrote:
>
>> Hi Daniel,
>>
>> >
>> > On 29 May 2011 15:26, Daniel Drake <dsd <at> laptop.org> wrote:
>> > > Hi,
>> > >
>> > > The following commit in 2.6.39 causes instant death for libertas=
_sdio
>> > > when it receives its first interrupt during initialization:
>> > >
>> > > commit 06e8935febe687e2a561707d4c7ca4245d261dbe
>> >
>> > The crash happens on this line of code in if_sdio_interrupt:
>> >
>> > cause =3D sdio_readb(card->func, IF_SDIO_H_INT_STATUS, &ret);
>> >
>> > card is NULL here
>> Thanks for you detailed report. It fails due to sdio_get_drvdata() r=
eturns NULL.
>>
>> I am thinking of if the timing has changed due to this "single irq" =
patch or if
>> the functionality is broken.
>> To answer that I have a question on the if_sdio.c in libertas.
>>
>> if_sdio.c
>> =A0sdio_claim_host();
>> =A0sdio_claim_irq()
>> =A0...
>> =A0sdio_release_host()
>> =A0sdio_set_drvdata(func, card)
>
> This looks wrong to me. =A0the driver must be ready to receive interr=
upts
> the moment it registers for it, or make sure the hardware is not
> generating any.
>
>> Just a sanity question, can the interrupt occur before sdio_set_drvd=
ata()?
>
> What might be happening here is that for some reasons the card is
> asserting the interrupt line, but none of the function bits in CCCR_I=
NTx
> is set.
>
I think your assumption is correct. I didn't know this could happen.
I propose to let the client decide whether use make sdio_irq_single or
not, default is no. I'll make patch for it.

Thanks,
Per
