From: Matt Redfearn <matt.redfearn@imgtec.com>
Subject: Re: [PATCH v5] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Thu, 11 Feb 2016 08:12:59 +0000
Message-ID: <56BC428B.5030903@imgtec.com>
References: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com>
 <56BB7B2F.60307@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56BB7B2F.60307@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-mmc@vger.kernel.org, david.daney@cavium.com, ulf.hansson@linaro.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Zubair.Kakakhel@imgtec.com, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>
List-Id: linux-mmc@vger.kernel.org

Hi David

On 10/02/16 18:02, David Daney wrote:
> On 02/10/2016 09:36 AM, Matt Redfearn wrote:
>> From: Aleksey Makarov<aleksey.makarov@caviumnetworks.com>
>>
>> The OCTEON MMC controller is currently found on cn61XX and cnf71XX
>> devices.  Device parameters are configured from device tree data.
>>
>> eMMC, MMC and SD devices are supported.
>>
>> Tested-by: Aaro Koskinen<aaro.koskinen@iki.fi>
>> Signed-off-by: Chandrakala Chavva<cchavva@caviumnetworks.com>
>> Signed-off-by: David Daney<david.daney@cavium.com>
>> Signed-off-by: Aleksey Makarov<aleksey.makarov@auriga.com>
>> Signed-off-by: Leonid Rosenboim<lrosenboim@caviumnetworks.com>
>> Signed-off-by: Peter Swain<pswain@cavium.com>
>> Signed-off-by: Aaron Williams<aaron.williams@cavium.com>
>> Signed-off-by: Matt Redfearn<matt.redfearn@imgtec.com>
>> ---
>> v5:
>> Incoroprate comments from review
>> http://patchwork.linux-mips.org/patch/9558/
>> - Use standard <bus-width> property instead of <cavium,bus-max-width>.
>> - Use standard <max-frequency> property instead of <spi-max-frequency>.
>> - Add octeon_mmc_of_parse_legacy function to deal with the above
>>    properties, since many devices have shipped with those properties
>>    embedded in firmware.
>> - Allow the <vmmc-supply> binding in addition to the legacy
>>    <gpios-power>.
>> - Remove the secondary driver for each slot.
>> - Use core gpio cd/wp handling
>>
> [...]
>
>> +static int octeon_mmc_of_copy_legacy_u32(struct device_node *node,
>> +                      const char *legacy_name,
>> +                      const char *new_name)
>> +{
>> +    u32 value;
>> +    int ret;
>> +
>> +    ret = of_property_read_u32(node, legacy_name, &value);
>> +    if (!ret) {
>> +        /* Found legacy - set generic property */
>> +        struct property *new_p;
>> +        u32 *new_v;
>> +
>> +        pr_warn(FW_WARN "%s: Legacy property '%s'. Please remove\n",
>> +            node->full_name, legacy_name);
>> +
>
> I don't like this warning message.
>
> The vast majority of people that see it will not be able to change 
> their firmware.  So it will be forever cluttering up their boot logs.
>
> We are not ever planning on removing support for legacy firmware 
> properties, so alarming people is really all this message does.
>
> If you insist on a message then make it something like pr_info("This 
> is working properly, but please consider using modern device tree 
> properties...")

Fair enough - I was just following what the PHY driver does when it 
encounters a whitelisted compatible string, e.g. when my board boots:

[Firmware Warn]: /soc@0/mdio@1180000001800/ethernet-phy@0: Whitelisted 
compatible string. Please remove
[Firmware Warn]: /soc@0/mdio@1180000001800/ethernet-phy@1: Whitelisted 
compatible string. Please remove
[Firmware Warn]: /soc@0/mdio@1180000001800/ethernet-phy@2: Whitelisted 
compatible string. Please remove
[Firmware Warn]: /soc@0/mdio@1180000001800/ethernet-phy@3: Whitelisted 
compatible string. Please remove
[Firmware Warn]: /soc@0/mdio@1180000001800/ethernet-phy@4: Whitelisted 
compatible string. Please remove
[Firmware Warn]: /soc@0/mdio@1180000001800/ethernet-phy@5: Whitelisted 
compatible string. Please remove
[Firmware Warn]: /soc@0/mdio@1180000001800/ethernet-phy@6: Whitelisted 
compatible string. Please remove
[Firmware Warn]: /soc@0/mdio@1180000001800/ethernet-phy@7: Whitelisted 
compatible string. Please remove

But I can see why it would be preferable to avoid this kind of message. 
I don't think it's essential so could be removed.

Thanks,
Matt
>
>> +        new_p = kzalloc(sizeof(*new_p), GFP_KERNEL);
>> +        new_v = kzalloc(sizeof(u32), GFP_KERNEL);
>> +        if (!new_p || !new_v)
>> +            return -ENOMEM;
>> +
>> +        *new_v = value;
>> +        new_p->name = kstrdup(new_name, GFP_KERNEL);
>> +        new_p->length = sizeof(u32);
>> +        new_p->value = new_v;
>> +
>> +        of_update_property(node, new_p);
>> +    }
>> +    return 0;
>> +}
>> +
>> +/*
>> + * This function parses the legacy device tree that may be found in 
>> devices
>> + * shipped before the driver was upstreamed. Future devices should 
>> not require
>> + * it as standard bindings should be used
>> + */
>> +static int octeon_mmc_of_parse_legacy(struct device *dev,
>> +                      struct device_node *node,
>> +                      struct octeon_mmc_slot *slot)
>> +{
>> +    int ret;
>> +
>> +    ret = octeon_mmc_of_copy_legacy_u32(node, "cavium,bus-max-width",
>> +                        "bus-width");
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = octeon_mmc_of_copy_legacy_u32(node, "spi-max-frequency",
>> +                        "max-frequency");
>> +    if (ret)
>> +        return ret;
>> +
>> +    slot->pwr_gpiod = devm_gpiod_get_optional(dev, "power", 
>> GPIOD_OUT_LOW);
>> +    if (!IS_ERR(slot->pwr_gpiod)) {
>> +        pr_warn(FW_WARN "%s: Legacy property '%s'. Please remove\n",
>> +            node->full_name, "gpios-power");
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>
