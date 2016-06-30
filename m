From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH RFC 2/8] mmc: sdhci-msm: Fix the regulator binding name
Date: Thu, 30 Jun 2016 18:35:47 +0530
Message-ID: <a9c391e1-b1df-b96e-91bf-b37880981692@codeaurora.org>
References: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
 <1467199233-20506-3-git-send-email-riteshh@codeaurora.org>
 <20160629214809.GC16832@hector.attlocal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40286 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbcF3NF4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jun 2016 09:05:56 -0400
In-Reply-To: <20160629214809.GC16832@hector.attlocal.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, adrian.hunter@intel.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org

Hi Andy,

Thanks for the review -

On 6/30/2016 3:18 AM, Andy Gross wrote:
> On Wed, Jun 29, 2016 at 04:50:27PM +0530, Ritesh Harjani wrote:
>> QUALCOMM sdhci-msm driver follows a pwr_irq method
>> (deviation from regular standard) for any pwr related
>> operations (which also involves regulator settings changes).
>>
>> vmmc/vqmmc regulator names are used by core layer,
>> so change the names to vdd/vdd-io so that it can
>> be used by sdhci-msm driver alone.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> index 485483a..851e66d 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> @@ -27,8 +27,8 @@ Example:
>>  		bus-width = <8>;
>>  		non-removable;
>>
>> -		vmmc-supply = <&pm8941_l20>;
>> -		vqmmc-supply = <&pm8941_s3>;
>> +		vdd-supply = <&pm8941_l20>;
>> +		vdd-io-supply = <&pm8941_s3>;
>
> If you are adding supplies, you need to specify them in the required properties.
Ok sure will add this in required properties.

> And if these properties are required by a specific compat you need to add the
> compat.  Because this binding has consumers, you need to think about them as
> well.
I think adding it in required properties should be fine, this is not 
specific to any compat.

>
> Is the pwr_irq stuff still part of the v4 controller?  If not and this is a new
> revision, perhaps a new binding/compat is required.  This would make dealing
> with it in the driver easier as well.
Pwr_irq is part of v4 controller itself.

>
>>
>>  		pinctrl-names = "default";
>>  		pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
>> @@ -44,8 +44,8 @@ Example:
>>  		bus-width = <4>;
>>  		cd-gpios = <&msmgpio 62 0x1>;
>>
>> -		vmmc-supply = <&pm8941_l21>;
>> -		vqmmc-supply = <&pm8941_l13>;
>> +		vdd-supply = <&pm8941_l21>;
>> +		vdd-io-supply = <&pm8941_l13>;
>
> ditto above
Done.

>
>>
>>  		pinctrl-names = "default";
>>  		pinctrl-0 = <&sdc2_clk &sdc2_cmd &sdc2_data>;
