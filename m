From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] mmc: pwrseq: Use highest priority for eMMC restart
 handler
Date: Thu, 22 Oct 2015 13:02:12 +0200
Message-ID: <5628C234.40606@osg.samsung.com>
References: <1445440540-21525-1-git-send-email-javier@osg.samsung.com>
 <56282F71.2070408@samsung.com> <562839F7.3040005@osg.samsung.com>
 <56283F27.9060804@samsung.com> <56284F60.4070802@osg.samsung.com>
 <56286294.7060907@samsung.com> <5628B552.8030701@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5628B552.8030701@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-kernel@vger.kernel.org
Cc: Markus Reichl <m.reichl@fivetechno.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Douglas Anderson <dianders@chromium.org>, heiko@sntech.de, enric.balletbo@collabora.com
List-Id: linux-mmc@vger.kernel.org

Hello Marek,

On 10/22/2015 12:07 PM, Marek Szyprowski wrote:
> On 2015-10-22 06:14, Alim Akhtar wrote:
>> On 10/22/2015 08:22 AM, Javier Martinez Canillas wrote:
>>> On 10/22/2015 03:43 AM, Krzysztof Kozlowski wrote:
>>>> On 22.10.2015 10:20, Javier Martinez Canillas wrote:> Hello Krzysztof,

[snip]

>>>>> And $SUBJECT should not cause any regressions for the platforms that
>>>>> are currently using the pwrseq_emmc, since the restart handler was
>>>>> already being called before the system restart handler so bumping
>>>>> the priority should not cause any effect.
>>>>
>>>> I found at least one platform where the sequence *might* change. There
>>>> could be more of them.
>>>>
>>>
>>> Agreed, I missed that rk3288-veyron is using a restart handler with higher
>>> priority and could be other boards too as you said.
>>>
>>> Let's see what is Marek's opinion since he added the pwrseq_emmc support
>>> and also what Ulf thinks about always doing a eMMC reset before reboot.
>>>
>>> I can't think how doing a eMMC card reset before reboot could affect a
>>> board but you are right that we don't know without testing.
>>>
>> git grep result shows:
>> ======
>>  git grep mmc-pwrseq-emmc
>> Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt:- compatible : contains "mmc-pwrseq-emmc".
>> Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt: compatible = "mmc-pwrseq-emmc";
>> arch/arm/boot/dts/am335x-sl50.dts:              compatible = "mmc-pwrseq-emmc";
>> arch/arm/boot/dts/exynos4412-odroid-common.dtsi: compatible = "mmc-pwrseq-emmc";
>> arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi: compatible = "mmc-pwrseq-emmc";
>> arch/arm/boot/dts/rk3288-veyron.dtsi:           compatible = "mmc-pwrseq-emmc";
>> arch/arm64/boot/dts/rockchip/rk3368-r88.dts:            compatible = "mmc-pwrseq-emmc";
>> drivers/mmc/core/pwrseq.c:              .compatible = "mmc-pwrseq-emmc",
>> =====
>> So apart from exynos, there are rk3xxx and am335x which used pwrseq-emmc-restart. So lets wait for the feedback from these guys as well.
>> Thanks.
>>
> 
> The priority was initially chosen in such a way to do the emmc reset just before performing system reboot. I wanted let other possible handlers potentially use mmc if needed (although there is no such case atm). Now it turns that this approach was not the best idea, because there are other board-specific restart handlers with higher priority than the default I was using. IMHO the change proposed by Javier seems to be the best solution for now. The other possibility would be to entirely get rid of restart handler usage and wire this logic to mmc_shutdown(). This makes sense from the logical point of view, but the drawback of this solution is the lack of proper reset sequence in case of emergency reboot (shutdown callbacks are not called on emergency reboot).
>

Thanks a lot for your feedback, I'm glad that you agree with the change then.
 
> Best regards

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
