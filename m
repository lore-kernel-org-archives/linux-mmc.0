Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEDC3A6EEE;
	Fri,  7 Aug 2026 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786123433; cv=none; b=qw4v19z93hE/gVBe8TCDtU6G7+NfDpn0nrgW+m8KQflEFwCw0WoiZOQH/9Buc0zOhJVHPOmwpXYWOc1Nk+ZTyyp81BlzPpMhf+my5qvfkE+MYhYN5tYj8gPPOnu2F1LHUsvfmoL3zhIYF9WK486XLJ2rv2mPqe+Yn6EytC1VnRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786123433; c=relaxed/simple;
	bh=+Z+rLnu80/tj5r5EvIpSKTEXh+L+IOeZ5o/UAr8GcWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EHICyRBGvU8LWiya6XtWWXczh/qBSqJiHE/ap+Z/QGb4DBwdk7Bfh09CbOjhvyAOfgcJjig8qcoOXpWyFepLqxB7NP4x+wC3X3ddyF2dj7iHA1rNHRPhJTuDFPee43N2A0e2KGbhd6faZn/LmcpQB9QzicwPbvqlFWFVktlCqWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e0dEWhp5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e0dEWhp5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786123435; x=1817659435;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=+Z+rLnu80/tj5r5EvIpSKTEXh+L+IOeZ5o/UAr8GcWw=;
  b=e0dEWhp5RsJERRqrgXoELmZcegnH/WUJyOZzy/whyuEiyW4yMzdWxyjZ
   YHz5G/FGAN6a4RVeMtVqO/LFRGmcsmWXKNs6maiNyKygxNTg4rtv+FwMn
   yvwXuWU1mgdDFjc9h6Vc8B3U6mbrpmJMUXoeAAVJldTcPI1M65DNSOQHY
   uKnOjtbwvNqU+wcL1rl/U9BWZ8Cb75NSu79V5h5f6y4o+ZZB6dvR+zctX
   RuW+7UMYEemVyGlWLpnwtR6yUwrgi8NF2dU/T0opOMC/fIkN+Qz2l3r42
   kTUQniu1YospPHLoYrtFroFakFuhUM57l243rwHBSWlAMG1uLI3IzNpv9
   Q==;
X-CSE-ConnectionGUID: 0/cx6JZQTNWmZ46ra+BWzw==
X-CSE-MsgGUID: AzOXgBViRLyVa7zLfFgNlQ==
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="61825255"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 10:23:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Fri, 7 Aug 2026 10:23:42 -0700
Received: from [10.171.248.73] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 7 Aug 2026 10:23:40 -0700
Message-ID: <e4960897-fe77-41c2-95c6-56038b7c9ba2@microchip.com>
Date: Fri, 7 Aug 2026 19:23:39 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: atmel-mci: Fix use-after-free in atmci_remove due to
 race condition
To: Pei Xiao <xiaopei01@kylinos.cn>, <ulfh@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-mmc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <4389d5deff90b2b860bd07f17668270fda36bd26.1785750407.git.xiaopei01@kylinos.cn>
Content-Language: en-US, fr
From: Aubin Constans <aubin.constans@microchip.com>
In-Reply-To: <4389d5deff90b2b860bd07f17668270fda36bd26.1785750407.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 03/08/2026 11:48, Pei Xiao wrote:

 > In atmci_probe, &host->bh_work is bound with atmci_work_func, and> atmci_interrupt, atmci_timeout_timer and atmci_dma_complete can all
> queue this work on system_bh_wq.
> 
> If we remove the module, atmci_remove makes cleanup and the memory
> allocated for host with devm_kzalloc() is released after the remove
> callback returns, while the work mentioned above may still be pending
> or running. The sequence of operations that may lead to a UAF bug is
> as follows:

Thank you for having spotted the issue, and sent this fix.
  >
> CPU0                                      CPU1
> 
>                                            | atmci_interrupt
>                                            | queue_work(system_bh_wq,
>                                            |            &host->bh_work)
> atmci_remove                              |
> atmci_cleanup_slot(...)                   |
> atmci_writel(host, ATMCI_IDR, ~0UL)       |
> timer_delete_sync(&host->timer)           |
> dma_release_channel(host->dma.chan)       |
> free_irq(platform_get_irq(pdev, 0), host) |
>                                            | atmci_work_func
>                                            | // use host
> // devm resources released after          |
> // remove returns, host is freed          |
>                                            | // use host (use-after-free)
> 
> Fix it by canceling the work after all the sources that can schedule
> it (IRQ handler, timeout timer and DMA completion callback) have been
> stopped, and before proceeding with the remaining cleanup in
> atmci_remove.

For completeness, PDC completion could be added to the above list of sources,
even though it is a subroutine of the IRQ handler.
PDC and DMA are exclusive.

Mentioning on which board or MPU the patch was tested would also be a welcome
addition.

> 
> Fixes: 7d2be0749a59 ("atmel-mci: Driver for Atmel on-chip MMC controllers")
> Assisted-by: Codex:deepseek-v4-flash
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>   drivers/mmc/host/atmel-mci.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 3b4928f5b9b2..8f4df250a77a 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2610,6 +2610,8 @@ static void atmci_remove(struct platform_device *pdev)
> 
>          free_irq(platform_get_irq(pdev, 0), host);
> 
> +       cancel_work_sync(&host->bh_work);
> +
>          clk_disable_unprepare(host->mck);
> 
>          pm_runtime_disable(dev);
> --
> 2.25.1
> 

