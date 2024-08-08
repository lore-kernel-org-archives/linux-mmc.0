Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA373466;
	Thu,  8 Aug 2024 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110462; cv=none; b=ogotp7vqDuLb9Oad+xcOloM4T90Q9UxDD/WHhi9/rUQwxCTJXgSEeNVoX6azEuLy/zPVg5n5Y9MeckS1v387pMXVsfBtd13y47yMT9LrPgxoM78099FZl4mvxUJWfTxtJb1sHm4UJ1NoUhOqrmMKejnpCJ+NynDqUU0dVbjv94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110462; c=relaxed/simple;
	bh=MGdoEFtRggCclD8PChFBmTqeJSblL4Hi36NwkAEyY48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tl6vdeBXvr2crVh/aKXqGsiGVQ6tnqrS+BJFh9YYuhCVj10eapGc9TKIW0dx4IW45kf057GvGjpwYwPTH92t/GtxzQ9hVDlm53KLGhvuR6tlpelbDbuFtp/cE2aY9tDjrFpts4H9XhqV0h5XucU5vrGH4JFg4L/GD/FkiE6jmrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sf5tMkAT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sf5tMkAT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723110461; x=1754646461;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MGdoEFtRggCclD8PChFBmTqeJSblL4Hi36NwkAEyY48=;
  b=Sf5tMkATrwyMjOeGD3Llq4DQknCGbaLh0+J2E1s7nxMnceg/5Oq98gkP
   Be+pHDy4E63aNus0pLtRg3b78/vCCCbxejLs9aCYBqoYloajyB4PE4DRT
   CN+I00l/okuoamQP+UudGUbGS94lL59Qyp+u9Tyu2c7LKh5mutTJacGyD
   cAfyx9Ml6vfsQtqn3EPHCWIQQj0kvBAf+AqF89xejOm/yQeFcDGa1jB53
   nV8AfYfDcKmDUOfIEI66CyRVd5qXlUO+Qlz1H2L0HBzXpBBAuVW0joPEw
   AMUL7+ZxZ6xgJW1+5tuob1iyNzmxRh5EfcRcIj5TC3v6VNMfcWJ8cPHzH
   g==;
X-CSE-ConnectionGUID: pR9XuCXwQ2uNK1IsyZd2Iw==
X-CSE-MsgGUID: tiDLi5EdTfWHGPL8aK610w==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21393220"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21393220"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 02:47:40 -0700
X-CSE-ConnectionGUID: QCPxD7T3TUOjeJx/4r9PXA==
X-CSE-MsgGUID: mNkm1e5YS1+j4XnIQrhwmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="56847830"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.150.149])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 02:47:37 -0700
Message-ID: <f4f5d6bd-86d3-46d4-b0cb-765d4a6b2a26@intel.com>
Date: Thu, 8 Aug 2024 12:47:30 +0300
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
 <dcde3b9f-ccc8-4e1e-8737-74768193f0af@intel.com> <87frrhqn8n.fsf@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <87frrhqn8n.fsf@ni.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/08/24 00:35, Gratian Crisan wrote:
