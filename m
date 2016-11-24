From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH] mmc: sdhci-msm: Add sdhci_reset() implementation
Date: Thu, 24 Nov 2016 21:36:54 +0530
Message-ID: <95ef8403-5e3c-4219-f45e-e289cf59f1b8@codeaurora.org>
References: <20161122155005.16910-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20161122155005.16910-1-georgi.djakov@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Georgi,

I collected some info on this problem. May be below info might help you.


I think "Reset 0x1" problem is occurring because of below call stack.
SDHCI_RESET_ALL to SDHCI_SOFTWARE_RESET register will anyway trigger the 
sdhci_msm_pwr_irq.

But I think the problem is that the above occurs in spinlock context
and because of only one core the IRQ will never be serviced, hence you 
were seeing (Reset 0x1) error.


[   12.583245] systemd-journald[1236]: Received SIGTERM from PID 1 
(systemd-shutdow).
[   12.673684] EXT4-fs (mmcblk0p10): re-mounted. Opts: data=ordered
[   12.678224] EXT4-fs (mmcblk0p10): re-mounted. Opts: data=ordered
[   13.698330] mmc0: Reset 0x1 never completed.
[   13.698353] sdhci: =========== REGISTER DUMP (mmc0)===========
[   13.701659] sdhci: Sys addr: 0x00000000 | Version:  0x00002e02
[   13.707301] sdhci: Blk size: 0x00004000 | Blk cnt:  0x00000000
[   13.713117] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[   13.718933] sdhci: Present:  0x01f80000 | Host ctl: 0x00000000
[   13.724750] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[   13.730564] sdhci: Wake-up:  0x00000000 | Clock:    0x00000003
[   13.736381] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[   13.742197] sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
[   13.748012] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[   13.753830] sdhci: Caps:     0x322dc8b2 | Caps_1:   0x00008007
[   13.759644] sdhci: Cmd:      0x00000000 | Max curr: 0x00000000
[   13.765461] sdhci: Host ctl2: 0x00000000
[   13.771275] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x0000000000000000
[   13.775357] sdhci: ===========================================
[   13.781698] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 
4.9.0-rc5-00222-g59ac3c0-dirty #9
[   13.787514] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[   13.796104] Call trace:
[   13.802878] [<ffff0000080882c4>] dump_backtrace+0x0/0x1a8
[   13.805049] [<ffff000008088480>] show_stack+0x14/0x1c
[   13.810602] [<ffff000008366274>] dump_stack+0x8c/0xb0
[   13.815640] [<ffff00000870eab0>] sdhci_reset+0xd8/0x114
[   13.820670] [<ffff00000870ee30>] sdhci_do_reset+0x48/0x7c
[   13.825706] [<ffff00000870ef20>] sdhci_init+0xbc/0x110
[   13.831260] [<ffff000008710c44>] sdhci_set_ios+0x68/0x59c
[   13.836299] [<ffff0000086f95f4>] mmc_set_initial_state+0xc0/0xcc
[   13.841767] [<ffff0000086f983c>] mmc_power_off.part.22+0x28/0x40
[   13.847841] [<ffff0000086f9b5c>] mmc_power_off+0x14/0x1c
[   13.853832] [<ffff0000086fc754>] _mmc_suspend+0x1e4/0x260
[   13.859127] [<ffff0000086fe104>] mmc_shutdown+0x2c/0x60
[   13.864421] [<ffff0000086faa00>] mmc_bus_shutdown+0x40/0x74
[   13.869458] [<ffff0000084f9280>] device_shutdown+0xf0/0x1a8
[   13.875013] [<ffff0000080db908>] kernel_restart_prepare+0x34/0x3c
[   13.880568] [<ffff0000080db9e4>] kernel_restart+0x14/0x74
[   13.886817] [<ffff0000080dbd2c>] SyS_reboot+0x178/0x244
[   13.892198] [<ffff000008082ef0>] el0_svc_naked+0x24/0x28
[   13.897300] mmc0: sdhci_msm_pwr_irq:
[   13.902799] mmc0: sdhci_msm_voltage_switch: irq_status 9
[   13.906355] mmc0: sdhci_msm_voltage_switch: irq_status 9, irq_ack 5


To prove above I tried this and the problem goes away. But I still dont 
think that the below approach is correct. As it will still trigger a 
pwr_irq as well.


diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 62aedf1..01e611c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -174,6 +174,8 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
                 /* Reset-all turns off SD Bus Power */
                 if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
                         sdhci_runtime_pm_bus_off(host);
+               if (host->ops->voltage_switch)
+                       host->ops->voltage_switch(host);
         }

         /* Wait max 100 ms */



On 11/22/2016 9:20 PM, Georgi Djakov wrote:
> On apq8016, apq8084 and apq8074 platforms, when we want to do a
> software reset, we need to poke some additional vendor specific
> registers. If we don't do so, the following error message appears:
>
> mmc0: Reset 0x1 never completed.
> sdhci: =========== REGISTER DUMP (mmc0)===========
> sdhci: Sys addr: 0x00000000 | Version:  0x00002e02
> sdhci: Blk size: 0x00004000 | Blk cnt:  0x00000000
> sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
> sdhci: Present:  0x01f80000 | Host ctl: 0x00000000
> sdhci: Power:    0x00000000 | Blk gap:  0x00000000
> sdhci: Wake-up:  0x00000000 | Clock:    0x00000003
> sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
> sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
> sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
> sdhci: Caps:     0x322dc8b2 | Caps_1:   0x00008007
> sdhci: Cmd:      0x00000000 | Max curr: 0x00000000
> sdhci: Host ctl2: 0x00000000
> sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x0000000000000000
> sdhci: ===========================================
>
> Fix it by implementing the custom sdhci_reset() function,
> which does what is needed.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 8ef44a2a2fd9..87a124a37408 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -505,6 +505,23 @@ static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>
> +void sdhci_msm_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	if (mask & SDHCI_RESET_ALL) {
> +		u32 val = readl_relaxed(msm_host->core_mem + CORE_POWER);
> +
> +		val |= CORE_SW_RST;
> +		writel_relaxed(val, msm_host->core_mem + CORE_POWER);
Not required as sdhci_reset register should anyway reset and trigger a 
pwr_irq. Because you are not servicing that IRQ the problem is present.

> +
> +		sdhci_msm_voltage_switch(host);
> +	}
> +
> +	sdhci_reset(host, mask);
This I think is sufficient.

> +}
> +
>  static const struct of_device_id sdhci_msm_dt_match[] = {
>  	{ .compatible = "qcom,sdhci-msm-v4" },
>  	{},
> @@ -514,7 +531,7 @@ MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
>
>  static const struct sdhci_ops sdhci_msm_ops = {
>  	.platform_execute_tuning = sdhci_msm_execute_tuning,
> -	.reset = sdhci_reset,
> +	.reset = sdhci_msm_reset,
>  	.set_clock = sdhci_set_clock,
>  	.set_bus_width = sdhci_set_bus_width,
>  	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
