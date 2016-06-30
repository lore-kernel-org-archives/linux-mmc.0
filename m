From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH RFC 4/8] mmc: sdhci-msm: Add regulator DT props to
 sdhci-msm bindings
Date: Thu, 30 Jun 2016 19:00:54 +0530
Message-ID: <2e77ecd7-abd8-cffc-b0ff-f29f68543263@codeaurora.org>
References: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
 <1467199233-20506-5-git-send-email-riteshh@codeaurora.org>
 <20160629215326.GD16832@hector.attlocal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43337 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbcF3NbU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jun 2016 09:31:20 -0400
In-Reply-To: <20160629215326.GD16832@hector.attlocal.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, adrian.hunter@intel.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org

Hi Andy,

On 6/30/2016 3:23 AM, Andy Gross wrote:
> On Wed, Jun 29, 2016 at 04:50:29PM +0530, Ritesh Harjani wrote:
>> This patch adds the DT properties for voltage regulator nodes
>> for Qualcomm SDHCI driver.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> index 851e66d..32cea75 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> @@ -17,7 +17,15 @@ Required properties:
>>  	"iface" - Main peripheral bus clock (PCLK/HCLK - AHB Bus clock) (required)
>>  	"core"	- SDC MMC clock (MCLK) (required)
>>  	"bus"	- SDCC bus voter clock (optional)
>> +- qcom,<supply>-voltage_level - specifies voltage levels for supply. Should be
>> +					specified in pairs (min, max), units uV.
>> +- qcom,<supply>-current_level - specifies load levels for supply in lpm or
>> +					high power mode (hpm). Should be specified in
>> +					pairs (lpm, hpm), units uA.
>
> These seem like OPPs to me.  Why use something non-standard?
>
> Check out Documentation/devicetree/bindings/opp/opp.txt
Isn't OPP used w.r.t. DVFS?
This is voltage/load regulator supplies used to provide vdd/vdd-io to 
card. We require this to switch the I/O voltage while switching to UHS 
card mode or to turn on/off the regulators while not in use, (but not 
tied to voltage switching while different frequency transitions).

This is mentioned in the same way how other drivers uses vmmc/vqmmc, but 
the deviation in the name is since Qcom follows pwr_irq 
deviation(different from standard) to switch the I/O voltage, bus on/off.

>
>>
>> +Optional Properties:
>> +	- qcom,<supply>-always-on - specifies whether supply should be kept "on" always.
>
> Would this only be the base if mmc is used on this platform?  You could specify
> this in the regulator binding itself if this is more of a global thing.
This could be specific to SDHC nodes, like for emmc - we may need only 
vdd-io to be on. So we need this per sdhc node.

>
>> +	- qcom,<supply>-lpm_sup - specifies whether supply can be kept in low power mode (lpm).
>>  Example:
>>
>>  	sdhc_1: sdhci@f9824900 {
>> @@ -28,7 +36,13 @@ Example:
>>  		non-removable;
>>
>>  		vdd-supply = <&pm8941_l20>;
>> +		qcom,vdd-voltage-level = <2950000 2950000>;
>> +		qcom,vdd-current-level = <200 570000>;
>> +
>>  		vdd-io-supply = <&pm8941_s3>;
>> +		qcom,vdd-io-always-on;
>> +		qcom,vdd-io-voltage-level = <1800000 1800000>;
>> +		qcom,vdd-io-current-level = <110 325000>;
>>
>>  		pinctrl-names = "default";
>>  		pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
>> @@ -45,7 +59,12 @@ Example:
>>  		cd-gpios = <&msmgpio 62 0x1>;
>>
>>  		vdd-supply = <&pm8941_l21>;
>> +		qcom,vdd-voltage-level = <2950000 2950000>;
>> +		qcom,vdd-current-level = <200 800000>;
>> +
>>  		vdd-io-supply = <&pm8941_l13>;
>> +		qcom,vdd-io-voltage-level = <1800000 2950000>;
>> +		qcom,vdd-io-current-level = <200 22000>;
>>
>>  		pinctrl-names = "default";
>>  		pinctrl-0 = <&sdc2_clk &sdc2_cmd &sdc2_data>;
>
> Regards,
>
> Andy
>

--
Regards
Ritesh
