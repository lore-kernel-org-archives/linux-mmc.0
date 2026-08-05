Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E862809;
	Wed,  5 Aug 2026 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892377; cv=none; b=UjPAXQ//CR0nkvPRXC2i2nWsoWpMV3lYWVGhk8xrHwHEO+ndbJgHP2cCv3ZuKaJAEEhlD1A99zfnPozj7OEVVRCQ/o/l1NI9T85Ka4zux84hhSLbHUac2eAOmPT5PRpjsrhh7+66SaWfvrCods++YDMyX+Q9NJd0VNycoy/xAh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892377; c=relaxed/simple;
	bh=6aqmHv0rn3KHDTCqwW5cC07vZM3sOrKjYjZu1YoXOu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRg+po2ZqI+zyy1Tw6OTo1d8KWYDst5LwHS062PTH6SkyiA4rfdhP40LM2un6WLBPekWYyRDiViJ8Smn+IdrYZSwJod2Cvb1FedUBMww5EzhUNFQdywuIh474G0rg6nxLU8S7rMxs4C6D9YnuwxwTzLwstsaHj/iVBeLkfFgIX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c1c91a6c906a11f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:109343fe-a58b-43d6-96e9-5eaa45aa25bf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:1207a41c0c3c31d4e2663d9e984c0ea1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c1c91a6c906a11f1aa26b74ffac11d73-20260805
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1603796922; Wed, 05 Aug 2026 09:12:41 +0800
Message-ID: <dd57c4f7-925d-4f24-a486-22223066acaa@kylinos.cn>
Date: Wed, 5 Aug 2026 09:12:39 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: via-sdmmc: Fix use-after-free in via_sd_remove due
 to race condition
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: ulfh@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <94dac731cadea4732725a83bbbe1d8fe47636694.1785807411.git.xiaopei01@kylinos.cn>
 <CAPx+jO-nfhVA2UiPxYJ5A3gzdwBmjgo4oodMhqMW0xFfPCrdTw@mail.gmail.com>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <CAPx+jO-nfhVA2UiPxYJ5A3gzdwBmjgo4oodMhqMW0xFfPCrdTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/4 21:43, Ulf Hansson 写道:
> On Tue, Aug 4, 2026 at 3:40 AM Pei Xiao <xiaopei01@kylinos.cn> wrote:
>>
>> In via_init_mmc_host, &sdhost->carddet_work is bound with
>> via_sdc_card_detect, and via_sdc_isr can schedule this work on
>> system_wq when it handles a card insertion/removal interrupt.
>>
>> If we remove the device, via_sd_remove makes cleanup and the memory
>> allocated for sdhost with devm_mmc_alloc_host() is released after the
>> remove callback returns, while the work mentioned above may still be
>> pending or running. The sequence of operations that may lead to a UAF
>> bug is as follows:
>>
>> CPU0                                      CPU1
>>
>>                                           | via_sdc_isr
>>                                           | schedule_work(&sdhost->carddet_work)
>> via_sd_remove                             |
>> mmc_remove_host(sdhost->mmc)              |
>> free_irq(pcidev->irq, sdhost)             |
>> timer_delete_sync(&sdhost->timer)         |
>> cancel_work_sync(&sdhost->finish_bh_work) |
>>                                           | via_sdc_card_detect
>>                                           | // use sdhost
>> // devm resources released after          |
>> // remove returns, sdhost is freed        |
>>                                           | // use sdhost (use-after-free)
>>
>> Fix it by canceling the work after the IRQ handler that can schedule
>> it has been stopped, and before proceeding with the remaining cleanup
>> in via_sd_remove.
>>
>> Fixes: f0bf7f61b840 ("mmc: Add new via-sdmmc host controller driver")
>> Assisted-by: Codex:deepseek-v4-flash
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> 
> I already have a patch for this in my tree, so this isn't needed. Thanks anyway!
> 
> Future wise, please make sure to base your patches again on my next
> branch in my mmc tree.
Maybe I was using the linux-next branch, and I haven't updated it for a
few days. Thank you for pointing that out.

Thanks!
Pei.
> 
> Kind regards
> Uffe
> 
> 
> 
> 
>> ---
>>  drivers/mmc/host/via-sdmmc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
>> index 8c049f8355cd..be90fc767c74 100644
>> --- a/drivers/mmc/host/via-sdmmc.c
>> +++ b/drivers/mmc/host/via-sdmmc.c
>> @@ -1199,6 +1199,8 @@ static void via_sd_remove(struct pci_dev *pcidev)
>>
>>         free_irq(pcidev->irq, sdhost);
>>
>> +       cancel_work_sync(&sdhost->carddet_work);
>> +
>>         timer_delete_sync(&sdhost->timer);
>>
>>         cancel_work_sync(&sdhost->finish_bh_work);
>> --
>> 2.25.1
>>

