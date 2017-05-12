From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v5 05/14] MIPS: ingenic: Enable pinctrl for all ingenic
 SoCs
Date: Fri, 12 May 2017 19:00:15 +0200
Message-ID: <421a30e7-1bfc-b1de-6db8-96216a65adcf@crapouillou.net>
References: <20170402204244.14216-2-paul@crapouillou.net>
 <20170428200824.10906-1-paul@crapouillou.net>
 <20170428200824.10906-6-paul@crapouillou.net>
 <CACRpkdaYRmB=i-=k4vfFYL6wHVrpNo1w11xnLGbu+6YPPmT8vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdaYRmB=i-=k4vfFYL6wHVrpNo1w11xnLGbu+6YPPmT8vA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>"linux-mtd@lists.infradead.org" <li>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 11/05/2017 13:08, Linus Walleij wrote:
> On Fri, Apr 28, 2017 at 10:08 PM, Paul Cercueil <paul@crapouillou.net> wrote:
>
>> There is a pinctrl driver for each of the Ingenic SoCs supported by the
>> upstream Linux kernel. In order to switch away from the old GPIO
>> platform code, we now enable the pinctrl drivers by default for the
>> Ingenic SoCs.
>>
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> ---
>>   arch/mips/Kconfig | 1 +
> So please tell me your desired merge strategy for these bits. I can
> provide an immutable branch for pinctrl if you want to pull the deps in
> or we can just merge this orthogonally in the MIPS tree and let things
> smoothen together in the merge window.
>
> This goes for everything outside of pinctrl/gpio.
>
> If I should merge patches for other subsystems I need ACKs from
> the maintainers of MIPS etc.
>
> Yours,
> Linus Walleij
>
It is very unlikely that those patches will cause merge failures
if you merge it in your tree, these drivers are touched very rarely;
so I'd say you can merge them.

But to be sure I'd like Ralf's input on that.

Regards,
-Paul

