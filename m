From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH v4] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Fri, 20 Mar 2015 10:24:51 -0700
Message-ID: <550C57E3.60800@gmail.com>
References: <1426518362-24349-1-git-send-email-aleksey.makarov@auriga.com> <CAPDyKFoZsx_GtGT1NsZnFB9PPWKzsLv8dU26eWcobz4cCdKAOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36323 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbbCTRZX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Mar 2015 13:25:23 -0400
In-Reply-To: <CAPDyKFoZsx_GtGT1NsZnFB9PPWKzsLv8dU26eWcobz4cCdKAOw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Aleksey Makarov <aleksey.makarov@auriga.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-mips@linux-mips.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <david.daney@cavium.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chris Ball <chris@printf.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 03/20/2015 02:57 AM, Ulf Hansson wrote:
> On 16 March 2015 at 16:06, Aleksey Makarov <aleksey.makarov@auriga.com> wrote:
>> The OCTEON MMC controller is currently found on cn61XX and cnf71XX
>> devices.  Device parameters are configured from device tree data.
>>
>> eMMC, MMC and SD devices are supported.
>>
>> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>> Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
>> Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
>> Signed-off-by: Peter Swain <pswain@cavium.com>
>> Signed-off-by: Aaron Williams <aaron.williams@cavium.com>
>> ---
>>   .../devicetree/bindings/mmc/octeon-mmc.txt         |   69 +
>>   drivers/mmc/host/Kconfig                           |   10 +
>>   drivers/mmc/host/Makefile                          |    1 +
>>   drivers/mmc/host/octeon_mmc.c                      | 1415 ++++++++++++++++++++
>>   4 files changed, 1495 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mmc/octeon-mmc.txt
>>   create mode 100644 drivers/mmc/host/octeon_mmc.c
>>
>> This patch should be applied on top of the patchset
>> "MIPS: OCTEON: flash: syncronize bootbus access"
>> https://lkml.kernel.org/g/<1425565893-30614-1-git-send-email-aleksey.makarov@auriga.com>
>>
>> v3:
>> https://lkml.kernel.org/g/<1425567033-31236-1-git-send-email-aleksey.makarov@auriga.com>
>>
>> Changes in v4:
>> - The sparse error discovered by Aaro Koskinen has been fixed
>> - Other sparse warnings have been silenced
>>
>> Changes in v3:
>> - Rebased to v4.0-rc2
>> - Use gpiod_*() functions instead of legacy gpio
>> - Cosmetic changes
>>
>> Changes in v2: All the fixes suggested by Mark Rutland were implemented:
>> - Device tree parsing has been fixed
>> - Device tree docs have been fixed
>> - Comment about errata workaroud has been added
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/octeon-mmc.txt b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
>> new file mode 100644
>> index 0000000..40dd7f1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
>> @@ -0,0 +1,69 @@
>> +* OCTEON SD/MMC Host Controller
>> +
>> +This controller is present on some members of the Cavium OCTEON SoC
>> +family, provide an interface for eMMC, MMC and SD devices.  There is a
>> +single controller that may have several "slots" connected.  These
>
> Even it it may have several slots, that's not being supported by the
> mmc core from a MMC/SD/SDIO protocol perspective.
>
> We have hade some discussions around this historocally, and I doubt
> that we ever will be adding this.
>
> So, with that in mind I would rather see that you remove the concept
> of "slot" entirely and thus don't do the DT configuration within a
> child node.

As you note this is a device tree representation, and thus really has 
nothing to do with the capabilities and internal structure of any given 
operating system.

The hardware really is structured as a single controller with a single 
set of registers and register fields that can control multiple "slots". 
  There are not multiple independent slot controllers.

This device tree representation reflects,  with fidelity, the actual 
hardware topology.

But none of this matters, because the device tree bindings train has 
already left the station.  You should have expressed opposition to this 
binding back when it was first discussed:

http://www.linux-mips.org/archives/linux-mips/2012-05/msg00119.html

The device tree is deployed in the boot firmware of shipping devices, 
and we are merely documenting what is there.

>
>> +slots appear as children of the main controller node.
>> +The DMA engine is an integral part of the controller block.
>> +
>> +Required properties:
>> +- compatible : Should be "cavium,octeon-6130-mmc" or "cavium,octeon-7890-mmc"
>> +- reg : Two entries:
>> +       1) The base address of the MMC controller register bank.
>> +       2) The base address of the MMC DMA engine register bank.
>> +- interrupts :
>> +       For "cavium,octeon-6130-mmc": two entries:
>> +       1) The MMC controller interrupt line.
>> +       2) The MMC DMA engine interrupt line.
>> +       For "cavium,octeon-7890-mmc": nine entries:
>> +       1) The next block transfer of a multiblock transfer has completed (BUF_DONE)
>> +       2) Operation completed successfully (CMD_DONE).
>> +       3) DMA transfer completed successfully (DMA_DONE).
>> +       4) Operation encountered an error (CMD_ERR).
>> +       5) DMA transfer encountered an error (DMA_ERR).
>> +       6) Switch operation completed successfully (SWITCH_DONE).
>> +       7) Switch operation encountered an error (SWITCH_ERR).
>> +       8) Internal DMA engine request completion interrupt (DONE).
>> +       9) Internal DMA FIFO underflow (FIFO).
>
> So are you really having that many irq lines to the controller?

