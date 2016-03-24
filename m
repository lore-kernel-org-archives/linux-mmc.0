From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] ARM: dts: exynos: Fix invalid maximum voltage for buck9
 supplying SD card
Date: Thu, 24 Mar 2016 19:25:35 +0900
Message-ID: <CAJKOXPc03ksVFKAHo_Znw41wdzRmzJpFYfAEw2q3EfrQxevghg@mail.gmail.com>
References: <1458807125-13580-1-git-send-email-k.kozlowski@samsung.com>
	<20160324095332.GS2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f194.google.com ([209.85.214.194]:36651 "EHLO
	mail-ob0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbcCXKZg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2016 06:25:36 -0400
In-Reply-To: <20160324095332.GS2566@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

On Thu, Mar 24, 2016 at 6:53 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Mar 24, 2016 at 05:12:05PM +0900, Krzysztof Kozlowski wrote:
>
>>                       buck9_reg: BUCK9 {
>>                               regulator-name = "vdd_2.8v_ldo";
>>                               regulator-min-microvolt = <3000000>;
>> -                             regulator-max-microvolt = <3750000>;
>> +                             regulator-max-microvolt = <3755000>;
>>                               regulator-always-on;
>>                               regulator-boot-on;
>>                       };
>
> Why does this regulator even have voltage constraints configured?  Is
> there any intention that it should ever be varied at runtime?

Good question. I was also wondering that, if tetting it by 5 mV lower
causes failure, then the constraints are actually fixed at 3.755 V. I
do not know the answer. Boards schematics do not specify the
requirement here, datasheet for PMIC says default value of 3.4V. Heh,
maybe the regulator driver is missing proper starting value for 'vsel'
(datasheet says values in register start from 0x40 -> 3 V). Something
looks wrong here...

I'll look at it after weekend. For now I applied my patch to the
for-next, so the next should be fixed.

Best regards,
Krzysztof
