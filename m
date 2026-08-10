Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367E45695;
	Mon, 10 Aug 2026 01:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786323658; cv=none; b=d17oNz8HlNMmJIjQ54ZUsVoJCpXkpEyCARkqeu8OU9W9Zx1RGlmen5UlPn2p0nMqcUfp+d2N9RhmD7QGRvz690yMOla0QVODZ46L9QOzKulm0ivW/pOJkjuO9Z6thteTFwWn2e5sDxklsID9ZaEKGBgISFQxNeAvUp+bqmZaNPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786323658; c=relaxed/simple;
	bh=DgW71cJmCV5xFGLedMaWYcCmsfNj81ysm0gAjiqEH0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=utVdQFekt1HCsn2A/JgLqeHWPQEBz7SG/ZyYLGo7NHKsfXf+3dw9S5JV55P1HkGIov4/pMFw3zxvbzq/AQVD8DohUXJDLmkG/NISA+Q67snpFBCtKcXh0qCQv5f2ipju0xHPfdtXSYNMY8sS9pnzizuqeMw7Lt6CdXnZI12mC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ea58cce4945611f1aa26b74ffac11d73-20260810
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f71462ab-abc3-4110-b015-ca616d577845,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:6fd1508fc49c735f6f7edf5eb54f382b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ea58cce4945611f1aa26b74ffac11d73-20260810
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 944241646; Mon, 10 Aug 2026 09:00:44 +0800
Message-ID: <14a274fe-b414-4360-bc88-757a04a020e5@kylinos.cn>
Date: Mon, 10 Aug 2026 09:00:41 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: atmel-mci: Fix use-after-free in atmci_remove due to
 race condition
To: Aubin Constans <aubin.constans@microchip.com>, ulfh@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <4389d5deff90b2b860bd07f17668270fda36bd26.1785750407.git.xiaopei01@kylinos.cn>
 <e4960897-fe77-41c2-95c6-56038b7c9ba2@microchip.com>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <e4960897-fe77-41c2-95c6-56038b7c9ba2@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/8 01:23, Aubin Constans 写道:
> On 03/08/2026 11:48, Pei Xiao wrote:
> 
>> In atmci_probe, &host->bh_work is bound with atmci_work_func, and>
> atmci_interrupt, atmci_timeout_timer and atmci_dma_complete can all
>> queue this work on system_bh_wq.
>>
>> If we remove the module, atmci_remove makes cleanup and the memory
>> allocated for host with devm_kzalloc() is released after the remove
>> callback returns, while the work mentioned above may still be pending
>> or running. The sequence of operations that may lead to a UAF bug is
>> as follows:
> 
> Thank you for having spotted the issue, and sent this fix.
>  >
>> CPU0                                      CPU1
>>
>>                                            | atmci_interrupt
>>                                            | queue_work(system_bh_wq,
>>                                            |            &host->bh_work)
>> atmci_remove                              |
>> atmci_cleanup_slot(...)                   |
>> atmci_writel(host, ATMCI_IDR, ~0UL)       |
>> timer_delete_sync(&host->timer)           |
>> dma_release_channel(host->dma.chan)       |
>> free_irq(platform_get_irq(pdev, 0), host) |
>>                                            | atmci_work_func
>>                                            | // use host
>> // devm resources released after          |
>> // remove returns, host is freed          |
>>                                            | // use host (use-after-free)
>>
>> Fix it by canceling the work after all the sources that can schedule
>> it (IRQ handler, timeout timer and DMA completion callback) have been
>> stopped, and before proceeding with the remaining cleanup in
>> atmci_remove.
> 
> For completeness, PDC completion could be added to the above list of
> sources,
> even though it is a subroutine of the IRQ handler.
Yes.I used an IRQ handler instead here.
> PDC and DMA are exclusive.

> 
> Mentioning on which board or MPU the patch was tested would also be a
> welcome
> addition.
Sorry, I don't have hardware testing here; I found this issue through
static analysis.

Thanks!
Pei.
> 
>>
>> Fixes: 7d2be0749a59 ("atmel-mci: Driver for Atmel on-chip MMC
>> controllers")
>> Assisted-by: Codex:deepseek-v4-flash
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>> ---
>>   drivers/mmc/host/atmel-mci.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
>> index 3b4928f5b9b2..8f4df250a77a 100644
>> --- a/drivers/mmc/host/atmel-mci.c
>> +++ b/drivers/mmc/host/atmel-mci.c
>> @@ -2610,6 +2610,8 @@ static void atmci_remove(struct platform_device
>> *pdev)
>>
>>          free_irq(platform_get_irq(pdev, 0), host);
>>
>> +       cancel_work_sync(&host->bh_work);
>> +
>>          clk_disable_unprepare(host->mck);
>>
>>          pm_runtime_disable(dev);
>> -- 
>> 2.25.1
>>

