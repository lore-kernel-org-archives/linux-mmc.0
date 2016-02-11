From: Matt Redfearn <matt.redfearn-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 2/3] MIPS: OCTEON: Rename legacy properties in internal
 device trees.
Date: Thu, 11 Feb 2016 16:53:36 +0000
Message-ID: <56BCBC90.6090805@imgtec.com>
References: <1455207976-2262-1-git-send-email-matt.redfearn@imgtec.com>
 <1455207976-2262-2-git-send-email-matt.redfearn@imgtec.com>
 <56BCB7AE.2050901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56BCB7AE.2050901-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, aleksey.makarov-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi David,

On 11/02/16 16:32, David Daney wrote:
> On 02/11/2016 08:26 AM, Matt Redfearn wrote:
>> Many OCTEON devices have been shipped in products with fixed DTBs. These
>> DTBS contain properties which are not compatible with newer kernels with
>> upstream drivers.
>> Therefore some mechanism is necessary to convert legacy naming into
>> upstream naming. In the first instance this is to support the OCTEON MMC
>> controller, which is in a later patch of this series.
>> This patch adds a octeon_handle_legacy_device_tree() function which is
>> always called from device_tree_init() to fix up the device tree so that
>> drivers need have no knowledge of the legacy naming or properties.
>>
>> Signed-off-by: Matt Redfearn <matt.redfearn-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>
> NAK...
>
> I already sent e-mail on this, but it crossed in flight.

Yeah, unfortunate timing.

>
> Basically, this patch is much more complex than the original code 
> which was just a few lines to check the alternate "legacy" names.

This code is functionally equivalent to the previous version, just 
located in platform code rather than the driver itself. In terms of LOC 
it's not much different. Doing it this was does allow future flexibility 
to change other bindings that are fixed in firmware without having to 
support each set in the individual drivers.
Leaving this patch out will mean having to get any legacy bindings 
accepted into each driver via their maintainer.
But for the moment we're just talking about the MMC driver - if this 
patch is not accepted then the only way to support legacy devices is 
with Ulf's signoff of handling both binding versions in the driver.

