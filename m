Received: from mail-m32115.qiye.163.com (mail-m32115.qiye.163.com [220.197.32.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0BC2F361B
	for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2025 00:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764118272; cv=none; b=FxzlQzUmSMqG/qYtqyCi8MRCy1yqnbIJbFy942mRI6VSxnXaICM5d0bo1EzOeqELFkFMixQMNiFogKSRciJl+NN/YJvcq/3qhiF/Akoo2cEOaknV0ANW9b8laDpBpvg7rrEVXTVEHaLbUM5dpOkzk7h72W11+37cCPVSTQ0sFek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764118272; c=relaxed/simple;
	bh=TP9KUTd3Y46P75KFW3KLhfpIKyefyiOwq9PDMc0FJG0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XWICA8xqvjhZNLItMuonDfSVKNuns/N4KV9OLEibzH89XyfypDTikxL+tJ+tPaAyYyVouoiNKzEmtFgyIJsPjGMst8Byr3ni5z1GV7qDDmH/PN1L8sYp78HW6J9l7j+fbKJZfNm1NVWv69UOracFjDrkIfjHSb51V/3pTlxUUoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=MunjuvEo; arc=none smtp.client-ip=220.197.32.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="MunjuvEo"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ae2864cd;
	Wed, 26 Nov 2025 07:35:32 +0800 (GMT+08:00)
Message-ID: <ac6e55f4-faa6-4c41-a141-976fe0b15507@rock-chips.com>
Date: Wed, 26 Nov 2025 07:35:29 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org,
 linux-mmc@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-dwcmshc: reduce CIT for better
 performance
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <1762933460-204066-1-git-send-email-shawn.lin@rock-chips.com>
 <1762933460-204066-2-git-send-email-shawn.lin@rock-chips.com>
 <7b05327d-fc76-471e-9148-3dfc0cd17623@rock-chips.com>
 <CAPDyKFrx_5cnyFeLRhoia2aHK9Cxo+fp_kKhyQ526xE02_+vSA@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPDyKFrx_5cnyFeLRhoia2aHK9Cxo+fp_kKhyQ526xE02_+vSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9abd5f52fe09cckunmf13488f44d8cf7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUJOQlZLHRgZSh8YHxkfH0xWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=MunjuvEo0wMP3WyIy2lDC+tzeWxHZrTG2ZQO3a6ttnyC2xRrZS1oNf9M++wXlUbPnaOfl/hdV/z2sM7//4vwZnGearFIdY9kZk4RqgKZnjndJtZBDWNXU5/5vCWC5SBUTfZ5WNFWkxBG+IFH5C03xP9YB6xEhbCsyVfeKipt4Zo=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=1fMDqlNLtATTA3YPhw1Ncna3hJAtBCXlyyomumBazcY=;
	h=date:mime-version:subject:message-id:from;



在 2025/11/26 星期三 0:02, Ulf Hansson 写道:
> On Tue, 25 Nov 2025 at 14:58, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> 在 2025/11/12 星期三 15:44, Shawn Lin 写道:
>>> CQHCI_SSC1.CIT indicates to the CQE the polling period to use for
>>> periodic SEND_QUEUE_STATUS (CMD13) polling. Some eMMCs have only one
>>> hardware queue, and CMD13 can only query one slot at a time for data
>>> transmission, which cannot be processed in parallel. Modifying the
>>> CMD13 query interval can increase the query frequency and improve
>>> random write performance.
>>>
>>
>> Ping...
>>
>> Adrain acked these two patches, so will them be candidates for 6.19
>> given the merge windows is coming soon?
> 
> Looks like I simply failed to see them. Possibly because there was
> cover-letter, which makes it harder for me to follow all the different
> series.
> 
> Anyway, I tried to apply them, but there are conflicts that I am not
> sure I can resolve easily by myself. Would you mind doing a re-base
> and post a new version, then I can apply them asap.
> 

Thanks Ulf. I just did a rebase on top of linux-next and posted a new
version[1].

[1] 
https://lore.kernel.org/all/1764113200-237279-1-git-send-email-shawn.lin@rock-chips.com/


> Kind regards
> Uffe
> 
>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>> ---
>>>
>>>    drivers/mmc/host/cqhci.h            | 1 +
>>>    drivers/mmc/host/sdhci-of-dwcmshc.c | 5 +++++
>>>    2 files changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
>>> index ce189a1..3668856 100644
>>> --- a/drivers/mmc/host/cqhci.h
>>> +++ b/drivers/mmc/host/cqhci.h
>>> @@ -93,6 +93,7 @@
>>>    /* send status config 1 */
>>>    #define CQHCI_SSC1                  0x40
>>>    #define CQHCI_SSC1_CBC_MASK         GENMASK(19, 16)
>>> +#define CQHCI_SSC1_CIT_MASK          GENMASK(15, 0)
>>>
>>>    /* send status config 2 */
>>>    #define CQHCI_SSC2                  0x44
>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> index e276a4e..cad5165 100644
>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> @@ -631,6 +631,11 @@ static void rk35xx_sdhci_cqe_pre_enable(struct mmc_host *mmc)
>>>        struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
>>>        u32 reg;
>>>
>>> +     /* Set Send Status Command Idle Timer to 10.66us (256 * 1 / 24) */
>>> +     reg = sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_SSC1);
>>> +     reg = (reg & ~CQHCI_SSC1_CIT_MASK) | 0x0100;
>>> +     sdhci_writel(host, reg, dwc_priv->vendor_specific_area2 + CQHCI_SSC1);
>>> +
>>>        reg = sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
>>>        reg |= CQHCI_ENABLE;
>>>        sdhci_writel(host, reg, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
>>
> 

