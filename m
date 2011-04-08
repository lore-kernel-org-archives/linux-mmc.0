From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH v3] mmc: Add ioctl to let userspace apps send ACMDs
Date: Fri, 8 Apr 2011 16:39:02 -0500
Message-ID: <BANLkTinOarwAj3Pz1Z_ayHe2tG6fU989Og@mail.gmail.com>
References: <alpine.DEB.2.00.1104071816270.10238@peruna>
	<BANLkTin9hfr+VfprkDr-Lc+iY0qShmcnng@mail.gmail.com>
	<alpine.DEB.2.00.1104081202550.15086@peruna>
	<BANLkTi=wPYkrj72ixpN52WewVwsb9Ar-Vg@mail.gmail.com>
	<alpine.DEB.2.00.1104081404210.15584@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:57829 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab1DHVjG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Apr 2011 17:39:06 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p38LbLNg009309
	for <linux-mmc@vger.kernel.org>; Fri, 8 Apr 2011 17:37:21 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p38LbJOo009300
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 8 Apr 2011 17:37:20 -0400 (EDT)
Received: by wwb28 with SMTP id 28so4563315wwb.3
        for <linux-mmc@vger.kernel.org>; Fri, 08 Apr 2011 14:39:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104081404210.15584@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Fri, Apr 8, 2011 at 4:25 PM, John Calixto
<john.calixto@modsystems.com> wrote:
> Hi Andrei,
>
> On Fri, 8 Apr 2011, Andrei Warkentin wrote:
>> Is the timeout fixed or variable (I've seen all timeouts in the
>> simplified ASSD to be specified in units of 250ms in fields of
>> ASSD-PR)? Are you using this force_timeout_ns for DAT-transfer
>> commands also, or just for R1B commands?
>
> Actually, ASSD is a different-but-similarly-named-so-it's-confusing s=
et
> of functionality from that which I am using. =A0Do you have access to
> "Part 3, Security Specification"? =A0There is no "simplified" version=
 of
> this spec.
>
> As for the usage of the force_timeout_ns, yes, it is also used for
> DAT-transfer commands.
>
>>
>> Do you always invoke commands that only involve transfers?
>
> No.
>
>> If not, I can see how your code handles R1B command timeouts correct=
ly
>> (always pretends it's a data transfer, even if 0-byte sized - thus
>> host driver sets timeout correctly). In my boot partition patch set,
>> there are two changes that add cmd_timeout (for DAT-busy commands) a=
nd
>> enable proper handling of it for SDHCI. Obviously, none of the other
>
> I'll have a look.
>
>> hosts are fixed, so I guess what you are doing is okay for now. Coul=
d
>> you add a "cmd_timeout" field to your ioctl, however, so in the futu=
re
>> this is not a breaking change? Then right now you could add somethin=
g
>> like -
>>
>> if (blksz * blocks =3D=3D 0) {
>>
>> =A0 =A0 /*
>> =A0 =A0 =A0* We're doing a R1B command and relying on the host drive=
r to
>> compute timeout as if
>> =A0 =A0 =A0* we were doing a data transfer. When all host drivers ar=
e fixed
>> to handle R1B right, we won't have to rely
>> =A0 =A0 =A0* on this behavior, and can make mrq.data NULL in this ca=
se, and
>> pass the timeout
>> =A0 =A0 =A0* through cmd.cmd_timeout.
>> =A0 =A0 =A0*/
>> =A0 =A0 data.timeout_ns =3D idata->cmd_timeout;
>> }
>>
>> and in the future it can be changed to -
>>
>> if (blksz * blocks =3D=3D 0) {
>> =A0 =A0mrq.data =3D NULL;
>> =A0 =A0cmd.cmd_timeout =3D idata->cmd_timeout;
>> }
>>
>>
>
> Sure. =A0Like you said, this sounds reasonable while there's still
> variation in timeout setting between the host drivers.
>
>> >
>> > In practice, 100 us. =A0Borderline? =A0Note that this sleep is sep=
arate from
>> > the timeout above. =A0This one is specifically for read operations=
 where
>> > there is no such thing as "busy".
>> >
>>
>> You mean 'write'? I don't know. Nasty, really, in my opinion. If
>
> Unfortunately, I really do mean "read". =A0I suspect it's meant to gi=
ve
> the card enough time to do the crypto <shrug>.
>
>> you're doing ASSD operations then you know if the card is busy or no=
t
>> (via ASSD-state) . As in something like this paragraph from the
>> simplified ASSD?
>>
>> =A0 =A0 =A0 =A0 =A0"The card shall not assert the BUSY signal for ti=
me periods
>> longer then the WR_SEC_BUS_BUSY as
>> =A0 =A0 =A0 =A0 =A0defined in the card properties register. The only=
 indication
>> for completion of a secure Token execution is
>> =A0 =A0 =A0 =A0 =A0the ASSD_STATE field in the card status register.=
 The host
>> shall validate that the card is in the correct
>> =A0 =A0 =A0 =A0 =A0state before attempting any ASSD command."
>>
>> If so, maybe it's worthwhile to just make your user code use SEND_PS=
I
>> to get the ASSD_STATE registers and verify that previous secure
>> operation completed before sending another one.
>>
>> Anyone else have an opinion on this?
>>
>> If this is not ASSD but something else, maybe you have a status
>> register to query someplace?
>>
>> >> I'm not sure I understand why blksz is passed. If you needed to s=
et
>> >> the block size (via CMD16) prior to some command (like MMC passwo=
rd
>> >> protection) I could kind of get it, but then all I see the blk si=
ze
>> >> getting used for is calculating the data amount in bytes, so you'=
re
>> >> not doing that. So why not just infer it from the card queue?
>> >>
>
> I can't quote directly from this spec (it would be nice if some other
> SDA member could corroborate here... Part 3, anybody???), but it is
> clear that there is nothing to do but wait. =A0However, speaking to y=
our
> initial question about usleep() vs. udelay(), I'll try testing with
> usleep().
>
> John

I'm not sure what the etiquette for this list is, but you can a
Reviewed-by: Andrei Warkentin <andreiw@motorola.com>

=2E..if that's alright with the maintainers.

A
