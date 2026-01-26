Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92293385AB
	for <linux-mmc@vger.kernel.org>; Mon, 26 Jan 2026 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435209; cv=none; b=dGJkthT/loB1Y2vsaQq7ZMjSTA8JwG5IOtLJhYUbZaUrJBSyyDp9oGmd4F+V+K3wQuaAIROEQXkV2xVVX6WPr8ZY7csr9GPOiDqzSmNJ/iEdH8X1vUh6YRB5o5Wz3RUQCWZWJFraeNyC9zglwivn9xiraiHbxnIo9DbKIMSjRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435209; c=relaxed/simple;
	bh=okwKjC7Em3EYOfYOdh6/p5CVNTSGLkwx89KABod1E1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=THfcHOh+2jPzfS+PNFysjVOcvXXh8RaghcXO2aBryoLGtJ+7laeiOmkDWT7PBaN7sKTIjOf/leh+hlOxKZ56dc+ZhGVnHHv/UFJ/THm/CKSk1yikv00VDtaxF/FnpNOad4SIA0HPf/dhIzDPwdRkHvOFsd8GEOv3GOBV6vFFE8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J1q6K7W2; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J1q6K7W2"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260126134644euoutp02225f0b556fc61dcba1fbfc4b1597db45~OS-Gmfo0v1119511195euoutp023
	for <linux-mmc@vger.kernel.org>; Mon, 26 Jan 2026 13:46:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260126134644euoutp02225f0b556fc61dcba1fbfc4b1597db45~OS-Gmfo0v1119511195euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769435204;
	bh=oNQwt/1mL7+62hCmmri65Bhp9q25KbUAw7UrkSO3pgw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=J1q6K7W21RmESamaNMP5SbxKQG9VYg1uRLazlbWp/aBbr4lo1YQHREafKsPVdCVBb
	 Mm0cGGwQIvN4sZfxR+bN01fpBAVq2jp/czA0soEDhkC8PGKEmnSEgmTglNgiQXG4lY
	 TxT36nGH9f2dAzYG8faYjJrUVu+IXZKBcr+4h3TM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260126134644eucas1p24159a71515c695fe07ba3e682c549f34~OS-GR6G332588025880eucas1p26;
	Mon, 26 Jan 2026 13:46:44 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260126134644eusmtip18a9b20121825ac2c9696d06395acac44~OS-GDylgA1212312123eusmtip1P;
	Mon, 26 Jan 2026 13:46:44 +0000 (GMT)
Message-ID: <7ac71d27-2170-416f-ba09-c2b1959aec2d@samsung.com>
Date: Mon, 26 Jan 2026 14:46:43 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2 18/18] mmc: dw_mmc: Implement Host Software Queue
 support
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <1767665829-183001-19-git-send-email-shawn.lin@rock-chips.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260126134644eucas1p24159a71515c695fe07ba3e682c549f34
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260126134644eucas1p24159a71515c695fe07ba3e682c549f34
X-EPHeader: CA
X-CMS-RootMailID: 20260126134644eucas1p24159a71515c695fe07ba3e682c549f34
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
	<1767665829-183001-19-git-send-email-shawn.lin@rock-chips.com>
	<CGME20260126134644eucas1p24159a71515c695fe07ba3e682c549f34@eucas1p2.samsung.com>

On 06.01.2026 03:17, Shawn Lin wrote:
> Per tests done by different TF cards under 200MHz in HS200 mode,
> the average random read/write is improved by 10% and 7% respectively,
> while no obvious improvement for sequential read and write.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

