From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v3 2/3] mmc: omap_hsmmc: Pin remux workaround to support
 SDIO interrupt on AM335x.
Date: Wed, 27 Nov 2013 22:29:28 +0530
Message-ID: <529624F0.8040508@ti.com>
References: <1385386009-14981-1-git-send-email-afenkart@gmail.com> <1385386009-14981-3-git-send-email-afenkart@gmail.com> <20131125224601.GX10023@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20131125224601.GX10023@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, zonque@gmail.com, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday 26 November 2013 04:16 AM, Tony Lindgren wrote:
> * Andreas Fenkart <afenkart@gmail.com> [131125 05:30]:
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -452,10 +475,23 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
>>   	} else
>>   		pdata->slots[0].gpio_wp = -EINVAL;
>>
>> +	if (gpio_is_valid(pdata->slots[0].gpio_cirq)) {
>> +		ret = gpio_request_one(pdata->slots[0].gpio_cirq, GPIOF_DIR_IN,
>> +				       "sdio_cirq");
>> +		if (ret)
>> +			goto err_free_ro;
>> +
>> +	} else {
>> +		pdata->slots[0].gpio_cirq = -EINVAL;
>> +	}
>> +
>> +
>>   	return 0;
>>
>> +err_free_ro:
>> +	if (gpio_is_valid(pdata->slots[0].gpio_wp))
>>   err_free_wp:
>> -	gpio_free(pdata->slots[0].gpio_wp);
>> +		gpio_free(pdata->slots[0].gpio_wp);
>>   err_free_cd:
>>   	if (gpio_is_valid(pdata->slots[0].switch_pin))
>>   err_free_sp:
>
> This patch we can now make a bit more generic with the recent addition
> of interrupts-extended property that's now merged in mainline tree :)
>
> We can optionally pass two interrupts to omap_hsmmc.c where the second
> interrupt is either the pinctrl-single wake-up interrupt, or the GPIO
> interrupt.
>
> Both the iochain wake interrupt or the GPIO interrupt are available with
> request_irq as long as configured in the .dts file. And can both use the
> SDIO interrupt handler. The only difference is that the GPIO wake-up
> still needs to do the dynamic remuxing of pins.
>
> So omap3 can use:
>
> mmc: mmc@4800abcd {
> 	compatible = "ti,omap3-hsmmc";
> 	...
> 	interrupts-extended = <&intc 83 &omap3_pmx_core 0x11a>;
> 	...
> };
>
> And am33xx can use:
>
> mmc: mmc@4810abcd {
> 	compatible = "ti,omap33xx-hsmmc";
> 	...
> 	interrupts-extended = <&intc 64 &gpio3 28>;
> 	...
> };
>
Hi Tony,

I made similar changes for omap4 panda-es as below, but get WARNING for no irq domain [1]
omap3 beagle seems to be OK.

  		mmc1: mmc@4809c000 {
  			compatible = "ti,omap4-hsmmc";
  			reg = <0x4809c000 0x400>;
+			interrupts-extended = <&gic GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH &omap4_pmx_core 0xa8>;
			ti,hwmods = "mmc1";

[    0.338745] OMAP GPIO hardware version 0.1
[    0.348266] omap-gpmc 50000000.gpmc: GPMC revision 6.0
[    0.354339] irq: no irq domain found for /ocp/pinmux@4a100040 !
[    0.354339] ------------[ cut here ]------------
[    0.354370] WARNING: CPU: 1 PID: 1 at /home/a0393241/git/lo/drivers/of/platform.c:171 of_device_alloc+0x158/0x16c()
[    0.354370] Modules linked in:
[    0.354400] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 3.13.0-rc1-00141-g8ae516a-dirty #36
[    0.354431] [<c001520c>] (unwind_backtrace+0x0/0xf0) from [<c0011ef4>] (show_stack+0x10/0x14)
[    0.354431] [<c0011ef4>] (show_stack+0x10/0x14) from [<c0521750>] (dump_stack+0x78/0x94)
[    0.354461] [<c0521750>] (dump_stack+0x78/0x94) from [<c003e678>] (warn_slowpath_common+0x6c/0x90)
[    0.354492] [<c003e678>] (warn_slowpath_common+0x6c/0x90) from [<c003e6b8>] (warn_slowpath_null+0x1c/0x24)
[    0.354492] [<c003e6b8>] (warn_slowpath_null+0x1c/0x24) from [<c04460e4>] (of_device_alloc+0x158/0x16c)
[    0.354522] [<c04460e4>] (of_device_alloc+0x158/0x16c) from [<c0446128>] (of_platform_device_create_pdata+0x30/0x94)
[    0.354522] [<c0446128>] (of_platform_device_create_pdata+0x30/0x94) from [<c044626c>] (of_platform_bus_create+0xe0/0x164)
[    0.354553] [<c044626c>] (of_platform_bus_create+0xe0/0x164) from [<c04462c8>] (of_platform_bus_create+0x13c/0x164)
[    0.354553] [<c04462c8>] (of_platform_bus_create+0x13c/0x164) from [<c044634c>] (of_platform_populate+0x5c/0x9c)
[    0.354583] [<c044634c>] (of_platform_populate+0x5c/0x9c) from [<c0785c38>] (pdata_quirks_init+0x28/0x70)
[    0.354614] [<c0785c38>] (pdata_quirks_init+0x28/0x70) from [<c0777458>] (customize_machine+0x1c/0x40)
[    0.354614] [<c0777458>] (customize_machine+0x1c/0x40) from [<c00088fc>] (do_one_initcall+0xec/0x150)
[    0.354644] [<c00088fc>] (do_one_initcall+0xec/0x150) from [<c0774bfc>] (kernel_init_freeable+0xfc/0x1cc)
[    0.354644] [<c0774bfc>] (kernel_init_freeable+0xfc/0x1cc) from [<c051c9ac>] (kernel_init+0x8/0x118)
[    0.354675] [<c051c9ac>] (kernel_init+0x8/0x118) from [<c000e5e8>] (ret_from_fork+0x14/0x2c)
[    0.354766] ---[ end trace 7067c7558a4cd015 ]---
[    0.366607] platform 4b501000.aes: Cannot lookup hwmod 'aes'
[    0.367034] platform 480a5000.des: Cannot lookup hwmod 'des'
[    0.374481] No ATAGs?
[    0.374511] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint registers.
[    0.374542] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.377502] OMAP DMA hardware revision 0.0
[    0.415100] bio: create slab <bio-0> at 0
[    0.417388] edma-dma-engine edma-dma-engine.0: Can't allocate PaRAM dummy slot
[    0.417419] edma-dma-engine: probe of edma-dma-engine.0 failed with error -5
[    0.460754] omap-dma-engine 4a056000.dma-controller: OMAP DMA engine driver
[    0.462249] hsusb1_vbus: 3300 mV

