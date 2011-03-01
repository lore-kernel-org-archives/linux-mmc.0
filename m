From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [linux-pm] [RFC, PATCHv3 3/3] mmc: sdhci: handle wake-up from runtime_pm
Date: Tue, 1 Mar 2011 21:48:37 +0100
Message-ID: <AANLkTi=nWXad7WMRYxu7cvC478qy7ptpotR4K_ATNt_J@mail.gmail.com>
References: <AANLkTikt1r3j99_ub0ce3_3snjoDXvR2+x6RxcjGfMK8@mail.gmail.com>
	<Pine.LNX.4.44L0.1103011525040.2034-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52627 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757358Ab1CAUsi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 15:48:38 -0500
In-Reply-To: <Pine.LNX.4.44L0.1103011525040.2034-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org

On Tue, Mar 1, 2011 at 9:27 PM, Alan Stern <stern@rowland.harvard.edu> =
wrote:
> On Tue, 1 Mar 2011, Pierre Tardy wrote:
>
>> >> + =A0 =A0 if (pm_runtime_suspended()) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 host->waking_up =3D 1;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* Note that we disable temporarly the =
interrupt until we do the
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* resume. If we don't then we'll get=
 constantly interrupted
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* until we actually resume.
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* as the irq is shared, this might n=
ot be very friendly to our
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* irq sharers but the pm_runtime wor=
kqueue should really be
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* called soon.
>> >
>> > Instead of disabling the IRQ, would it be possible to tell the dev=
ice
>> > to stop generating an interrupt request?
>>
>> Well, the device is power gated, so any access to it will cause a bu=
s
>> timeout (depending of the platform)
>
> But could you gate the power back on and then turn off the interrupt
> request?
That's the role of runtime_resume... On some platform, this may need
up to sending some SPI commands to the PMIC, to get those power rails
back on.
Something that you cannot do in interrupt context.

>
> It seems like a foolish design to have an interrupt request that can'=
t
> be turned off by an interrupt handler.
It's what we have for now ( looks like I need to go back to my system
architects to see if we can change that...)

Alan,
thanks for all this feedback. I have now a much more clear view on how
this is working on ACPI, I'll try to see how we can mimic this
behaviour on intel_mid.
