From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 03/14] pinctrl: add a pinctrl driver for the Ingenic
 jz47xx SoCs
Date: Thu, 11 May 2017 13:01:30 +0200
Message-ID: <CACRpkdYR8Y77VXrNz=NwczgxZvitkO72bAYcDuhneZbVVsT6=g@mail.gmail.com>
References: <20170402204244.14216-2-paul@crapouillou.net> <20170428200824.10906-1-paul@crapouillou.net>
 <20170428200824.10906-4-paul@crapouillou.net> <7941dbfbaeaf5c23bb177e66165060d3@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <7941dbfbaeaf5c23bb177e66165060d3@crapouillou.net>
Sender: linux-pwm-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>"linux-mtd@lists.infradead.org" <li>
List-Id: linux-mmc@vger.kernel.org

On Wed, May 3, 2017 at 11:12 AM, Paul Cercueil <paul@crapouillou.net> wrote:

> The dependency on MFD is gone but now I notice I forgot to remove the
> 'select MFD_CORE'
> in the Kconfig. It'd be great if you can make a quick edit when merging
> this,
> otherwise I'll send a v6.

No problem I can fix it up.

Yours,
Linus Walleij
