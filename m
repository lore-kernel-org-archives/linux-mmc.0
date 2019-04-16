From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC] mmc: cqhci: clear pending interrupt and halt
Date: Tue, 16 Apr 2019 10:19:03 +0300
Message-ID: <32bf3efd-a29c-1105-73b3-b4a6f8c51277@intel.com>
References: <20190416070128.12039-1-peng.fan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416070128.12039-1-peng.fan@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Fan <peng.fan@nxp.com>, "riteshh@codeaurora.org" <riteshh@codeaurora.org>, "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Marie Cheng <haibo.cheng@nxp.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "van.freenix@gmail.com" <van.freenix@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 16/04/19 9:48 AM, Peng Fan wrote:
> On i.MX8MM, we are running Dual Linux OS, with 1st Linux using SD Card
> as rootfs storage, 2nd Linux using eMMC as rootfs storage. We let the
> the 1st linux configure power/clock for the 2nd Linux.
> 
> When the 2nd Linux is booting into rootfs stage, we let the 1st Linux
> to destroy the 2nd linux, then restart the 1st linux, we met SDHCI dump
> as following, after we clear the pending interrupt and halt CQCTL, issue
> gone.

I think it is better if the vendor driver does any necessary resets before
initialization.

> 
> [ 1.334594] mmc2: Got command interrupt 0x00000001 even though no command operation was in progress.
> [ 1.334595] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
> [ 1.334599] mmc2: sdhci: Sys addr: 0xa05dcc00 | Version: 0x00000002
> [ 1.340819] lib80211: common routines for IEEE802.11 drivers
> [ 1.345538] mmc2: sdhci: Blk size: 0x00000200 | Blk cnt: 0x00000000
> [ 1.345541] mmc2: sdhci: Argument: 0x00018000 | Trn mode: 0x00000033
> [ 1.345543] mmc2: sdhci: Present: 0x01f88008 | Host ctl: 0x00000031
> [ 1.345547] mmc2: sdhci: Power: 0x00000002 | Blk gap: 0x00000080
> [ 1.357903] mmc2: sdhci: Wake-up: 0x00000008 | Clock: 0x0000003f
> [ 1.357905] mmc2: sdhci: Timeout: 0x0000008f | Int stat: 0x00000000
> [ 1.357908] mmc2: sdhci: Int enab: 0x107f100b | Sig enab: 0x107f100b
> [ 1.357911] mmc2: sdhci: AC12 err: 0x00000000 | Slot int: 0x00000502
> [ 1.370268] mmc2: sdhci: Caps: 0x07eb0000 | Caps_1: 0x0000b400
> [ 1.370270] mmc2: sdhci: Cmd: 0x00000d1a | Max curr: 0x00ffffff
> [ 1.370273] mmc2: sdhci: Resp[0]: 0x00000b00 | Resp[1]: 0xffffffff
> [ 1.370276] mmc2: sdhci: Resp[2]: 0x328f5903 | Resp[3]: 0x00d00f00
> [ 1.382132] mmc2: sdhci: Host ctl2: 0x00000000
> [ 1.382135] mmc2: sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0xa2040208
> 
> [ 2.060932] mmc2: Unexpected interrupt 0x00004000.
> [ 2.065538] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
> [ 2.071720] mmc2: sdhci: Sys addr: 0x00000000 | Version: 0x00000002
> [ 2.077902] mmc2: sdhci: Blk size: 0x00000200 | Blk cnt: 0x00000001
> [ 2.084083] mmc2: sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
> [ 2.090264] mmc2: sdhci: Present: 0x01f88009 | Host ctl: 0x00000011
> [ 2.096446] mmc2: sdhci: Power: 0x00000002 | Blk gap: 0x00000080
> [ 2.102627] mmc2: sdhci: Wake-up: 0x00000008 | Clock: 0x000010ff
> [ 2.108809] mmc2: sdhci: Timeout: 0x0000008f | Int stat: 0x00004000
> [ 2.114990] mmc2: sdhci: Int enab: 0x007f1003 | Sig enab: 0x007f1003
> [ 2.121171] mmc2: sdhci: AC12 err: 0x00000000 | Slot int: 0x00000502
> [ 2.127353] mmc2: sdhci: Caps: 0x07eb0000 | Caps_1: 0x0000b400
> [ 2.133534] mmc2: sdhci: Cmd: 0x0000371a | Max curr: 0x00ffffff
> [ 2.139715] mmc2: sdhci: Resp[0]: 0x00000900 | Resp[1]: 0xffffffff
> [ 2.145896] mmc2: sdhci: Resp[2]: 0x328f5903 | Resp[3]: 0x00d00f00
> [ 2.152077] mmc2: sdhci: Host ctl2: 0x00000000
> [ 2.156342] mmc2: sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/mmc/host/cqhci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index d59cb0a51964..4f41960ac7ad 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -1116,6 +1116,7 @@ int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc,
>  	      bool dma64)
>  {
>  	int err;
> +	u32 status;
>  
>  	cq_host->dma64 = dma64;
>  	cq_host->mmc = mmc;
> @@ -1139,6 +1140,10 @@ int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc,
>  
>  	spin_lock_init(&cq_host->lock);
>  
> +	status = cqhci_readl(cq_host, CQHCI_IS);
> +	cqhci_writel(cq_host, status, CQHCI_IS);
> +	cqhci_writel(cq_host, CQHCI_HALT, CQHCI_CTL);
> +
>  	init_completion(&cq_host->halt_comp);
>  	init_waitqueue_head(&cq_host->wait_queue);
>  
> 
