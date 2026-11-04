Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=47.88.81.242
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779703;
	b=mPv2le4h4Fy484p/Pra8TDt4NpQ6uBrBpRjSykzLiq+dbk98+Ubu0+u7vRrgRFl2tI5v
	 F89L5+e9+hOgJS8sH63a4JI39/HjSyqjJBD9F2EcTJDJA/bggeW3yZaFLB4JliRfO+h6J
	 MTrZ4zmTN5x6FNfVH3DpSvTmwcBGbDJhji0Ist4sVn1+FRkIFhNHQsVociECM5AlHvbds
	 FfBeUnDhexpLvNL4X4IHvwGKJQid8XbqewE3jtIBiepI4k1tqhvcoXl4JRhbKZYdfYuVo
	 Scb+u0fQXV5mkZO++7DwP+Zn6N9wHsQjUR4xmaiKeHT5ypRy1g2ZkvCgy4r3oV7m3ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779703;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=6lrDaoLYIefaqcIrn787JgDk6gdj2N5+Qhpdebuqtk4=;
	b=MjG9NFrKHVb8iUs2XOp3XSMFegPbBqFTJUOCJ4q7TYmNY0w+dHWcUYGDvck57U8TN3+g
	 AtDPmGXRZHPRv5HNT3l8+wn3PM8bhsFjygyLq2NUdlE4FQ46Auxy7UK7DZx6kSpsN0azL
	 C1zUd+2S+JZ62o+qd801l2Pi/M8vnGtIfT7lAdL9QbWTRQqgPP4pXm8YfMk6lNaFMXWwU
	 FHfCWMt9k8JuSF8uOhJ/g2Uvb4X2fK2W9ghIwsZ2r7uuKGpE/mZGbmLp1FJdIac1Hlvtb
	 goWSRdV/5QROLy0wftGviCQF9vRuX0WpK1wF9kV9XrQnf1EehjAL6uvADaNjhycPmsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b="YLP/EzPN";
	arc=none smtp.remote-ip=47.88.81.242
