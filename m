From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH 3/3] mmc: sunxi: Add support to the Allwinner A83T
Date: Thu, 21 Jul 2016 11:18:51 +0200
Message-ID: <20160721111851.133a3f16d6e9de1ee45b3654@free.fr>
References: <cover.1469082481.git.moinejf@free.fr>
	<0ddc5f7d9a42515f901c95b8c0c1f5a5e4d575e9.1469082481.git.moinejf@free.fr>
	<20160721085838.GH5993@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:25552 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbcGUJTD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jul 2016 05:19:03 -0400
In-Reply-To: <20160721085838.GH5993@lukather>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-sunxi@googlegroups.com

On Thu, 21 Jul 2016 10:58:38 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Wed, Jul 20, 2016 at 08:28:47PM +0200, Jean-Francois Moine wrote:
> > The rate of the PLL-PERIPH clock is usually set to 1.2GHz in the A8=
3T.
>=20
> Uh? The datasheet says to set it to 600MHz.

Right. But the driver of the SDK for the Banana Pi M3 (A83T) sets it
to 1.2GHz.

> > This patch sets the phase delays of the output and sample clocks
> > accordingly.
> >=20
> > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> > ---
> > Note: The impacted phase delays are only for 50MHz.
> > The phase delays are not used in 50MHz 8 bits DDR (new timing mode)=
=2E
>=20
> Actually, they seem to be, in the new timing mode register.

In the SDK driver, nothing is set in the new timing mode register.
Anyway, the eMMC works fine in both the Banana Pis M2+ and M3
with no delay.

--=20
Ken ar c'henta=F1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
