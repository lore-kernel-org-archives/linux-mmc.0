From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 06/14] MIPS: jz4740: DTS: Add nodes for ingenic pinctrl
 and gpio drivers
Date: Fri, 07 Apr 2017 15:57:11 +0200
Message-ID: <e4aaf8c3e8a54df2c5878f8e873e290f@crapouillou.net>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-7-paul@crapouillou.net>
 <CACRpkdbXe1Xxk93jqLXBdEDwWOnWD+CkZrqvok-PcmWxzBbSZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbXe1Xxk93jqLXBdEDwWOnWD+CkZrqvok-PcmWxzBbSZA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Linux MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Le 2017-04-07 11:44, Linus Walleij a écrit :
> On Sun, Apr 2, 2017 at 10:42 PM, Paul Cercueil <paul@crapouillou.net> 
> wrote:
> 
>> For a description of the pinctrl devicetree node, please read
>> Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
>> 
>> For a description of the gpio devicetree nodes, please read
>> Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
>> 
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> ---
>>  arch/mips/boot/dts/ingenic/jz4740.dtsi | 61 
>> ++++++++++++++++++++++++++++++++++
>>  1 file changed, 61 insertions(+)
>> 
>>  v2: Changed the devicetree bindings to match the new driver
>>  v3: No changes
>>  v4: Update the bindings for the v4 version of the drivers
> (...)
> 
>> +       pinctrl: ingenic-pinctrl@10010000 {
>> +               compatible = "ingenic,jz4740-pinctrl";
>> +               reg = <0x10010000 0x400>;
>> +
>> +               gpa: gpio-controller@0 {
>> +                       compatible = "ingenic,gpio-bank-a", 
>> "ingenic,jz4740-gpio";
> 
> As Sergei and Rob notes, the bank compatible properties look
> a bit strange. Especially if they are all the same essentially.
> 
> I like Sergei's idea to simply use the reg property if what you want
> is really a unique ID number. What do you think about this?
> 
> Yours,
> Linus Walleij

I think the 'reg' property makes more sense, yes. I'll fix this in the 
v5, this
week-end. Do you think it can go in 4.12?

Thanks,
-Paul
