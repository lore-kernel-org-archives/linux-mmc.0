From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: SD power-control necessary?
Date: Fri, 7 Jan 2011 16:48:44 +0100
Message-ID: <AANLkTi=018==gJeCQFp-SpMiJ7Y03ZZKncBibrwJsE=H@mail.gmail.com>
References: <4D272592.6000508@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54620 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab1AGPso convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jan 2011 10:48:44 -0500
Received: by pwj3 with SMTP id 3so2352108pwj.19
        for <linux-mmc@vger.kernel.org>; Fri, 07 Jan 2011 07:48:44 -0800 (PST)
In-Reply-To: <4D272592.6000508@yahoo.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hein_Tibosch <hein_tibosch@yahoo.es>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

2011/1/7 Hein_Tibosch <hein_tibosch@yahoo.es>:
> Maybe a stupid question, but when designing new hardware with a slot
> for an sd-card, how essential is it that the driver is able to power =
off/on
> the card?

=46or one, this is needed for power-management. In powered suspend case=
,
when card's slot does not provide card change detection, power-cycle
is the only way sure way to get a card to known state in case it can
be removed in that time.

> I would say essential, because I've seen sd-cards in a state in which=
 they
> didn't respond to MMC_GO_IDLE_STATE anymore, until they were re-inser=
ted.
>
> Can anyone shed a light on this? How could an sd-card get into such a=
 state?

After CMD15 (GO_INACTIVE_STATE) or because of a card bug.

>
> Will the mmc driver fall back to mmc_rescan() after an initialized ca=
rd
> becomes non-responsive?

When the card goes off-protocol it's in undefined state, so a reset is
the only way to get it back to known state. Since in SD/MMC there's no
reset signal - only power cycle can reset the card.

Best Regards,
Micha=B3 Miros=B3aw
