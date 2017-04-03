From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v4 06/14] MIPS: jz4740: DTS: Add nodes for ingenic pinctrl
 and gpio drivers
Date: Mon, 3 Apr 2017 13:32:46 +0300
Message-ID: <b5d195a9-ec3d-1b92-b17c-e87bd6d990cf@cogentembedded.com>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-7-paul@crapouillou.net>
 <48f7f4ee-b8e3-0096-ddea-2fbe0b399b40@cogentembedded.com>
 <cf809000718514ba612b4f7b477586a9@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <cf809000718514ba612b4f7b477586a9@crapouillou.net>
Sender: linux-gpio-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, james.hogan@imgtec.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 4/3/2017 1:20 PM, Paul Cercueil wrote:

>>> For a description of the pinctrl devicetree node, please read
>>> Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
>>>
>>> For a description of the gpio devicetree nodes, please read
>>> Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
>>>
>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> [...]
>>
>>> diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>> b/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>> index 3e1587f1f77a..9c23c877fc34 100644
>>> --- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>> +++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>> @@ -55,6 +55,67 @@
>>>          clock-names = "rtc";
>>>      };
>>>
>>> +    pinctrl: ingenic-pinctrl@10010000 {
>>
>>    The node name should be generic, so please rename it to something
>> like "pin-controller@..."
>
> OK.
>
>>> +        compatible = "ingenic,jz4740-pinctrl";
>>> +        reg = <0x10010000 0x400>;
>>> +
>>> +        gpa: gpio-controller@0 {
>>
>>    The name should be just "gpio@0", according to ePAPR and its
>> successor spec. Although, using the <unit-address> without the "reg"
>> prop isn't allowed either...
>
> ePAPR says: "If the node has no reg property, the unit-address may be

    My copy of ePAPR 1.1 says "must be omitted". :-)

> omitted if the node name alone differentiates the node from other nodes at
> the same level in the tree."

> I could use 'gpio@bank-a', it is allowed by the spec. Or do you prefer 'gpio@0'?

    Hm... maybe you should just use the "reg" prop.

> I'll wait from some feedback on the other patches then send a v5.
>
> Thanks,
> -Paul

MBR, Sergei

