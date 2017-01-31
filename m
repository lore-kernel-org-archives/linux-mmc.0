From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 04/14] GPIO: Add gpio-ingenic driver
Date: Tue, 31 Jan 2017 16:29:58 +0100
Message-ID: <699f0c63e95ecdafe6946fdcdbb97a37@mail.crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
 <20170125185207.23902-5-paul@crapouillou.net>
 <CACRpkdbcO+1c7izYpn0sb1mkE1ORFETMq=xtzVi1hKbJz0EWfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbcO+1c7izYpn0sb1mkE1ORFETMq=xtzVi1hKbJz0EWfw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Linux MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, James Hogan <james.hogan@imgtec.com>
List-Id: linux-mmc@vger.kernel.org

Le 2017-01-31 15:20, Linus Walleij a écrit :

>> + of_property_read_u32(dev->of_node, "base", &jzgc->gc.base);
> 
> Remove this. Dynamic allocation should be fine, if you're using the
> new userspace ABI like tools/gpio/* or libgpiod and only that and 
> in-kernel
> consumers, dynamic numbers are just fine.

The problem is that the QI_LB60 board code still have a lot of 
references
to global GPIO numbers. Just grep for JZ_GPIO_PORT in
arch/mips/jz4740/board-qi_lb60.c to see what I mean...

-Paul
