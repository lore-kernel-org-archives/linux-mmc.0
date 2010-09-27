From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH (mmc-next) 1/3] mmc: add suspend/resume in the
 sdhci-pltfm driver
Date: Mon, 27 Sep 2010 14:57:59 +0200
Message-ID: <4CA094D7.7070101@st.com>
References: <1285233266-5039-1-git-send-email-peppe.cavallaro@st.com>
 <20100927103722.GC2664@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:49173 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759163Ab0I0M6W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Sep 2010 08:58:22 -0400
In-Reply-To: <20100927103722.GC2664@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 09/27/2010 12:37 PM, Wolfram Sang wrote:
> On Thu, Sep 23, 2010 at 11:14:24AM +0200, Giuseppe CAVALLARO wrote:
>> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> 
> I'd prefer it the way sdhci-mv.c is doing it (just one #if-block and
> returning the code from the sdhci_*-functions). Then it should be fine.

Okay! I can rework it without any problems.

Peppe

> 
>> ---
>>  drivers/mmc/host/sdhci-pltfm.c |   22 ++++++++++++++++++++++
>>  1 files changed, 22 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
>> index e045e3c..89ea64b 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.c
>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>> @@ -165,6 +165,24 @@ static const struct platform_device_id sdhci_pltfm_ids[] = {
>>  };
>>  MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
>>  
>> +#ifdef CONFIG_PM
>> +static int sdhci_pltfm_suspend(struct platform_device *dev, pm_message_t pm)
>> +{
>> +	struct sdhci_host *host = platform_get_drvdata(dev);
>> +
>> +	sdhci_suspend_host(host, pm);
>> +	return 0;
>> +}
>> +
>> +static int sdhci_pltfm_resume(struct platform_device *dev)
>> +{
>> +	struct sdhci_host *host = platform_get_drvdata(dev);
>> +
>> +	sdhci_resume_host(host);
>> +	return 0;
>> +}
>> +#endif
>> +
>>  static struct platform_driver sdhci_pltfm_driver = {
>>  	.driver = {
>>  		.name	= "sdhci",
>> @@ -173,6 +191,10 @@ static struct platform_driver sdhci_pltfm_driver = {
>>  	.probe		= sdhci_pltfm_probe,
>>  	.remove		= __devexit_p(sdhci_pltfm_remove),
>>  	.id_table	= sdhci_pltfm_ids,
>> +#ifdef CONFIG_PM
>> +	.suspend = sdhci_pltfm_suspend,
>> +	.resume = sdhci_pltfm_resume,
>> +#endif
>>  };
>>  
>>  /*****************************************************************************\
>> -- 
>> 1.5.5.6
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
