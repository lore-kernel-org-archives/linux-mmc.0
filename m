From: Kukjin Kim <kgene@kernel.org>
Subject: Re: [PATCHv2] ARM: dts: change the compatible from exynos5250 to
 exynos5420 for mshc
Date: Sat, 24 Oct 2015 03:36:37 +0900
Message-ID: <562A7E35.50909@kernel.org>
References: <1445565713-4000-1-git-send-email-jh80.chung@samsung.com> <562997F7.3060803@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53535 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823AbbJWSgm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 23 Oct 2015 14:36:42 -0400
In-Reply-To: <562997F7.3060803@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, ulf.hansson@linaro.org, kgene@kernel.org, linux-arm-kernel@lists.infradead.org

On 10/23/15 11:14, Krzysztof Kozlowski wrote:
> On 23.10.2015 11:01, Jaehoon Chung wrote:
>> Exynos3250 and exnos5250 are some differences in Mobile Storage Host.
>> (For example, exynos3250 support the HS400 mode, but exynos5250 doesn't
>> support it.)
>> Exynos3250 can perform the similar function with exynos5420 compatible.
>> So this patch changes the compatible from exynos5250 to exynos5420
>> for mshc.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>> Changelog v2:
>> 	- Drop "mmc: dw_mmc: exynos: Add the exynos3250 compatible" patch.
>> 	- Describe commit-message more detailedly than before.
>> 	- Change to exynos5420, not add new compatible (exynos3250).
>>
>>  arch/arm/boot/dts/exynos3250.dtsi | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> 
> Thanks! Looks good:
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
Applied, thanks.

- Kukjin
