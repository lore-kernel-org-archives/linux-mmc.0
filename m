From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [RFC v2 1/2] dt-bindings: mmc: Document the Amlogic Meson8 and
 Meson8b SDIO bindings
Date: Mon, 2 Oct 2017 20:47:48 +0200
Message-ID: <CAFBinCA6HfKTNSLczx=V3dtfsrUSMKJw-nLAp6s9m55dJ9nQxA@mail.gmail.com>
References: <20170924190528.21841-1-martin.blumenstingl@googlemail.com>
 <20170924190528.21841-2-martin.blumenstingl@googlemail.com> <CAPDyKFohh0_aONKyoc2deN+L8TCzY8tdEs5-fja3t5oVL2Gs7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFohh0_aONKyoc2deN+L8TCzY8tdEs5-fja3t5oVL2Gs7w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Oct 2, 2017 at 9:55 AM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 24 September 2017 at 21:05, Martin Blumenstingl
> <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
>> From: Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
>>
>> This documents the devicetree bindings for the SDIO/MMC host found in
>> Amlogic Meson8 and Meson8b SoCs. It supports the SD specification v2.0
>> and the eMMC specification v4.41.
>> It has an internal "mux" which allows connecting up to three MMC devices
>> to it. The maximum supported bus-width is 4-bits.
>>
>> Amlogic's GPL kernel sources call it "SDIO" to differentiate it from the
>> other MMC controller in (at least the Meson8 and Meson8b) the SoCs (they
>> call the other one "SDHC", which supports a bus-width of up to 8-bits).
>>
>> Signed-off-by: Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>> ---
>>  .../bindings/mmc/amlogic,meson-mx-sdio.txt         | 52 ++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
>> new file mode 100644
>> index 000000000000..124ea362eec9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
>> @@ -0,0 +1,52 @@
>> +* Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
>> +
>> +The highspeed MMC host controller on Amlogic SoCs provides an interface
>> +for MMC, SD, SDIO and SDHC types of memory cards.
>> +
>> +Supported maximum speeds are the ones of the eMMC standard 4.41 as well
>> +as the speed of SD standard 2.0.
>> +
>> +The hardware provides an internal "mux" which allows up to three slots
>> +to be controlled. Only one slot can be accessed at a time.
>
> This is good information, however as the driver won't support multiple
> slots, at least short term, I think we need to mention that. Otherwise
> people may think that three slots is actually supported, while in fact
> it isn't.
OK, I'll add a note when I re-spin this series

>> +
>> +Required properties:
>> + - compatible : must be one of
>> +       - "amlogic,meson8-sdio"
>> +       - "amlogic,meson8b-sdio"
>> +       along with the generic "amlogic,meson-mx-sdio"
>> + - reg : mmc controller base registers
>> + - interrupts : mmc controller interrupt
>> + - #address-cells : must be 1
>> + - size-cells : must be 0
>> + - clocks : phandle to clock providers
>> + - clock-names : must contain "core" and "clkin"
>> +
>> +Required child nodes:
>> +A node for each slot provided by the MMC controller is required.
>> +
>> +Required properties on each child node (= slot):
>> + - compatible : must be "mmc-slot" (see mmc.txt within this directory)
>> + - reg : the slot (or "port") ID
>> +
>> +Optional properties on each child node (= slot):
>> + - bus-width : must be 1 or 4 (8-bit bus is not supported)
>> + - for cd and all other additional generic mmc parameters
>> +   please refer to mmc.txt within this directory
>> +
>> +Examples:
>> +       mmc@c1108c20 {
>> +               compatible = "amlogic,meson8-sdio", "amlogic,meson-mx-sdio";
>> +               reg = <0xc1108c20 0x20>;
>> +               interrupts = <0 28 1>;
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               clocks = <&clkc CLKID_SDIO>, <&clkc CLKID_CLK81>;
>> +               clock-names = "core", "clkin";
>> +
>> +               slot@1 {
>> +                       compatible = "mmc-slot";
>> +                       reg = <1>;
>> +
>> +                       bus-width = <4>;
>> +               };
>> +       };
>> --
>> 2.14.1
>>
>
> Kind regards
> Uffe


Regards,
Martin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
