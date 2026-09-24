Received: from mta0.migadu.com (out-206.mta0.migadu.com [91.218.175.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA13342E40E
	for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2026 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235894; cv=none; b=D3mD4KB7mtr1Vtv+90K1dPSGROlrIDOjBO8uz0J8RdF4MpN5TVWY8wMVIL2hRb2/eD58eZO5I18Ot/CrtuQzaW0Mnp5JV/G3vf5HyfKxddWiJswmE/FSmMKxvZr7QqkV8fp0N1Q9wMvWpwTDkYDfVppVHSUFHrra2VuuyFgWHwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235894; c=relaxed/simple;
	bh=BMB+STVJq0l9ZLkULujYCxV/D/DSiU8LV/duU85x3rg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=orR16aWTr0t4ryBGIqn0Id3G8/c3ISeEDCVzflzQKLfuTVWDryhK2ljsROT3O1BZzp9H0M7ivyleWiD5nknbtmZbnY88n0QPN0cnm9hc/Ma9lzeCUmNg6wK5fb6XKzv3S8U4tglgRzL1xm+/vxUQ+9OVHkhTQFGT6ztAlDjes2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ra3/KDRZ; arc=none smtp.client-ip=91.218.175.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ra3/KDRZ"
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BMB+STVJq0l9ZLkULujYCxV/D/DSiU8LV/duU85x3rg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790235889; v=1; x=1790840689;
 b=Ra3/KDRZ+wA+yqI4O4FBCUzw55F1XzpsH6NcAdj4jH8YLjgjsMGfKu9hN4VEtDanakTjMf7/
 vRg7r6OqAD1YsfGIgMS+SYhRSEbFVCjVesdjS0aLCslB7D3OAk3BZ0cndCo1fs4/t4+5V60Y6jK
 0b4VGJpEZlHXzEBmPL+8iKt0=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d11a2545b59d3edf;
	Thu, 24 Sep 2026 07:44:49 +0000
X-Mizu-Trace-ID: d11a2545b59d3edf
X-Migadu-Flow: FLOW_OUT
Message-ID: <79f82832-c805-4ae3-8204-495bab068dd5@linux.dev>
Date: Thu, 24 Sep 2026 15:44:44 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@linux.dev, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
 Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH] mmc: core: apply a per-command tuning timeout instead of
 the whole sequence budget
To: Adrian Hunter <adrian.hunter@intel.com>
References: <1789530589-8466-1-git-send-email-shawn.lin@rock-chips.com>
 <da386006-9673-4774-85fb-3a145fc972bf@intel.com>
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <da386006-9673-4774-85fb-3a145fc972bf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Adrian,

在 2026/09/24 星期四 15:18, Adrian Hunter 写道:
> On 16/09/2026 06:49, Shawn Lin wrote:
>> From: Shawn Lin <shawn.lin@linux.dev>
>>
>> The tuning specs guarantee that a *sequence* of 40 tuning commands
>> completes within 150 ms, exclusive of any host overhead:
>>
>>    eMMC, JESD84-B51B 6.6.5.1 "Sampling Tuning Sequence for HS200":
>>
>>      "The Device is guaranteed to complete a sequence of 40 times CMD21
>>      executions within 150 ms. This is exclusive of any host overhead."
>>
>>    SD Physical Layer Specification Version 4.00:
>>
>>      "The card shall complete a sequence of 40 times CMD19 executions
>>      in no more than 150ms. The tuning process is normally shorter than
>>      40 executions of CMD19, and therefore should be shorter than
>>      150 ms."
>>
>> mmc_send_tuning() however applied that 150 ms as the data timeout of
>> every single CMD19/CMD21, i.e. 40x the per-execution budget implied
>> by the specs (150 ms / 40 = 3.75 ms of device time, excluding host
>> overhead).
>>
>> The data timeout only matters for tuning commands where the device
>> never returns the tuning block at all; a wrong sampling phase
>> normally fails fast with a CRC error instead.  Waiting 150 ms per
>> such test makes software phase scanning painfully slow.  With
>> dw_mmc-rockchip HS200 eMMC the TMOUT register saturates at ~112 ms
>> for the requested 150 ms, and dw_mmc's execute_tuning() scans every
>> phase of the tuning window, stalling that long on each phase that
>> misses the window.  Multi-second boot slowdowns have been reported[1].
>>
>> Note that SDHCI hosts are unaffected: sdhci_send_tuning() does not
>> use mmc_send_tuning() (the hardware generates and checks the tuning
>> pattern itself) and bounds every tuning command to 50 ms in software
>> (sdhci.c).  The SDHCI variants which scan the tuning phases manually
>> through mmc_send_tuning() -- sdhci-msm, sdhci-omap, sdhci-tegra,
>> sdhci-cadence, sdhci-esdhc-imx, sdhci_am654, sdhci-of-k1,
>> sdhci-of-dwcmshc (CV180x), sdhci-of-bst and the AMD sdhci-pci
>> variant -- suffer from the same excessive per-command timeout and
>> benefit from this change as well.
>>
>> Use 5 ms per tuning command.  For reference, the device serves the
>> tuning block straight out of its SD/MMC IP (no storage access is
>> involved), so even in the slowest reasonable setup -- a 64-byte
>> tuning block at 50 MHz over a 4-bit bus -- the block transfer alone
>> takes ~2.6 us, and a full tuning transaction only a few us of bus
>> time.  5 ms is ~1.3x the spec-implied per-execution device budget
>> (150 ms / 40 = 3.75 ms, excluding host overhead), 30x below the
>> 150 ms ceiling, and the reporter verified that tuning keeps passing
>> with it on dw_mmc-rockchip HS200 eMMC.  Even in the worst case where
>> every tuning command times out, the whole tuning process stays
>> bounded within a few hundred milliseconds.
>>
>> This also bounds the cost of runtime re-tuning, not just the tuning
>> performed at enumeration time.
>>
>> [1] Link: https://bugzilla.kernel.org/show_bug.cgi?id=221781
>> Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
>> ---
>>
>>   drivers/mmc/core/mmc_ops.c | 30 ++++++++++++++++++++++++++----
>>   1 file changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index a952cc8..abcdcf8 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -708,11 +708,33 @@ int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error)
>>   	data.flags = MMC_DATA_READ;
>>   
>>   	/*
>> -	 * According to the tuning specs, Tuning process
>> -	 * is normally shorter 40 executions of CMD19,
>> -	 * and timeout value should be shorter than 150 ms
>> +	 * JESD84-B51B 6.6.5.1, "Sampling Tuning Sequence for HS200":
>> +	 *
>> +	 *   "The Device is guaranteed to complete a sequence of 40 times
>> +	 *   CMD21 executions within 150 ms. This is exclusive of any
>> +	 *   host overhead."
>> +	 *
>> +	 * SD Physical Layer Specification Version 4.00:
>> +	 *
>> +	 *   "The card shall complete a sequence of 40 times CMD19
>> +	 *   executions in no more than 150ms. The tuning process is
>> +	 *   normally shorter than 40 executions of CMD19, and therefore
>> +	 *   should be shorter than 150 ms."
>> +	 *
>> +	 * Both specs bound a *sequence* of 40 tuning commands, i.e. at
>> +	 * most 150/40 ms (3.75 ms) of device time per command, excluding
>> +	 * host overhead.  And that is generous: the device serves the
>> +	 * tuning block straight from its SD/MMC IP, no storage access
>> +	 * involved, so the whole transaction is only a few us of bus
>> +	 * time even in the slowest reasonable setup (64 bytes at
>> +	 * 50 MHz, 4-bit takes ~2.6 us).  The timeout exists solely to
>> +	 * catch devices which never return the block at all.
>> +	 *
>> +	 * Use 5 ms per command: ~1.3x the spec-implied per-command
>> +	 * budget for host overhead and slower devices, still 30x below
>> +	 * the 150 ms bound.
>>   	 */
>> -	data.timeout_ns = 150 * NSEC_PER_MSEC;
>> +	data.timeout_ns = 5 * NSEC_PER_MSEC;
> 
> Perhaps it is safer to let drivers provide an override value,
> either as an mmc_host member or create
> mmc_send_tuning_timeout(host, opcode, cmd_error, timeout_ns)
> 

This is less likely to cause a regression. Nice idea.

I plan to introduce mmc_send_tuning_timeout() in v2 and convert
dw_mmc-rockchip to use it with a smaller timeout. Other platforms
that also care about the overly long per-command timeout can opt
in individually later.

Thanks for the suggestion.


>>   
>>   	data.sg = &sg;
>>   	data.sg_len = 1;
> 

