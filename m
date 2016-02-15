From: Matt Redfearn <matt.redfearn@imgtec.com>
Subject: Re: [PATCH v5] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Mon, 15 Feb 2016 08:11:02 +0000
Message-ID: <56C18816.2010708@imgtec.com>
References: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com>
 <20160212153940.GA32211@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:18985 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbcBOILG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Feb 2016 03:11:06 -0500
In-Reply-To: <20160212153940.GA32211@rob-hp-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-mmc@vger.kernel.org, david.daney@cavium.com, ulf.hansson@linaro.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Zubair.Kakakhel@imgtec.com, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>

Hi Rob,

On 12/02/16 15:39, Rob Herring wrote:
> On Wed, Feb 10, 2016 at 05:36:15PM +0000, Matt Redfearn wrote:
>> From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
>>
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
>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
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
>> Tested on Rhino labs UTM8, Cavium CN7130.
>>
>> For reference, the binding in the shipped devices is:
>> mmc: mmc@1180000002000 {
>> 	compatible = "cavium,octeon-6130-mmc";
>> 	reg = <0x11800 0x00002000 0x0 0x100>,
>> 		<0x11800 0x00000168 0x0 0x20>;
>> 	#address-cells = <1>;
>> 	#size-cells = <0>;
>> 	/* EMM irq, DMA irq */
>> 	interrupts = <1 19>, <0 63>;
>>
>> 	/* The board only has a single MMC slot */
>> 	mmc-slot@2 {
>> 		compatible = "cavium,octeon-6130-mmc-slot";
>> 		reg = <2>;
>> 		voltage-ranges = <3300 3300>;
>> 		spi-max-frequency = <26000000>;
>> 		/* Power on GPIO 8, active high */
>> 		/* power-gpios = <&gpio 8 0>; */
>> 		power-gpios = <&gpio 8 1>;
>>
>> 	/*      spi-max-frequency = <52000000>; */
>> 		/* bus width can be 1, 4 or 8 */
>> 		cavium,bus-max-width = <8>;
>> 	};
>> 	mmc-slot@0 {
>> 		compatible = "cavium,octeon-6130-mmc-slot";
>> 		reg = <0>;
>> 		voltage-ranges = <3300 3300>;
>> 		spi-max-frequency = <26000000>;
>> 		/* non-removable; */
>> 		bus-width = <8>;
>> 		/* bus width can be 1, 4 or 8 */
>> 		cavium,bus-max-width = <8>;
>> 	};
>> };
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
>> ---
>>   .../devicetree/bindings/mmc/octeon-mmc.txt         |   80 ++
>>   drivers/mmc/host/Kconfig                           |   10 +
>>   drivers/mmc/host/Makefile                          |    1 +
>>   drivers/mmc/host/octeon_mmc.c                      | 1409 ++++++++++++++++++++
>>   4 files changed, 1500 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mmc/octeon-mmc.txt
>>   create mode 100644 drivers/mmc/host/octeon_mmc.c
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/octeon-mmc.txt b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
>> new file mode 100644
>> index 000000000000..a1b20753172f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
>> @@ -0,0 +1,80 @@
>> +* OCTEON SD/MMC Host Controller
>> +
>> +This controller is present on some members of the Cavium OCTEON SoC
>> +family, provide an interface for eMMC, MMC and SD devices.  There is a
>> +single controller that may have several "slots" connected.  These
>> +slots appear as children of the main controller node.
>> +The DMA engine is an integral part of the controller block.
>> +
>> +1) MMC node
>> +
>> +Required properties:
>> +- compatible : Should be "cavium,octeon-6130-mmc" or "cavium,octeon-7890-mmc"
>> +- reg : Two entries:
>> +	1) The base address of the MMC controller register bank.
>> +	2) The base address of the MMC DMA engine register bank.
>> +- interrupts :
>> +	For "cavium,octeon-6130-mmc": two entries:
>> +	1) The MMC controller interrupt line.
>> +	2) The MMC DMA engine interrupt line.
>> +	For "cavium,octeon-7890-mmc": nine entries:
>> +	1) The next block transfer of a multiblock transfer has completed (BUF_DONE)
>> +	2) Operation completed successfully (CMD_DONE).
>> +	3) DMA transfer completed successfully (DMA_DONE).
>> +	4) Operation encountered an error (CMD_ERR).
>> +	5) DMA transfer encountered an error (DMA_ERR).
>> +	6) Switch operation completed successfully (SWITCH_DONE).
>> +	7) Switch operation encountered an error (SWITCH_ERR).
>> +	8) Internal DMA engine request completion interrupt (DONE).
>> +	9) Internal DMA FIFO underflow (FIFO).
> Why do h/w designers think doing this speeds up interrupt handling...

I know, right? :-/

>> +- #address-cells : Must be <1>
>> +- #size-cells : Must be <0>
>> +
>> +The node contains child nodes for each slot that the platform uses.
>> +
>> +Example:
>> +mmc@1180000002000 {
>> +	compatible = "cavium,octeon-6130-mmc";
>> +	reg = <0x11800 0x00002000 0x0 0x100>,
>> +		<0x11800 0x00000168 0x0 0x20>;
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	/* EMM irq, DMA irq */
>> +	interrupts = <1 19>, <0 63>;
>> +
>> +	[ child node definitions...]
>> +};
>> +
>> +
>> +2) Slot nodes
>> +Properties in mmc.txt apply to each slot node that the platform uses.
>> +
>> +Required properties:
>> +- reg : The slot number.
>> +
>> +Optional properties:
>> +- cavium,cmd-clk-skew : the amount of delay (in pS) past the clock edge
>> +	to sample the command pin.
>> +- cavium,dat-clk-skew : the amount of delay (in pS) past the clock edge
>> +	to sample the data pin.
> Are you trying to maintain compatibility with legacy bindings here? If
> not, append units (-ps).

Yes, we're trying to maintain compatibility, but should be able to 
accept either form, with the "-ps" version being the binding documented.

>
>> +
>> +Example:
>> +	mmc@1180000002000 {
>> +		compatible = "cavium,octeon-6130-mmc";
>> +		reg = <0x11800 0x00002000 0x0 0x100>,
>> +		      <0x11800 0x00000168 0x0 0x20>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		/* EMM irq, DMA irq */
>> +		interrupts = <1 19>, <0 63>;
>> +
>> +		/* The board only has a single MMC slot */
>> +		mmc-slot@0 {
> Most mmc bindings don't separately describe the slot. This is probably
> a more correct h/w description, but then again I've never seen more than
> 1 slot.

The OCTEON MMC controller supports up to 4 slots of MMC, eMMC or SD 
types. The board I have (a Rhino Labs UTM8) has both a uSD card slot and 
eMMC device connected to the controller - the best way to describe this 
is via multiple slot nodes as children of the controller.

>
> Otherwise, this looks fine to me.

Thanks,
Matt

>
>> +			reg = <0>;
>> +			max-frequency = <20000000>;
>> +			bus-width = <8>;
>> +			vmmc-supply = <&reg_vmmc3>;
>> +			cd-gpios = <&gpio 9 0>;
>> +			wp-gpios = <&gpio 10 0>;
>> +		};
>> +	};

