From: Alim Akhtar <alim.akhtar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/2] ARM: dts: Add HS400 support for exynos5420 and exynos5800
Date: Thu, 29 Jan 2015 11:43:29 +0900
Message-ID: <CAGOxZ50kXSrTxNpjsc19B-5A=7EMPevdbAZZO7zwtzWtac-OBQ@mail.gmail.com>
References: <1421231446-4776-1-git-send-email-alim.akhtar@samsung.com>
 <1421231446-4776-3-git-send-email-alim.akhtar@samsung.com>
 <54BEDE9C.5060501@samsung.com> <CAGOxZ5186+9U-6eri6OSGw9awsmr0EPP-gdhu-__oCWP1Oyyxg@mail.gmail.com>
 <54C06049.5070106@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54C06049.5070106-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, kgene <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Jaehoon,

Thanks for review.

On Thu, Jan 22, 2015 at 11:28 AM, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Hi.
>
> On 01/21/2015 11:12 PM, Alim Akhtar wrote:
>> Hi Jaehoon
>>
>> On Wed, Jan 21, 2015 at 4:32 AM, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>>> Hi,
>>>
>>> If you want to enable the hs400 mode, need to add "mmc-hs400-1_8v" or "mmc-hs400-1_2v".
>>> But this patch didn't add them. do you have any other plan?
>>>
>> Yes, right, plan is to send separate patch to enable hs400, as of now
>> I am not sure if all the 5800-peach-pi boards are populated with
>> emmc5.0 device or not. So I will enable HS400 after confirming this
>> point.
>
> I know if card is not support hs400, then it should be enabled to other bus mode.
>
hmm...mmc-hs{200/400}-1_8v are host capabilities, so host should first
support this, then we can enable it.
ok,  I will enable HS400 for peach-pi in this series.
Also I checked UMs for 5420/5800, in UM, strobe signal is named as
RCLK, so going to keep the same name as UM.
Will resend the patches after modification shortly.

> Best Regards,
> Jaehoon Chung
>
>>> On 01/14/2015 07:30 PM, Alim Akhtar wrote:
>>>> From: Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>>
>>>> HS400 timing values are added for SMDK5420, exynos5420-peach-pit
>>>> and exynos5800-peach-pi boards.
>>>> This also adds RCLK GPIO line, this gpio should be in pull-down
>>>> state.
>>>>
>>>> Signed-off-by: Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>> Signed-off-by: Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>> [Alim: addressed review comments]
>>>> ---
>>>>  arch/arm/boot/dts/exynos5420-peach-pit.dts |    4 +++-
>>>>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi  |    7 +++++++
>>>>  arch/arm/boot/dts/exynos5420-smdk5420.dts  |    4 +++-
>>>>  arch/arm/boot/dts/exynos5800-peach-pi.dts  |    4 +++-
>>>>  4 files changed, 16 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>>>> index 9a050e1..7ffaba8 100644
>>>> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
>>>> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>>>> @@ -569,8 +569,10 @@
>>>>       samsung,dw-mshc-ciu-div = <3>;
>>>>       samsung,dw-mshc-sdr-timing = <0 4>;
>>>>       samsung,dw-mshc-ddr-timing = <0 2>;
>>>> +     samsung,dw-mshc-hs400-timing = <0 2>;
>>>> +     read-strobe-delay = <90>;
>>>>       pinctrl-names = "default";
>>>> -     pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>>>> +     pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
>>>>       bus-width = <8>;
>>>>  };
>>>>
>>>> diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
>>>> index ba686e4..8b15316 100644
>>>> --- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
>>>> +++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
>>>> @@ -201,6 +201,13 @@
>>>>                       samsung,pin-drv = <3>;
>>>>               };
>>>>
>>>> +             sd0_rclk: sd0-rclk {
>>>
>>> I know it used to "sd0_rdqs", not "sd0_rclk".
>>> Change name.
>>>
>> Ok, I will change as per UM of 5800/5420,
>>
>>> Best Regards,
>>> Jaehoon Chung
>>>> +                     samsung,pins = "gpc0-7";
>>>> +                     samsung,pin-function = <2>;
>>>> +                     samsung,pin-pud = <1>;
>>>> +                     samsung,pin-drv = <3>;
>>>> +             };
>>>> +
>>>>               sd1_cmd: sd1-cmd {
>>>>                       samsung,pins = "gpc1-1";
>>>>                       samsung,pin-function = <2>;
>>>> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>>>> index 8be3d7b..5290e79 100644
>>>> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
>>>> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
>>>> @@ -80,8 +80,10 @@
>>>>               samsung,dw-mshc-ciu-div = <3>;
>>>>               samsung,dw-mshc-sdr-timing = <0 4>;
>>>>               samsung,dw-mshc-ddr-timing = <0 2>;
>>>> +             samsung,dw-mshc-hs400-timing = <0 2>;
>>>> +             read-strobe-delay = <90>;
>>>>               pinctrl-names = "default";
>>>> -             pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>>>> +             pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
>>>>               bus-width = <8>;
>>>>               cap-mmc-highspeed;
>>>>       };
>>>> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>>>> index e8fdda8..fa1c858 100644
>>>> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
>>>> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>>>> @@ -557,8 +557,10 @@
>>>>       samsung,dw-mshc-ciu-div = <3>;
>>>>       samsung,dw-mshc-sdr-timing = <0 4>;
>>>>       samsung,dw-mshc-ddr-timing = <0 2>;
>>>> +     samsung,dw-mshc-hs400-timing = <0 2>;
>>>> +     read-strobe-delay = <90>;
>>>>       pinctrl-names = "default";
>>>> -     pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>>>> +     pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8 &sd0_rclk>;
>>>>       bus-width = <8>;
>>>>  };
>>>>
>>>>
>>>
>>
>>
>>
>



-- 
Regards,
Alim
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
