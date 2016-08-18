From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: do not touch other bit when config
 DTOCV
Date: Thu, 18 Aug 2016 15:49:30 +0300
Message-ID: <70d47eac-250c-ef88-c59e-0af03245488c@intel.com>
References: <1471249178-32204-1-git-send-email-haibo.chen@nxp.com>
 <20160816073050.GA9211@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8754 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752483AbcHRM5E (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Aug 2016 08:57:04 -0400
In-Reply-To: <20160816073050.GA9211@shlinux2>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>, Haibo Chen <haibo.chen@nxp.com>
Cc: ulf.hansson@linaro.org, aisheng.dong@nxp.com, linux-mmc@vger.kernel.org

On 16/08/16 10:30, Dong Aisheng wrote:
> On Mon, Aug 15, 2016 at 04:19:38PM +0800, Haibo Chen wrote:
>> Now, when call esdhc_set_timeout() to set the data timeout counter value,
>> IPP_RST_N(bit 23) is wrongly affected. This patch add a mask to avoid this.
>>
>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> 
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Regards
> Dong Aisheng
> 
>> ---
>>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index 99e0b33..437c448 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -31,6 +31,7 @@
>>  #include "sdhci-pltfm.h"
>>  #include "sdhci-esdhc.h"
>>  
>> +#define ESDHC_SYS_CTRL_DTOCV_MASK	0x0f
>>  #define	ESDHC_CTRL_D3CD			0x08
>>  #define ESDHC_BURST_LEN_EN_INCR		(1 << 27)
>>  /* VENDOR SPEC register */
>> @@ -937,7 +938,8 @@ static void esdhc_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>>  
>>  	/* use maximum timeout counter */
>> -	sdhci_writeb(host, esdhc_is_usdhc(imx_data) ? 0xF : 0xE,
>> +	esdhc_clrset_le(host, ESDHC_SYS_CTRL_DTOCV_MASK,
>> +			esdhc_is_usdhc(imx_data) ? 0xF : 0xE,
>>  			SDHCI_TIMEOUT_CONTROL);
>>  }
>>  
>> -- 
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