>
> Also this code is prone to breakage, see below...
>
>
>> ---
>> For reference, the legacy MMC bindings are as follows. Only the
>> spi-max-frequency and bus-width properties currently need renaming.
>>
>> mmc: mmc@1180000002000 {
>>     compatible = "cavium,octeon-6130-mmc";
>>     reg = <0x11800 0x00002000 0x0 0x100>,
>>         <0x11800 0x00000168 0x0 0x20>;
>>     #address-cells = <1>;
>>     #size-cells = <0>;
>>     /* EMM irq, DMA irq */
>>     interrupts = <1 19>, <0 63>;
>>
>>     /* The board only has a single MMC slot */
>>     mmc-slot@2 {
>>         compatible = "cavium,octeon-6130-mmc-slot";
>>         reg = <2>;
>>         voltage-ranges = <3300 3300>;
>>         spi-max-frequency = <26000000>;
>>         /* Power on GPIO 8, active high */
>>         /* power-gpios = <&gpio 8 0>; */
>>         power-gpios = <&gpio 8 1>;
>>
>>     /*      spi-max-frequency = <52000000>; */
>>         /* bus width can be 1, 4 or 8 */
>>         cavium,bus-max-width = <8>;
>>     };
>>     mmc-slot@0 {
>>         compatible = "cavium,octeon-6130-mmc-slot";
>>         reg = <0>;
>>         voltage-ranges = <3300 3300>;
>>         spi-max-frequency = <26000000>;
>>         /* non-removable; */
>>         bus-width = <8>;
>>         /* bus width can be 1, 4 or 8 */
>>         cavium,bus-max-width = <8>;
>>     };
>> };
>> ---
>>   arch/mips/cavium-octeon/octeon-platform.c | 57 
>> +++++++++++++++++++++++++++++++
>>   arch/mips/cavium-octeon/setup.c           |  3 ++
>>   2 files changed, 60 insertions(+)
>>
>> diff --git a/arch/mips/cavium-octeon/octeon-platform.c 
>> b/arch/mips/cavium-octeon/octeon-platform.c
>> index d113c8ded6e2..7933978bdfa5 100644
>> --- a/arch/mips/cavium-octeon/octeon-platform.c
>> +++ b/arch/mips/cavium-octeon/octeon-platform.c
>> @@ -980,6 +980,63 @@ end_led:
>>       return 0;
>>   }
>>
>> +/*
>> + * Rename a DT property from legacy to upstream accepted name.
>> + * The value is copied from old legacy name to new name.
>> + */
>> +static void __init octeon_fdt_renameprop(int node, const char *old, 
>> const char *new)
>> +{
>> +    const u32 *pv;
>> +    u32 v;
>> +
>> +    pv = fdt_getprop(initial_boot_params, node, old, NULL);
>> +    if (pv) {
>> +        v = *pv;
>> +        fdt_delprop(initial_boot_params, node, old);
>> +        fdt_setprop_u32(initial_boot_params, node, new, v);
>> +    }
>> +}
>> +
>> +/*
>> + * This function is called for every machine type to replace legacy 
>> entries
>> + * in the device tree blob passed from older firmwares.
>> + * It is impractical to change the DTB in shipped devices, but to 
>> support newer
>> + * kernels with upstreamed drivers and DT bindings some massaging of 
>> the DTB
>> + * must be done.
>> + */
>> +int __init octeon_handle_legacy_device_tree(void)
>> +{
>> +    const char *alias_prop;
>> +    int aliases;
>> +
>> +    if (fdt_check_header(initial_boot_params))
>> +        panic("Corrupt Device Tree.");
>> +
>> +    aliases = fdt_path_offset(initial_boot_params, "/aliases");
>> +    if (aliases < 0) {
>> +        pr_err("Error: No /aliases node in device tree.");
>> +        return -EINVAL;
>> +    }
>> +
>
> /aliases doesn't exist on many boards, so this will likely fail.
>

OK, well it could be looked up a different way, I just followed the lead 
of octeon_prune_device_tree() which looks up the nodes this way.

Thanks,
Matt

>
>> +    /* MMC */
>> +    alias_prop = fdt_getprop(initial_boot_params, aliases,
>> +                 "emmc", NULL);
>> +    if (alias_prop) {
>> +        int mmc = fdt_path_offset(initial_boot_params, alias_prop);
>> +        int slot = fdt_first_subnode(initial_boot_params, mmc);
>> +
>> +        while (slot > 0) {
>> +            octeon_fdt_renameprop(slot, "cavium,bus-max-width",
>> +                          "bus-width");
>> +            octeon_fdt_renameprop(slot, "spi-max-frequency",
>> +                          "max-frequency");
>> +            slot = fdt_next_subnode(initial_boot_params, slot);
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>> +
>>   static int __init octeon_publish_devices(void)
>>   {
>>       return of_platform_bus_probe(NULL, octeon_ids, NULL);
>> diff --git a/arch/mips/cavium-octeon/setup.c 
>> b/arch/mips/cavium-octeon/setup.c
>> index cd7101fb6227..f1f5191d02be 100644
>> --- a/arch/mips/cavium-octeon/setup.c
>> +++ b/arch/mips/cavium-octeon/setup.c
>> @@ -1080,6 +1080,7 @@ void __init prom_free_prom_memory(void)
>>   }
>>
>>   int octeon_prune_device_tree(void);
>> +int octeon_handle_legacy_device_tree(void);
>>
>>   extern const char __appended_dtb;
>>   extern const char __dtb_octeon_3xxx_begin;
>> @@ -1112,6 +1113,8 @@ void __init device_tree_init(void)
>>
>>       initial_boot_params = (void *)fdt;
>>
>> +    octeon_handle_legacy_device_tree();
>> +
>>       if (do_prune) {
>>           octeon_prune_device_tree();
>>           pr_info("Using internal Device Tree.\n");
>>
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
