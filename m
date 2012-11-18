From: Philip Rakity <prakity@nvidia.com>
Subject: Re: UHS-I voltage switching on OLPC XO-1.75
Date: Sun, 18 Nov 2012 21:25:32 +0100
Message-ID: <BD70DCA0-9C48-4595-99B8-3696A5CB392E@nvidia.com>
References: <CAMLZHHQfQ26E+BH2sqV9CGyso+uuKHC=WMaqehzBo9_Gr_kyPQ@mail.gmail.com>
 <CA+20K0CQmFHNruQv5-7D=2kxqxp=Vt1h2rXXuKF0-JOm8jyoJQ@mail.gmail.com>
 <CAMLZHHRAq7NHrDeA6d3JLsALGgVgfBxL8Y=DMNCLSDvFOFVw2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:12928 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387Ab2KRUZh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 15:25:37 -0500
In-Reply-To: <CAMLZHHRAq7NHrDeA6d3JLsALGgVgfBxL8Y=DMNCLSDvFOFVw2Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Johan Rudholm <jrudholm@gmail.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>



On Nov 18, 2012, at 5:42 PM, Daniel Drake <dsd@laptop.org> wrote:

> On Fri, Nov 2, 2012 at 8:35 AM, Johan Rudholm <jrudholm@gmail.com> wr=
ote:
>> Good question. I=92d guess that mmc_power_off/up does not work as
>> expected here, that the card is not at all power cycled.
>=20
> Before going further on the "find a way to quirk it" route, there is
> something else we could look into.
>=20
> According to our hardware engineers, the external SD card power has
> been "always-on" until now. It is actually controlled by our embedded
> controller, separate from the CPU.
>=20
> In a test firmware, I can now control the SD card power via our "OLPC
> EC" interface, I call into that from mmc_power_up and mmc_power_down.
> And, with your hacky patch to make the voltage switch failure
> detection work, this fixes it: it tries 10 times at 1.8v then falls
> back to 3.3 successfully. No more problems with the power cycle.
>=20
> So we have the option of fixing it that way: if we can fix the voltag=
e
> switch failure detection, we could implement a custom vmmc regulator
> driver that uses our EC interface to enable and disable the SD power
> appropriately, solving our ability to power cycle.
>=20
> On the other hand, we may have a good basis to add a quirk, triggered
> by the device tree, for when the hardware physically does not have
> 1.8v capabilities.
>=20
> I'm also curious if there is a 3rd option. It seems like in the case
> of our SoC, the SoC design mandates that the SD card power is separat=
e
> from the SDHCI interface - requiring either a GPIO or some other
> mechanism (e.g. OLPC EC) to be able to control it.
>=20
> I'm wondering if this is the same for all sdhci-pxa devices. And the
> same for all sdhci devices? Maybe the SDHCI specs would help here, bu=
t
> I guess they aren't public.
>=20
> If this is the case, the driver could have another heuristic: if ther=
e
> is no vmmc regulator, there is no way of cutting the card power,
> therefore we could avoid even trying 1.8v on the basis that we know w=
e
> can't recover if things go wrong.
>=20
> Similarly, for our next product we are looking at adding 1.8v
> capabilities. However, it seems that again, the SoC design (or
> something more fundamental?) requires that this power is controlled
> via some external mechanism - we're planning to use a GPIO to switch
> between 1.8v and 3.3v, which can be exposed as a regulator. So again,
> would it be fair for sdhci-pxa or sdhci to drop the UHS-I support whe=
n
> no regulator is present? Or am I over-generalizing?

You can use a notifier to get control when voltage switch is called in =
your low level board file.
I did this originally to control PAD settings for 3.3 and 1.8v.  I had =
the receiver of the notifier in my low level board file and I registere=
d it my sdhci-xxx.c file.
The notified is called at the end of the voltage switch by the regulato=
r code but maybe there is now a case to add notifier control at the beg=
inning of the routines.

>=20
> Thanks,
> Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-----------------------------------------------------------------------=
------------
This email message is for the sole use of the intended recipient(s) and=
 may contain
confidential information.  Any unauthorized review, use, disclosure or =
distribution
is prohibited.  If you are not the intended recipient, please contact t=
he sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------=
------------
