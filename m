From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 10/13] ARM: dts: exynos: replace to "max-frequecy" instead
 of "clock-freq-min-max"
Date: Mon, 07 Nov 2016 09:38:15 +0900
Message-ID: <72612112-3b79-8fd3-8be4-a8f60ab3b68a@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
 <20161103184112.GB11071@kozik-lap>
 <ecf4fac2-0ab7-d4c4-69e3-d498ee5b601c@samsung.com> <4066252.a1W9ejEKHX@phil>
 <CGME20161104150527epcas4p4004d2c3a8686cccef97760dacdb2892c@epcas4p4.samsung.com>
 <20161104150447.GA4829@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20161104150447.GA4829@kozik-lap>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, ulf.hansson@linaro.org, robh+dt@kernel.org, shawn.lin@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

On 11/05/2016 12:04 AM, Krzysztof Kozlowski wrote:
> On Fri, Nov 04, 2016 at 12:19:49PM +0100, Heiko Stuebner wrote:
>> Hi Jaehoon,
>>
>> Am Freitag, 4. November 2016, 19:21:30 CET schrieb Jaehoon Chung:
>>> On 11/04/2016 03:41 AM, Krzysztof Kozlowski wrote:
>>>> On Thu, Nov 03, 2016 at 03:21:32PM +0900, Jaehoon Chung wrote:
>>>>> In drivers/mmc/core/host.c, there is "max-frequency" property.
>>>>> It should be same behavior. So Use the "max-frequency" instead of
>>>>> "clock-freq-min-max".
>>>>>
>>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>>> ---
>>>>>
>>>>>  arch/arm/boot/dts/exynos3250-artik5-eval.dts | 2 +-
>>>>>  arch/arm/boot/dts/exynos3250-artik5.dtsi     | 2 +-
>>>>>  arch/arm/boot/dts/exynos3250-monk.dts        | 2 +-
>>>>>  arch/arm/boot/dts/exynos3250-rinato.dts      | 2 +-
>>>>>  4 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> This looks totally independent to rest of patches so it can be applied
>>>> separately without any functional impact (except lack of minimum
>>>> frequency). Is that correct?
>>>
>>> You're right. I will split the patches. And will resend.
>>> Thanks!
>>
>> I think what Krzysztof was asking was just if he can simply pick up this patch 
>> alone, as it does not require any of the previous changes.
>>
>> Same is true for the Rockchip patches I guess, so we could just take them 
>> individually into samsung/rockchip dts branches.
> 
> Yes, I wanted to get exactly this information. I couldn't find it in
> cover letter.

In drivers/mmc/core/host.c, there already is "max-frequency" property.
It's same functionality with "clock-freq-min-max". 
Minimum clock value can be fixed to 100K. because MMC core will check clock value from 400K to 100K.
But max-frequency can be difference.
If we can use "max-frequency" property, we don't need to use "clock-freq-min-max" property anymore.
I will resend the deprecated property instead of removing "clock-freq-min-max".

If you want to pick this, it's possible to pick. Then i will resend the patches without dt patches.

Best Regards,
Jaehoon Chung


> 
> Best regards,
> Krzysztof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
