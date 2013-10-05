From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH v2 3/9] ARM: dts: Add SHAM data and documentation for
 AM33XX
Date: Sat, 5 Oct 2013 13:18:08 -0500
Message-ID: <525057E0.80009@ti.com>
References: <1380553986-15910-1-git-send-email-joelf@ti.com>
 <1380553986-15910-4-git-send-email-joelf@ti.com>
 <20131004142644.GI6999@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131004142644.GI6999@e106331-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, Rob Landley <rob@landley.net>, Pawel Moll <Pawel.Moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, open list <linux-kernel@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Linux MMC List <linux-mmc@vger.kernel.org>, "Mark A. Greer" <mgreer@animalcreek.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, DOCUMENTATION <linux-doc@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 10/04/2013 09:26 AM, Mark Rutland wrote:
> On Mon, Sep 30, 2013 at 04:13:00PM +0100, Joel Fernandes wrote:
>> From: "Mark A. Greer" <mgreer@animalcreek.com>
>>
>> Add the generic AM33XX SHAM module's device tree data and
>> enable it for the am335x-evm, am335x-evmsk, and am335x-bone
>> platforms.  Also add Documentation file describing the data
>> for the SHAM module.
>>
>> [joelf@ti.com: Dropped interrupt-parrent property]
>> CC: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
>> ---
>>  .../devicetree/bindings/crypto/omap-sham.txt       | 31 ++++++++++++++++++++++
>>  arch/arm/boot/dts/am335x-bone.dts                  |  4 +++
>>  arch/arm/boot/dts/am335x-evm.dts                   |  4 +++
>>  arch/arm/boot/dts/am335x-evmsk.dts                 |  4 +++
>>  arch/arm/boot/dts/am33xx.dtsi                      |  9 +++++++
>>  5 files changed, 52 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt
>>
>> diff --git a/Documentation/devicetree/bindings/crypto/omap-sham.txt b/Documentation/devicetree/bindings/crypto/omap-sham.txt
>> new file mode 100644
>> index 0000000..b97710f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/crypto/omap-sham.txt
>> @@ -0,0 +1,31 @@
>> +OMAP SoC SHA crypto Module
>> +
>> +Required properties:
>> +
>> +- compatible : Should contain entries for this and backward compatible
>> +  SHAM versions:
>> +  - "ti,omap2-sham" for OMAP2 & OMAP3.
>> +  - "ti,omap4-sham" for OMAP4 and AM33XX.
>> +  Note that these two versions are incompatible.
>> +- ti,hwmods: Name of the hwmod associated with the SHAM module
>> +- reg : Offset and length of the register set for the module
>> +- interrupt-parent : the phandle for the interrupt controller that
>> +  services interrupts for this module.
> 
> I don't think this is strictly speaking necessary -- it's mostly going
> to be implicit (it is in the dtsi below). As this is a standard
> property, you don't need to document it here.

Ok, dropping from documentation.

>> +- interrupts : the interrupt number for the SHAM module.
> 
> Sorry, I missed this last time, but this should be interrupt-specifier
> rather than interrupt number.

Ok, done.

> 
> Otherwise, this looks good to me. With the fixups above:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks!

-Joel

> 
>> +
>> +Optional properties:
>> +- dmas: DMA specifier for the rx dma. See the DMA client binding,
>> +	Documentation/devicetree/bindings/dma/dma.txt
>> +- dma-names: DMA request name. Should be "rx" if a dma is present.
>> +
>> +Example:
>> +	/* AM335x */
>> +	sham: sham@53100000 {
>> +		compatible = "ti,omap4-sham";
>> +		ti,hwmods = "sham";
>> +		reg = <0x53100000 0x200>;
>> +		interrupt-parent = <&intc>;
>> +		interrupts = <109>;
>> +		dmas = <&edma 36>;
>> +		dma-names = "rx";
>> +	};
>> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
>> index 0d63348..8a9802e 100644
>> --- a/arch/arm/boot/dts/am335x-bone.dts
>> +++ b/arch/arm/boot/dts/am335x-bone.dts
>> @@ -19,3 +19,7 @@
>>  &mmc1 {
>>  	vmmc-supply = <&ldo3_reg>;
>>  };
>> +
>> +&sham {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
>> index 23b0a3e..d59e51c 100644
>> --- a/arch/arm/boot/dts/am335x-evm.dts
>> +++ b/arch/arm/boot/dts/am335x-evm.dts
>> @@ -522,3 +522,7 @@
>>  	status = "okay";
>>  	vmmc-supply = <&vmmc_reg>;
>>  };
>> +
>> +&sham {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
>> index bc93895..d45a330 100644
>> --- a/arch/arm/boot/dts/am335x-evmsk.dts
>> +++ b/arch/arm/boot/dts/am335x-evmsk.dts
>> @@ -424,3 +424,7 @@
>>  	status = "okay";
>>  	vmmc-supply = <&vmmc_reg>;
>>  };
>> +
>> +&sham {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>> index 553adc6..299710b 100644
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>> @@ -710,5 +710,14 @@
>>  			#size-cells = <1>;
>>  			status = "disabled";
>>  		};
>> +
>> +		sham: sham@53100000 {
>> +			compatible = "ti,omap4-sham";
>> +			ti,hwmods = "sham";
>> +			reg = <0x53100000 0x200>;
>> +			interrupts = <109>;
>> +			dmas = <&edma 36>;
>> +			dma-names = "rx";
>> +		};
>>  	};
>>  };
>> -- 
>> 1.8.1.2
>>
>>
