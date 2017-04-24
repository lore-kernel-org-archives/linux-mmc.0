From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 06/14] MIPS: jz4740: DTS: Add nodes for ingenic pinctrl
 and gpio drivers
Date: Mon, 24 Apr 2017 14:58:00 +0200
Message-ID: <CACRpkdZ8o1OFC0HGaVuLWy5JbnHjeXmAYorii7eX=XvJNkSSvA@mail.gmail.com>
References: <20170125185207.23902-2-paul@crapouillou.net> <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-7-paul@crapouillou.net> <CACRpkdbXe1Xxk93jqLXBdEDwWOnWD+CkZrqvok-PcmWxzBbSZA@mail.gmail.com>
 <e4aaf8c3e8a54df2c5878f8e873e290f@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <e4aaf8c3e8a54df2c5878f8e873e290f@crapouillou.net>
Sender: linux-pwm-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>"linux-mtd@lists.infradead.org" <li>
List-Id: linux-mmc@vger.kernel.org

On Fri, Apr 7, 2017 at 3:57 PM, Paul Cercueil <paul@crapouillou.net> wrote:

> I think the 'reg' property makes more sense, yes. I'll fix this in the v5,
> this
> week-end. Do you think it can go in 4.12?

Surely, Torvalds just cut an -rc8 giving me more time to queue more
material, and I really like this series.

Yours,
Linus Walleij
