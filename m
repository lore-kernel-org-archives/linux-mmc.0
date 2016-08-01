From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH v2] mmc: sunxi: Handle the 'New Timings'
Date: Mon, 1 Aug 2016 19:09:06 +0200
Message-ID: <20160801190906.8e7b86044aa32afda1a11e97@free.fr>
References: <20160801133359.5B1802E03D@muse.csie.ntu.edu.tw>
	<CAGb2v67ocbAVhUA530JC9OiOW8ozybTgP+3yzjPomMKKwP-Bcg@mail.gmail.com>
Reply-To: moinejf-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCV6DL6LYMNBBOUE726AKGQE7ADGI4A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v67ocbAVhUA530JC9OiOW8ozybTgP+3yzjPomMKKwP-Bcg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Chen-Yu,

On Mon, 1 Aug 2016 21:52:48 +0800
Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:

> On Mon, Aug 1, 2016 at 9:10 PM, Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org> wro=
te:
> > Some MMC devices as mmc2 in the A83T or mmc1 and mmc2 in the H3 have
> > a 'New Timings' mode.
> > Set this capacity in the DT and use it when possible.
>=20
>            ^^ capability?
>=20
> Also, in this patch you are adding support for a DT boolean flag
> property, not adding stuff to the DT.

Sorry, forgotten.

> >
> > Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
> > ---
>=20
> I got 3 copies of the same patch...

Maybe because I sent it to you, and to the mmc and sunxi lists.

> > I don't know if this mode works or is needed at 25MHz.
>=20
> Could you test it? You can change mmc->f_max in the probe function
> to limit it to 25 MHz.
>=20
> I'm more interested in the throughput you get after applying this
> patch though.

I did a test on a BPI-M2+ (H3). The new timings don't work at 25MHz,
neither for mmc1 (wifi) - nor for mmc2 (eMMC).

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
