From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH V5 2/2] ARM: dts: Add HS400 support for exynos5420 and exynos5800
Date: Sun, 15 Mar 2015 16:58:13 +0530
Message-ID: <CAGOxZ53_TGay2ooTW22ZGPZ+yneqoXH6JEPZ=mMSYr1cpOhXWg@mail.gmail.com>
References: <1422499318-13726-1-git-send-email-alim.akhtar@samsung.com>
 <1422499318-13726-3-git-send-email-alim.akhtar@samsung.com> <54ED6D24.4000703@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:32895 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbbCOL2y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Mar 2015 07:28:54 -0400
In-Reply-To: <54ED6D24.4000703@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Douglas Anderson <dianders@chromium.org>, kgene <kgene@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Abhilash Kesavan <a.kesavan@samsung.com>

Ping?

On Wed, Feb 25, 2015 at 12:05 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi, Alim.
>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>
> Best Regards,
> Jaehoon Chung
>
> On 01/29/2015 11:41 AM, Alim Akhtar wrote:
>> From: Seungwon Jeon <tgih.jun@samsung.com>
>>
>> HS400 timing values are added for SMDK5420, exynos5420-peach-pit
>> and exynos5800-peach-pi boards.
>> This also adds RCLK GPIO line, this gpio should be in pull-down
>> state.
>> This also enables HS400 on peach-pi and this updates the clock frequency
>> to 800MHz to be set as input clock to controller.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> [Alim: addressed review comments]
>> ---
>>  arch/arm/boot/dts/exynos5420-peach-pit.dts |    4 +++-
>>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi  |    7 +++++++
>>  arch/arm/boot/dts/exynos5420-smdk5420.dts  |    4 +++-
>>  arch/arm/boot/dts/exynos5800-peach-pi.dts  |    7 +++++--
>>  4 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> index 9a050e1..f7a44a4 100644
>> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> @@ -569,8 +569,10 @@
>>       samsung,dw-mshc-ciu-div = <3>;
>>       samsung,dw-mshc-sdr-timing = <0 4>;
>>       samsung,dw-mshc-ddr-timing = <0 2>;
>> +     samsung,dw-mshc-hs400-timing = <0 2>;
>> +     samsung,read-strobe-delay = <90>;
>>       pinctrl-names = "default";
>> -     pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>> +     pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
>>       bus-width = <8>;
>>  };
>>
>> diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
>> index ba686e4..8b15316 100644
>> --- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
>> @@ -201,6 +201,13 @@
>>                       samsung,pin-drv = <3>;
>>               };
>>
>> +             sd0_rclk: sd0-rclk {
>> +                     samsung,pins = "gpc0-7";
>> +                     samsung,pin-function = <2>;
>> +                     samsung,pin-pud = <1>;
>> +                     samsung,pin-drv = <3>;
>> +             };
>> +
>>               sd1_cmd: sd1-cmd {
>>                       samsung,pins = "gpc1-1";
>>                       samsung,pin-function = <2>;
>> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> index 8be3d7b..2078a1f 100644
>> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>> @@ -80,8 +80,10 @@
>>               samsung,dw-mshc-ciu-div = <3>;
>>               samsung,dw-mshc-sdr-timing = <0 4>;
>>               samsung,dw-mshc-ddr-timing = <0 2>;
>> +             samsung,dw-mshc-hs400-timing = <0 2>;
>> +             samsung,read-strobe-delay = <90>;
>>               pinctrl-names = "default";
>> -             pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>> +             pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
>>               bus-width = <8>;
>>               cap-mmc-highspeed;
>>       };
>> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> index e8fdda8..96f0d61 100644
>> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> @@ -550,15 +550,18 @@
>>       num-slots = <1>;
>>       broken-cd;
>>       mmc-hs200-1_8v;
>> +     mmc-hs400-1_8v;
>>       cap-mmc-highspeed;
>>       non-removable;
>>       card-detect-delay = <200>;
>> -     clock-frequency = <400000000>;
>> +     clock-frequency = <800000000>;
>>       samsung,dw-mshc-ciu-div = <3>;
>>       samsung,dw-mshc-sdr-timing = <0 4>;
>>       samsung,dw-mshc-ddr-timing = <0 2>;
>> +     samsung,dw-mshc-hs400-timing = <0 2>;
>> +     samsung,read-strobe-delay = <90>;
>>       pinctrl-names = "default";
>> -     pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>> +     pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
>>       bus-width = <8>;
>>  };
>>
>>
>



-- 
Regards,
Alim
