From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: sunxi: fix unusuable eMMC on some H6
 boards by disabling DDR
Date: Thu, 29 Aug 2019 13:37:14 +0200
Message-ID: <CAPDyKFp420OaeoedkR=KuX1EMNwOvCkCfJHZPRDXhVz-w8J0mg@mail.gmail.com>
References: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
 <CAPDyKFr5opD2yBXmFRBY-9oA_3ShVv0GPFRO8Q_8TEiT+z2pQA@mail.gmail.com> <f84d62b7-da00-f2bd-36e9-972435080bfe@gmail.com>
Reply-To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDF57NG2XIHRBD7ST3VQKGQEOS6DHBQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <f84d62b7-da00-f2bd-36e9-972435080bfe-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?UTF-8?Q?Alejandro_Gonz=C3=A1lez?= <alejandro.gonzalez.correo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 28 Aug 2019 at 12:52, Alejandro Gonz=C3=A1lez
<alejandro.gonzalez.correo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> El 27/8/19 a las 15:24, Ulf Hansson escribi=C3=B3:> Assuming this should =
go stable as well? Perhaps you can find a
> > relevant commit that we can put as a fixes tag as well?
> >
> > Kind regards
> > Uffe
>
> The most relevant commit I've found that is related to enabling DDR speed=
s
> on H6 boards is this one: https://github.com/torvalds/linux/commit/07bafc=
1e3536a4e3c422dbd13341688b54f159bb .
> But it doesn't address the H6 SoC specifically, so I doubted whether it w=
ould
> be appropiate to mark this patch as fixing it, and opted to not do it. I =
don't
> mind adding that tag if it's appropiate, though :-)

Hard to say what makes sense here, but how about picking this below instead=
?

Fixes: 0a23f1ad88fc ("dt-binding: mmc: sunxi: add H6 compatible (with
A64 fallback)")

>
> On the other hand, I'm not sure that I understood correctly what do you m=
ean by
> this patch going stable, but I might say the changes themselves are stabl=
e and work.
> The only downside I can think of to them is that they are a kind of worka=
round that
> reduces performance on H6 boards and/or eMMC not affected by this problem=
 (are there
> any?), unless device trees are changed.

Adding a stable tag and a fixes tag for the commit, makes maintainers
of stable kernels to try to backport this commit and fix the problem
for "older" kernels.

Kind regards
Uffe

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/CAPDyKFp420OaeoedkR%3DKuX1EMNwOvCkCfJHZPRDXhVz-w8J0mg%40mail.g=
mail.com.
