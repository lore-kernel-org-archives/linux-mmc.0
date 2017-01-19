From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 13/13] MIPS: jz4740: Remove custom GPIO code
Date: Thu, 19 Jan 2017 10:07:03 +0100
Message-ID: <CACRpkdYMm0iWxmEGyQyEz4JfWukXNyGXO1rqw1dSiABgHdA1tQ@mail.gmail.com>
References: <20170117231421.16310-1-paul@crapouillou.net> <20170117231421.16310-14-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117231421.16310-14-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, linux-p
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 18, 2017 at 12:14 AM, Paul Cercueil <paul@crapouillou.net> wrote:

> All the drivers for the various hardware elements of the jz4740 SoC have
> been modified to use the pinctrl framework for their pin configuration
> needs.
> As such, this platform code is now unused and can be deleted.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

I feel I might have come across as a bit harsh in the previous review of the
patches leading up to this one. In that case I'm sorry.

I can clearly see that the intent of the series is to remove this hopelessly
idiomatic code from the MIPS hurdle, and move these systems over
to standard frameworks.

In a way, if I look at the kernel as a whole, it would likely look better
after these patches were merged, than before. Even with the
shortcomings I painted out in the previous review comments.

A very complicated piece of messy code is cut from MIPS.

I think this is very valuable work and well worth persuing, so please
go ahead and work with the series, your effort is very much appreciated!

Yours,
Linus Walleij
