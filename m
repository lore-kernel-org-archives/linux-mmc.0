From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] dw_mmc: fixed regulator control
Date: Mon, 02 May 2011 16:53:34 +0900
Message-ID: <4DBE62FE.6020402@samsung.com>
References: <4DBA90BD.8070804@samsung.com> <m3iptv2027.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:46023 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540Ab1EBHxg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 May 2011 03:53:36 -0400
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LKK005FZ5VTTTI0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 02 May 2011 16:53:34 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LKK008695XAQE@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 02 May 2011 16:53:34 +0900 (KST)
In-reply-to: <m3iptv2027.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>

Hi Chris..

Thanks for comments...
I think that could confuse that message when didn't set CONFIG_REGULATOR.

And i wonder how do you think about regulator control in suspend (dw_mmc.c)?

@@ -1769,9 +1771,6 @@ static int dw_mci_suspend(struct platform_device *pdev, pm_message_t mesg)
 	int i, ret;
 	struct dw_mci *host = platform_get_drvdata(pdev);
 
-	if (host->vmmc)
-		regulator_enable(host->vmmc);
-
 	for (i = 0; i < host->num_slots; i++) {
 		struct dw_mci_slot *slot = host->slot[i];
 		if (!slot)
@@ -1798,6 +1797,9 @@ static int dw_mci_resume(struct platform_device *pdev)
 	int i, ret;
 	struct dw_mci *host = platform_get_drvdata(pdev);
 
+	if (host->vmmc)
+		regulator_enable(host->vmmc);
+
 	if (host->dma_ops->init)
 		host->dma_ops->init(host);

Regards,
Jaehoon Chung

Chris Ball wrote:
> Hi Jaehoon,
> 
> On Fri, Apr 29 2011, Jaehoon Chung wrote:
>> This patch fixed regulator control in dw_mmc.c
>> If we didn't set CONFIG_REGULATOR, always entered error condition.
>> But that's not error..because we didn't use regulator framework.
>>
>> So when we only used CONFIG_REGULATOR, i think that need to get regulator.
> [..]
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 87e1f57..62b900f 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1441,12 +1441,14 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>  	}
>>  #endif /* CONFIG_MMC_DW_IDMAC */
>>  
>> +#ifdef CONFIG_REGULATOR
>>  	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
>>  	if (IS_ERR(host->vmmc)) {
>>  		printk(KERN_INFO "%s: no vmmc regulator found\n", mmc_hostname(mmc));
>>  		host->vmmc = NULL;
>>  	} else
>>  		regulator_enable(host->vmmc);
>> +#endif /* CONFIG_REGULATOR */
>>  
>>  	if (dw_mci_get_cd(mmc))
>>  		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
> [..]
> 
> As Lars pointed out, this doesn't make sense; without CONFIG_REGULATOR
> host->vmmc becomes NULL, which isn't IS_ERR.
> 
> - Chris.

