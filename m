From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v4 2/2] ARM: dts: Add HS400 support for exynos5420 and
 exynos5800
Date: Thu, 22 Jan 2015 11:28:25 +0900
Message-ID: <54C06049.5070106@samsung.com>
References: <1421231446-4776-1-git-send-email-alim.akhtar@samsung.com>
 <1421231446-4776-3-git-send-email-alim.akhtar@samsung.com>
 <54BEDE9C.5060501@samsung.com>
 <CAGOxZ5186+9U-6eri6OSGw9awsmr0EPP-gdhu-__oCWP1Oyyxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:33984 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbbAVC22 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jan 2015 21:28:28 -0500
In-reply-to: <CAGOxZ5186+9U-6eri6OSGw9awsmr0EPP-gdhu-__oCWP1Oyyxg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Douglas Anderson <dianders@chromium.org>, kgene <kgene@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Abhilash Kesavan <a.kesavan@samsung.com>

Hi.

On 01/21/2015 11:12 PM, Alim Akhtar wrote:
> Hi Jaehoon
> 
> On Wed, Jan 21, 2015 at 4:32 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi,
>>
>> If you want to enable the hs400 mode, need to add "mmc-hs400-1_8v" or "mmc-hs400-1_2v".
>> But this patch didn't add them. do you have any other plan?
>>
> Yes, right, plan is to send separate patch to enable hs400, as of now
> I am not sure if all the 5800-peach-pi boards are populated with
> emmc5.0 device or not. So I will enable HS400 after confirming this
> point.

I know if card is not support hs400, then it should be enabled to other bus mode.

Best Regards,
Jaehoon Chung

>> On 01/14/2015 07:30 PM, Alim Akhtar wrote:
>>> From: Seungwon Jeon <tgih.jun@samsung.com>
>>>
>>> HS400 timing values are added for SMDK5420, exynos5420-peach-pit
>>> and exynos5800-peach-pi boards.
>>> This also adds RCLK GPIO line, this gpio should be in pull-down
>>> state.
>>>
>>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>>> [Alim: addressed review comments]
>>> ---
>>>  arch/arm/boot/dts/exynos5420-peach-pit.dts |    4 +++-
>>>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi  |    7 +++++++
>>>  arch/arm/boot/dts/exynos5420-smdk5420.dts  |    4 +++-
>>>  arch/arm/boot/dts/exynos5800-peach-pi.dts  |    4 +++-
>>>  4 files changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>>> index 9a050e1..7ffaba8 100644
>>> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
>>> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>>> @@ -569,8 +569,10 @@
>>>       samsung,dw-mshc-ciu-div = <3>;
>>>       samsung,dw-mshc-sdr-timing = <0 4>;
>>>       samsung,dw-mshc-ddr-timing = <0 2>;
>>> +     samsung,dw-mshc-hs400-timing = <0 2>;
>>> +     read-strobe-delay = <90>;
>>>       pinctrl-names = "default";
>>> -     pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>>> +     pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
>>>       bus-width = <8>;
>>>  };
>>>
>>> diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
>>> index ba686e4..8b15316 100644
>>> --- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
>>> +++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
>>> @@ -201,6 +201,13 @@
>>>                       samsung,pin-drv = <3>;
>>>               };
>>>
>>> +             sd0_rclk: sd0-rclk {
>>
>> I know it used to "sd0_rdqs", not "sd0_rclk".
>> Change name.
>>
> Ok, I will change as per UM of 5800/5420,
> 
>> Best Regards,
>> Jaehoon Chung
>>> +                     samsung,pins = "gpc0-7";
>>> +                     samsung,pin-function = <2>;
>>> +                     samsung,pin-pud = <1>;
>>> +                     samsung,pin-drv = <3>;
>>> +             };
>>> +
>>>               sd1_cmd: sd1-cmd {
>>>                       samsung,pins = "gpc1-1";
>>>                       samsung,pin-function = <2>;
>>> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>>> index 8be3d7b..5290e79 100644
>>> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
>>> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>>> @@ -80,8 +80,10 @@
>>>               samsung,dw-mshc-ciu-div = <3>;
>>>               samsung,dw-mshc-sdr-timing = <0 4>;
>>>               samsung,dw-mshc-ddr-timing = <0 2>;
>>> +             samsung,dw-mshc-hs400-timing = <0 2>;
>>> +             read-strobe-delay = <90>;
>>>               pinctrl-names = "default";
>>> -             pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>>> +             pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
>>>               bus-width = <8>;
>>>               cap-mmc-highspeed;
>>>       };
>>> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>>> index e8fdda8..fa1c858 100644
>>> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
>>> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>>> @@ -557,8 +557,10 @@
>>>       samsung,dw-mshc-ciu-div = <3>;
>>>       samsung,dw-mshc-sdr-timing = <0 4>;
>>>       samsung,dw-mshc-ddr-timing = <0 2>;
>>> +     samsung,dw-mshc-hs400-timing = <0 2>;
>>> +     read-strobe-delay = <90>;
>>>       pinctrl-names = "default";
>>> -     pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>>> +     pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
>>>       bus-width = <8>;
>>>  };
>>>
>>>
>>
> 
> 
> 

