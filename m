From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 12/18] pinctrl: bcm2835: Add support for BCM2711 pull-up
 functionality
Date: Fri, 27 Sep 2019 22:15:01 +0200
Message-ID: <CACRpkdb9pxCF-WvA0f3rU2cttX1XmQxB=xtOhPAaP+nYoBd_LA@mail.gmail.com>
References: <1563776607-8368-1-git-send-email-wahrenst@gmx.net>
 <1563776607-8368-3-git-send-email-wahrenst@gmx.net>
 <CACRpkdabfiDbGmAQciAUSThY-KfTsVq3tHz0bBszs2j_ej18Nw@mail.gmail.com>
 <63f17284-5551-9492-9eff-f8a4c003196b@gmx.net>
 <66dc2cad-673e-0a0b-0aeb-3d62fa2d4ccf@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <66dc2cad-673e-0a0b-0aeb-3d62fa2d4ccf@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <mbrugger@suse.com>, Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>, Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>, Michael Turquette <mturquette@baylibre.com>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Florian Fainelli <f.fainelli@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 27, 2019 at 9:29 PM Stefan Wahren <wahrenst@gmx.net> wrote:

> today i had the time to try this out. Instead of the following:
>
>     i2c0_gpio0: i2c0_gpio0 {
>         brcm,pins = <0 1>;
>         brcm,function = <BCM2835_FSEL_ALT0>;
>         brcm,pull = <BCM2835_PUD_UP
>                  BCM2835_PUD_OFF>;
>     }
>
> you want this?
>
>     i2c0_gpio0: i2c0_gpio0 {
>         pin-sda {
>             function = "alt0";
>             pins = "gpio0";
>             bias-pull-up;
>         };
>         pin-scl {
>             function = "alt0";
>             pins = "gpio1";
>             bias-disable;
>         };
>     };

Yes that looks much better. In my opinion.

I understand that it puts some developers off because of being
more lines or excessively verbose, so to be on the clear,
verboseness in itself is not the goal.

The goal is universal
portability: i.e. it should not matter one bit whether I work
on an 2001 Intel StrongARM SoC, a 2019 Broadcom SoC
or a 2011 ST-Ericsson SoC: I will understand what bias-disable;
or bias-pull-up; means, which lowers the threshold to
maintenance.

Opaque macros, however helpfully named, still creates
a higher cognitive resistance and stresses developers.

> Unfortunately i don't know U-Boot is handle the BCM2835 specific pinctrl
> functions.

I think it would be nice if boot loaders avoid to forking the
standards, but I suppose it will invariably happen.
Just keep in mind the IETF motto "rough consensus and
running code".

Yours,
Linus Walleij
