From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH -next] mmc: sdhci-bcm-kona: fix error return code in
 sdhci_bcm_kona_probe()
Date: Thu, 18 Aug 2016 09:59:58 +0300
Message-ID: <315af61f-6a29-cc06-2b74-2e243088ef97@intel.com>
References: <1469722664-15136-1-git-send-email-weiyj.lk@gmail.com>
 <f4099dac-99fb-00df-72d4-24ff4e52ed2f@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53059 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487AbcHRHE3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Aug 2016 03:04:29 -0400
In-Reply-To: <f4099dac-99fb-00df-72d4-24ff4e52ed2f@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ray Jui <ray.jui@broadcom.com>, Wei Yongjun <weiyj.lk@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org

On 28/07/16 19:45, Ray Jui wrote:
> Hi Wei,
> 
> On 7/28/2016 9:17 AM, Wei Yongjun wrote:
>> In clk_set_rate() or clk_prepare_enable() error handling case, the
>> error return code ret is not set, so sdhci_bcm_kona_probe() return
>> 0 in those error cases.
>>
>> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
>> ---
>>  drivers/mmc/host/sdhci-bcm-kona.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c
>> b/drivers/mmc/host/sdhci-bcm-kona.c
>> index e5c634b..51dd2fd 100644
>> --- a/drivers/mmc/host/sdhci-bcm-kona.c
>> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
>> @@ -253,12 +253,14 @@ static int sdhci_bcm_kona_probe(struct
>> platform_device *pdev)
>>          goto err_pltfm_free;
>>      }
>>
>> -    if (clk_set_rate(pltfm_priv->clk, host->mmc->f_max) != 0) {
>> +    ret = clk_set_rate(pltfm_priv->clk, host->mmc->f_max);
>> +    if (ret) {
>>          dev_err(dev, "Failed to set rate core clock\n");
>>          goto err_pltfm_free;
>>      }
>>
>> -    if (clk_prepare_enable(pltfm_priv->clk) != 0) {
>> +    ret = clk_prepare_enable(pltfm_priv->clk);
>> +    if (ret) {
>>          dev_err(dev, "Failed to enable core clock\n");
>>          goto err_pltfm_free;
>>      }
>>
> 
> The above change looks good to me, thanks!
> 
> Acked-by: Ray Jui <ray.jui@broadcom.com>
> 

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

