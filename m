Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31F31DDC2A;
	Mon,  7 Oct 2024 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728327498; cv=none; b=tR2iTEWdeh/lO3T1RrSDmNbo4VfDVCWa6/EHFvSjAVyFiEwte5+2FzbQDCp7AyosLYwa3sN7hmDz6DcR3xpU1Y9aNez5MY/AdXRiUFhddQfz501tyLZVXPMNrJPZyaJ+A7UjJsq0EGI7+OyAhwQ+Naqo7pej94SHRrn0abeVUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728327498; c=relaxed/simple;
	bh=4283/+FD0TmbZef6qzw4G8KMDo/sn/145NYT4V2WlHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyZMlVs6IHOL8QNDH7sQPhSE5TkbqVeAPpItc5olBjfDXFMDQul+UQETRnMb0NaJgehlqfLIoXl+6f8oikiKElxoKguXHxlqauko11aY5VJ5BopyBZ148x5rHs32k+IsdOHxB2Nfkk4M65V0ROBJ24jWahFdId9gaOXplJTYe5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtrRTLHn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtrRTLHn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728327496; x=1759863496;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4283/+FD0TmbZef6qzw4G8KMDo/sn/145NYT4V2WlHA=;
  b=RtrRTLHnuWFt827LY+FE+WCRaTrLu3vi/2UAxlk9LV+ecJ54OiezToQ1
   zzGeWjKrdoHpTcof9v+P8L8YyJiQdnjD4Y0/5PW0TYrMpZuhlhFyIWHnW
   +26uXGjyjTHQ+dRkwU0aZ31XqIBP6BFym/4kFDbtJwhTboCg7MTlZtCk6
   Vcm+RuDNNrtsSeeos0nZ0f089P+sAIuJ3jL5NgBYMf8M9vrpAk7o2o/2E
   CYIhueqZwKvbvq2HfujyWE5vWTR1a3giMrftBIqn7jgycfjNEa2XLKG7v
   13Fqw9HEDqokTxgVLnrkwJc94rWb79CYkgq+piCnu+4G6Pjlo0B5Krxm5
   A==;
X-CSE-ConnectionGUID: rn2PLNHGSCqhxRTcuzPN7A==
X-CSE-MsgGUID: jv+9GJuNSHarWc69iv1kbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27617816"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27617816"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 11:58:16 -0700
X-CSE-ConnectionGUID: WeHWy1JJQwWFvSLbvqi37A==
X-CSE-MsgGUID: iqafrQ87T7ew+JJWbvlv9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80396883"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 11:58:11 -0700
Message-ID: <ae376f35-b551-485f-b98f-1a18c506933c@intel.com>
Date: Mon, 7 Oct 2024 21:58:02 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mmc: sdhci: Prevent stale command and data interrupt
 handling
To: Michal Wilczynski <m.wilczynski@samsung.com>, ulf.hansson@linaro.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 m.szyprowski@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Drew Fustini <drew@pdp7.com>
References: <CGME20241003161012eucas1p2ab704a8771869e142b024cc95d5ecb5d@eucas1p2.samsung.com>
 <20241003161007.3485810-1-m.wilczynski@samsung.com>
 <51b6cee1-d23f-475e-bfe0-979e96e687c6@intel.com>
 <deeda5fb-16a6-4d89-a224-18898aba9a0b@samsung.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <deeda5fb-16a6-4d89-a224-18898aba9a0b@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/24 20:00, Michal Wilczynski wrote:
