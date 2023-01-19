Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2F7C00A5A
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Jan 2023 10:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjASK3D (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Jan 2023 05:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjASK2S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2023 05:28:18 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7E94B19A
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2023 02:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674124092; x=1705660092;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HiSAbK+S8UkZFs6Kd2wOSDDFCcKanae967VV38yuL78=;
  b=eCStbPLjXXwxPn83jftKGgL5+Xjh5hO9vLJT7Wks72/683EYTEFkLOJK
   7oA8l+HHKUrpDK0y+Fn01oZDjYxTqmVKsuyT/We8cSoeAm5uHgMJbNAVn
   UUKjRHRdbhQXLqaKr3kSttaHt6kUtcnamaYbbRKT0+Xf3msEXSw50C/4o
   SQd5zIt32vsfroSIAZxpFNN1P8dcBOpkHy8ltq04Gkszsqe16cM2S4ufv
   uAT9d0VlmzgoY5FLg1GV8q5d1Nj5vdl/KQjJm7VaqEUb6i2j23RvRFbsl
   nvQnMb2SUVZ48RXRxgcxGRfItO+Dx0I80Ra2BYJYmy3YMQ3VNKoLDazXq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="313124599"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="313124599"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 02:28:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="662065199"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="662065199"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.46.228])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 02:28:10 -0800
Message-ID: <c6f162c3-367f-d357-8eb0-27b7aa70ecd5@intel.com>
Date:   Thu, 19 Jan 2023 12:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.0
Subject: Re: Regression 5.14.21 vs 5.15.1: mmc blocked: mmc0: cqhci: timeout
 for tag #
Content-Language: en-US
To:     sebastian.kloska@snafu.de
Cc:     linux-mmc@vger.kernel.org
References: <c1214ad81df49a314bd4863751de1a45@snafu.de>
 <05add7ba-f2f8-7cbe-3449-4a3128c096b5@intel.com>
 <2ae56408f156f4f728cd1e94863c0795@snafu.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <2ae56408f156f4f728cd1e94863c0795@snafu.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/01/23 11:46, sebastian.kloska@snafu.de wrote:
> Am 19.01.2023 10:15, schrieb Adrian Hunter:
>> On 18/01/23 23:24, sebastian.kloska@snafu.de wrote:
>>> Hi,
>>>
>>> Hardware: Acer Swift-1 SF114-34-P6U1
>>> SD Host controller: Intel Corporation Device 4dc4 (rev 01) 8086:4dc4
>>> eMMC: Kingston A29128
>>>
>>> * A couple of seconds after boot access to the eMMC is completely
>>>   blocked. Can be triggered by extensive I/O (e.g, with badblocks -w)
>>>
>>> * Tested with stable branch linux-5.14.21 vs. linux-5.15.1
>>>   Latest highest version including the bug is a fedora 6.1.6
>>
>> There is very little difference in drivers/mmc between 5.14.21
>> and 5.15.1. Are you sure the same issue is not present in
>> 5.14.21?
> 
> Pretty sure. Using 5.14.21 day in day out 5.15.1 fails on me after ~10min
> The "slowed down by pr_debug" version sometimes lives for >2h (without stress
> via badblocks etc)
> 
>>
>> You could try disabling runtime PM to see if that helps:
>>
>>     echo on > /sys/class/mmc_host/mmc0/device/power/control
>>
> Will try
>> Also it should be possible to disable cqhci by adding to the kernel
>> command line:
>>
>>     sdhci.debug_quirks=0x40a0000
>>
> Will try
>>>
>>> * Spiked the code with a lot of pr_debug messages. As a side effect the driver
>>>   seems to be much more stable, so to me it appears like a timing issue where
>>>   the driver fails to wait for a specific state change which seems to appear
>>>   less often when  slowed down by logging
>>
>> Ideally it would be good to see a full log with dynamic
>> debugging enabled for the latest kernel.
> 
> Latest torvalds/linux or stable/linux ?

Stable would be fine.

