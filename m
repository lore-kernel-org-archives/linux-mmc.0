Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887DF187859;
	Thu, 10 Oct 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552547; cv=none; b=EhxSxDZR62bgGDBecETpr/4v+8xFTkMH0D8jlS2CMoH33EHv4YKM1019GucV0K59F/4nmk6+IHrIjzKaCQ8vzV7/IRTOccnBrERlz72QeKWJs+bRhyTIz71N7FbWPjEyOes8KdHfVV0TjJroyGNdJKWhiIKv1rgthAtr+3JhqeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552547; c=relaxed/simple;
	bh=3MWIB6YPNQ7Ys95rrr5Z3iqkTMBH7/EbWG9fSXyXcbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQDss9i4EK4eCf0bJ/DUphnwT72mRJEffKxrHuqZOWJh6jUCjB9XJ6bpYPcDOS1JslK91gCVG6dbizqwMgoU05NxbRkwtCECryYqXZi4ib9YZCJN4K2+ZwS5NKsD/7O2vPUrXU9MxEMN0/OBkWExImZzqAIoKMn+mLEemnWAWK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dD9BiYnB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dD9BiYnB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728552546; x=1760088546;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3MWIB6YPNQ7Ys95rrr5Z3iqkTMBH7/EbWG9fSXyXcbI=;
  b=dD9BiYnBw1y/8RODlMAPsojIq9swt1sIFqu82GbkbUfOVkiFlZ/B+jRa
   wyJRJQwa7WzEXwh3WQz1A2ETR5WKXUvlkFrj9r+JiIl0cHhjgGGw4wx69
   OQmbdxTHEu74/MC5NWDHN6Eo0hlWP2a/bDNdXMGzeva6OHsRUfBCd8cgi
   zdGLjOxASVMjob9AJnnkSOhccIOvxF+tgh8ysOXoUin79JbYp26xhtKWQ
   4E1lEMrnM8nRd7r9YXOnoJtR2VqwD3A4dA7vbHTbzon0XuvM2XaRnuosB
   bhlwLDRHEO1sHf2bA0ouONuRMlJeC8c6r22osf00+aqqajchGOMGYSM+u
   Q==;
X-CSE-ConnectionGUID: e8GqysL+TzWjW4APn+JQGQ==
X-CSE-MsgGUID: AiuHe+qTRk69+5TCrzjUpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28015090"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="28015090"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 02:29:05 -0700
X-CSE-ConnectionGUID: 4ixj6F09TLaqdej5z9ADOw==
X-CSE-MsgGUID: S3YGe2raT0+l/PUJicw/dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="77011173"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 02:29:02 -0700
Message-ID: <bc8e6cb6-3950-4cf9-ab47-636e4ac92341@intel.com>
Date: Thu, 10 Oct 2024 12:28:57 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: Prevent stale command interrupt
 handling
To: Michal Wilczynski <m.wilczynski@samsung.com>, ulf.hansson@linaro.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 m.szyprowski@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <CGME20241008100332eucas1p12e84a156c835e719e6916331762c74b0@eucas1p1.samsung.com>
 <20241008100327.4108895-1-m.wilczynski@samsung.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241008100327.4108895-1-m.wilczynski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/24 13:03, Michal Wilczynski wrote:
