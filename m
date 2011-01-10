From: Pawel Moll <mail@pawelmoll.com>
Subject: Re: [PATCH] mmc, ARM: Add zboot from MMC support for SuperH Mobile
 ARM
Date: Mon, 10 Jan 2011 10:10:19 +0000
Message-ID: <c1e9db480d82d1804930ddcc7bb0db02@rootnode.net>
References: <20110109124928.GC25591@verge.net.au>
 <1294589548.8897.1.camel@rojo> <20110109225042.GB29257@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110109225042.GB29257@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

 On Mon, 10 Jan 2011 07:50:42 +0900, Simon Horman <horms@verge.net.au>=20
 wrote:
>> >  Documentation/arm/SH-Mobile/Makefile              |    8 +
>> >  Documentation/arm/SH-Mobile/vrl4.c                |  169=20
>> +++++++++++++++++++++
>> How about putting those two into "tools" (in particular "tools/arm")
>> instead of "Documentation"?
>> Just a thought... ;-)
>
> Thats fine by me except that tools/arm doesn't exist yet.
> It would be good to get some consensus before creating it.

 I think there is consensus regarding "tools" as a place for user-space=
=20
 tools - eg. perf tools used to live in "Documentation/..." and then we=
re=20
 moved to "tools/perf".

 Now, whether your stuff should be in "tools/SH-Mobile" or=20
 "tools/arm/SH-Mobile", I have no opinion ;-)

 Cheers!

 Pawe=C5=82

