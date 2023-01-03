Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9449CC3DA7D
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Jan 2023 20:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjACU7E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Jan 2023 15:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjACU7D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jan 2023 15:59:03 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E53B1F581
        for <linux-mmc@vger.kernel.org>; Tue,  3 Jan 2023 12:59:02 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1152)
        id 9D96320B92A6; Tue,  3 Jan 2023 12:59:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D96320B92A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1672779542;
        bh=HzL/EVaJgWK+WYY7Qd+Z5hnXAUdv7/9w7ei3HlGBuzg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Yo/DQNhq6OhCrnD3VBLHzIS/qAA/T8Se+XynF1fEBi1Oh8nW1uQI9gEjB67iZpr1H
         WiZJSAd96wAKPW0hBQqTdCKaEBSN11tmtOBm4/jETf1mIIuF2QGxEfLtrSZ00sxs9t
         3e1oFKsAqrLMDNpm026tXi5zEBhpzqzsSjjEogIY=
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id 9A41B30705CD;
        Tue,  3 Jan 2023 12:59:02 -0800 (PST)
Date:   Tue, 3 Jan 2023 12:59:02 -0800 (PST)
From:   Shyam Saini <shyamsaini@linux.microsoft.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
cc:     linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, code@tyhicks.com
Subject: Re: [PATCH] mmc: core: host: fix mmc retuning
In-Reply-To: <e467c158-b298-53d1-4b12-7cbfe413af79@intel.com>
Message-ID: <cacb9337-ed1b-6c5b-efa2-ae4086f9d7a9@linux.microsoft.com>
References: <20221219225319.24637-1-shyamsaini@linux.microsoft.com> <14de0095-db93-cf5b-e843-1554a392b177@linux.microsoft.com> <e467c158-b298-53d1-4b12-7cbfe413af79@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="656392-982051008-1672779542=:3557"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--656392-982051008-1672779542=:3557
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT


Hi Adrian,

Thank you for response.

> On 20/12/22 01:41, Shyam Saini wrote:
>> As per the JEDEC spec, tuning(command CMD21) is not allowed in
>> RPMB partition.
>>
>> To avoid retuning while switching to RPMB, hold_retune variable was
>> introduced
>
> No, mmc_retune_pause() is used:
>
> /*
> * Pause re-tuning for a small set of operations.  The pause begins after the
> * next command and after first doing re-tuning.
> */
> void mmc_retune_pause(struct mmc_host *host)
> {
> 	if (!host->retune_paused) {
> 		host->retune_paused = 1;
> 		mmc_retune_needed(host);
> 		mmc_retune_hold(host);
> 	}
> }
>
>>            but it is not taken into account while making the tuning
>> decision. As a consequence of this, mmc driver aborts while switching to
>> RPMB partition:
>>  mmc0: mmc_hs400_to_hs200 failed, error -84
>
> Do you normally re-tune at all?  It could just be that re-tuning
> doesn't work.
>

Yes, we are able to retune.

In fact this bug occurs when we iteratively switch to RPMB partition.

May be related to this, we also observed that in __mmc_blk_ioctl_cmd
function in line 487[1] part_index is assigned target_part variable and
on the next line EXT_CSD_PART_CONFIG_ACC_RPMB OR'ed to the target_part
variable.

In mmc_blk_part_switch_pre function line 831 [2], part_type variable is
compared to EXT_CSD_PART_CONFIG_ACC_RPMB without taking into account that
the part_index variable is also OR'ed and its not separated before
the comparision.

Same thing happens in mmc_blk_part_switch_post function.

Is it expected to be this way?, please let me know.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/tree/drivers/mmc/core/block.c?h=next#n487
[2] https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/tree/drivers/mmc/core/block.c?h=next#n831

>>
>> To fix this, take hold_retune variable into account while making retune
>> decision in mmc_retune() function.
>>
>> Fixes: 57da0c042f4a ("mmc: block: Pause re-tuning while switched to the RPMB partition")
>> Reported-by: Judy Wang <wangjudy@linux.microsoft.com>
>> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
>> ---
>>  drivers/mmc/core/host.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index b89dca1f15e9..342c1f5c256b 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -181,6 +181,9 @@ int mmc_retune(struct mmc_host *host)
>>  	bool return_to_hs400 = false;
>>  	int err;
>>
>> +	if (host->hold_retune >= 1)
>> +		return 0;
>
> No, hold_retune is set *before* the command *after* which
> tuning is not permitted.
>
>> +
>>  	if (host->retune_now)
>>  		host->retune_now = 0;
>>  	else
>> --
>> 2.34.1
>>
> On 20/12/22 01:41, Shyam Saini wrote:
>> Hi All,
>>
>> Cc'ing Tyler
>>
>> Please note that I am not 100 % sure about the fix.
>> This issue is reproducible without this patch and the patch at least fix the issue without
>> any regressions on our side.
>>
>> We observed that hold_retune is always greater or equal to 1 in mmc_retune() function,
>>
>> so it may always avoid  re-tuning when it is actually needed and there may
>>
>> be a better fix for the issue.
>>
>> Please let me know your any feedback or comments.
>>
>> Best Regards,
>> Shyam
>>
>>
>
>
--656392-982051008-1672779542=:3557--
