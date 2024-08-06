Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9CF4FA;
	Tue,  6 Aug 2024 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929495; cv=none; b=TVIaPFtsglS6kxfMg0Sd2/3YtRgBpvmNd1ZiC/cpzWJWwNhDvnrpi5OmbFC1nPr2QcyRYnlOKfVmLCl7gCYaeDL19bnEDAGhUOJ+qVnshMPCdL7OxC84u8o0s7q0LjPlEZ1BQI5k8DmaLcGwpVAV075l3CKB0r3GFVtYNxYKzT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929495; c=relaxed/simple;
	bh=bbYqh0nJ+Cb4KE9wqOrGAYpZ3SiWXxZmVwwuA5Whp+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htBemdhFmccsL6P1kg0NF33yT+v+LZ7p7BOG3wUo5gZHpXcFetOFO7+ZZEbQyeAoMK9AusXrsPGRJZpXm/gDQN+rDB3DIUdNJqo5DIHIo+YYHuxPHWslb/dIaQyoyBN+N+Og3Q9VaCCwCGAfRJhYASzNtT83eoSdNHIFqPwcUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XwPPlXpJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwPPlXpJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722929494; x=1754465494;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bbYqh0nJ+Cb4KE9wqOrGAYpZ3SiWXxZmVwwuA5Whp+I=;
  b=XwPPlXpJligf+V0pRPTw6mxzIsXt6ult4jbSh5oy3F7CkZQwHkZJYw2p
   yTAr8cftGrsxWWPjKBhHIRrn/v1Bi/XvFYlf225FKjyQSMSzGWzXosrKC
   gt+p9e4atafS2Tv3G0YOq+ILqtNATDNjV6gPwOO0ucdCJR2ZdQTXU/GSK
   tx0pwIPIhZCnVKfRjAO8ERWa1gmHgD0Gj4jg1pQKshOzMktzZ8sL5Kelo
   PIsfclqg/IhGUo3aioVN7VntWzNt8XYzrF3yksm37CSsr1wVx7NKpFZgh
   wnPnBSQVJdVwiyOQfHRQeaDCHF/xNNmp5ApAFF98Iu8BoszgpMOu8K0y8
   A==;
X-CSE-ConnectionGUID: 2JDLwuyvQleDLGT3zCkh9w==
X-CSE-MsgGUID: oE4bkI2uQFuB5BQDlWpW8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21076479"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="21076479"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 00:31:32 -0700
X-CSE-ConnectionGUID: q9CoV/m9SCaOYLD+pgoAPg==
X-CSE-MsgGUID: rDGs3TWNTdGOhwfzEV74/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56637543"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.248.17])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 00:31:28 -0700
Message-ID: <dcde3b9f-ccc8-4e1e-8737-74768193f0af@intel.com>
Date: Tue, 6 Aug 2024 10:31:22 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mmc0: Got data interrupt 0x04000000 even though no data operation
 was in progress.
To: Gratian Crisan <gratian.crisan@ni.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Hans de Goede
 <hdegoede@redhat.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <87jzgur32p.fsf@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <87jzgur32p.fsf@ni.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/08/24 00:33, Gratian Crisan wrote:
> Hi all,
> 
> We are getting the following splat on latest 6.11.0-rc2-00002-gc813111d19e6 (and
> older) kernel(s):

Do you know a kernel version that does not get an error?

> 
> [    4.792991] mmc0: new ultra high speed DDR50 SDHC card at address 0001
> [    4.793550]   with environment:
> [    4.793786]     HOME=/
> [    4.793985]     TERM=linux
> [    4.794201]     BOOT_IMAGE=/runmode/bzImage
> [    4.794485]     sys_reset=false
> [    4.795791] mmcblk0: mmc0:0001 0016G 15.2 GiB
> [    5.333153] mmc0: Got data interrupt 0x04000000 even though no data operation was in progress.
> [    5.333676] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    5.334069] mmc0: sdhci: Sys addr:  0x12454200 | Version:  0x0000b502
> [    5.334464] mmc0: sdhci: Blk size:  0x00007040 | Blk cnt:  0x00000001
> [    5.334860] mmc0: sdhci: Argument:  0x00010000 | Trn mode: 0x00000010
> [    5.335253] mmc0: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000016
> [    5.335648] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> [    5.336040] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
> [    5.336432] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
> [    5.336824] mmc0: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
> [    5.337214] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> [    5.337605] mmc0: sdhci: Caps:      0x076864b2 | Caps_1:   0x00000004
> [    5.337997] mmc0: sdhci: Cmd:       0x00000d1a | Max curr: 0x00000000
> [    5.338389] mmc0: sdhci: Resp[0]:   0x00400900 | Resp[1]:  0x00000000
> [    5.338780] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> [    5.339170] mmc0: sdhci: Host ctl2: 0x0000000c
> [    5.339468] mmc0: sdhci: ADMA Err:  0x00000003 | ADMA Ptr: 0x12454200
> [    5.339859] mmc0: sdhci: ============================================
> [    5.340293] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [    5.344663] Buffer I/O error on dev mmcblk0, logical block 0, async page read
> [    5.346127]  mmcblk0: p1 p2
> 
> This is on an Intel Bay Trail based system: NI cRIO-9053 using an Atom E3805.
> 
> The issue appears related to the one fixed by commit b3855668d98c ("mmc: sdhci:
> Add support for "Tuning Error" interrupts") and discussed here[1].

Does reverting that commit help?

> 
> After adding some debug prints it appears that in our case we get a tuning error
> interrupt during a MMC_SEND_STATUS (13) sdhci cmd which has no 'host->data'
> associated with it (leading to the splat):
> 
> [    4.893298] mmc0: new ultra high speed DDR50 SDHC card at address 0001
> [    4.896489] mmcblk0: mmc0:0001 0016G 15.2 GiB
> [    4.906048] mmc0: tuning err irq, sdhci cmd: 18, host->cmd: 0000000003b39249, host->data: 00000000c0b4ad8a
> [    4.963027] mmc0: tuning err irq, sdhci cmd: 18, host->cmd: 0000000003b39249, host->data: 00000000c0b4ad8a
> [    5.384960] mmc0: tuning err irq, sdhci cmd: 17, host->cmd: 0000000003b39249, host->data: 00000000c0b4ad8a
> [    5.442877] mmc0: tuning err irq, sdhci cmd: 13, host->cmd: 00000000e1669bad, host->data: 0000000000000000
> [    5.443463] mmc0: Got data interrupt 0x04000000 even though no data operation was in progress.
> 
> I am new to this area of the kernel so I would appreciate any suggestions on the
> direction to take here:
> 
>   - Should the tuning error interrupts be handled in common code in sdhci_irq()
>     (or at least before the !host->data check in sdhci_data_irq())?
> 
>   - Is this more of an issue with tuning not happening when is expected or
>     taking too long, since at first we do get the error during data transfer
>     commands? Suggestions on what I should debug/trace next appreciated.

SDHCI driver does not enable the "Tuning Error" interrupt, refer
the kernel messages above:

	Int enab:  0x03ff008b | Sig enab: 0x03ff008b

but it happens anyway, so the "fix" was to handle it anyway.

But it begs the question, wasn't the error happening already?

> 
> Thanks,
>     Gratian
> 
> [1] https://lore.kernel.org/r/20240410191639.526324-3-hdegoede@redhat.com