> 
>>
>>     To enable mmc debug via kernel command line:
>>
>>         dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"
>>
>>     Kernel must be configured:
>>
>>         CONFIG_DYNAMIC_DEBUG=y
>>
>>>
>>> * Would love to have a decent reference documentation to the SD Controller
>>>   especially a detailed description of the behavior of the register map in
>>>  mmc/host/cqhci.h All intel documents I could find seem to describe
>>>  similar but not quite identical register maps
>>
>> The JEDEC eMMC specification describes the CQHCI registers.
>> It looks like you need to register to get access to them
>> at www.jedec.org.  AFAICT older specs, which would be just
>> fine, are free to download after registering.
>>
> THX
>> You can get SD Host Controller Simplified Specification
>> from www.sdcard.org.
>>
> THX
>>>
>>> Regards
>>>
>>> Sebastian
>>>
>>> * dmesg
>>>
>>> [  347.583082] mmc0: cqhci: timeout for tag 3, qcnt
>>
>> The timeout is pretty long, so it seems like the controller
>> has gotten stuck.  It won't reset the command or data
>> circuits either, which is impossible if it is behaving
>> correctly.
>>
>>> [  347.583086] mmc0: cqhci: ============ CQHCI REGISTER DUMP ===========
>>> [  347.583114] mmc0: cqhci: Caps:      0x000030c0 | Version:  0x00000510
>>> [  347.583117] mmc0: cqhci: Config:    0x00001101 | Control:  0x00000000
>>> [  347.583120] mmc0: cqhci: Int stat:  0x00000000 | Int enab: 0x00000016
>>> [  347.583123] mmc0: cqhci: Int sig:   0x00000016 | Int Coal: 0x00000000
>>> [  347.583157] mmc0: cqhci: TDL base:  0x7c2b5000 | TDL up32: 0x00000001
>>> [  347.583160] mmc0: cqhci: Doorbell:  0x0000000f | TCN:      0x00000000
>>> [  347.583163] mmc0: cqhci: Dev queue: 0x00000008 | Dev Pend: 0x00000008
>>> [  347.583166] mmc0: cqhci: Task clr:  0x00000000 | SSC1:     0x00010008
>>> [  347.583169] mmc0: cqhci: SSC2:      0x00000001 | DCMD rsp: 0x00000800
>>> [  347.583172] mmc0: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x00000000
>>> [  347.583175] mmc0: cqhci: Resp idx:  0x0000002f | Resp arg: 0x00000900
>>> [  347.583176] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>>> [  347.583182] mmc0: sdhci: Sys addr:  0x00000080 | Version:  0x00001002
>>> [  347.583185] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000070
>>> [  347.583188] mmc0: sdhci: Argument:  0x00030000 | Trn mode: 0x00000023
>>> [  347.583191] mmc0: sdhci: Present:   0x1fff0106 | Host ctl: 0x0000003c
>>> [  347.583194] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
>>> [  347.583197] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>>> [  347.583200] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
>>> [  347.583203] mmc0: sdhci: Int enab:  0x02ff4000 | Sig enab: 0x02ff4000
>>> [  347.583206] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>> [  347.583209] mmc0: sdhci: Caps:      0x546ec881 | Caps_1:   0x80000807
>>> [  347.583212] mmc0: sdhci: Cmd:       0x00002f3a | Max curr: 0x00000000
>>> [  347.583214] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
>>> [  347.583217] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>>> [  347.583219] mmc0: sdhci: Host ctl2: 0x0000000d
>>> [  347.583223] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x000000011eef1218
>>> [  347.583224] mmc0: sdhci: ============================================
>>> [  347.583229] mmc0: running CQE recovery
>>> [  347.690108] mmc0: Reset 0x2 never completed.
>>> [  347.690109] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>>> [  347.690115] mmc0: sdhci: Sys addr:  0x00000080 | Version:  0x00001002
>>> [  347.690118] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000070
>>> [  347.690121] mmc0: sdhci: Argument:  0x00030000 | Trn mode: 0x00000023
>>> [  347.690124] mmc0: sdhci: Present:   0x1fff0106 | Host ctl: 0x0000003c
>>> [  347.690127] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
>>> [  347.690130] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>>> [  347.690133] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
>>> [  347.690136] mmc0: sdhci: Int enab:  0x00ff0003 | Sig enab: 0x00ff0003
>>> [  347.690139] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>> [  347.690141] mmc0: sdhci: Caps:      0x546ec881 | Caps_1:   0x80000807
>>> [  347.690144] mmc0: sdhci: Cmd:       0x00002f3a | Max curr: 0x00000000
>>> [  347.690147] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
>>> [  347.690150] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>>> [  347.690152] mmc0: sdhci: Host ctl2: 0x0000000d
>>> [  347.690156] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x000000011eef1218
>>> [  347.690157] mmc0: sdhci: ============================================
>>> [  347.790190] mmc0: Reset 0x4 never completed.
>>> [  347.790191] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>>> [  347.790193] mmc0: sdhci: Sys addr:  0x00000080 | Version:  0x00001002
>>> [  347.790196] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000070
>>> [  347.790199] mmc0: sdhci: Argument:  0x00030000 | Trn mode: 0x00000023
>>> [  347.790202] mmc0: sdhci: Present:   0x1fff0106 | Host ctl: 0x0000003c
>>> [  347.790205] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
>>> [  347.790208] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>>> [  347.790211] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
>>> [  347.790213] mmc0: sdhci: Int enab:  0x00ff0003 | Sig enab: 0x00ff0003
>>> [  347.790216] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>> [  347.790219] mmc0: sdhci: Caps:      0x546ec881 | Caps_1:   0x80000807
>>> [  347.790222] mmc0: sdhci: Cmd:       0x00002f3a | Max curr: 0x00000000
>>> [  347.790225] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
>>> [  347.790228] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>>> [  347.790230] mmc0: sdhci: Host ctl2: 0x0000000d
>>> [  347.790234] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x000000011eef1218
>>> [  347.790234] mmc0: sdhci: ============================================
>>> [  347.803056] mmc0: Controller never released inhibit bit(s).
>>> [  347.803058] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>>> [  347.803077] mmc0: sdhci: Sys addr:  0x00000080 | Version:  0x00001002
>>> [  347.803080] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000070
>>> [  347.803083] mmc0: sdhci: Argument:  0x00030000 | Trn mode: 0x00000023
>>> [  347.803086] mmc0: sdhci: Present:   0x1fff0106 | Host ctl: 0x0000003c
>>> [  347.803089] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
>>> [  347.803092] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>>> [  347.803095] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
>>> [  347.803098] mmc0: sdhci: Int enab:  0x00ff0003 | Sig enab: 0x00ff0003
>>> [  347.803101] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>> [  347.803103] mmc0: sdhci: Caps:      0x546ec881 | Caps_1:   0x80000807
>>> [  347.803106] mmc0: sdhci: Cmd:       0x00002f3a | Max curr: 0x00000000
>>> [  347.803109] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
>>> [  347.803112] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>>> [  347.803114] mmc0: sdhci: Host ctl2: 0x0000000d
>>> [  347.803118] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x000000011eef1218
>>> [  347.803119] mmc0: sdhci: ============================================
>>>  --
>>>
> 

