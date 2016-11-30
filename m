From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: Re: [PATCH] mmc: pwrseq: add support for Marvell SD8787 chip
Date: Tue, 29 Nov 2016 17:20:20 -0800
Message-ID: <CAJ_EiST_bpBm+spPuWH-a+47t4qVsDVFjUm=a+TtL-BWN3DHdw@mail.gmail.com>
References: <1479434109-8745-1-git-send-email-matt@ranostay.consulting> <CABxcv=nEih8xX4fM0eqjkqprdt1uGTEyx5tzK04GuSgsHc=Haw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABxcv=nEih8xX4fM0eqjkqprdt1uGTEyx5tzK04GuSgsHc=Haw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Nov 29, 2016 at 9:13 AM, Javier Martinez Canillas
<javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org> wrote:
> Hello Matt,
>
> On Thu, Nov 17, 2016 at 10:55 PM, Matt Ranostay
> <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org> wrote:
>> Allow power sequencing for the Marvell SD8787 Wifi/BT chip.
>> This can be abstracted to other chipsets if needed in the future.
>>
>> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
>> Cc: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
>> ---
>>  .../devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt  |  14 +++
>>  .../bindings/net/wireless/marvell-sd8xxx.txt       |   4 +
>>  drivers/mmc/core/Kconfig                           |  10 ++
>>  drivers/mmc/core/Makefile                          |   1 +
>>  drivers/mmc/core/pwrseq_sd8787.c                   | 117 +++++++++++++++++++++
>>  5 files changed, 146 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
>>  create mode 100644 drivers/mmc/core/pwrseq_sd8787.c
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
>
> According Documentation/devicetree/bindings/submitting-patches.txt,
> the DT bindings patches should posted as a separate patch.

Ok will do.

>
>> new file mode 100644
>> index 000000000000..1b658351629b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
>> @@ -0,0 +1,14 @@
>> +* Marvell SD8787 power sequence provider
>> +
>> +Required properties:
>> +- compatible: must be "mmc-pwrseq-sd8787".
>
> Since this is not a generic binding, the compatible string should have
> a vendor prefix.
>

Makes sense to me.


>> +- pwndn-gpio: contains a power down GPIO specifier.
>> +- reset-gpio: contains a reset GPIO specifier.
>> +
>
> I wonder if we really need a custom power sequence provider for just
> this SDIO WiFI chip though. AFAICT the only missing piece in
> mmc-pwrseq-simple is the power down GPIO property, so maybe
> mmc-pwrseq-simple could be extended instead to have an optional
> powerdown-gpios property and instead in the Marvell SD8787 DT binding
> can be mentioned which mmc-pwrseq-simple properties are required for
> the device.
>

The reason we didn't do that is we need delay between the two
assertions/desertions of GPIOs. It wouldn't seems good practice to
hack the pwrseq-simple for this...

>> +Example:
>> +
>> +       wifi_pwrseq: wifi_pwrseq {
>> +               compatible = "mmc-pwrseq-sd8787";
>> +               pwrdn-gpio = <&twl_gpio 0 GPIO_ACTIVE_LOW>;
>> +               reset-gpio = <&twl_gpio 1 GPIO_ACTIVE_LOW>;
>> +       }
>> diff --git a/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt b/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
>
> Does this patch depend on a previous posted series? I don't see this
> file in today's linux-next...

Got renamed to ->
Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt it
seems very recently.

>
>> index c421aba0a5bc..08fd65d35725 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
>> +++ b/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
>> @@ -32,6 +32,9 @@ Optional properties:
>>                  so that the wifi chip can wakeup host platform under certain condition.
>>                  during system resume, the irq will be disabled to make sure
>>                  unnecessary interrupt is not received.
>> +  - vmmc-supply: a phandle of a regulator, supplying VCC to the card
>> +  - mmc-pwrseq:  phandle to the MMC power sequence node. See "mmc-pwrseq-*"
>> +                for documentation of MMC power sequence bindings.
>>
>>  Example:
>>
>> @@ -44,6 +47,7 @@ so that firmware can wakeup host using this device side pin.
>>  &mmc3 {
>>         status = "okay";
>>         vmmc-supply = <&wlan_en_reg>;
>> +       mmc-pwrseq = <&wifi_pwrseq>;
>>         bus-width = <4>;
>>         cap-power-off-card;
>>         keep-power-in-suspend;
>
> I think this change should be split in a separate patch as well.
>
> Best regards,
> Javier
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
