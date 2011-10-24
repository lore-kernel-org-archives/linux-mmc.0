From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Improve runtime PM support
Date: Mon, 24 Oct 2011 14:18:51 +0200
Message-ID: <CACRpkdb7FwW=Qa2MiJkbezkBO3F+Y0j6-RWSiL8dfJXkbd4pHw@mail.gmail.com>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com>
	<20111021173637.GG21648@n2100.arm.linux.org.uk>
	<CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com>
	<CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com>
	<4EA51C4A.7040802@stericsson.com>
	<20111024090432.GA9893@n2100.arm.linux.org.uk>
	<4EA53181.2050700@stericsson.com>
	<20111024094203.GI9893@n2100.arm.linux.org.uk>
	<4EA538A3.9070501@stericsson.com>
	<20111024101416.GK9893@n2100.arm.linux.org.uk>
	<4EA55076.2010701@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47511 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166Ab1JXMSw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 08:18:52 -0400
Received: by iaby12 with SMTP id y12so1270178iab.19
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2011 05:18:51 -0700 (PDT)
In-Reply-To: <4EA55076.2010701@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sebastian Rasmussen <sebras@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 24, 2011 at 1:48 PM, Ulf Hansson <ulf.hansson@stericsson.co=
m> wrote:
> [Russell]
>> The MCIPWR signal controls the external power switch. =A0This is the=
 only
>> signal for it. =A0This is the only connection for it. =A0There is no=
 other
>> control form for this power switch.
>>
>
> Then we are only left to use the variant struct I believe. In princip=
le, a
> flag in the variant struct, could indicate whether it is OK to disabl=
e the
> vcore regulator and thus clear the MCIPWR when doing runtime_suspend.

Yep I think the best could be to add some variant named
bool external_card_power; and then document in the kerneldoc that this
means the driver can clear MMCIPWR without risk of cutting the power
to the card.

This should be true for Ux500, U300 and Nomadik (just checked the desig=
ns -
they all have external regulators).

So the state save/restore and amba_vcore_disable(adev); should be done
only for those variants.

However this:

clk_disable(host->clk);

We ought to be able to do for *all* variants, provided we can create
pm_runtime_get/put and delay properly to cover all bus traffic
(looks like the patch already does that), plus all the time the card is
signalling busy. The best I can think of is to just return -EBUSY to ru=
ntime
PM like this:

if ((readl(base + MMCISTATUS) & (MCI_CMDACTIVE | MCI_TXACTIVE| MCI_RXAC=
TIVE))
  return -EBUSY;

Yours,
Linus Walleij