> While working with the T-Head 1520 LicheePi4A SoC, certain conditions
> arose that allowed me to reproduce a race issue in the sdhci code.
> 
> To reproduce the bug, you need to enable the sdio1 controller in the
> device tree file
> `arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi` as follows:
> 
> &sdio1 {
> 	bus-width = <4>;
> 	max-frequency = <100000000>;
> 	no-sd;
> 	no-mmc;
> 	broken-cd;
> 	cap-sd-highspeed;
> 	post-power-on-delay-ms = <50>;
> 	status = "okay";
> 	wakeup-source;
> 	keep-power-in-suspend;
> };
> 
> When resetting the SoC using the reset button, the following messages
> appear in the dmesg log:
> 
> [    8.164898] mmc2: Got command interrupt 0x00000001 even though no
> command operation was in progress.
> [    8.174054] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    8.180503] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
> [    8.186950] mmc2: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> [    8.193395] mmc2: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
> [    8.199841] mmc2: sdhci: Present:   0x03da0000 | Host ctl: 0x00000000
> [    8.206287] mmc2: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> [    8.212733] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x0000decf
> [    8.219178] mmc2: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
> [    8.225622] mmc2: sdhci: Int enab:  0x00ff1003 | Sig enab: 0x00ff1003
> [    8.232068] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> [    8.238513] mmc2: sdhci: Caps:      0x3f69c881 | Caps_1:   0x08008177
> [    8.244959] mmc2: sdhci: Cmd:       0x00000502 | Max curr: 0x00191919
> [    8.254115] mmc2: sdhci: Resp[0]:   0x00001009 | Resp[1]:  0x00000000
> [    8.260561] mmc2: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> [    8.267005] mmc2: sdhci: Host ctl2: 0x00001000
> [    8.271453] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
> 0x0000000000000000
> [    8.278594] mmc2: sdhci: ============================================
> 
> I also enabled some traces to better understand the problem:
> 
>      kworker/3:1-62      [003] .....     8.163538: mmc_request_start:
> mmc2: start struct mmc_request[000000000d30cc0c]: cmd_opcode=5
> cmd_arg=0x0 cmd_flags=0x2e1 cmd_retries=0 stop_opcode=0 stop_arg=0x0
> stop_flags=0x0 stop_retries=0 sbc_opcode=0 sbc_arg=0x0 sbc_flags=0x0
> sbc_retires=0 blocks=0 block_size=0 blk_addr=0 data_flags=0x0 tag=0
> can_retune=0 doing_retune=0 retune_now=0 need_retune=0 hold_retune=1
> retune_period=0
>           <idle>-0       [000] d.h2.     8.164816: sdhci_cmd_irq:
> hw_name=ffe70a0000.mmc quirks=0x2008008 quirks2=0x8 intmask=0x10000
> intmask_p=0x18000
>      irq/24-mmc2-96      [000] .....     8.164840: sdhci_thread_irq:
> msg=
>      irq/24-mmc2-96      [000] d.h2.     8.164896: sdhci_cmd_irq:
> hw_name=ffe70a0000.mmc quirks=0x2008008 quirks2=0x8 intmask=0x1
> intmask_p=0x1
>      irq/24-mmc2-96      [000] .....     8.285142: mmc_request_done:
> mmc2: end struct mmc_request[000000000d30cc0c]: cmd_opcode=5
> cmd_err=-110 cmd_resp=0x0 0x0 0x0 0x0 cmd_retries=0 stop_opcode=0
> stop_err=0 stop_resp=0x0 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=0
> data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0 need_retune=0
> hold_retune=1 retune_period=0
> 
> Here's what happens: the __mmc_start_request function is called with
> opcode 5. Since the power to the Wi-Fi card, which resides on this SDIO
> bus, is initially off after the reset, an interrupt SDHCI_INT_TIMEOUT is
> triggered. Immediately after that, a second interrupt SDHCI_INT_RESPONSE
> is triggered. Depending on the exact timing, these conditions can
> trigger the following race problem:
> 
> 1) The sdhci_cmd_irq top half handles the command as an error. It sets
>    host->cmd to NULL and host->pending_reset to true.
> 2) The sdhci_thread_irq bottom half is scheduled next and executes faster
>    than the second interrupt handler for SDHCI_INT_RESPONSE. It clears
>    host->pending_reset before the SDHCI_INT_RESPONSE handler runs.
> 3) The pending interrupt SDHCI_INT_RESPONSE handler gets called, triggering
>    a code path that prints: "mmc2: Got command interrupt 0x00000001 even
>    though no command operation was in progress."
> 
> To solve this issue, we need to clear pending interrupts when resetting
> host->pending_reset. This ensures that after sdhci_threaded_irq restores
> interrupts, there are no pending stale interrupts.
> 
> The behavior observed here is non-compliant with the SDHCI standard.
> Place the code in the sdhci-of-dwcmshc driver to account for a
> hardware-specific quirk instead of the core SDHCI code.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v2:
>  - instead of modifying SDHCI core code, only modify th1520 specific
>    reset
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 8999b97263af..8fd80dac11bf 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -852,6 +852,14 @@ static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
>  
>  	sdhci_reset(host, mask);
>  
> +	/* The T-Head 1520 SoC does not comply with the SDHCI specification
> +	 * regarding the "Software Reset for CMD line should clear 'Command
> +	 * Complete' in the Normal Interrupt Status Register." Clear the bit
> +	 * here to compensate for this quirk.
> +	 */
> +	if (mask & SDHCI_RESET_CMD)
> +		sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
> +
>  	if (priv->flags & FLAG_IO_FIXED_1V8) {
>  		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>  		if (!(ctrl_2 & SDHCI_CTRL_VDD_180)) {