Yes.  It's weird, isn't it.

The interrupt controller has 2^20 sources, these are just 10 of them.

>
>> +- #address-cells : Must be <1>
>> +- #size-cells : Must be <0>
>> +
>> +Required properties of child nodes:
>> +- compatible : Should be "cavium,octeon-6130-mmc-slot".
>> +- reg : The slot number.
>> +
>> +Optional properties of child nodes:
>> +- cd-gpios : Specify GPIOs for card detection
>> +- wp-gpios : Specify GPIOs for write protection
>> +- power-gpios : Specify GPIOs for power control
>
> Please consider to modell these through gpio regulators instead. In
> that way you well automatically get the ocr mask a well.


As stated above, it is too late to change this.  We could add additional 
bindings if absolutely necessary.

>
>> +- cavium,bus-max-width : The number of data lines present in the slot.
>> +       Default is 8.
>> +- spi-max-frequency : The maximum operating frequency of the slot.
>> +       Default is 52000000.
>
> Please use the common mmc binding for both the above.


Also, ... As stated above, it is too late to change this.  We could add 
additional bindings if necessary.


>
>> +- cavium,cmd-clk-skew : the amount of delay (in pS) past the clock edge
>> +       to sample the command pin.
>> +- cavium,dat-clk-skew : the amount of delay (in pS) past the clock edge
>> +       to sample the data pin.
>
> Is this SoC specifc?

Yes, that is why the property names have a "cavium," prefix.

>
[...]
>> diff --git a/drivers/mmc/host/octeon_mmc.c b/drivers/mmc/host/octeon_mmc.c
>> new file mode 100644
>> index 0000000..a3f10c6
>> --- /dev/null
>> +++ b/drivers/mmc/host/octeon_mmc.c
[...]
>> +
>> +#include <asm/byteorder.h>
>> +#include <asm/octeon/octeon.h>
>> +#include <asm/octeon/cvmx-mio-defs.h>
>
> Please don't have these kind of SOC specific includes.
>

Well it is a SOC specific driver...  But we will see if it makes sense 
to pull the required definitions into the driver source.

[...]

>> +
>> +       struct octeon_mmc_slot  *slot[OCTEON_MAX_MMC];
>
> See my upper comment around slots, and please remove all realted code.
>

The slots are a reflection of the structure of the hardware.  We are not 
pushing the "slot" concept into the MMC core, so why does it matter?

There must be very close coordination between all the "slots" for proper 
operation.  Forcing us to de-encapsulate this concept will result in 
much less elegant code.  If possible we want to avoid having people 
gouge our their eyes when looking at the driver.

Honestly, I can't see any valid reason why the "slot" concept, wholly 
private to the driver, is at all objectionable.

>> +};
>> +
>> +struct octeon_mmc_slot {
>> +       struct mmc_host         *mmc;   /* slot-level mmc_core object */
>> +       struct octeon_mmc_host  *host;  /* common hw for all 4 slots */
>> +
>> +       unsigned int            clock;
>> +       unsigned int            sclock;
>> +
>> +       u64                     cached_switch;
>> +       u64                     cached_rca;
>> +
>> +       unsigned int            cmd_cnt; /* sample delay */
>> +       unsigned int            dat_cnt; /* sample delay */
>> +
>> +       int                     bus_width;
>> +       int                     bus_id;
>> +
>> +       struct gpio_desc        *ro_gpiod;
>> +       struct gpio_desc        *cd_gpiod;
>
> These shouldn't be needed since it's already handle by the mmc core
> (mmc slot-gpio).
>
>> +       struct gpio_desc        *pwr_gpiod;
>
> As stated convert to gpio regulators instead.
>

We will investigate these two to see if they can be improved.

[...]
>> +       ret = of_property_read_u32(node, "reg", &id);
>> +       if (ret) {
>> +               dev_err(dev, "Missing or invalid reg property on %s\n",
>> +                       of_node_full_name(node));
>> +               return ret;
>> +       }
>> +
>> +       if (id >= OCTEON_MAX_MMC || host->slot[id]) {
>> +               dev_err(dev, "Invalid reg property on %s\n",
>> +                       of_node_full_name(node));
>> +               return -EINVAL;
>> +       }
>> +
>> +       mmc = mmc_alloc_host(sizeof(struct octeon_mmc_slot), dev);
>> +       if (!mmc) {
>> +               dev_err(dev, "alloc host failed\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       slot = mmc_priv(mmc);
>> +       slot->mmc = mmc;
>> +       slot->host = host;
>> +
>
> I would like you to use mmc_of_parse() somewhere here to support the
> common mmc DT bindings.

Yes, we will try to do that.

>
[...]
>
>
> So this was I quick review, unfortunate I don't have more time right
> now. But please go ahead and adress my comments, then I will look into
> the next version more thoroughly.
>

Ok, Thanks for looking at it.

David Daney



