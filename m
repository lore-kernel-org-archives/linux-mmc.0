From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 00/13] Ingenic JZ4740 / JZ4780 pinctrl driver
Date: Fri, 20 Jan 2017 11:17:28 +0100
Message-ID: <775b4a87768de7263ce6ff9a38659334@mail.crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net>
 <20170118071530.GA18989@ulmo.ba.sec>
 <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <CACRpkdaeu9OxaSPeOrkKtKNQGUQh4puCFw8A2h=xhqVdDWgoow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdaeu9OxaSPeOrkKtKNQGUQh4puCFw8A2h=xhqVdDWgoow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Linux MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, James Hogan <james.hogan@imgtec.com>
List-Id: linux-mmc@vger.kernel.org

Le 2017-01-20 09:40, Linus Walleij a écrit :

> On Thu, Jan 19, 2017 at 12:19 PM, Paul Cercueil <paul@crapouillou.net> 
> wrote:
> 
>> The problem with pinctrl and PWM, is that the pinctrl API works by 
>> "states". A default state, sleep state, and basically any custom state 
>> that the devicetree provides. This works well until you need to 
>> control individually each pin; with 8 pins, you would need 2^8 states, 
>> each one corresponding to a given configuration.
> 
> I do not really understand, do you really use all 2^8 states in a given
> system?
> 
> The pin control states are to be used for practical situations, not
> for all theoretical situations.
> 
> You should define in your device tree the states that your
> particular system will use. Not all possible states on all possible
> systems.
> 

Well, that was if I wanted to dynamically set/unset the pin mux and
configuration when requesting/freeing a PWM. Then I'd need 2^x states
for X PWM pins.

Anyway, a static configuration works for me too. If at some point I
want dynamic configuration of the pins then I'll make the PWM driver
handle only one PWM pin and create one driver instance for each pin.

Regards,
-Paul