This patch landed in linux-next as commit f7bdff5900e6 ("mmc: dw_mmc: 
Implement Host Software Queue support"). In my of tests on next-20260123 
with commit 9157b7f91ed6 reverted (see 
https://lore.kernel.org/all/55a29373-fe1f-4628-9e0e-e1ade3a64edd@samsung.com/ 
), I found that it sometimes causes the NULL pointer dereference on 
Samsung Exynos3250 based Rinato board:

Unable to handle kernel NULL pointer dereference at virtual address 
00000048 when read
[00000048] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
usbcore: registered new interface driver usbhid
Modules linked in:
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 
6.19.0-rc6-next-20260123-00001-g8b237eeed4ae #16414 PREEMPT
dwmmc_exynos 12520000.mmc: Unexpected interrupt latency
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue:  0x0 (events)
PC is at __lock_acquire+0x44/0x29ec
...
Call trace:
  __lock_acquire from lock_acquire+0x134/0x39c
  lock_acquire from _raw_spin_lock_irqsave+0x4c/0x68
  _raw_spin_lock_irqsave from mmc_hsq_finalize_request+0x1c/0x124
  mmc_hsq_finalize_request from dw_mci_request_end+0x64/0x94
  dw_mci_request_end from dw_mci_work_func+0x328/0x424
  dw_mci_work_func from process_one_work+0x24c/0x70c
  process_one_work from bh_worker+0x1ac/0x234
  bh_worker from tasklet_action+0xc/0x28
  tasklet_action from handle_softirqs+0x130/0x520
  handle_softirqs from __irq_exit_rcu+0x144/0x1f0
  __irq_exit_rcu from irq_exit+0x8/0x28
  irq_exit from call_with_stack+0x18/0x20
  call_with_stack from __irq_svc+0x9c/0xd0
Exception stack(0xe0065e18 to 0xe0065e60)
...
  __irq_svc from lock_acquire+0x150/0x39c
  lock_acquire from __kmalloc_cache_node_noprof+0xa8/0x538
  __kmalloc_cache_node_noprof from create_worker+0x58/0x24c
  create_worker from worker_thread+0x2b4/0x3bc
  worker_thread from kthread+0x128/0x150
  kthread from ret_from_fork+0x14/0x28
Exception stack(0xe0065fb0 to 0xe0065ff8)
...
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Fatal exception in interrupt
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Let me know how I can help debugging this issue. There must be some kind 
of race somewhere, because sometimes the board boots fine. This issue 
happens not only on this board, but only this board I managed to get the 
above stacktrace.


> ---
>
> Changes in v2:
> - rebase
>
>   drivers/mmc/host/Kconfig  |  1 +
>   drivers/mmc/host/dw_mmc.c | 26 ++++++++++++++++++++++++--
>   2 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 6d79cc9..c354a0e 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -790,6 +790,7 @@ config MMC_CAVIUM_THUNDERX
>   config MMC_DW
>   	tristate "Synopsys DesignWare Memory Card Interface"
>   	depends on ARC || ARM || ARM64 || MIPS || RISCV || CSKY || COMPILE_TEST
> +	select MMC_HSQ
>   	help
>   	  This selects support for the Synopsys DesignWare Mobile Storage IP
>   	  block, this provides host support for SD and MMC interfaces, in both
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index f599205..112066b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -31,6 +31,7 @@
>   #include <linux/regulator/consumer.h>
>   
>   #include "dw_mmc.h"
> +#include "mmc_hsq.h"
>   
>   /* Common flag combinations */
>   #define DW_MCI_DATA_ERROR_FLAGS	(SDMMC_INT_DRTO | SDMMC_INT_DCRC | \
> @@ -1318,6 +1319,14 @@ static void dw_mci_queue_request(struct dw_mci *host, struct mmc_request *mrq)
>   	}
>   }
>   
> +static void dw_mci_request_done(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	if (mmc_hsq_finalize_request(mmc, mrq))
> +		return;
> +
> +	mmc_request_done(mmc, mrq);
> +}
> +
>   static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>   {
>   	struct dw_mci *host = mmc_priv(mmc);
> @@ -1332,7 +1341,7 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>   
>   	if (!dw_mci_get_cd(mmc)) {
>   		mrq->cmd->error = -ENOMEDIUM;
> -		mmc_request_done(mmc, mrq);
> +		dw_mci_request_done(mmc, mrq);
>   		return;
>   	}
>   
> @@ -1780,7 +1789,7 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
>   		host->state = STATE_IDLE;
>   
>   	spin_unlock(&host->lock);
> -	mmc_request_done(prev_mmc, mrq);
> +	dw_mci_request_done(prev_mmc, mrq);
>   	spin_lock(&host->lock);
>   }
>   
> @@ -3208,9 +3217,14 @@ EXPORT_SYMBOL(dw_mci_alloc_host);
>   int dw_mci_probe(struct dw_mci *host)
>   {
>   	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +	struct mmc_hsq *hsq;
>   	int width, i, ret = 0;
>   	u32 fifo_size;
>   
> +	hsq = devm_kzalloc(host->dev, sizeof(*hsq), GFP_KERNEL);
> +	if (!hsq)
> +		return dev_err_probe(host->dev, -ENOMEM, "hsq allocation failed\n");
> +
>   	ret = dw_mci_parse_dt(host);
>   	if (ret)
>   		return dev_err_probe(host->dev, ret, "parse dt failed\n");
> @@ -3395,6 +3409,10 @@ int dw_mci_probe(struct dw_mci *host)
>   		goto err_dmaunmap;
>   	}
>   
> +	ret = mmc_hsq_init(hsq, host->mmc);
> +	if (ret)
> +		goto err_dmaunmap;
> +
>   	/* Now that host is setup, we can enable card detect */
>   	dw_mci_enable_cd(host);
>   
> @@ -3442,6 +3460,8 @@ int dw_mci_runtime_suspend(struct device *dev)
>   {
>   	struct dw_mci *host = dev_get_drvdata(dev);
>   
> +	mmc_hsq_suspend(host->mmc);
> +
>   	if (host->use_dma && host->dma_ops->exit)
>   		host->dma_ops->exit(host);
>   
> @@ -3510,6 +3530,8 @@ int dw_mci_runtime_resume(struct device *dev)
>   	if (sdio_irq_claimed(host->mmc))
>   		__dw_mci_enable_sdio_irq(host, 1);
>   
> +	mmc_hsq_resume(host->mmc);
> +
>   	/* Now that host is setup, we can enable card detect */
>   	dw_mci_enable_cd(host);
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

