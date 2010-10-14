From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/5] CB710 driver updates
Date: Thu, 14 Oct 2010 03:03:40 +0100
Message-ID: <20101014020340.GC3553@void.printf.net>
References: <cover.1286922133.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38618 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924Ab0JNCDo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Oct 2010 22:03:44 -0400
Content-Disposition: inline
In-Reply-To: <cover.1286922133.git.mirq-linux@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Hi Micha=C5=82,

On Wed, Oct 13, 2010 at 12:22:13AM +0200, Micha=C5=82 Miros=C5=82aw wro=
te:
> This series consists of some updates for CB710 MMC host driver.
>=20
> Micha=C5=82 Miros=C5=82aw (5):
>   mmc: cb710: partially demystify clock selection
>   mmc: cb710: implement get_cd() callback
>   mmc: cb710: remove unnecessary msleep()
>   mmc: cb710: clear irq handler on init() error path
>   mmc: cb710: remove debugging printk (info duplicated from mmc-core)
>=20
>  drivers/mmc/host/cb710-mmc.c |   54 +++++++++++++++++++-------------=
---------
>  1 files changed, 25 insertions(+), 29 deletions(-)

Thanks, all applied to mmc-next.

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
