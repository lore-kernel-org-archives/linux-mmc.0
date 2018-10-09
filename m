From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 1/6] dt-bindings: phy: am654-mmc-phy: Document new phy
 bindings
Date: Tue, 9 Oct 2018 12:04:10 +0530
Message-ID: <92ff5e6a-455f-bd26-4f26-c5ff24ab6134@ti.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com>
 <20181004111451.9539-2-faiz_abbas@ti.com>
 <ad9945db-de08-36fc-47b8-499ce2079d92@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ad9945db-de08-36fc-47b8-499ce2079d92@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: kishon@ti.com, ulf.hansson@linaro.org, robh+dt@kernel.org, catalin.marinas@arm.com, adrian.hunter@intel.com
List-Id: linux-mmc@vger.kernel.org

Hi Andrew,

On Friday 05 October 2018 09:28 PM, Andrew F. Davis wrote:
> On 10/04/2018 06:14 AM, Faiz Abbas wrote:
>> Add information to document bindings for the MMC PHY
>> on TI's AM654 devices.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>>  .../devicetree/bindings/phy/am654-mmc-phy.txt | 42 +++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/am654-mmc-phy.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/am654-mmc-phy.txt b/Documentation/devicetree/bindings/phy/am654-mmc-phy.txt
>> new file mode 100644
>> index 000000000000..766921612758
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/am654-mmc-phy.txt
> 
> 
> Name ti,am654-mmc-phy.txt might be more consistent name.

Ok.

> 
> 
>> @@ -0,0 +1,42 @@
>> +TI AM654 MMC PHY
>> +-------------------
>> +
>> +Required properties:
>> + - compatible: ti,am654-emmc-phy
>> + - #phy-cells: must be 0
>> + - reg: PHY registers address offset and size
>> + - clocks: must be phandle of the clock provider which is the host
>> +	   controller
>> + - clock-names: must be "mmcclk"
>> + - ti,otap-del-sel: Output Tap Delay select.
>> + - ti,trm-icp: DLL trim select.
>> + - ti,driver-strength-ohm: driver strength in ohms.
>> +			   Valid values are 33, 40, 50, 66, and 100 ohms.
>> +
>> +Example:
>> +			mmc_phy1: mmc_phy@10100 {
>> +				compatible = "ti,am654-mmc-phy";
>> +				reg = <0x10100 0x34>;
>> +				clocks = <&sdhci1>;
>> +				clock-names = "mmcclk";
>> +				#phy-cells = <0>;
>> +				ti,otap-del-sel = <0x2>;
>> +				ti,trm-icp = <0x8>;
>> +				status = "disabled";
> 
> 
> No need for disabled in the example case. 

Ok.

> Also not sure the host
> controller example below needs to be here, there are already examples
> for that binding in mmc/arasan,sdhci.txt.
> 

I had added it because it is a clock source in clocks=<&sdhci1> so it
should have #clock-cells and clock-output-names. I suppose I can just
reference it here.

Thanks,
Faiz