> 
> Adrian Hunter <adrian.hunter@intel.com> writes:
>> On 6/08/24 00:33, Gratian Crisan wrote:
>>>
>>> We are getting the following splat on latest 6.11.0-rc2-00002-gc813111d19e6 (and
>>> older) kernel(s):
>>
>> Do you know a kernel version that does not get an error?
>>
> 
> Sorry for not being more clear in my original email - this is not a new issue. I
> believe this Bay Trail hardware always had an issue with receiving "Tuning
> Error" interrupts with certain SD cards. At least as far back as 4.9.47.
> 
> Up until commit b3855668d98c ("mmc: sdhci: Add support for "Tuning Error"
> interrupts") these resulted in a "mmc0: Unexpected interrupt 0x04000000" splat,
> which b3855668d98c fixed.
> 
> However, now that "Tuning Error" interrupts are treated as data interrupts and
> handled in sdhci_data_irq() we are hitting a corner case where that tuning error
> interrupt comes in after a MMC_SEND_STATUS command with no 'host->data'
> associated resulting in the new splat.

Ok, thanks for clarifying.

> Hence the question in my previous email: Should the tuning error interrupts be
> handled in common code in sdhci_irq()?
> 
>>>
>>> [    4.792991] mmc0: new ultra high speed DDR50 SDHC card at address 0001
>>> [    4.793550]   with environment:
>>> [    4.793786]     HOME=/
>>> [    4.793985]     TERM=linux
>>> [    4.794201]     BOOT_IMAGE=/runmode/bzImage
>>> [    4.794485]     sys_reset=false
>>> [    4.795791] mmcblk0: mmc0:0001 0016G 15.2 GiB
>>> [    5.333153] mmc0: Got data interrupt 0x04000000 even though no data operation was in progress.
>>> [    5.333676] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>>> [    5.334069] mmc0: sdhci: Sys addr:  0x12454200 | Version:  0x0000b502
>>> [    5.334464] mmc0: sdhci: Blk size:  0x00007040 | Blk cnt:  0x00000001
>>> [    5.334860] mmc0: sdhci: Argument:  0x00010000 | Trn mode: 0x00000010
>>> [    5.335253] mmc0: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000016
>>> [    5.335648] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>>> [    5.336040] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
>>> [    5.336432] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
>>> [    5.336824] mmc0: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
>>> [    5.337214] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>> [    5.337605] mmc0: sdhci: Caps:      0x076864b2 | Caps_1:   0x00000004
>>> [    5.337997] mmc0: sdhci: Cmd:       0x00000d1a | Max curr: 0x00000000
>>> [    5.338389] mmc0: sdhci: Resp[0]:   0x00400900 | Resp[1]:  0x00000000
>>> [    5.338780] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>>> [    5.339170] mmc0: sdhci: Host ctl2: 0x0000000c
>>> [    5.339468] mmc0: sdhci: ADMA Err:  0x00000003 | ADMA Ptr: 0x12454200
>>> [    5.339859] mmc0: sdhci: ============================================
>>> [    5.340293] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>>> [    5.344663] Buffer I/O error on dev mmcblk0, logical block 0, async page read
>>> [    5.346127]  mmcblk0: p1 p2
>>>
>>> This is on an Intel Bay Trail based system: NI cRIO-9053 using an Atom E3805.
>>>
>>> The issue appears related to the one fixed by commit b3855668d98c ("mmc: sdhci:
>>> Add support for "Tuning Error" interrupts") and discussed here[1].
>>
>> Does reverting that commit help?
>>
> 
> Reverting the commit brings back the original splat that commit fixed (albeit
> without the I/O error):
> 
> [    4.893032] mmc0: new ultra high speed DDR50 SDHC card at address 0001
> [    4.896238] mmcblk0: mmc0:0001 0016G 15.2 GiB
> [    4.905944] mmc0: Unexpected interrupt 0x04000000.
> [    4.906272] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [    4.906664] mmc0: sdhci: Sys addr:  0x126e6200 | Version:  0x0000b502
> [    4.907059] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000008
> [    4.907451] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x0000003b
> [    4.907842] mmc0: sdhci: Present:   0x01ff0206 | Host ctl: 0x00000016
> [    4.908234] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> [    4.908625] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
> [    4.909015] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000002
> [    4.909408] mmc0: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
> [    4.909800] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
> [    4.910193] mmc0: sdhci: Caps:      0x076864b2 | Caps_1:   0x00000004
> [    4.910581] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
> [    4.910976] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00400900
> [    4.911371] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00400900
> [    4.911765] mmc0: sdhci: Host ctl2: 0x0000000c
> [    4.912064] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x126e6200
> [    4.912456] mmc0: sdhci: ============================================
> [    4.913301]  mmcblk0: p1 p2
> [    6.401855] EXT4-fs (mmcblk1p2): mounted filesystem d57a3d3c-a1f9-4f8e-8cbc-19dc5bb4fc4c r/w with ordered data mode. Quota mode: disabled.
> 
>>> I am new to this area of the kernel so I would appreciate any suggestions on the
>>> direction to take here:
>>>
>>>   - Should the tuning error interrupts be handled in common code in sdhci_irq()
>>>     (or at least before the !host->data check in sdhci_data_irq())?
>>>
>>>   - Is this more of an issue with tuning not happening when is expected or
>>>     taking too long, since at first we do get the error during data transfer
>>>     commands? Suggestions on what I should debug/trace next appreciated.
>>
>> SDHCI driver does not enable the "Tuning Error" interrupt, refer
>> the kernel messages above:
>>
>> 	Int enab:  0x03ff008b | Sig enab: 0x03ff008b
>>
>> but it happens anyway, so the "fix" was to handle it anyway.
>>
>> But it begs the question, wasn't the error happening already?
>>
> 
> Kind of: Before we were getting "mmc0: Unexpected interrupt 0x04000000", but
> somehow it didn't result in a I/O error. That may be just lucky timing.
> 
> Now we're getting "mmc0: Got data interrupt 0x04000000 even though no data operation was in
> progress." followed by an I/O error on READ.
> 
> I appreciate your reply. I'm happy to work on a patch or test things if I'm
> pointed in the right direction.

Note that neither "Got data interrupt ... even though no data
operation was in progress" nor "Unexpected interrupt ..." messages
result in I/O errors directly, but indicate that the host controller
is not behaving as expected.

However, according to the spec. "Tuning Error" interrupt status is
an unrecoverable error, so commit b3855668d98c ("mmc: sdhci: Add
support for "Tuning Error" interrupts") began treating it that way
and causing a re-tune and retry, as Hans reported that it made things
work for his devices.

You should first get a better idea of what circumstances errors are
occurring.  Enabling debug messages should help, but it will cause
a very large number of messages and you may also want to increase
the kernel message buffer size (CONFIG_LOG_BUF_SHIFT)

Dynamic debug for mmc:

    Kernel must be configured:

        CONFIG_DYNAMIC_DEBUG=y

    To enable mmc debug via sysfs:

        echo 'file drivers/mmc/core/* +p' > /sys/kernel/debug/dynamic_debug/control
        echo 'file drivers/mmc/host/* +p' > /sys/kernel/debug/dynamic_debug/control

    To enable mmc debug via kernel command line:

        dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"

    To disable mmc debug:

        echo 'file drivers/mmc/core/* -p' > /sys/kernel/debug/dynamic_debug/control
        echo 'file drivers/mmc/host/* -p' > /sys/kernel/debug/dynamic_debug/control

    More general information in kernel documentation in kernel tree:

        Documentation/admin-guide/dynamic-debug-howto.rst




