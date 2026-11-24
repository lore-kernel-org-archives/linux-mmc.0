Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.209.128.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795484724;
	b=nTPncjjr7xRzWqvlXrJp88g/sTqPnsorc7K2MBwtc4/oPpavHz8nHoQ8VJVUl2iGa7S1
	 /xSS6z69Xs+R8c5ynPGgWQy+jbCPtHg2zj/JyLCkAC2dFepdV++7GWxK5LBk6dNRe3lG/
	 Zs8sIpoZGFlqsbF6PzRGYoXRf090VlE+AR5nG7qS8D6ScQKndWejgzvW2RpDOeXumdUJT
	 LvqhB5FByjTkJmEsHGnWZdm5ifcQWMjBJFrNRwxK4vEudW9JuuspRRWHQeYYgSyaVbHq1
	 UqV9ZoNUVWcaHxAyiUuz1me9WFcoMWySAELWwNtnL1UOwDpWJaIgHAk3aGG6vN+nPtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795484724;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=v+ihHmChNOMgWqBYSOTa89ELTpW5J6c076NhAgKtKg0=;
	b=Hg6QNgjHUO6amXH4gz4XdGi74xihDdRRqZ2wdYNU9/cVglcImgHLtlXkYVjrS/zA9FWG
	 ywFdLH4yTEsw8FGPCeZ5U98UPcMHVH/NYiDtQsJRNRpFx/6i8gsQJ3cM+76kApdy2tsEW
	 H5QPrFcyKd1dwBVOKg4B2z+Hz+c1bpDLtXsQSV1+7NkgHZ4iex6Cyv+suZlI13iypEHrn
	 3IaOYPWbxf+42+xtKYsm96eIUPQTCtMowBLd2K+7yr2p17D7rA70GrwugGYbkkMouGPEC
	 ya3x2wDGeAorNEcDlGjcDuim3hODxvdknHGcNZz6BIRa1WP9vr2ZUn6Ebi5cBKdH3jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=MxgVftIU;
	arc=none smtp.remote-ip=103.209.128.87
Received: from mail-m12887.netease.com (mail-m12887.netease.com [103.209.128.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32D4606A321;
	Tue, 24 Nov 2026 01:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E32D4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=MxgVftIU
Received: from [172.16.12.48] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 55bcaafbc;
	Tue, 24 Nov 2026 09:45:11 +0800 (GMT+08:00)
Message-ID: <55ccec4a-0f33-4332-a70f-000b2cde351f@rock-chips.com>
Date: Tue, 24 Nov 2026 09:45:08 +0800
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
Cc: shawn.lin@rock-chips.com
Subject: Re: [PATCH 11/13] mmc: dw_mmc: Disarm central watchdog when ending a
 request
To: Lee Jones <lee@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261123191703.179283-1-lee@kernel.org>
 <20261123191703.179283-12-lee@kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261123191703.179283-12-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa20b3a7ac703a4kunm4230d1b68bcb36
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGk1MS1YfS09PTk4dSU
	5KHkxWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=MxgVftIUBZS4/4sM8Ar3fmD9BIfLMzNZ9wWDgUx6KAvFukD7oIDmhyKqTMHssXPslJrv4gFcH3JBdUUwQzpkN3cJMB0cTIfkQB9fV8PTg22OultK/WNPk0kzZmLOw5Q3n0Qk8g48Cq7nAi2W07DliT8Jt0EZ38VbQE8MI5SEWlU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=v+ihHmChNOMgWqBYSOTa89ELTpW5J6c076NhAgKtKg0=;
	h=date:mime-version:subject:message-id:from;

Hi

在 2026/11/24 星期二 3:15, Lee Jones 写道:
> When EVENT_DATA_ERROR (such as SDMMC_INT_DCRC or SDMMC_INT_SBE) is
> handled in STATE_SENDING_DATA, send_stop_abort() starts a stop command
> and arms host->wd_timer for DW_MCI_WD_CMD_EVENTS.  In STATE_DATA_BUSY,
> dw_mci_data_complete() resets the controller on data error, aborting the
> in-flight stop command, and dw_mci_work_func() ends the request via
> dw_mci_request_end() if EVENT_CMD_COMPLETE is not already pending.
> 

Sure, it's a bug for send_stop_abort() case. The dw_mmc state machine
is so complicated and prone to error... This fix looks clean and
minimal,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Because dw_mci_request_end() does not disarm host->wd_timer, the stale
> command watch remains armed after mmc_request_done() and later injects a
> spurious SDMMC_INT_RTO and EVENT_CMD_COMPLETE while idle or during a
> subsequent recovery command (for example MMC_GO_IDLE_STATE, which does
> not re-arm the command watchdog).
> 
> Disarm the central watchdog under host->irq_lock when transitioning to
> STATE_IDLE in dw_mci_request_end(), and clear wd_states and
> wd_deadline_ns alongside wd_events when disarming in
> dw_mci_wd_deliver().
> 
> Fixes: ce0043b9a302 ("mmc: dw_mmc: add central watchdog and convert CTO onto it")
> Closes: https://sashiko.dev/#/bug/linux-d7e53c20-ef39-494b-bb97-b00b62186c2f
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/mmc/host/dw_mmc.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ff0b25d287a9..6865cffad51a 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -79,8 +79,11 @@
>   static void dw_mci_wd_deliver(struct dw_mci *host, unsigned long events)
>   {
>   	host->wd_events &= ~events;
> -	if (!host->wd_events)
> +	if (!host->wd_events) {
> +		host->wd_states = 0;
> +		host->wd_deadline_ns = 0;
>   		hrtimer_try_to_cancel(&host->wd_timer);
> +	}
>   }
>   
>   /*
> @@ -1887,15 +1890,20 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
>   	__acquires(&host->lock)
>   {
>   	struct mmc_host	*prev_mmc = host->mmc;
> +	unsigned long irqflags;
>   
>   	WARN_ON(host->cmd || host->data);
>   
>   	host->mrq = NULL;
>   
> -	if (host->state == STATE_SENDING_CMD11)
> +	if (host->state == STATE_SENDING_CMD11) {
>   		host->state = STATE_WAITING_CMD11_DONE;
> -	else
> +	} else {
> +		spin_lock_irqsave(&host->irq_lock, irqflags);
> +		dw_mci_wd_deliver(host, ~0UL);
> +		spin_unlock_irqrestore(&host->irq_lock, irqflags);
>   		host->state = STATE_IDLE;
> +	}
>   
>   	spin_unlock(&host->lock);
>   	mmc_request_done(prev_mmc, mrq);

