From: Matt Redfearn <matt.redfearn@imgtec.com>
Subject: Re: [PATCH v7 1/2] mmc: OCTEON: Add DT bindings for OCTEON MMC
 controller
Date: Thu, 18 Feb 2016 16:48:00 +0000
Message-ID: <56C5F5C0.7010008@imgtec.com>
References: <1455725574-9947-1-git-send-email-matt.redfearn@imgtec.com>
 <20160218143516.GA9654@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:35099 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425080AbcBRQsE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Feb 2016 11:48:04 -0500
In-Reply-To: <20160218143516.GA9654@rob-hp-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: david.daney@cavium.com, aleksey.makarov@caviumnetworks.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org, Chandrakala Chavva <cchavva@caviumnetworks.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>



On 18/02/16 14:35, Rob Herring wrote:
> On Wed, Feb 17, 2016 at 04:12:53PM +0000, Matt Redfearn wrote:
>> From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
>>
>> Add Device Tree binding document for Octeon MMC controller. The driver
>> is in a following patch.
>>
>> The MMC controller can be connected to up to 4 "slots" which may be
>> eMMC, MMC or SD card devices. As there is a single controller, each
>> available slot is represented as a child node of the controller.
>>
>> This is a similar concept to the atmel-mci driver.
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
>> v7: No changes
>>
>> v6:
>> - Split up patch
>> - Moved device tree fixup to platform code
>> ---
>>   .../devicetree/bindings/mmc/octeon-mmc.txt         | 79 ++++++++++++++++++++++
>>   1 file changed, 79 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mmc/octeon-mmc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/octeon-mmc.txt b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
>> new file mode 100644
>> index 000000000000..d2c576d9ad65
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
>> @@ -0,0 +1,79 @@
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
> I thought you were okay with adding -ps? Either way:
>
> Acked-by: Rob Herring <robh@kernel.org>
>
Thanks Rob.
Adding the -ps to the binding creates quite a bit of extra code in the 
driver, as we have to support the legacy version (without -ps) which is 
already in shipped devices. Depending how many revisions the driver 
itself goes through and how that code ends up being structured I may add 
them back in.

Thanks,
Matt
