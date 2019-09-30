From: ppvk@codeaurora.org
Subject: Re: [RFC 2/2] dt-bindings: mmc: sdhci-msm: Add Bus BW vote supported
 strings
Date: Mon, 30 Sep 2019 20:02:19 +0530
Message-ID: <695802ae255fe40ab9ca7750e0bbed91@codeaurora.org>
References: <1567774037-2344-1-git-send-email-ppvk@codeaurora.org>
 <1567774037-2344-3-git-send-email-ppvk@codeaurora.org>
 <5d7ba95c.1c69fb81.edf8e.6556@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5d7ba95c.1c69fb81.edf8e.6556@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, asutoshd@codeaurora.org, vbadigan@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, rampraka@codeaurora.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-mmc@vger.kernel.org

On 2019-09-13 20:06, Rob Herring wrote:
> On Fri, Sep 06, 2019 at 06:17:17PM +0530, Pradeep P V K wrote:
>> Add Bus bandwidth voting supported strings for qcom-sdhci controller.
> 
> What is bus bandwidth voting?

Controller is connected with its master using NOC and it controls its 
slaves using another NOC path.
So,controller have 2 NOC paths as below.
     a. CPU to Controller, This path is used to access the registers of 
controllers.
     b. Controller to DDR, This path is a data path, where data is 
read/write from/to DDR.
All data transfer will happen on these NOC's, which is shared between 
other peripherals.
In order to achieve required throughput (Data transfer Bandwidth) we put 
vote on these NOC's to
scale the NOC clocks to support required bandwidth.

Instantaneous bandwidth (ib) and Arbitrated bandwidth (ab) values are 
the values calculated (This involves various arch. specific parameters
like clock plans, voltage corners, etc. which varies from vendor to 
vendor and target to target)
to put vote on those noc's to achieve require throughput.

> 
>> 
>> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
>> ---
>>  .../devicetree/bindings/mmc/sdhci-msm.txt          | 32 
>> ++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt 
>> b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> index da4edb1..8255d92 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> @@ -39,6 +39,25 @@ Required properties:
>>  	"cal"	- reference clock for RCLK delay calibration (optional)
>>  	"sleep"	- sleep clock for RCLK delay calibration (optional)
>> 
>> +Optional Properties:
>> +* Following bus parameters are required for bus bw voting:
>> +- interconnects: Pairs of phandles and interconnect provider 
>> specifier
>> +		 to denote the edge source and destination ports of
>> +		 the interconnect path. Please refer to
>> +		 Documentation/devicetree/bindings/interconnect/
>> +		 for more details.
>> +- interconnect-names: List of interconnect path name strings sorted 
>> in the same
>> +		order as the interconnects property. Consumers drivers will use
>> +		interconnect-names to match interconnect paths with interconnect
>> +		specifiers. Please refer to Documentation/devicetree/bindings/
>> +		interconnect/ for more details.
> 
> How many? What are the strings?

As this is implemented using interconnect framework, "interconnects" and 
"interconnect-names" are required
and below qcom specific properties are required to calculate the ab and 
ib values.
> 
>> +- qcom,msm-bus,name: string describing the bus path
>> +- qcom,msm-bus,num-cases: number of configurations in which sdhc can 
>> operate in
>> +- qcom,msm-bus,num-paths: number of paths to vote for
>> +- qcom,msm-bus,vectors-KBps: Takes a tuple <ib ab>, <ib ab> (2 tuples 
>> for 2
> 
> ib and ab are what? Didn't we just add interconnect bindings for
> expressing bandwidth?

Instantaneous bandwidth (ib) is peak bandwidth and Arbitrated bandwidth 
(ab) is the Average bandwidth.
There is no interconnect binding node as such for expressing the 
bandwidth. Hence the reason to use the
above qcom nodes for parsing and storing the req. bandwidth.

> 
>> +				num-paths) The number of these entries *must*
>> +				be same as num-cases.
> 
> Are all these properties SDHCI specific or can we expect to get these
> for *all* the QCom blocks?
> 
As per the current implementation, these are some optional properties 
and is required
only when the bus bandwidth support is needed and all these are qcom 
specific.

>> +
>>  Example:
>> 
>>  	sdhc_1: sdhci@f9824900 {
>> @@ -56,6 +75,19 @@ Example:
>> 
>>  		clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
>>  		clock-names = "core", "iface";
>> +		interconnects = <&qnoc 50 &qnoc 512>,
>> +				<&qnoc 1 &qnoc 544>;
>> +		interconnect-names = "sdhc-ddr","cpu-sdhc";
>> +		qcom,msm-bus,name = "sdhc1";
>> +		qcom,msm-bus,num-cases = <3>;
>> +		qcom,msm-bus,num-paths = <2>;
>> +		qcom,msm-bus,vectors-KBps =
>> +		/* No Vote */
>> +		<0 0>, <0 0>,
>> +		/* 50 MB/s */
>> +		<130718 200000>, <133320 133320>,
>> +		/* 200 MB/s */
>> +		<1338562 4096000>, <1338562 4096000>;
>>  	};
>> 
>>  	sdhc_2: sdhci@f98a4900 {
>> --
>> 1.9.1
>> 
