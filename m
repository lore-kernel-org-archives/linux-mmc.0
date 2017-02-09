From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 04/14] GPIO: Add gpio-ingenic driver
Date: Thu, 09 Feb 2017 18:14:32 +0100
Message-ID: <b032ad924ae905ce4fd11535d08c29a8@mail.crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
 <20170125185207.23902-5-paul@crapouillou.net>
 <CACRpkdaqQ2==B1_o-Ru81Nbu_kUF+Kxn=XFYms-1e=nAtHiJ4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <CACRpkdaqQ2==B1_o-Ru81Nbu_kUF+Kxn=XFYms-1e=nAtHiJ4A@mail.gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Linux MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, James Hogan <james.hogan@imgtec.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

> What some drivers do when they just get/set a bit in a register
> to get/set or set the direction of a GPIO, is to select GPIO_GENERIC
> and just bgpio_init() with the right iomem pointers, then the core
> will register handlers for get, set, set_direcition callback and
> get_direction and your driver can just focus on the remainders.

GPIO_GENERIC and bgpio_init() would work for my .set() / .get() 
callbacks,
not for my .direction_input() / .direction_output() callbacks which need
to set more than one register.

> If you're not just replacing these with GPIO_GENERIC, please also
> include a .get_direction() callback.

My .direction_input() and .direction_output() callbacks just call into
the pinctrl driver, using pinctrl_gpio_direction_[in,out]put().
I didn't find a way to get the direction info from the pinctrl driver,
is that something that the core should provide?

Thanks,
-Paul
