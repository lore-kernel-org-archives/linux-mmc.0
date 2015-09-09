From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Enable PBIAS regulator
Date: Wed, 9 Sep 2015 11:38:53 +0530
Message-ID: <55EFCCF5.50407@ti.com>
References: <1441274111-18049-1-git-send-email-kishon@ti.com> <20150906234110.GA2228@roeck-us.net> <20150909040327.GA14905@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150909040327.GA14905@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: ulf.hansson@linaro.org, tony@atomide.com, broonie@kernel.org, linux@arm.linux.org.uk, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

hi,

On Wednesday 09 September 2015 09:33 AM, Guenter Roeck wrote:
> On Sun, Sep 06, 2015 at 04:41:10PM -0700, Guenter Roeck wrote:
>> On Thu, Sep 03, 2015 at 03:25:11PM +0530, Kishon Vijay Abraham I wrote:
>>> PBIAS regulator is required for MMC module in OMAP2, OMAP3, OMAP4,
>>> OMAP5 and DRA7 SoCs. Enable it here.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>
> This problem is now causing various runtime failures in mainline.
> I see the following qemu test failures:
> 
> arm:beagle:multi_v7_defconfig:omap3-beagle
> arm:beaglexm:multi_v7_defconfig:omap3-beagle-xm
> arm:overo:multi_v7_defconfig:omap3-overo-tobi
> 
> I would expect all omap2/3/4/5 runtime tests with multi_v7_defconfig to fail.
> 
> Also, FWIW,
> 
> Fixes: 6a9b2ff07d04 ("mmc: host: omap_hsmmc: return on fatal errors from omap_hsmmc_reg_get")

I've resend the patch to arm@kernel.org and it bounced back from Nicolas
Pitre. However others like Arnd, Thomas, Olof would have received and I
think they'll be applying this soonish.

Thanks
Kishon

> 
> Guenter
> 
>>> ---
>>>  arch/arm/configs/multi_v7_defconfig |    1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>>> index 5fd8df6..f497c96 100644
>>> --- a/arch/arm/configs/multi_v7_defconfig
>>> +++ b/arch/arm/configs/multi_v7_defconfig
>>> @@ -403,6 +403,7 @@ CONFIG_REGULATOR_MAX8973=y
>>>  CONFIG_REGULATOR_MAX77686=y
>>>  CONFIG_REGULATOR_MAX77693=m
>>>  CONFIG_REGULATOR_PALMAS=y
>>> +CONFIG_REGULATOR_PBIAS=y
>>>  CONFIG_REGULATOR_S2MPS11=y
>>>  CONFIG_REGULATOR_S5M8767=y
>>>  CONFIG_REGULATOR_TPS51632=y
>>> -- 
>>> 1.7.9.5
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>>
