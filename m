Received: from mail-m49223.qiye.163.com (mail-m49223.qiye.163.com [45.254.49.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F84F3A7F64;
	Wed, 15 Jul 2026 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784082751; cv=none; b=ZuJpwuBoVsoDOO+Ma03uP8cL1pVAMVQSvXiiKkdwA8+6eR/HYU0R68lg7C4O4LKzLQBqodWOWNF6vY0Wc6lAm1oLeWFYFujXPPVySxVMECR25RvcLZjgnLbF0smm4YNTrJIUYwfAi6yZ0wnjOKRpTAdJDK18pe8S4pEpVeheFe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784082751; c=relaxed/simple;
	bh=FlJmCWM6Xdt8uKWJ3UiLjhgLO474hgPIYzwgQWU04vg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EM9PJ2kr9xVj8Ags9zuSwo+tNN4WRiSyZo92QphPLPP3XDNnOQuty47Ay7qvrmwfAUot+GKO8hQkjPolCCzuMQsnaNCVbcob9QjMEnXfuytZxXQSvBTHBwxJeOY+Eybn2XWZcsVCyOHNJFgvdxaVcj04Wae2llGxrnPHzFcBhrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=N7wrJUvl; arc=none smtp.client-ip=45.254.49.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="N7wrJUvl"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 46357c29a;
	Wed, 15 Jul 2026 10:16:54 +0800 (GMT+08:00)
Message-ID: <29b8489c-3a0b-4e9d-a6f6-0400e7d00103@rock-chips.com>
Date: Wed, 15 Jul 2026 10:16:53 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: dw_mmc: move declaration of dw_mci_pmops
To: Ben Dooks <ben.dooks@codethink.co.uk>, Ulf Hansson <ulfh@kernel.org>
References: <20260710161254.569883-1-ben.dooks@codethink.co.uk>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260710161254.569883-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f639011d903a4kunm7bd851d34a493
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTh8aVkhCS0weTEhJTEkfTVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=N7wrJUvlP6W6pqGD4E2gPebo3ahqyrWuYxwjQ9m9Ie5nLMKSO/P2UlalhP8dPjUOAOpqL9RzTHt3RasPg+FX6m4kiIH8IekYRzQphIXX4aPIlNZu8t4PMj+bZvBDMtRnYjQ7p/7CsLWRYY9BWzRiqb4MiRBvlkESl7NuYhvM7GU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=NoVM5r8D/RSA21CSNws4J4aK0M4c+MRH26JgYcSIpJk=;
	h=date:mime-version:subject:message-id:from;

在 2026/07/11 星期六 0:12, Ben Dooks 写道:
> The dw_mci_pmops is exported out of dw_mmc.c so move the declaration of
> ton dw_mmc.h from dw_mmc-pltfm.h to fix the following sparse warning:
> 
> drivers/mmc/host/dw_mmc.c:3512:25: warning: symbol 'dw_mci_pmops' was not declared. Should it be static?
> 

Sorry for late response, this looks good to me,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>


> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> v2:
>    - changed to moving the definition and re-worded commit
> ---
>   drivers/mmc/host/dw_mmc-pltfm.h | 1 -
>   drivers/mmc/host/dw_mmc.h       | 2 ++
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.h b/drivers/mmc/host/dw_mmc-pltfm.h
> index ef1b05d484c3..f3193662abf1 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.h
> +++ b/drivers/mmc/host/dw_mmc-pltfm.h
> @@ -11,6 +11,5 @@
>   extern int dw_mci_pltfm_register(struct platform_device *pdev,
>   				const struct dw_mci_drv_data *drv_data);
>   extern void dw_mci_pltfm_remove(struct platform_device *pdev);
> -extern const struct dev_pm_ops dw_mci_pmops;
>   
>   #endif /* _DW_MMC_PLTFM_H_ */
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 9ffcd3946cff..38610c89d54a 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -19,6 +19,8 @@
>   #include <linux/interrupt.h>
>   #include <linux/workqueue.h>
>   
> +extern const struct dev_pm_ops dw_mci_pmops;
> +
>   enum dw_mci_state {
>   	STATE_IDLE = 0,
>   	STATE_SENDING_CMD,

