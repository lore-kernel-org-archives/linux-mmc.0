From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] mmc: pwrseq: Use highest priority for eMMC restart
 handler
Date: Wed, 28 Oct 2015 12:02:47 +0100
Message-ID: <5630AB57.4030405@osg.samsung.com>
References: <1445440540-21525-1-git-send-email-javier@osg.samsung.com>
 <CAPDyKFoMQcC5sdCEKHWqNOdw1Yw8e8yRpdx7mtq7sMxg6sAi+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoMQcC5sdCEKHWqNOdw1Yw8e8yRpdx7mtq7sMxg6sAi+A@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Markus Reichl <m.reichl@fivetechno.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Hello Ulf,

On 10/27/2015 11:10 AM, Ulf Hansson wrote:
> On 21 October 2015 at 17:15, Javier Martinez Canillas
> <javier@osg.samsung.com> wrote:
>> The pwrseq_emmc driver does a eMMC card reset before a system reboot to
>> allow broken or limited ROM boot-loaders (that don't have an eMMC reset
>> logic) to be able to read the second stage from the eMMC.
>>
>> But this has to be called before a system reboot handler and while most
>> of them use the priority 128, there are other restart handlers (such as
>> the syscon-reboot one) that use a higher priority. So, use the highest
>> priority to make sure that the eMMC hw is reset before a system reboot.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
>>
>> ---
>> Hello,
>>
>> This patch was needed since a recent series from Alim [0] added
>> syscon reboot and poweroff support to Exynos SoCs and removed
>> the reset handler in the Exynos Power Management Unit (PMU) code.
>>
>> But the PMU and syscon-reboot restart handler have a different
>> priority so [0] breaks restart when eMMC is used on these boards.
>>
>> [0]: http://www.spinics.net/lists/arm-kernel/msg454396.html
>>
>> So this patch must be merged before [0] to avoid regressions.
>>
>> Best regards,
>> Javier
> 
> So it seems like there have been a good discussion around this. I
> don't have any objections, but is more concerned about potential
> regressions.
>

Yes, there was a lot of discussion indeed but it seems we all agree
on the approach and that the patch should not land before having a
lot of testing.
 
> I have queued it up for next (4.4) so we get some testing in
> linux-next. If anyone have issues, please report them.
>

great, some weeks sitting in -next to let the CI infrastructure to
play with it seems reasonable to me. Thanks a lot!
 
> Kind regards
> Uffe
>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
