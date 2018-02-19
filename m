From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH 1/5] dt-bindings: mmc: document the stm32 sdmmc bindings
Date: Mon, 19 Feb 2018 16:16:01 +0100
Message-ID: <12fc58db-3b21-4c83-30ce-e1b495928dbc@st.com>
References: <1518701697-14242-1-git-send-email-ludovic.Barre@st.com>
 <1518701697-14242-2-git-send-email-ludovic.Barre@st.com>
 <20180219144735.sbxa76z6aik3w453@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180219144735.sbxa76z6aik3w453@rob-hp-laptop>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Torgue <alexandre.torgue@st.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Gerald Baeza <gerald.baeza@st.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

hi Rob

Ok for all changes

BR
Ludo

On 02/19/2018 03:47 PM, Rob Herring wrote:
> On Thu, Feb 15, 2018 at 02:34:53PM +0100, Ludovic Barre wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> Document the binding for stm32 sdmmc controller.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   .../devicetree/bindings/mmc/st,stm32-sdmmc.txt     | 35 ++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mmc/st,stm32-sdmmc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/st,stm32-sdmmc.txt b/Documentation/devicetree/bindings/mmc/st,stm32-sdmmc.txt
>> new file mode 100644
>> index 0000000..52eb1f8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/st,stm32-sdmmc.txt
>> @@ -0,0 +1,35 @@
>> +* STMicroelectronics STM32 SDMMC controller
>> +
>> +The highspeed MMC host controller on STM32 soc family
>> +provides an interface for MMC, SD and SDIO types of memory cards.
>> +
>> +This file documents differences between the core properties described
>> +by mmc.txt and the properties used by the sdmmc driver.
>> +
>> +Required properties:
>> + - compatible: Should be "st,stm32h7-sdmmc"
>> + - reg: mmc controller base registers
>> + - interrupts: Should contain the interrupt number
>> + - clocks: Should contain phandle for the clock feeding the controller
>> + - resets: Should contain phandle for the reset feeding the controller
>> +
>> +Optional property:
>> +- st,dirpol: Allow to select direction polarity of external voltage
> 
> This doesn't need to be so terse. Perhaps "st,dir-output-high".
> 

Ok, I take "st,dir-output-high", your're right it's more descriptive :-)

>> +  transceiver (which manage data and command direction).
>> +  if set: Voltage transceiver IOs are driven as output when direction signals are high,
>> +  else: Voltage transceiver IOs are driven as output when direction signals are low.
>> +- st,negedge: generate data & command on sdmmc clock falling edge
> 
> st,neg-edge
> 
>> +- st,pin-ckin: use sdmmc_ckin pin from an external driver to sample
>> +  the receive data (example: with voltage switch transceiver).
> 
> st,use-ckin
> 

OK

>> +
>> +Example:
>> +	sdmmc1: sdmmc@52007000 {
> 
> mmc@...
>

OK

>> +		compatible = "st,stm32h7-sdmmc";
>> +		reg = <0x52007000 0x1000>;
>> +		interrupts = <49>;
>> +		clocks = <&rcc SDMMC1_CK>;
>> +		resets = <&rcc SDMMC1_R>;
>> +		bus-width = <4>;
>> +		cap-sd-highspeed;
>> +		cap-mmc-highspeed;
>> +	};
>> -- 
>> 2.7.4
>>
