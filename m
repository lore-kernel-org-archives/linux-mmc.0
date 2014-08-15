From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3] mmc: implement Driver Stage Register handling
Date: Fri, 15 Aug 2014 10:21:48 +0200
Message-ID: <20140815082148.GF5134@pengutronix.de>
References: <1407944656-14592-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAPDyKFqKVvwFi+JoOG-O1jznOB1UyhQW_ovb_N=+G_FtoqXQXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43339 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbaHOIWE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Aug 2014 04:22:04 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFqKVvwFi+JoOG-O1jznOB1UyhQW_ovb_N=+G_FtoqXQXA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Markus Niebel <Markus.Niebel@tq-group.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>

Hello Ulf,

On Thu, Aug 14, 2014 at 11:26:28AM +0200, Ulf Hansson wrote:
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 95cceae96944..52e83f389428 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -452,6 +452,14 @@ int mmc_of_parse(struct mmc_host *host)
> >         if (of_find_property(np, "mmc-hs400-1_2v", &len))
> >                 host->caps2 |=3D MMC_CAP2_HS400_1_2V | MMC_CAP2_HS2=
00_1_2V_SDR;
> >
> > +       if (of_find_property(np, "dsr", &len)) {
> > +               u32 tmp;
> > +
> > +               of_property_read_u32(np, "dsr", &tmp);
> > +               host->dsr_req =3D 1;
> > +               host->dsr =3D (u16)tmp;
> > +       }
> > +
>=20
> Let's simplify the above with just:
> of_property_read_u16(np, "dsr", &host->dsr);
The downside here is that the syntax changes when using
of_property_read_u16. Instead of

	dsr =3D <0x100>

the following must be written then:

	dsr =3D /bits/ 16 <0x100>;

so I'd prefer to stay with of_property_read_u32. The block can still be
simplified. Will fix that in v4.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
