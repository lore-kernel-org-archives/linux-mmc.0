From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH 3/3] mmc: sunxi: Add support to the
 Allwinner A83T
Date: Fri, 22 Jul 2016 21:00:06 +0200
Message-ID: <20160722210006.2d08c8261f84c59f7e2ddd34@free.fr>
References: <cover.1469082481.git.moinejf@free.fr>
	<0ddc5f7d9a42515f901c95b8c0c1f5a5e4d575e9.1469082481.git.moinejf@free.fr>
	<20160721085838.GH5993@lukather>
	<20160721111851.133a3f16d6e9de1ee45b3654@free.fr>
Reply-To: moinejf-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCV6DL6LYMNBBOW2ZG6AKGQEIZTLK3A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160721111851.133a3f16d6e9de1ee45b3654-GANU6spQydw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 21 Jul 2016 11:18:51 +0200
Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org> wrote:

> > On Wed, Jul 20, 2016 at 08:28:47PM +0200, Jean-Francois Moine wrote:
> > > The rate of the PLL-PERIPH clock is usually set to 1.2GHz in the A83T=
.
> >=20
> > Uh? The datasheet says to set it to 600MHz.
>=20
> Right. But the driver of the SDK for the Banana Pi M3 (A83T) sets it
> to 1.2GHz.

I tested again, and, with the pll-periph at 600MHz, both the SDcard and
the eMMC are working fine.
So, you may forget about this patch, sorry for the noise.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
