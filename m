From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc, ARM: Add zboot from MMC support for SuperH Mobile
 ARM
Date: Mon, 10 Jan 2011 07:50:42 +0900
Message-ID: <20110109225042.GB29257@verge.net.au>
References: <20110109124928.GC25591@verge.net.au>
 <1294589548.8897.1.camel@rojo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:60968 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab1AIWuq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jan 2011 17:50:46 -0500
Content-Disposition: inline
In-Reply-To: <1294589548.8897.1.camel@rojo>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?B?UGF3ZcWC?= Moll <mail@pawelmoll.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Sun, Jan 09, 2011 at 04:12:28PM +0000, Pawe=C5=82 Moll wrote:
> Hi,
>=20
> >  Documentation/arm/SH-Mobile/Makefile              |    8 +
> >  Documentation/arm/SH-Mobile/vrl4.c                |  169 +++++++++=
++++++++++++
>=20
> How about putting those two into "tools" (in particular "tools/arm")
> instead of "Documentation"?
>=20
> Just a thought... ;-)

Thats fine by me except that tools/arm doesn't exist yet.
It would be good to get some consensus before creating it.
