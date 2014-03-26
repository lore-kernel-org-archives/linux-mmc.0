From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: mvsdio: unhandled interrupt, mmc writes queuing up
Date: Wed, 26 Mar 2014 21:46:31 +0100
Message-ID: <20140326214631.7dccf8b6@neptune.home>
References: <20140325192759.GJ29769@segv.de>
	<53320055.9080307@gmail.com>
	<20140326000735.GI28304@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:45230 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbaCZUqg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Mar 2014 16:46:36 -0400
In-Reply-To: <20140326000735.GI28304@titan.lakedaemon.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Alexander Elbs <alex@segv.de>, Nicolas Pitre <nico@fluxnic.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-mmc@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>

Hello Jason Sebastian,

On Tue, 25 March 2014 Jason Cooper <jason@lakedaemon.net> wrote:
> On Tue, Mar 25, 2014 at 11:16:53PM +0100, Sebastian Hesselbarth wrote=
:
> > >> On Wed, 19 Mar 2014, Bruno Pr=C3=A9mont wrote:
> > >>> Since upgrading my Sheevaplug from 3.7.2 to 3.13.6 (FDT) I'm se=
eing
> > >>> mvsdio f1090000.mvsdio: unhandled interrupt status=3D0x8810 en=3D=
0x0000 pio=3D0
> > >>> at varied timings.
> >=20
> > Can you please try the patches contained in [1]?
> >=20
> > They have been Acked-by Jason Cooper, but I guess we simply lost
> > track of them.
> >=20
> > Sebastian
> >=20
> > [1] https://lkml.org/lkml/2013/11/15/276
>=20
> If these work for you, please send a Tested-by and I'll keep better
> track of them this time.  I think these were sent before we had a
> process for shuttling things into irqchip...


Same for me as for Alexander, tested the series of 3 patches on top of
3.14-rc7 here with no complaints about unhandled interrupts left.

So for the 3 of them:
Tested-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>

Thanks,
Bruno
