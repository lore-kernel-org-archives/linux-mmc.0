From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Enable PBIAS regulator
Date: Fri, 4 Sep 2015 19:20:28 +0530
Message-ID: <55E9A1A4.30506@ti.com>
References: <1441274111-18049-1-git-send-email-kishon@ti.com> <20150903152325.GW4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150903152325.GW4215@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: ulf.hansson@linaro.org, broonie@kernel.org, linux@arm.linux.org.uk, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thursday 03 September 2015 08:53 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [150903 02:58]:
>> PBIAS regulator is required for MMC module in OMAP2, OMAP3, OMAP4,
>> OMAP5 and DRA7 SoCs. Enable it here.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> For the multi_v7_defconfig changes you need to resend this
> to arm@kernel.org. This is to avoid conflicts with other
> patches.

for some reason mail to arm@kernel.org bounced :-( Should I subscribe to
it before sending patches?

Thanks
Kishon

> 
> Regards,
> 
> Tony
> 
>>  arch/arm/configs/multi_v7_defconfig |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 5fd8df6..f497c96 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -403,6 +403,7 @@ CONFIG_REGULATOR_MAX8973=y
>>  CONFIG_REGULATOR_MAX77686=y
>>  CONFIG_REGULATOR_MAX77693=m
>>  CONFIG_REGULATOR_PALMAS=y
>> +CONFIG_REGULATOR_PBIAS=y
>>  CONFIG_REGULATOR_S2MPS11=y
>>  CONFIG_REGULATOR_S5M8767=y
>>  CONFIG_REGULATOR_TPS51632=y
>> -- 
>> 1.7.9.5
>>