Received: from mail-m81242.netease.com (mail-m81242.netease.com [47.88.81.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F1606A326;
	Wed,  4 Nov 2026 08:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB0F1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=YLP/EzPN
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 537471aba;
	Wed, 4 Nov 2026 16:08:10 +0800 (GMT+08:00)
Message-ID: <67019236-90c0-40d2-8b2b-798366c23a72@rock-chips.com>
Date: Wed, 4 Nov 2026 16:08:08 +0800
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mmc: sdhci-of-dwcmshc: Set CQHCI command idle time
 for StarFive JHB100
To: Adrian Hunter <adrian.hunter@intel.com>,
 Changhuang Liang <changhuang.liang@starfivetech.com>,
 Asutosh Das <quic_asutoshd@quicinc.com>,
 Ritesh Harjani <ritesh.list@gmail.com>, Ulf Hansson <ulfh@kernel.org>
References: <20261014121222.31385-1-changhuang.liang@starfivetech.com>
 <20261014121222.31385-3-changhuang.liang@starfivetech.com>
 <1db96e86-8f70-4b72-a2e4-a251c41fb1e3@intel.com>
 <35d05298-9e72-4b7d-bb2d-832f44725d82@rock-chips.com>
 <a811d789-713b-4c4e-9e68-402cf6c49b6d@intel.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <a811d789-713b-4c4e-9e68-402cf6c49b6d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1a599ea1503a4kunm133f948ea7a93
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSh8dVkIYSUlNSEIYS0oYGlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YLP/EzPNaEksJdsclpqxy/M6Qk2BSkxdD2yhMEGUazMw67GHQQ9GDi6fPVvtVfzgBWLdoaQH8OIeF95OqD1QixUzew9q+BUGkgVp4EBDlrLUtWf3c4E/NIHq+jczTzXmjxiZSvDOoQpeZXASIAmQcg1uWRA6xfy7a6pxJx/wIgs=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=6lrDaoLYIefaqcIrn787JgDk6gdj2N5+Qhpdebuqtk4=;
	h=date:mime-version:subject:message-id:from;

在 2026/11/04 星期三 15:29, Adrian Hunter 写道:
> On 04/11/2026 03:40, Shawn Lin wrote:
>> 在 2026/10/31 星期六 0:45, Adrian Hunter 写道:
>>> + Shawn
>>>
>>> On 14/10/2026 15:12, Changhuang Liang wrote:
>>>> Add a cqhci_host_ops for the StarFive JHB100 platform that sets the
>>>> CQHCI command idle time (CIT) to 320 ns during pre_enable.
>>>>
>>>> Setting the command idle time improves eMMC performance on this
>>>> platform. Before/after dd results:
>>>>
>>>> before:
>>>> dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
>>>> 838860800 bytes (839 MB, 800 MiB) copied, 9.38511 s, 89.4 MB/s
>>>> dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
>>>> 838860800 bytes (839 MB, 800 MiB) copied, 12.2127 s, 68.7 MB/s
>>>>
>>>> after:
>>>> dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
>>>> 838860800 bytes (839 MB, 800 MiB) copied, 3.19472 s, 263 MB/s
>>>> dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
>>>> 838860800 bytes (839 MB, 800 MiB) copied, 10.7587 s, 78.0 MB/s
>>>>
>>>> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>>>> ---
>>>>    drivers/mmc/host/sdhci-of-dwcmshc.c | 22 ++++++++++++++++++++++
>>>>    1 file changed, 22 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>> index 249055f14162..36628b44f78b 100644
>>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>> @@ -283,6 +283,8 @@
>>>>    #define PHY_DELAY_CODE_SD        0x55
>>>>    #define PHY_DELAY_CODE_SDIO        0x29
>>>>    +/* CIT for the JHB100 SoC */
>>>> +#define JHB100_CQHCI_CIT_NS    320
>>>>    struct rk35xx_priv {
>>>>        struct reset_control *reset;
>>>>        u8 txclk_tapnum;
>>>> @@ -2340,6 +2342,25 @@ static const struct sdhci_ops starfive_jhb100_ops = {
>>>>        .platform_execute_tuning = th1520_execute_tuning,
>>>>    };
>>>>    +static void dwcmshc_starfive_jhb100_pre_enable(struct mmc_host *mmc)
>>>> +{
>>>> +    struct cqhci_host *cq_host = mmc->cqe_private;
>>>> +    int ret;
>>>> +
>>>> +    ret = cqhci_set_cmd_idle_time(cq_host, JHB100_CQHCI_CIT_NS);
>>>
>>> Currently doing this from ->pre_enable() leaves a gap.  It needs:
>>>
>>> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
>>> index a466cd88b043..e1bf6d50e8eb 100644
>>> --- a/drivers/mmc/host/cqhci-core.c
>>> +++ b/drivers/mmc/host/cqhci-core.c
>>> @@ -283,6 +283,9 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>>>          cqhci_set_irqs(cq_host, 0);
>>>    +    if (cq_host->ops->pre_enable)
>>> +        cq_host->ops->pre_enable(mmc);
>>> +
>>>        cqcfg |= CQHCI_ENABLE;
>>>          cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
>>>
>>> which is probably:
>>>
>>> Fixes: 79cf71c0b177 ("mmc: sdhci-of-dwcmshc: reduce CIT for better performance")
>>>
>>> Shawn?
>>>
>>
>> The window between CQHCI_ENABLE and the first request has no queued
>> commands for the idle timer to apply to, and pre_enable() re-runs on
>> every cqe_off -> cqe_on transition (recovery, resume), so the value gets
>> rewritten even if the registers were reset in between.
> 
> Might be worth checking.
> 
> At card init, cqhci_enable() calls __cqhci_enable(), which sets mmc->cqe_on =
> true (cqhci-core.c) and never calls ->pre_enable(). cqhci_request() only calls
> ->pre_enable() when !mmc->cqe_on (cqhci-core.c). So the first request skips it,
> and so do all the requests after it. CIT is first written only after something
> runs a non-CQE command, because mmc_start_request() then calls cqe_off()
> (core.c). Examples: a CMD6 partition switch, a discard, an ioctl, or a flush
> without DCMD. Until that happens, real CQE I/O runs with the default CIT.
> 

Indeed. If Changhuang is going to configure cit in __cqhci_enable, I
could prepare a patch on top to improve it for rockchip platforms.

> For Resume: cqhci_suspend() → cqhci_deactivate() → __cqhci_disable() clears both
> cqe_on and activated. The first request after resume takes the !activated path
> into __cqhci_enable(), which sets cqe_on = true again. The !cqe_on branch is
> then skipped and ->pre_enable() is not called.
> 
> RESET_ALL: same problem. rk35xx_sdhci_reset() on SDHCI_RESET_ALL calls
> cqhci_deactivate() and also asserts the reset_control, so SSC1 is certainly back
> to its default. CIT then stays at the default after resume until the next
> cqe_off.
> 
> 

