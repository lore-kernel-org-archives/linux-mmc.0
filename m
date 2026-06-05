Received: from mail-m32105.qiye.163.com (mail-m32105.qiye.163.com [220.197.32.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1560D3BBFBC
	for <linux-mmc@vger.kernel.org>; Fri,  5 Jun 2026 03:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780629671; cv=none; b=RerZHCp62V9y+z63JHzR6Wic3DnDOXzpu2IL3S7aaWXEEJzyWETpXnq+VJOLMJt0Or6rdJ0SB3Y0aGoyv5Xbhnzdr8fMUGf/b1YvzwmvrBI0YCqh6X0RJJ2dIUJe+sDreixxl2MXnKyIKN6GJEgENJG/1aG2sfR151/OTBTjR9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780629671; c=relaxed/simple;
	bh=uF1A+heyTIsCsB9/+RFdDS426CWfEn+SvXD5Vz+dCVM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hku+f6tsLHSkqMxDknyO5Nk6b0Ndjk1NPceMi3PisTDZrKIJZBFDU+Nt9wiqRrUSZCz2yIpEmLyOCRKGmRmp6BKqe5ep3mMgtW8Gz0nHuxxh5gGbb3tupkeZc4J5RPTCSbBmtUPclldgVrdYK+WEaUu59Rnm6tphBmKrMuZFZ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=E+72MoZS; arc=none smtp.client-ip=220.197.32.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="E+72MoZS"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 412b6a92e;
	Fri, 5 Jun 2026 11:15:49 +0800 (GMT+08:00)
Message-ID: <81954a17-97ab-4ef8-83cb-e9456a2f1d01@rock-chips.com>
Date: Fri, 5 Jun 2026 11:15:48 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>,
 Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: dw_mmc: stop and complete DMA also in
 STATE_DATA_BUSY state
To: Marek Szyprowski <m.szyprowski@samsung.com>
References: <CGME20260603083946eucas1p278014c7fb89fb7764abc7b0904d15e71@eucas1p2.samsung.com>
 <20260603083935.3201411-1-m.szyprowski@samsung.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260603083935.3201411-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e95c7a4e803a4kunm83bd51b069c19
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDShlDVh1KTkIZQ01LShgdSFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=E+72MoZS7Ehdj/hdn+Q94wMy8x5Z1ktAmxn3FFInILrm81Gjb9CBBZwECNM0Fu3def1JGsUnaduKMyWqyjvDm9wpgd7jur0A9Qa7fpfII3Yk51T/A3Uy0NWXbNWIdnjCOmtW0i376bNQV0DZl2uT41v+b5a9Q4OP+iv4I9Gscok=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=mGJcVBc1Uh5zK0PjDpU4Q+EstYvX/MtzFBEEW0mnLoo=;
	h=date:mime-version:subject:message-id:from;

在 2026/06/03 星期三 16:39, Marek Szyprowski 写道:
> When transfer was stopped in STATE_DATA_BUSY state, there was no call to
> dma_ops->cleanup function, so the DMA mapped buffer was never properly
> unmapped. Fix this by calling dw_mci_stop_dma() function also in that
> state to ensure proper cleanup call when DMA transfer was used.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/mmc/host/dw_mmc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index d734d010444d..cf5cecc5491d 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2057,6 +2057,7 @@ static void dw_mci_work_func(struct work_struct *t)
>   			}
>   
>   			dw_mci_stop_fault_timer(host);
> +			dw_mci_stop_dma(host);
>   			host->data = NULL;
>   			set_bit(EVENT_DATA_COMPLETE, &host->completed_events);
>   			err = dw_mci_data_complete(host, data);

