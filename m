From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: mvsdio: unhandled interrupt, mmc writes queuing up
Date: Tue, 25 Mar 2014 23:16:53 +0100
Message-ID: <53320055.9080307@gmail.com>
References: <20140325192759.GJ29769@segv.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:65200 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbaCYWQ7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Mar 2014 18:16:59 -0400
In-Reply-To: <20140325192759.GJ29769@segv.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexander Elbs <alex@segv.de>, Nicolas Pitre <nico@fluxnic.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, bonbons@linux-vserver.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>

On 03/25/2014 08:27 PM, Alexander Elbs wrote:
>> On Wed, 19 Mar 2014, Bruno Pr=E9mont wrote:
>>> Since upgrading my Sheevaplug from 3.7.2 to 3.13.6 (FDT) I'm seeing
>>>   mvsdio f1090000.mvsdio: unhandled interrupt status=3D0x8810 en=3D=
0x0000 pio=3D0
>>> at varied timings.
>=20
> I have the same problem on my sheevaplug.
>=20
>> It has been many years since I've looked at the code for this driver=
=2E =20
>> I'm therefore including Thomas Petazzoni to the CC list as he appear=
s to=20
>> have been the most active since then.
>>
>> The reported status seems to indicate missing data in the context of=
 a=20
>> transfer with CMD12, and a CRC error ensued of course.
>>
>> At this point I'd suggest testing intermediate kernels between 3.7 a=
nd=20
>> 3.13, and try bisection until you find the offending commit.
>>
>> [...]
>>> I get same results with 3.14-rc7.
>>
>> Excellent, that reduces the search space significantly.  You can do =
a=20
>> git bisect directly.
>=20
> I did a git bisect.
>   good: no message "unhandled interrupt"
>   bad: message above appears
>   skipped: unbootable kernel, usually stuck after the line "Uncompres=
sing Linux".=20
>=20
> So far I am down to a few commits after 3.11.
>=20
> $ git bisect view --oneline
> 2326f04 (refs/bisect/bad) ARM: kirkwood: convert to DT irqchip and cl=
ocksource

Can you please try the patches contained in [1]?

They have been Acked-by Jason Cooper, but I guess we simply lost
track of them.

Sebastian

[1] https://lkml.org/lkml/2013/11/15/276

