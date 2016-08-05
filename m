From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ARM64: dts: meson-gxbb: add MMC support
Date: Thu, 4 Aug 2016 21:45:05 -0500
Message-ID: <CAL_JsqK18UPAUFCqfN7TJqz4AoLBbNA7fOgeQXqPES06fuhgFQ@mail.gmail.com>
References: <20160803231843.23012-1-khilman@baylibre.com> <20160804181556.GA13000@rob-hp-laptop>
 <m2oa58nntc.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-compiler-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <m2oa58nntc.fsf-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-compiler-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-compiler-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Victor Wan <victor.wan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, Jerry Cao <jerry.cao-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, Xing Wu <xing.xu-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

+dtc list

On Thu, Aug 4, 2016 at 5:58 PM, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
> Hi Rob,
>
> Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:
>
>> On Wed, Aug 03, 2016 at 04:18:42PM -0700, Kevin Hilman wrote:
>>> Add binding and basic support for the SD/eMMC controller on Amlogic
>>> S905/GXBB devices.
>>>
>>> Signed-off-by: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>
> [...]
>
>>> +    mmc_iv: gpio-regulator {
>>> +            compatible = "regulator-gpio";
>>> +
>>> +            regulator-name = "mmc-gpio-supply";
>>> +            regulator-min-microvolt = <1800000>;
>>> +            regulator-max-microvolt = <3300000>;
>>> +
>>> +            gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
>>> +            gpio-states = <0 1>;
>>> +
>>> +            /*
>>> +             * Based on ODROID-C2 schematics:
>>> +             * signal name: IO_TF_3V3N_1V8, GPIOAO bit 3
>>> +             */
>>> +            states = <3300000 0
>>> +                      1800000 1>;
>>
>> There are multiple things wrong in this node based on the regulator-gpio
>> documentation.
>
> I see I got the property name wrong, and the number of elements wrong,
> and this fixes those issues:
>
> -               gpio-states = <0 1>;
> +               gpios-states = <0>;
>
> By "multiple", did you mean more than those 2?  If so, I'm not seeing
> what else is wrong.

I was thinking it needed an enable-gpio property, but now I see that
is separate from "gpios".

> [...]
>
>>> +    mmc_iv: gpio-regulator {
>>> +            compatible = "regulator-gpio";
>>> +
>>> +            regulator-name = "mmc-gpio-supply";
>>> +            regulator-min-microvolt = <1800000>;
>>> +            regulator-max-microvolt = <3300000>;
>>> +
>>> +            gpios = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
>>> +            gpio-states = <0 1>;
>>> +
>>> +            /* Based on P200 schematics, signal CARD_1.8V/3.3V_CTR */
>>> +            states = <1800000 0
>>> +                      3300000 1>;
>>> +    };
>>> +
>>> +    vddio_boot: regulator {
>> [...]
>>> +    vcc_3v3: regulator {
>>
>> This won't even compile as you have the same node name twice.
>
> Oops, it's wrong indeed, but in fact, it does compile, otherwise I
> would've caught that..  Even if I remove the labels, it still compiles.
> Interesting.

Humm, news to me. I will have to do some testing unless the dtc folks
have any insight.

Rob
