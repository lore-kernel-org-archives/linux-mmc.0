From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: correct the max timeout count
Date: Thu, 18 Aug 2016 15:55:17 +0300
Message-ID: <680be0ba-3096-fbde-d337-0caeaac25ff9@intel.com>
References: <1471249893-32345-1-git-send-email-haibo.chen@nxp.com>
 <20160816074457.GB9211@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:44324 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027AbcHRNAK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Aug 2016 09:00:10 -0400
In-Reply-To: <20160816074457.GB9211@shlinux2>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>, Haibo Chen <haibo.chen@nxp.com>
Cc: ulf.hansson@linaro.org, aisheng.dong@nxp.com, linux-mmc@vger.kernel.org

On 16/08/16 10:44, Dong Aisheng wrote:
> On Mon, Aug 15, 2016 at 04:31:33PM +0800, Haibo Chen wrote:
>> i.MX USDHC Reference Manual has a mistake, for the register SYS_CTRL,
>> the DTOCV(bit 19~16) means the data timeout counter value. When DTOCV
>> is set to 0xF, it means SDCLK << 29, not SDCLK << 28.
>>
>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>> ---
>>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index 437c448..ea7d086 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -929,7 +929,7 @@ static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
>>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>>  
> 
> Better add a comment here like:
> 	/* Doc Errata: the uSDHC actual maximum timeout count is 1 << 29 */
> 
>> -	return esdhc_is_usdhc(imx_data) ? 1 << 28 : 1 << 27;
>> +	return esdhc_is_usdhc(imx_data) ? 1 << 29 : 1 << 27;
> 
> Otherwise:
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Please take account of Dong's comment, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Regards
> Dong Aisheng
> 
>>  }
>>  
>>  static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>> -- 
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