> 
> 
> On 10/7/24 18:09, Adrian Hunter wrote:
>> On 3/10/24 19:10, Michal Wilczynski wrote:
>>> While working with the T-Head 1520 LicheePi4A SoC, certain conditions
>>> arose that allowed me to reproduce a race issue in the sdhci code.
>>>
>>> To reproduce the bug, you need to enable the sdio1 controller in the
>>> device tree file
>>> `arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi` as follows:
>>>
>>> &sdio1 {
>>> 	bus-width = <4>;
>>> 	max-frequency = <100000000>;
>>> 	no-sd;
>>> 	no-mmc;
>>> 	broken-cd;
>>> 	cap-sd-highspeed;
>>> 	post-power-on-delay-ms = <50>;
>>> 	status = "okay";
>>> 	wakeup-source;
>>> 	keep-power-in-suspend;
>>> };
>>>
>>> When resetting the SoC using the reset button, the following messages
>>> appear in the dmesg log:
>>>
>>> [    8.164898] mmc2: Got command interrupt 0x00000001 even though no
>>> command operation was in progress.
>>> [    8.174054] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
>>> [    8.180503] mmc2: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
>>> [    8.186950] mmc2: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
>>> [    8.193395] mmc2: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
>>> [    8.199841] mmc2: sdhci: Present:   0x03da0000 | Host ctl: 0x00000000
>>> [    8.206287] mmc2: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>>> [    8.212733] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x0000decf
>>> [    8.219178] mmc2: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
>>> [    8.225622] mmc2: sdhci: Int enab:  0x00ff1003 | Sig enab: 0x00ff1003
>>> [    8.232068] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>> [    8.238513] mmc2: sdhci: Caps:      0x3f69c881 | Caps_1:   0x08008177
>>> [    8.244959] mmc2: sdhci: Cmd:       0x00000502 | Max curr: 0x00191919
>>> [    8.254115] mmc2: sdhci: Resp[0]:   0x00001009 | Resp[1]:  0x00000000
>>> [    8.260561] mmc2: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>>> [    8.267005] mmc2: sdhci: Host ctl2: 0x00001000
>>> [    8.271453] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
>>> 0x0000000000000000
>>> [    8.278594] mmc2: sdhci: ============================================
>>>
>>> I also enabled some traces to better understand the problem:
>>>
>>>      kworker/3:1-62      [003] .....     8.163538: mmc_request_start:
>>> mmc2: start struct mmc_request[000000000d30cc0c]: cmd_opcode=5
>>> cmd_arg=0x0 cmd_flags=0x2e1 cmd_retries=0 stop_opcode=0 stop_arg=0x0
>>> stop_flags=0x0 stop_retries=0 sbc_opcode=0 sbc_arg=0x0 sbc_flags=0x0
>>> sbc_retires=0 blocks=0 block_size=0 blk_addr=0 data_flags=0x0 tag=0
>>> can_retune=0 doing_retune=0 retune_now=0 need_retune=0 hold_retune=1
>>> retune_period=0
>>>           <idle>-0       [000] d.h2.     8.164816: sdhci_cmd_irq:
>>> hw_name=ffe70a0000.mmc quirks=0x2008008 quirks2=0x8 intmask=0x10000
>>> intmask_p=0x18000
>>>      irq/24-mmc2-96      [000] .....     8.164840: sdhci_thread_irq:
>>> msg=
>>>      irq/24-mmc2-96      [000] d.h2.     8.164896: sdhci_cmd_irq:
>>> hw_name=ffe70a0000.mmc quirks=0x2008008 quirks2=0x8 intmask=0x1
>>> intmask_p=0x1
>>>      irq/24-mmc2-96      [000] .....     8.285142: mmc_request_done:
>>> mmc2: end struct mmc_request[000000000d30cc0c]: cmd_opcode=5
>>> cmd_err=-110 cmd_resp=0x0 0x0 0x0 0x0 cmd_retries=0 stop_opcode=0
>>> stop_err=0 stop_resp=0x0 0x0 0x0 0x0 stop_retries=0 sbc_opcode=0
>>> sbc_err=0 sbc_resp=0x0 0x0 0x0 0x0 sbc_retries=0 bytes_xfered=0
>>> data_err=0 tag=0 can_retune=0 doing_retune=0 retune_now=0 need_retune=0
>>> hold_retune=1 retune_period=0
>>>
>>> Here's what happens: the __mmc_start_request function is called with
>>> opcode 5. Since the power to the Wi-Fi card, which resides on this SDIO
>>> bus, is initially off after the reset, an interrupt SDHCI_INT_TIMEOUT is
>>> triggered. Immediately after that, a second interrupt SDHCI_INT_RESPONSE
>>> is triggered. Depending on the exact timing, these conditions can
>>> trigger the following race problem:
>>>
>>> 1) The sdhci_cmd_irq top half handles the command as an error. It sets
>>>    host->cmd to NULL and host->pending_reset to true.
>>> 2) The sdhci_thread_irq bottom half is scheduled next and executes faster
>>>    than the second interrupt handler for SDHCI_INT_RESPONSE. It clears
>>>    host->pending_reset before the SDHCI_INT_RESPONSE handler runs.
>>> 3) The pending interrupt SDHCI_INT_RESPONSE handler gets called, triggering
>>>    a code path that prints: "mmc2: Got command interrupt 0x00000001 even
>>>    though no command operation was in progress."
>>>
>>> To solve this issue, we need to clear pending interrupts when resetting
>>> host->pending_reset. This ensures that after sdhci_threaded_irq restores
>>> interrupts, there are no pending stale interrupts.
>>>
>>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 4b91c9e96635..b91a6076c332 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -3098,6 +3098,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
>>>  		sdhci_reset_for(host, REQUEST_ERROR);
>>>  
>>>  		host->pending_reset = false;
>>> +
>>> +		/* Clear any pending interrupts after reset */
>>> +		sdhci_writel(host, SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK,
>>> +			     SDHCI_INT_STATUS);
>>
>> According to SDHCI spec, "Software Reset For CMD Line" clears
>> "Command Complete" in "Normal Interrupt Status register", so the
>> interrupt status should not need to be cleared again.
>>
>> Which SDHCI driver is it?
>>
> 
> Thank you for your review.
> 
> The driver in use is located at drivers/mmc/host/sdhci-of-dwcmshc.c,
> and the .compatible string is thead,th1520-dwcmshc.
> 
> Based on the specifications, it appears that the specific hardware used in
> the LicheePi4A SoC may not be fully compliant with the SDHCI standard.
> Therefore, the appropriate solution might be to add additional clearing
> code to the th1520_sdhci_reset() function.
> 

Seems reasonable


