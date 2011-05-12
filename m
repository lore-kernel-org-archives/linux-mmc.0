From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] dw_mmc: fixed wrong regulator_enable in suspend/resume
Date: Thu, 12 May 2011 12:01:47 +0900
Message-ID: <4DCB4D9B.8050706@samsung.com>
References: <4DCA3237.3080609@samsung.com> <m3pqnp2vvl.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:31573 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379Ab1ELDBk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 May 2011 23:01:40 -0400
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LL200B5CB1CDBE0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 12 May 2011 12:01:39 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LL200INDB2RR1@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 12 May 2011 12:01:39 +0900 (KST)
In-reply-to: <m3pqnp2vvl.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>

Hi Chris..

I think you're confused something because my explanation.

My means..if we use the regulator, regulator is enabled when probing.
Then regulator is enabling until we don't disable..

In order to power-save, disabled the regulator when entered suspend.
Already in suspend function, located "regulator_disable()".
but also located "regulator_enable()" in suspend function.

So i think right that "regulator_enable()" is located in resume function.
not in suspend function.

Regards,
Jaehoon Chung

Chris Ball wrote:
> Hi,
> 
> On Wed, May 11 2011, Jaehoon Chung wrote:
>> In suspend function, regulator_enable() need not.
>> regulator_enable() should be locate in resume function.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 87e1f57..66dcddb 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1769,9 +1769,6 @@ static int dw_mci_suspend(struct platform_device *pdev, pm_message_t mesg)
>>  	int i, ret;
>>  	struct dw_mci *host = platform_get_drvdata(pdev);
>>  
>> -	if (host->vmmc)
>> -		regulator_enable(host->vmmc);
>> -
>>  	for (i = 0; i < host->num_slots; i++) {
>>  		struct dw_mci_slot *slot = host->slot[i];
>>  		if (!slot)
>> @@ -1798,6 +1795,9 @@ static int dw_mci_resume(struct platform_device *pdev)
>>  	int i, ret;
>>  	struct dw_mci *host = platform_get_drvdata(pdev);
>>  
>> +	if (host->vmmc)
>> +		regulator_enable(host->vmmc);
>> +
>>  	if (host->dma_ops->init)
>>  		host->dma_ops->init(host);
>>  
>>
> 
> Should the regulator be being disabled in the suspend function, then?
> 
> - Chris.

