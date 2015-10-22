From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: exynos: Add the exynos3250 compatible
Date: Thu, 22 Oct 2015 11:54:06 +0900
Message-ID: <56284FCE.3000108@samsung.com>
References: <1445409555-1684-1-git-send-email-jh80.chung@samsung.com>
 <5628289C.90800@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:54410 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473AbbJVCyJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2015 22:54:09 -0400
In-reply-to: <5628289C.90800@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: ulf.hansson@linaro.org, kgene@kernel.org, linux-arm-kernel@lists.infradead.org

Hi, Krzysztof.

On 10/22/2015 09:06 AM, Krzysztof Kozlowski wrote:
> On 21.10.2015 15:39, Jaehoon Chung wrote:
>> To check more exactly, add the exynos3250 compatible.
>> Not use exynos5250 compatibility.
> 
> Hi,
> 
> I can't find any difference between old and new compatible. Maybe I am
> missing something? Maybe there is a difference for these devices?

Sorry, I needs to add more explanation about changing compatible.
Exynos3250 has more registers than exynos5250 in dwmmc IP.
Now, we used dwmmc controller with exynos5250 compatible.
Then some codes can't run in dw-mmc.c, if SoC is exynos3250.
For example, there is the checking point in dw_mci_exynos_config_hs400().

static void dw_mci_exynos_config_hs400(struct dw_mci *host, u32 timing)
{
        struct dw_mci_exynos_priv_data *priv = host->priv;
        u32 dqs, strobe;

        /*
         * Not supported to configure register
         * related to HS400
         */
        if (priv->ctrl_type < DW_MCI_TYPE_EXYNOS5420)
                return;

        dqs = priv->saved_dqs_en;
        strobe = priv->saved_strobe_ctrl;

It can't use this feature with exynos5250 compatible.

Does it need to change the compatible from exynos5250 to exynos3250?

Beset Regards,
Jaehoon Chung

> 
> Anyway if the code is the same then it should use exactly the same
> compatible.
> 
> Best regards,
> Krzysztof
> 
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt | 2 ++
>>  drivers/mmc/host/dw_mmc-exynos.c                         | 7 +++++++
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> index aad9844..cd22ac9 100644
>> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> @@ -22,6 +22,8 @@ Required Properties:
>>  	  specific extensions.
>>  	- "samsung,exynos7-dw-mshc-smu": for controllers with Samsung Exynos7
>>  	  specific extensions having an SMU.
>> +	- "samsung,exynos3250-dw-mshc": for controllers with Samsung Exynos3250
>> +	  specific extensions.
>>  
>>  * samsung,dw-mshc-ciu-div: Specifies the divider value for the card interface
>>    unit (ciu) clock. This property is applicable only for Exynos5 SoC's and
>> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
>> index 1e75309..1c96218 100644
>> --- a/drivers/mmc/host/dw_mmc-exynos.c
>> +++ b/drivers/mmc/host/dw_mmc-exynos.c
>> @@ -32,6 +32,7 @@ enum dw_mci_exynos_type {
>>  	DW_MCI_TYPE_EXYNOS5420_SMU,
>>  	DW_MCI_TYPE_EXYNOS7,
>>  	DW_MCI_TYPE_EXYNOS7_SMU,
>> +	DW_MCI_TYPE_EXYNOS3250,
>>  };
>>  
>>  /* Exynos implementation specific driver private data */
>> @@ -73,6 +74,9 @@ static struct dw_mci_exynos_compatible {
>>  	}, {
>>  		.compatible	= "samsung,exynos7-dw-mshc-smu",
>>  		.ctrl_type	= DW_MCI_TYPE_EXYNOS7_SMU,
>> +	}, {
>> +		.compatible	= "samsung,exynos3250-dw-mshc",
>> +		.ctrl_type	= DW_MCI_TYPE_EXYNOS3250,
>>  	},
>>  };
>>  
>> @@ -467,6 +471,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot)
>>  	} while (start_smpl != smpl);
>>  
>>  	found = dw_mci_exynos_get_best_clksmpl(candiates);
>> +
>>  	if (found >= 0) {
>>  		dw_mci_exynos_set_clksmpl(host, found);
>>  		priv->tuned_sample = found;
>> @@ -520,6 +525,8 @@ static const struct of_device_id dw_mci_exynos_match[] = {
>>  			.data = &exynos_drv_data, },
>>  	{ .compatible = "samsung,exynos7-dw-mshc-smu",
>>  			.data = &exynos_drv_data, },
>> +	{ .compatible = "samsung,exynos3250-dw-mshc",
>> +			.data = &exynos_drv_data, },
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(of, dw_mci_exynos_match);
>>
> 
> 

