From: Orson Zhai <orsonzhai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] mmc: sprd: add MMC host driver for Spreadtrum SoC
Date: Fri, 3 Jul 2015 10:50:19 +0800
Message-ID: <CA+H2tpFO2uz3Pr4bxoesqc8teF+SYhw-GqKOdk_w4_p5KvJR6A@mail.gmail.com>
References: <1435735399-15333-1-git-send-email-chunyan.zhang@spreadtrum.com>
	<CAL_JsqKcZ-7rM5YrkpJSP7OfECmRg4hWPRFy=UqZn1y74R8qsg@mail.gmail.com>
	<CA+H2tpG+_pCR-j3nZ+SeAhpj6QfiPK2=Q0pwjndQoG9R4+LMYw@mail.gmail.com>
	<CAL_JsqKk0KOheyGvc=EBkgH3K4fPDsppLQGtXjNA4cekW57bvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqKk0KOheyGvc=EBkgH3K4fPDsppLQGtXjNA4cekW57bvQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Chunyan Zhang <chunyan.zhang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, "chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org" <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, billows.wu-lxIno14LUO0EEoCn2XhGlw@public.gmane.org, =?UTF-8?B?V2VpIFFpYW8gKOS5lOS8nyk=?= <wei.qiao-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org, ning.yang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org, =?UTF-8?B?T3Jzb24gWmhhaSjnv5/kuqwp?= <orson.zhai-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, jason.wu-lxIno14LUO0EEoCn2XhGlw@public.gmane.org, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jul 2, 2015 at 11:47 PM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Jul 2, 2015 at 4:26 AM, Orson Zhai <orsonzhai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi Rob,
>>
>> Thanks for your quick reply.
>> I have one question to your last comment.
>>
>> On Thu, Jul 2, 2015 at 1:50 AM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> On Wed, Jul 1, 2015 at 2:23 AM, Chunyan Zhang
>>> <chunyan.zhang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org> wrote:
>>>> From: Billows Wu <billows.wu-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
>
> [...]
>
>>>> +const struct of_device_id sdhost_of_match[] = {
>>>> +       {.compatible = "sprd,sd-sdhost-3.0", .data = &sd_caps_info,},
>>>> +       {.compatible = "sprd,wifi-sdhost-3.0", .data = &wifi_caps_info,},
>>>> +       {.compatible = "sprd,emmc-sdhost-3.0",  .data = &emmc_caps_info,},
>>>
>>> What these are connected to is irrelevant to the driver and compatible
>>> string. All these differences belong in the DT unless the IP blocks
>>> are really different.
>>
>> It's my idea to let Billows do like this.
>> I learn from SSP part in freescale  "arch/arm/boot/dts/imx28-evk.dts"
>> Their ssp0-ssp2 each have 2 roles, mmc or generic spi bus.
>> And they may write one of their combo configuration like this:
>
> That is a bit different as the host controller is operating in
> completely different modes. In your case, the host controller is the
> same and functions the same way, but just has different cards
> attached.
>
>>
>>  43                         ssp1: ssp@80012000 {
>>  44                                 compatible = "fsl,imx28-mmc";
>>  45                                 bus-width = <8>;
>>  46                                 wp-gpios = <&gpio0 28 0>;
>>  47                         };
>>  48
>>  49                         ssp2: ssp@80014000 {
>>  50                                 #address-cells = <1>;
>>  51                                 #size-cells = <0>;
>>  52                                 compatible = "fsl,imx28-spi";
>>  53                                 pinctrl-names = "default";
>>  54                                 pinctrl-0 = <&spi2_pins_a>;
>>  55                                 status = "okay";
>>  56
>>  57                                 flash: m25p80@0 {
>>  58                                         #address-cells = <1>;
>>  59                                         #size-cells = <1>;
>>  60                                         compatible = "sst,sst25vf016b";
>>  61                                         spi-max-frequency = <40000000>;
>>  62                                         reg = <0>;
>>  63                                 };
>>  64                         };
>>
>> Billows tell me they also have 3 roles in their sd host controller
>> corresponding to 3 kinds of different operation.
>> He used to create "sprd,name" property for this. Is it a good way or
>> anything else better?
>
> Why do you need to know? You can define parameters which can't be
> probed such as bus width, voltage, and clock freq. in DT for each
> host. The MMC subsys core will figure out the type of device attached.

I think you're right.
Thanks!
-orson

>
> Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
