From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: add spin_unlock_irq() before calling
 clk_round_rate
Date: Thu, 01 Dec 2016 13:31:52 +0900
Message-ID: <422a666d-9a7a-4b1f-62a2-7890546f4bd8@samsung.com>
References: <CGME20161130060544epcas1p4e2cbb763842707125f98535dbb34fb28@epcas1p4.samsung.com>
 <20161130060542.18225-1-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:35508 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754165AbcLAEbz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2016 23:31:55 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHH02HDNOKXT4A0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 01 Dec 2016 13:31:53 +0900 (KST)
In-reply-to: <20161130060542.18225-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com

On 11/30/2016 03:05 PM, Jaehoon Chung wrote:
> Before calling clk_round_rate(), put the spin_unlock_irq() in
> sdhci_s3c_consider_clock() function.

this patch is for fixing the below issue.

  273.465261] BUG: scheduling while atomic: mmcqd/0/96/0x00000002
 [  273.469782] Modules linked in:
 [  273.472819] Preemption disabled at:[  273.476121] [<  (null)>]   (null)
 [  273.479424] CPU: 3 PID: 96 Comm: mmcqd/0 Not tainted 4.9.0-rc5-00106-g4d698fc-dirty #6
 [  273.487316] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
 [  273.493419] [<c010f0f4>] (unwind_backtrace) from [<c010ae24>] (show_stack+0x10/0x14)
 [  273.501127] [<c010ae24>] (show_stack) from [<c033cb68>] (dump_stack+0x78/0x8c)
 [  273.508333] [<c033cb68>] (dump_stack) from [<c013ddd4>] (__schedule_bug+0x84/0xd4)
 [  273.515884] [<c013ddd4>] (__schedule_bug) from [<c072e788>] (__schedule+0x398/0x480)
 [  273.523605] [<c072e788>] (__schedule) from [<c072e8bc>] (schedule+0x4c/0xac)
 [  273.530634] [<c072e8bc>] (schedule) from [<c072ed24>] (schedule_preempt_disabled+0x14/0x20)
 [  273.538969] [<c072ed24>] (schedule_preempt_disabled) from [<c07312a4>] (__mutex_lock_slowpath+0x19c/0x3fc)
 [  273.548603] [<c07312a4>] (__mutex_lock_slowpath) from [<c0731510>] (mutex_lock+0xc/0x24)
 [  273.556678] [<c0731510>] (mutex_lock) from [<c03a7614>] (clk_prepare_lock+0x50/0xf8)
 [  273.564403] [<c03a7614>] (clk_prepare_lock) from [<c03a8c34>] (clk_round_rate+0x18/0x60)
 [  273.572475] [<c03a8c34>] (clk_round_rate) from [<c057e274>] (sdhci_s3c_set_clock+0x1e0/0x1e8)
 [  273.580980] [<c057e274>] (sdhci_s3c_set_clock) from [<c057e2a0>] (sdhci_cmu_set_clock+0x24/0x17c)
 [  273.589831] [<c057e2a0>] (sdhci_cmu_set_clock) from [<c057d4d0>] (sdhci_set_ios+0x7c/0x408)
 [  273.598164] [<c057d4d0>] (sdhci_set_ios) from [<c057d378>] (sdhci_runtime_resume_host+0x70/0x14c)
 [  273.607025] [<c057d378>] (sdhci_runtime_resume_host) from [<c044a690>] (__rpm_callback+0x2c/0x60)
 [  273.615875] [<c044a690>] (__rpm_callback) from [<c044a71c>] (rpm_callback+0x58/0x80)
 [  273.623599] [<c044a71c>] (rpm_callback) from [<c044b5cc>] (rpm_resume+0x35c/0x560)
 [  273.631150] [<c044b5cc>] (rpm_resume) from [<c044b81c>] (__pm_runtime_resume+0x4c/0x64)
 [  273.639137] [<c044b81c>] (__pm_runtime_resume) from [<c056718c>] (__mmc_claim_host+0x17c/0x1b8)
 [  273.647821] [<c056718c>] (__mmc_claim_host) from [<c0578094>] (mmc_blk_issue_rq+0x2cc/0x570)
 [  273.656236] [<c0578094>] (mmc_blk_issue_rq) from [<c0578410>] (mmc_queue_thread+0xd8/0x188)
 [  273.664571] [<c0578410>] (mmc_queue_thread) from [<c0138bf8>] (kthread+0xdc/0xf4)
 [  273.672035] [<c0138bf8>] (kthread) from [<c0107878>] (ret_from_fork+0x14/0x3c)
 [  273.680046] ------------[ cut here ]------------
 [  273.684681] WARNING: CPU: 3 PID: 96 at kernel/sched/core.c:3182 _raw_spin_unlock_irq+0x14/0x40
 [  273.692452] DEBUG_LOCKS_WARN_ON(val > preempt_count())
 Modules linked in:
 [  273.699285] CPU: 3 PID: 96 Comm: mmcqd/0 Tainted: G        W       4.9.0-rc5-00106-g4d698fc-dirty #6
 [  273.708394] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
 [  273.714488] [<c010f0f4>] (unwind_backtrace) from [<c010ae24>] (show_stack+0x10/0x14)
 [  273.722202] [<c010ae24>] (show_stack) from [<c033cb68>] (dump_stack+0x78/0x8c)
 [  273.729406] [<c033cb68>] (dump_stack) from [<c011d3ec>] (__warn+0xe8/0x100)
 [  273.736349] [<c011d3ec>] (__warn) from [<c011d43c>] (warn_slowpath_fmt+0x38/0x48)
 [  273.743814] [<c011d43c>] (warn_slowpath_fmt) from [<c0733404>] (_raw_spin_unlock_irq+0x14/0x40)
 [  273.752496] [<c0733404>] (_raw_spin_unlock_irq) from [<c057e2e0>] (sdhci_cmu_set_clock+0x64/0x17c)
 [  273.761433] [<c057e2e0>] (sdhci_cmu_set_clock) from [<c057d4d0>] (sdhci_set_ios+0x7c/0x408)
 [  273.769765] [<c057d4d0>] (sdhci_set_ios) from [<c057d378>] (sdhci_runtime_resume_host+0x70/0x14c)
 [  273.778623] [<c057d378>] (sdhci_runtime_resume_host) from [<c044a690>] (__rpm_callback+0x2c/0x60)
 [  273.787475] [<c044a690>] (__rpm_callback) from [<c044a71c>] (rpm_callback+0x58/0x80)
 [  273.795199] [<c044a71c>] (rpm_callback) from [<c044b5cc>] (rpm_resume+0x35c/0x560)
 [  273.802750] [<c044b5cc>] (rpm_resume) from [<c044b81c>] (__pm_runtime_resume+0x4c/0x64)
 [  273.810737] [<c044b81c>] (__pm_runtime_resume) from [<c056718c>] (__mmc_claim_host+0x17c/0x1b8)
 [  273.819420] [<c056718c>] (__mmc_claim_host) from [<c0578094>] (mmc_blk_issue_rq+0x2cc/0x570)
 [  273.827837] [<c0578094>] (mmc_blk_issue_rq) from [<c0578410>] (mmc_queue_thread+0xd8/0x188)
 [  273.836171] [<c0578410>] (mmc_queue_thread) from [<c0138bf8>] (kthread+0xdc/0xf4)
 [  273.843635] [<c0138bf8>] (kthread) from [<c0107878>] (ret_from_fork+0x14/0x3c)

If my approach is wrong, let me know, plz.

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 784c5a8..de219ca 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -121,7 +121,9 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
>  	 * speed possible with selected clock source and skip the division.
>  	 */
>  	if (ourhost->no_divider) {
> +		spin_unlock_irq(&ourhost->host->lock);
>  		rate = clk_round_rate(clksrc, wanted);
> +		spin_lock_irq(&ourhost->host->lock);
>  		return wanted - rate;
>  	}
>  
> 

