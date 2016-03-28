From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] regulator: s2mps11: Fix invalid minimal selector for buck9
 supplying SD card
Date: Mon, 28 Mar 2016 12:32:56 +0900
Message-ID: <56F8A5E8.5010908@samsung.com>
References: <1459126489-18311-1-git-send-email-k.kozlowski@samsung.com>
 <56F8900D.3080203@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:47216 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbcC1DdH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Mar 2016 23:33:07 -0400
In-reply-to: <56F8900D.3080203@osg.samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, stable@vger.kernel.org

On 28.03.2016 10:59, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 03/27/2016 08:54 PM, Krzysztof Kozlowski wrote:
>> The buck9 regulator of S2MPS11 PMIC lacked minimal selector for linear
>> mapping. The mapping starts from 0x40 (3 V).
>>
> 
> This patch is a real fix since the the SD error goes away and the regulator
> driver probes correctly now.
>  
>> This buck9 provides power to other regulators, including LDO13 and LDO19
>> which supply the MMC2 (SD card).
>>
> 
> I think it's worth mentioning that this is the case for the Exynos5422 Odroid
> XU{3,4} boards. I mean, the regulators can be used for anything but are those
> boards that use LDO19 as the SD card supply.

Yes, indeed. I forgot to add that details.

> 
> In fact, I wonder if the subject line shouldn't be changed to something like:
> 
> "regulator: s2mps11: Fix invalid min selector and voltages num for buck9"
> 
> since the real problem is that the .linear_min_sel and .n_voltages are wrong.
> The fact that the SD was failing on Odroids is just a consequence of that
> (although I agree that this information should be part of the commit message).

Okay, seems more accurate.

> 
>> Bootloader initializes the regulator with value of 0xff (5 V) which is
>> outside of supported voltage range. When (during boot) constraints to
>> buck9 were applied, the driver wrote value counting from 0x00, not 0x40.
>> Effectively driver set lower voltage than required leading to SD card
>> detection errors on Odroid XU3/XU4:
>> 	mmc1: card never left busy state
>> 	mmc1: error -110 whilst initialising SD card
>>
>> Fixes: cb74685ecb39 ("regulator: s2mps11: Add samsung s2mps11 regulator driver")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
>> ---
>>
>> The issue can be reproduced on next-20160324 with
>> bae4fdc88d7f7dda1 (regulator: core: Ensure we are at least in bounds
>> for our constraints).
>> ---
>>  drivers/regulator/s2mps11.c         | 19 ++++++++++++++++++-
>>  include/linux/mfd/samsung/s2mps11.h |  9 +++++++++
>>  2 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
>> index d24e2c783dc5..caeefc38ac47 100644
>> --- a/drivers/regulator/s2mps11.c
>> +++ b/drivers/regulator/s2mps11.c
>> @@ -324,6 +324,23 @@ static struct regulator_ops s2mps11_buck_ops = {
>>  	.enable_mask	= S2MPS11_ENABLE_MASK			\
>>  }
>>  
>> +#define regulator_desc_s2mps11_buck9 {				\
>> +	.name		= "BUCK9",				\
>> +	.id		= S2MPS11_BUCK9,			\
>> +	.ops		= &s2mps11_buck_ops,			\
>> +	.type		= REGULATOR_VOLTAGE,			\
>> +	.owner		= THIS_MODULE,				\
>> +	.min_uV		= MIN_3000_MV,				\
>> +	.uV_step	= STEP_25_MV,				\
>> +	.linear_min_sel	= S2MPS11_BUCK9_MIN_VSEL,		\
> 
> I don't have a datasheet for this PMIC but I wonder if buck9 is the only
> buck regulator whose minimal register value is != 0. If that's not the
> case, it would be good to fix the descriptions for all other regulators.

Some of them are broken, some not. :) Buck 1-4 and 6 also should have
minimal selector. Also number of selectors and masks seems to be
invalid. I already have a plan to fix this up but it is not an urgent
task because the driver works so far.

> 
>> +	.n_voltages	= S2MPS11_BUCK9_N_VOLTAGES,		\
>> +	.ramp_delay	= S2MPS11_RAMP_DELAY,			\
>> +	.vsel_reg	= S2MPS11_REG_B9CTRL2,			\
>> +	.vsel_mask	= S2MPS11_BUCK_VSEL_MASK,		\
>> +	.enable_reg	= S2MPS11_REG_B9CTRL1,			\
>> +	.enable_mask	= S2MPS11_ENABLE_MASK			\
>> +}
>> +
>>  static const struct regulator_desc s2mps11_regulators[] = {
>>  	regulator_desc_s2mps11_ldo(1, STEP_25_MV),
>>  	regulator_desc_s2mps11_ldo(2, STEP_50_MV),
>> @@ -371,7 +388,7 @@ static const struct regulator_desc s2mps11_regulators[] = {
>>  	regulator_desc_s2mps11_buck6_10(6, MIN_600_MV, STEP_6_25_MV),
>>  	regulator_desc_s2mps11_buck6_10(7, MIN_600_MV, STEP_6_25_MV),
>>  	regulator_desc_s2mps11_buck6_10(8, MIN_600_MV, STEP_6_25_MV),
>> -	regulator_desc_s2mps11_buck6_10(9, MIN_3000_MV, STEP_25_MV),
> 
> Maybe the regulator_desc_s2mps11_buck6_10() define should be renamed?
> Since it's no longer true that can be used for buck6-10, so the name
> is misleading now.

Sure.

> 
> Patch looks good to me though and as I said it fixes the issue so:
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks!

I'll update patch as you suggested and re-spin with tags.

Best regards,
Krzysztof

