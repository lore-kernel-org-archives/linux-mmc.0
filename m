From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2] mmc: sdhci: add quirk for broken write protect detection
Date: Thu, 6 Mar 2014 14:31:52 +0100
Message-ID: <531878C8.2020001@topic.nl>
References: <1393759200-22819-1-git-send-email-eli.billauer@gmail.com> <74003aec-1707-4f43-b947-df148d573fa1@TX2EHSMHS038.ehs.local> <53163247.8000904@gmail.com> <ae0f71ac-c5f7-4af7-a9ba-c019cec19ebf@AM1EHSMHS017.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from retry101.mer-nm.internl.net ([217.149.192.105]:36498 "EHLO
	retry101.mer-nm.internl.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750760AbaCFNlS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 6 Mar 2014 08:41:18 -0500
In-Reply-To: <ae0f71ac-c5f7-4af7-a9ba-c019cec19ebf@AM1EHSMHS017.ehs.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?U8O2cmVuIEJyaW5rbWFubg==?= <soren.brinkmann@xilinx.com>, Eli Billauer <eli.billauer@gmail.com>
Cc: chris@printf.net, michal.simek@xilinx.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

=EF=BB=BFOn 03/04/2014 10:00 PM, S=C3=B6ren Brinkmann wrote:
> On Tue, 2014-03-04 at 10:06PM +0200, Eli Billauer wrote:
>> Hello S=C3=B6ren,
>>
>> wp-inverted solves the practical problem indeed, and fools the
>> driver into thinking that the card has an inverted write protection
>> sensor, and the logic zero that it finds in the hardware register
>> means that the card isn't write protected.
>>
>> I'm insisting on this patch, because I think that the device tree
>> should describe the hardware as it is, and not fool the driver into
>> behaving the way we want it to. These tricks always bite back later
>> on.
> Well, why is broken-wp more accurate than wp-inverted? Strictly
> speaking the WP is there and working, it's just tied off to some valu=
e
> you want to have interpreted the other way.
> Anyway, seems like this is solvable with wp-inverted and whether the
> additional quirk is needed I leave to others do decide.

I've begged for this patch - or a similar one - to be included too, bec=
ause on=20
our boards, the "wp" value appears to be sort of random. Out of 5 proto=
type=20
boards, 3 would only boot with wp-inverted while the other 2 wouldn't b=
oot=20
with wp-inverted set.

In our case I really don't know (and I don't care either) to which logi=
c level=20
the wp happens to think it's wired. I just want to be able to tell the =
driver=20
that the WP line is=20
free-floating-and-might-have-any-random-value-at-any-given-moment which=
 is a=20
bit long, so I'd go for disable-wp instead.

Mike.


Met vriendelijke groet / kind regards,

Mike Looijmans

TOPIC Embedded Systems
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: (+31) (0) 499 33 69 79
Telefax:  (+31) (0) 499 33 69 70
E-mail: mike.looijmans@topic.nl
Website: www.topic.nl

Please consider the environment before printing this e-mail

