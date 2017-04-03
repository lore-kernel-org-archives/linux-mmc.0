From: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Subject: Re: [PATCH v4 06/14] MIPS: jz4740: DTS: Add nodes for ingenic pinctrl
 and gpio drivers
Date: Mon, 03 Apr 2017 12:20:12 +0200
Message-ID: <cf809000718514ba612b4f7b477586a9@crapouillou.net>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-7-paul@crapouillou.net>
 <48f7f4ee-b8e3-0096-ddea-2fbe0b399b40@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <48f7f4ee-b8e3-0096-ddea-2fbe0b399b40-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Maarten ter Huurne <maarten-Ph2Y2OKCxY1M656bX5wj8A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

Le 2017-04-03 11:57, Sergei Shtylyov a écrit :
> Hello!
> 
> On 4/2/2017 11:42 PM, Paul Cercueil wrote:
> 
>> For a description of the pinctrl devicetree node, please read
>> Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
>> 
>> For a description of the gpio devicetree nodes, please read
>> Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
>> 
>> Signed-off-by: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
> [...]
> 
>> diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi 
>> b/arch/mips/boot/dts/ingenic/jz4740.dtsi
>> index 3e1587f1f77a..9c23c877fc34 100644
>> --- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
>> +++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
>> @@ -55,6 +55,67 @@
>>  		clock-names = "rtc";
>>  	};
>> 
>> +	pinctrl: ingenic-pinctrl@10010000 {
> 
>    The node name should be generic, so please rename it to something
> like "pin-controller@..."

OK.

>> +		compatible = "ingenic,jz4740-pinctrl";
>> +		reg = <0x10010000 0x400>;
>> +
>> +		gpa: gpio-controller@0 {
> 
>    The name should be just "gpio@0", according to ePAPR and its
> successor spec. Although, using the <unit-address> without the "reg"
> prop isn't allowed either...

ePAPR says: "If the node has no reg property, the unit-address may be
omitted if the node name alone differentiates the node from other nodes 
at
the same level in the tree."

I could use 'gpio@bank-a', it is allowed by the spec. Or do you prefer 
'gpio@0'?

> MBR, Sergei

I'll wait from some feedback on the other patches then send a v5.

Thanks,
-Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
