From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 10/13] ARM: dts: exynos: replace to "max-frequecy" instead
 of "clock-freq-min-max"
Date: Fri, 04 Nov 2016 19:21:30 +0900
Message-ID: <ecf4fac2-0ab7-d4c4-69e3-d498ee5b601c@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
 <20161103062135.10697-11-jh80.chung@samsung.com>
 <CGME20161103184120epcas1p3e51865aa2ea7b6073bcb72f5cba5772f@epcas1p3.samsung.com>
 <20161103184112.GB11071@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59936 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753593AbcKDKVd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2016 06:21:33 -0400
In-reply-to: <20161103184112.GB11071@kozik-lap>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, ulf.hansson@linaro.org, robh+dt@kernel.org, heiko@sntech.de, shawn.lin@rock-chips.com

On 11/04/2016 03:41 AM, Krzysztof Kozlowski wrote:
> On Thu, Nov 03, 2016 at 03:21:32PM +0900, Jaehoon Chung wrote:
>> In drivers/mmc/core/host.c, there is "max-frequency" property.
>> It should be same behavior. So Use the "max-frequency" instead of
>> "clock-freq-min-max".
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos3250-artik5-eval.dts | 2 +-
>>  arch/arm/boot/dts/exynos3250-artik5.dtsi     | 2 +-
>>  arch/arm/boot/dts/exynos3250-monk.dts        | 2 +-
>>  arch/arm/boot/dts/exynos3250-rinato.dts      | 2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> This looks totally independent to rest of patches so it can be applied
> separately without any functional impact (except lack of minimum
> frequency). Is that correct?

You're right. I will split the patches. And will resend.
Thanks!

Best Regards,
Jaehoon Chung

> 
> Best regards,
> Krzysztof
> 
> 
> 
> 

