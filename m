From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: sunxi: fix unusuable eMMC on some H6 boards by
 disabling DDR
Date: Wed, 28 Aug 2019 14:52:30 +0200
Message-ID: <CACRpkdazfe3gJr6Q+X05GzxPuKtUg0M780SPA_oR5bd+-xBPvA@mail.gmail.com>
References: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Alejandro_Gonz=C3=A1lez?= <alejandro.gonzalez.correo@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>
List-Id: linux-mmc@vger.kernel.org

On Sun, Aug 25, 2019 at 5:06 PM Alejandro Gonz=C3=A1lez
<alejandro.gonzalez.correo@gmail.com> wrote:

> Jernej Skrabec compared the BSP driver with this
> driver, and found that the BSP driver configures pinctrl to operate at
> 1.8 V when entering DDR mode (although 3.3 V operation is supported), whi=
le
> the mainline kernel lacks any mechanism to switch voltages dynamically.
(...)
> the kernel lacks the required
> dynamic pinctrl control for now

This is not a pin control thing, the I/O voltage level is usually
controlled by a regulator called VCCQ, if the selection of the
voltage rails is inside the pin control registers, see the solution
in drivers/pinctrl/sh-pfc/pfc-sh73a0.c where we simply provide
a regulator from inside the pinctrl driver to make things easy
for the MMC core. Do this thing!

If you don't have time to fix it up properly right now I would slap
in a big FIXME in the code so people know this needs
to be fixed properly.

Yours,
Linus Walleij
