From: =?UTF-8?Q?Alejandro_Gonz=c3=a1lez?=
 <alejandro.gonzalez.correo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mmc: sunxi: fix unusuable eMMC on some H6
 boards by disabling DDR
Date: Wed, 28 Aug 2019 12:52:49 +0200
Message-ID: <f84d62b7-da00-f2bd-36e9-972435080bfe@gmail.com>
References: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
 <CAPDyKFr5opD2yBXmFRBY-9oA_3ShVv0GPFRO8Q_8TEiT+z2pQA@mail.gmail.com>
Reply-To: alejandro.gonzalez.correo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCMJLZOTUYPBBB52THVQKGQEYB322PA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAPDyKFr5opD2yBXmFRBY-9oA_3ShVv0GPFRO8Q_8TEiT+z2pQA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: es-ES
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

El 27/8/19 a las 15:24, Ulf Hansson escribi=C3=B3:> Assuming this should go=
 stable as well? Perhaps you can find a
> relevant commit that we can put as a fixes tag as well?
>=20
> Kind regards
> Uffe

The most relevant commit I've found that is related to enabling DDR speeds
on H6 boards is this one: https://github.com/torvalds/linux/commit/07bafc1e=
3536a4e3c422dbd13341688b54f159bb .
But it doesn't address the H6 SoC specifically, so I doubted whether it wou=
ld
be appropiate to mark this patch as fixing it, and opted to not do it. I do=
n't
mind adding that tag if it's appropiate, though :-)

On the other hand, I'm not sure that I understood correctly what do you mea=
n by
this patch going stable, but I might say the changes themselves are stable =
and work.
The only downside I can think of to them is that they are a kind of workaro=
und that
reduces performance on H6 boards and/or eMMC not affected by this problem (=
are there
any?), unless device trees are changed.

El 27/8/19 a las 15:32, Maxime Ripard escribi=C3=B3:
> On Sun, Aug 25, 2019 at 05:05:58PM +0200, Alejandro Gonz=C3=A1lez wrote:
>> Some Allwinner H6 boards have timing problems when dealing with
>> DDR-capable eMMC cards. These boards include the Pine H64 and Tanix TX6.
>>
>> These timing problems result in out of sync communication between the
>> driver and the eMMC, which renders the memory unsuable for every
>> operation but some basic commmands, like reading the status register.
>>
>> The cause of these timing problems is not yet well known, but they go
>> away by disabling DDR mode operation in the driver. Like on some H5
>> boards, it might be that the traces are not precise enough to support
>> these speeds. However, Jernej Skrabec compared the BSP driver with this
>> driver, and found that the BSP driver configures pinctrl to operate at
>> 1.8 V when entering DDR mode (although 3.3 V operation is supported), wh=
ile
>> the mainline kernel lacks any mechanism to switch voltages dynamically.
>> Finally, other possible cause might be some timing parameter that is
>> different on the H6 with respect to other SoCs.
>=20
> This should be a comment in the driver where this is disabled.
>=20
> Maxime

Thank you for your review. I'll mention that briefly in a comment in the co=
de for
the next revision of this patch.

Regards.

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/f84d62b7-da00-f2bd-36e9-972435080bfe%40gmail.com.
