From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 3/4] mmc: sdhci-s3c: revert
 "fix missing clock for gpio card-detect"
Date: Tue, 03 Sep 2013 21:26:27 +0900
Message-ID: <5225D573.8040101@samsung.com>
References: <51FBBD7D.2020203@samsung.com> <871u5cx99m.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:27973 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab3ICM0K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2013 08:26:10 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSJ004ICUJKCAM0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 03 Sep 2013 21:26:09 +0900 (KST)
In-reply-to: <871u5cx99m.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCb?= =?ISO-8859-1?Q?ner?= <heiko@sntech.de>

Hi,

On 08/30/2013 10:22 AM, Chris Ball wrote:
> Hi,
> 
> On Fri, Aug 02 2013, Jaehoon Chung wrote:
>> Fixed the warning message.(clk_disable/enable didn't pair)
>> [..]
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <Kyungmin.park@samsung.com>
>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>> Changelog v2:
>> 	- Added acked/tested by Heiko (on s3c2416)
>>
>>  drivers/mmc/host/sdhci-s3c.c |    9 ---------
>>  1 file changed, 9 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
>> index 6debda9..f974778 100644
>> --- a/drivers/mmc/host/sdhci-s3c.c
>> +++ b/drivers/mmc/host/sdhci-s3c.c
>> @@ -373,27 +373,18 @@ static struct sdhci_ops sdhci_s3c_ops = {
>>  static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
>>  {
>>  	struct sdhci_host *host = platform_get_drvdata(dev);
>> -#ifdef CONFIG_PM_RUNTIME
>> -	struct sdhci_s3c *sc = sdhci_priv(host);
>> -#endif
>>  	unsigned long flags;
>>  
>>  	if (host) {
>>  		spin_lock_irqsave(&host->lock, flags);
>>  		if (state) {
>>  			dev_dbg(&dev->dev, "card inserted.\n");
>> -#ifdef CONFIG_PM_RUNTIME
>> -			clk_prepare_enable(sc->clk_io);
>> -#endif
>>  			host->flags &= ~SDHCI_DEVICE_DEAD;
>>  			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>>  		} else {
>>  			dev_dbg(&dev->dev, "card removed.\n");
>>  			host->flags |= SDHCI_DEVICE_DEAD;
>>  			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>> -#ifdef CONFIG_PM_RUNTIME
>> -			clk_disable_unprepare(sc->clk_io);
>> -#endif
>>  		}
>>  		tasklet_schedule(&host->card_tasklet);
>>  		spin_unlock_irqrestore(&host->lock, flags);
> 
> Jaehoon/Heiko, it looks this patch was itself a bug fix -- can we
> not find a way to support cd-gpios and runtime PM at the same time?
I will check with slot-gpio.c. If it's working well, i think good that sdhci-s3c use it.
Then Patch v2 3/4~4/4 can be dropped. I will send the other patch series on this week.

Best Regards,
Jaehoon Chung
> 
> Thanks,
> 
> - Chris.
> 

