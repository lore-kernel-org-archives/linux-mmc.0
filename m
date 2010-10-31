From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sun, 31 Oct 2010 21:06:56 +0200
Message-ID: <AANLkTi=cPURFAitedD=mjkNiD_=ZCjakkMN6z7ecqv6k@mail.gmail.com>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
 <AANLkTinEes6Er6-WW_t8esjazrLWZ0Z7jvYJDSZL9PNG@mail.gmail.com>
 <AANLkTinJ2K2cz9PSdyNoNGUS8GWfLpqRBH2C3XjO5vjO@mail.gmail.com>
 <AANLkTi=VAU=9Q+Ga7yQyu3aL7gV0vbzymQ-2uJAg1jf8@mail.gmail.com>
 <AANLkTi=QT6_zyddRz=3f6GDx-RVoiROOumhegm8pFuHU@mail.gmail.com>
 <AANLkTimfp0pPqpO03-R4yBsADQ27RLQ_PxLTfBAMfPGk@mail.gmail.com>
 <AANLkTi=gFmq47Xq+CxnU18aHyhcaF78WrWYDhga4Xf2X@mail.gmail.com>
 <AANLkTimqFBBsDCCDNOq22fuqjw7pezizZ9At+1ucGZ-j@mail.gmail.com>
 <AANLkTi=RP0i5cWO4AogGJx-sQ+17YKuiptQWi0ypYVnA@mail.gmail.com>
 <AANLkTiktD13-UC8=gwWhp9oR9_vGcM98VpRQ9i0CQg_-@mail.gmail.com> <AANLkTi=8Xd1xTfFvAJkicR_89JOu4P2uwyoMHvXCBKv8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45841 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213Ab0JaTHR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 31 Oct 2010 15:07:17 -0400
Received: by iwn10 with SMTP id 10so6139391iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 31 Oct 2010 12:07:16 -0700 (PDT)
In-Reply-To: <AANLkTi=8Xd1xTfFvAJkicR_89JOu4P2uwyoMHvXCBKv8@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Sun, Oct 31, 2010 at 6:24 PM, Daniel Drake <dsd@laptop.org> wrote:
> On 31 October 2010 16:16, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Just to make sure - on an older kernel (that doesn't have SDIO runti=
me
>> pm), the card is powered on at this stage (this info will help me ru=
le
>> out some corner cases) ?
>
> Looks that way. Same test, after reverting your patches:
>
> clock: =A0 =A0 =A0 =A0 =A025000000 Hz
> vdd: =A0 =A0 =A0 =A0 =A0 =A020 (3.2 ~ 3.3 V)
> bus mode: =A0 =A0 =A0 2 (push-pull)
> chip select: =A0 =A00 (don't care)
> power mode: =A0 =A0 2 (on)
> bus width: =A0 =A0 =A02 (4 bits)
> timing spec: =A0 =A00 (legacy)

OK, as expected.

So to summarize:
1. Card is powered up at boot, and successfully initialized
2. After mmc + sdio devices are added to the device tree, power is
(seemingly) taken down by runtime PM
3. When the driver is loaded, card is powered up again, but doesn't
respond to CMD3

The only explanation I can think of why the card doesn't respond to
CMD3, after its power is brought up again, is that we didn't have a
full reset here (i.e. mmc_power_off() didn't completely power off
everything).

It's interesting to understand exactly what happens in the context of
the XO-1.5 (there can be several possible culprits, including a
controller quirk), but even if that's not exactly the case here, it is
pretty clear that we need to support boards with controllers/cards
which we can't power off in runtime.

On such boards, the right thing to do would be to disable runtime PM al=
together.

Luckily I'll have the XO-1.5 later on this week to cook a fix and test =
it.

Thanks,
Ohad.
