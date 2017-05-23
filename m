From: David Woods <dwoods@mellanox.com>
Subject: Re: [PATCH 2/2] mmc: core: Use device_property_read instead of
 of_property_read
Date: Tue, 23 May 2017 15:30:33 -0400
Message-ID: <4803df54-117e-451f-ee88-9e19c1a4def1@mellanox.com>
References: <1495059429-15247-1-git-send-email-dwoods@mellanox.com>
 <1495059429-15247-2-git-send-email-dwoods@mellanox.com>
 <CAPDyKFq-LSBr79ej06p2F_GcJeOMnuuJvOO0XgjaGCHoU1RpUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:40160
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1761585AbdEWTaq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 23 May 2017 15:30:46 -0400
In-Reply-To: <CAPDyKFq-LSBr79ej06p2F_GcJeOMnuuJvOO0XgjaGCHoU1RpUQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Heiner Kallweit <hkallweit1@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, cmetcalf@mellanox.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable@vger.linux.org

On 05/19/2017 04:23 AM, Ulf Hansson wrote:
> On 18 May 2017 at 00:17, David Woods <dwoods@mellanox.com> wrote:
>> Using the device_property interfaces allows mmc drivers to work
>> on platforms which run on either device tree or ACPI.
>>
>> Signed-off-by: David Woods <dwoods@mellanox.com>
>> Reviewed-by: Chris Metcalf <cmetcalf@mellanox.com>
>> Cc: stable@vger.linux.org
>> ---
>>   drivers/mmc/core/host.c | 72 ++++++++++++++++++++++++-------------------------
>>   1 file changed, 35 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index 3f8c85d..d2c059e 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -176,19 +176,17 @@ static void mmc_retune_timer(unsigned long data)
>>    */
>>   int mmc_of_parse(struct mmc_host *host)
>>   {
>> -       struct device_node *np;
>> +       struct device *dev = host->parent;
>>          u32 bus_width;
>>          int ret;
>>          bool cd_cap_invert, cd_gpio_invert = false;
>>          bool ro_cap_invert, ro_gpio_invert = false;
>>
>> -       if (!host->parent || !host->parent->of_node)
>> +       if (!dev)
>>                  return 0;
>>
> So earlier we stopped executing the OF parsing at this point, unless
> we had valid a of_node pointer. To be safe, I think we need to do
> something similar here.
>
> In other words, perhaps check the result from dev_fwnode(), before continue.

I will add that check.

> [...]
>
> mmc_pwrseq_alloc() is called from mmc_of_parse() which currently only
> supports OF parsing. I assume you would like to convert that as well?
> Perhaps that should even be the first step?

Our board does not have a power sequence device, so this is not 
something I have the hardware available to test.  It's not very clear to 
me how a pwrseq reference would be represented in ACPI or how to access 
it with the device_property API.  As it is, of_parse_phandle just 
returns NULL in the case where there is no parent->of_node.

-David Woods

>
> Kind regards
> Uffe


