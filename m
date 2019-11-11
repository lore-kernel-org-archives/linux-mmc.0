From: Markus Reichl <m.reichl@fivetechno.de>
Subject: Re: arm64: dts: rockchip: Add SDR104 mode to SD-card I/F on
 rk3399-roc-pc
Date: Mon, 11 Nov 2019 20:31:57 +0100
Message-ID: <e69268d2-4a3f-3cd8-fc2e-57ae52ad337a@fivetechno.de>
References: <f03c978c-86de-b8bb-22c2-177d7fafed94@fivetechno.de>
 <CAPDyKFqn06LZZMXLD2o-M6A0R6KU97PFUTN=NgYnMtf=ESULTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqn06LZZMXLD2o-M6A0R6KU97PFUTN=NgYnMtf=ESULTA@mail.gmail.com>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>, Jagan Teki <jagan@amarulasolutions.com>, DTML <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

Am 11.11.19 um 18:27 schrieb Ulf Hansson:
> On Mon, 11 Nov 2019 at 15:13, Markus Reichl <m.reichl@fivetechno.de> wrote:
>>
>> Add SDR104 capability and regulators to SD card node.
>> While at it, fix a typo in lcd pinctrl and remove two
>> undocumented bindings from pmic.
>>
>> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
>> ---
>>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      | 31 +++++++++++++++----
>>  1 file changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> index 33df95e384b4..e86a6db54499 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
>> @@ -135,6 +135,20 @@
>>                 vin-supply = <&vcc_1v8>;
>>         };
>>
>> +       vcc3v0_sd: vcc3v0-sd {
>> +               compatible = "regulator-fixed";
>> +               enable-active-high;
>> +               gpio = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&vcc3v0_sd_en>;
>> +               regulator-name = "vcc3v0_sd";
>> +               regulator-always-on;
> 
> This looks odd. A GPIO regulator being always on?

This is a standard micro SD card socket that can also be used for
booting the board. I wanted to be cautious and start
working with it and several SD cards and explore the capabilities.

On this board nearly all regulators are still continously
switched on. I plan to remove the always-on properties step
by step from the regulators when the board runs stable with it's
components all enbled. 

> 
>> +               regulator-boot-on;
>> +               regulator-min-microvolt = <3000000>;
>> +               regulator-max-microvolt = <3000000>;
>> +               vin-supply = <&vcc3v3_sys>;
>> +       };
> 
> Assumes this powers an SDIO embedded card. Often those have a specific
> power sequence, just wanted to make sure the above are really
> sufficient? No delays or external clock needed?

It's not embedded, just a standard µSD plug. It is already enabled
by mainline U-Boot and ejecting and inserting the card works fine.

--
Gruß,
Markus
> 
> [...]
> 
> Kind regards
> Uffe
> 
