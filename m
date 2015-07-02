From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC PATCH] mmc: sprd: add MMC host driver for Spreadtrum SoC
Date: Thu, 2 Jul 2015 10:47:16 -0500
Message-ID: <CAL_JsqKk0KOheyGvc=EBkgH3K4fPDsppLQGtXjNA4cekW57bvQ@mail.gmail.com>
References: <1435735399-15333-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <CAL_JsqKcZ-7rM5YrkpJSP7OfECmRg4hWPRFy=UqZn1y74R8qsg@mail.gmail.com> <CA+H2tpG+_pCR-j3nZ+SeAhpj6QfiPK2=Q0pwjndQoG9R4+LMYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+H2tpG+_pCR-j3nZ+SeAhpj6QfiPK2=Q0pwjndQoG9R4+LMYw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <chunyan.zhang@spreadtrum.com>, "chris@printf.net" <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, billows.wu@spreadtrum.com, =?UTF-8?B?V2VpIFFpYW8gKOS5lOS8nyk=?= <wei.qiao@spreadtrum.com>, baolin.wang@spreadtrum.com, ning.yang@spreadtrum.com, =?UTF-8?B?T3Jzb24gWmhhaSjnv5/kuqwp?= <orson.zhai@spreadtrum.com>, jason.wu@spreadtrum.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jul 2, 2015 at 4:26 AM, Orson Zhai <orsonzhai@gmail.com> wrote:
> Hi Rob,
>
> Thanks for your quick reply.
> I have one question to your last comment.
>
> On Thu, Jul 2, 2015 at 1:50 AM, Rob Herring <robherring2@gmail.com> wrote:
>> On Wed, Jul 1, 2015 at 2:23 AM, Chunyan Zhang
>> <chunyan.zhang@spreadtrum.com> wrote:
>>> From: Billows Wu <billows.wu@spreadtrum.com>

[...]

>>> +const struct of_device_id sdhost_of_match[] = {
>>> +       {.compatible = "sprd,sd-sdhost-3.0", .data = &sd_caps_info,},
>>> +       {.compatible = "sprd,wifi-sdhost-3.0", .data = &wifi_caps_info,},
>>> +       {.compatible = "sprd,emmc-sdhost-3.0",  .data = &emmc_caps_info,},
>>
>> What these are connected to is irrelevant to the driver and compatible
>> string. All these differences belong in the DT unless the IP blocks
>> are really different.
>
> It's my idea to let Billows do like this.
> I learn from SSP part in freescale  "arch/arm/boot/dts/imx28-evk.dts"
> Their ssp0-ssp2 each have 2 roles, mmc or generic spi bus.
> And they may write one of their combo configuration like this:

That is a bit different as the host controller is operating in
completely different modes. In your case, the host controller is the
same and functions the same way, but just has different cards
attached.

>
>  43                         ssp1: ssp@80012000 {
>  44                                 compatible = "fsl,imx28-mmc";
>  45                                 bus-width = <8>;
>  46                                 wp-gpios = <&gpio0 28 0>;
>  47                         };
>  48
>  49                         ssp2: ssp@80014000 {
>  50                                 #address-cells = <1>;
>  51                                 #size-cells = <0>;
>  52                                 compatible = "fsl,imx28-spi";
>  53                                 pinctrl-names = "default";
>  54                                 pinctrl-0 = <&spi2_pins_a>;
>  55                                 status = "okay";
>  56
>  57                                 flash: m25p80@0 {
>  58                                         #address-cells = <1>;
>  59                                         #size-cells = <1>;
>  60                                         compatible = "sst,sst25vf016b";
>  61                                         spi-max-frequency = <40000000>;
>  62                                         reg = <0>;
>  63                                 };
>  64                         };
>
> Billows tell me they also have 3 roles in their sd host controller
> corresponding to 3 kinds of different operation.
> He used to create "sprd,name" property for this. Is it a good way or
> anything else better?

Why do you need to know? You can define parameters which can't be
probed such as bus width, voltage, and clock freq. in DT for each
host. The MMC subsys core will figure out the type of device attached.

Rob
