From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: Re: [PATCH] mmc: sunxi: fix unusuable eMMC on some
 H6 boards by disabling DDR
Date: Wed, 28 Aug 2019 21:46:43 +0800
Message-ID: <CAGb2v67hS1a2iNJYgc97vwpg6hZwxjoxRhdMb5PjHmMrOC1jNA@mail.gmail.com>
References: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
 <CACRpkdazfe3gJr6Q+X05GzxPuKtUg0M780SPA_oR5bd+-xBPvA@mail.gmail.com>
 <CAGb2v67e8EiS-LUuhAyPc57nWd4iOBEWC_SZbH801Lzi4QWGyg@mail.gmail.com> <20190828134334.qzuwodoxmw7ov5yg@flea>
Reply-To: wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCMILY6JWQBBBUELTLVQKGQE7MRBG6Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190828134334.qzuwodoxmw7ov5yg@flea>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: =?UTF-8?Q?Alejandro_Gonz=C3=A1lez?= <alejandro.gonzalez.correo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 28, 2019 at 9:43 PM Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> On Wed, Aug 28, 2019 at 09:29:32PM +0800, Chen-Yu Tsai wrote:
> > On Wed, Aug 28, 2019 at 8:52 PM Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org=
> wrote:
> > >
> > > On Sun, Aug 25, 2019 at 5:06 PM Alejandro Gonz=C3=A1lez
> > > <alejandro.gonzalez.correo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >
> > > > Jernej Skrabec compared the BSP driver with this
> > > > driver, and found that the BSP driver configures pinctrl to operate=
 at
> > > > 1.8 V when entering DDR mode (although 3.3 V operation is supported=
), while
> > > > the mainline kernel lacks any mechanism to switch voltages dynamica=
lly.
> >
> > AFAIK The Pine H64 does not have the ability to switch I/O voltages. It=
 is
> > fixed to either 1.8V (the default based on the schematics) or 3.3V.
>
> Should that be handled at the board level then maybe?

Yeah. You'd specify which one using vqmmc-supply in the mmc node and
vcc-pc-supply
in the pinctrl node.

ChenYu

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/CAGb2v67hS1a2iNJYgc97vwpg6hZwxjoxRhdMb5PjHmMrOC1jNA%40mail.gma=
il.com.
