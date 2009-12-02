From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] mmc: pxamci: call mmc_remove_host() before freeing
 resources
Date: Wed, 2 Dec 2009 12:03:26 +0100
Message-ID: <20091202110326.GZ14091@buzzloop.caiaq.de>
References: <1259687838-31722-1-git-send-email-daniel@caiaq.de>
 <f17812d70912011650h48a6c391s426ffc8b4b653fc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:35484 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbZLBLDZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2009 06:03:25 -0500
Content-Disposition: inline
In-Reply-To: <f17812d70912011650h48a6c391s426ffc8b4b653fc8@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@kernel.org

On Wed, Dec 02, 2009 at 08:50:44AM +0800, Eric Miao wrote:
> On Wed, Dec 2, 2009 at 1:17 AM, Daniel Mack <daniel@caiaq.de> wrote:
> > mmc_remove_host() will cause the mmc core to switch off the bus pow=
er by
> > eventually calling pxamci_set_ios(). This function uses the regulat=
or or
> > the GPIO which have been freed already.
> >
> > This causes the following Oops on module unload.
> >

[...]

> >
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > Reported-by: Sven Neumann <s.neumann@raumfeld.com>
> > Cc: Pierre Ossman <pierre@ossman.eu>
> > Cc: Eric Miao <eric.y.miao@gmail.com>
> > Cc: linux-mmc@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: stable@kernel.org
> > ---
> > =A0drivers/mmc/host/pxamci.c | =A0 =A04 ++--
>=20
> Looks like a correct fix to me.
>=20
> Acked-by: Eric Miao <eric.y.miao@gmail.com>

Would be good to still get this into .32 - who will take care of pickin=
g
this?

