Return-Path: <SRS0=YSSR=4G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6673C34031
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 07:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C96206E2
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 07:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgBRHsW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:48:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:64177 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgBRHsV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Feb 2020 02:48:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 23:48:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,455,1574150400"; 
   d="scan'208";a="314978836"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga001.jf.intel.com with ESMTP; 17 Feb 2020 23:48:19 -0800
Subject: Re: [PATCH v3 11/14] mmc: sdhci-esdhc-imx: clear pending interrupt
 and halt cqhci
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, linus.walleij@linaro.org
References: <1581324597-31031-1-git-send-email-haibo.chen@nxp.com>
 <1581324597-31031-6-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8f8775f0-98a6-ef86-6e45-195060c43533@intel.com>
Date:   Tue, 18 Feb 2020 09:47:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581324597-31031-6-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/02/20 10:49 am, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> On i.MX8MM, we are running Dual Linux OS, with 1st Linux using SD Card
> as rootfs storage, 2nd Linux using eMMC as rootfs storage. We let the
> the 1st linux configure power/clock for the 2nd Linux.
> 
> When the 2nd Linux is booting into rootfs stage, we let the 1st Linux
> to destroy the 2nd linux, then restart the 2nd linux, we met SDHCI dump
> as following, after we clear the pending interrupt and halt CQCTL, issue
> gone.
> 
> [ 1.334594] mmc2: Got command interrupt 0x00000001 even though no command operation was in progress.
> [ 1.334595] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
> [ 1.334599] mmc2: sdhci: Sys addr: 0xa05dcc00 | Version: 0x00000002
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
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 100c081cfcae..106097cbd0d4 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1233,6 +1233,7 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> +	struct cqhci_host *cq_host = host->mmc->cqe_private;
>  	int tmp;
>  
>  	if (esdhc_is_usdhc(imx_data)) {
> @@ -1309,6 +1310,21 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
>  			tmp &= ~ESDHC_STD_TUNING_EN;
>  			writel(tmp, host->ioaddr + ESDHC_TUNING_CTRL);
>  		}
> +
> +		/*
> +		 * On i.MX8MM, we are running Dual Linux OS, with 1st Linux using SD Card
> +		 * as rootfs storage, 2nd Linux using eMMC as rootfs storage. We let the
> +		 * the 1st linux configure power/clock for the 2nd Linux.
> +		 *
> +		 * When the 2nd Linux is booting into rootfs stage, we let the 1st Linux
> +		 * to destroy the 2nd linux, then restart the 2nd linux, we met SDHCI dump.
> +		 * After we clear the pending interrupt and halt CQCTL, issue gone.
> +		 */
> +		if (cq_host) {
> +			tmp = cqhci_readl(cq_host, CQHCI_IS);
> +			cqhci_writel(cq_host, tmp, CQHCI_IS);
> +			cqhci_writel(cq_host, CQHCI_HALT, CQHCI_CTL);
> +		}
>  	}
>  }
>  
> 

