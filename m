From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v2] mmc: sdhci: add quirk for broken write protect
 detection
Date: Thu, 6 Mar 2014 08:42:48 -0800
Message-ID: <ad0a3559-a687-4f51-b284-f515372cfad2@VA3EHSMHS001.ehs.local>
References: <1393759200-22819-1-git-send-email-eli.billauer@gmail.com>
 <74003aec-1707-4f43-b947-df148d573fa1@TX2EHSMHS038.ehs.local>
 <53163247.8000904@gmail.com>
 <ae0f71ac-c5f7-4af7-a9ba-c019cec19ebf@AM1EHSMHS017.ehs.local>
 <531878C8.2020001@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:21677
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752068AbaCFQnq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 6 Mar 2014 11:43:46 -0500
Content-Disposition: inline
In-Reply-To: <531878C8.2020001@topic.nl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Eli Billauer <eli.billauer@gmail.com>, chris@printf.net, michal.simek@xilinx.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2014-03-06 at 02:31PM +0100, Mike Looijmans wrote:
> On 03/04/2014 10:00 PM, S=C3=B6ren Brinkmann wrote:
> >On Tue, 2014-03-04 at 10:06PM +0200, Eli Billauer wrote:
> >>Hello S=C3=B6ren,
> >>
> >>wp-inverted solves the practical problem indeed, and fools the
> >>driver into thinking that the card has an inverted write protection
> >>sensor, and the logic zero that it finds in the hardware register
> >>means that the card isn't write protected.
> >>
> >>I'm insisting on this patch, because I think that the device tree
> >>should describe the hardware as it is, and not fool the driver into
> >>behaving the way we want it to. These tricks always bite back later
> >>on.
> >Well, why is broken-wp more accurate than wp-inverted? Strictly
> >speaking the WP is there and working, it's just tied off to some val=
ue
> >you want to have interpreted the other way.
> >Anyway, seems like this is solvable with wp-inverted and whether the
> >additional quirk is needed I leave to others do decide.
>=20
> I've begged for this patch - or a similar one - to be included too,
> because on our boards, the "wp" value appears to be sort of random.
> Out of 5 prototype boards, 3 would only boot with wp-inverted while
> the other 2 wouldn't boot with wp-inverted set.
>=20
> In our case I really don't know (and I don't care either) to which
> logic level the wp happens to think it's wired. I just want to be
> able to tell the driver that the WP line is
> free-floating-and-might-have-any-random-value-at-any-given-moment
> which is a bit long, so I'd go for disable-wp instead.

Could you provide the design you use and give more details? According t=
o
the people I talked to, the signal should never float, unless you pin i=
t
out and don't drive it.
Actually, you should open a support case for this. It is not supposed t=
o
happen.

	S=C3=B6ren


