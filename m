Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EB6C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Dec 2022 11:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiLTLgL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Dec 2022 06:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiLTLgK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2022 06:36:10 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE92D2AC6
        for <linux-mmc@vger.kernel.org>; Tue, 20 Dec 2022 03:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671536168; x=1703072168;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U227dlSQP42Ip6BPzoWS5YSi8yUl6VxmxnE0zlu+8x8=;
  b=aPpvBrN6ZJ0HoFzHIyIOvbW/OnyzrNRBaIiERfyCeNibGHI0BqOq+x3Q
   EsW4wtNJ68hpgto6zOzaGplZiqRHkWMqagH8yS9BlRmAAOc6hstNkn7pG
   oVIYuq9s9VchBDlo5RCD7cG+V7guBWzp2eAz84gt5YIinlyBK46MZHURp
   dvOI50RMo69GZRYGpfQM1YoJnrYZTcuFj1dM1qLloVos3CoszH5ViY39E
   KZAS8FhyWXPLRe4kjO4NXZIv/oIV9dn8+Bq31d9XK7qymW3W/nsr31pul
   MFPj5heeTjJLVs0fVU+yV5QVSm+z0Xus4vN0auCehzJF4tP6nHKRbYdKk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="307273274"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="307273274"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 03:36:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="825199133"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="825199133"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.157])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 03:36:04 -0800
Message-ID: <e467c158-b298-53d1-4b12-7cbfe413af79@intel.com>
Date:   Tue, 20 Dec 2022 13:36:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] mmc: core: host: fix mmc retuning
Content-Language: en-US
To:     Shyam Saini <shyamsaini@linux.microsoft.com>,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, code@tyhicks.com
References: <20221219225319.24637-1-shyamsaini@linux.microsoft.com>
 <14de0095-db93-cf5b-e843-1554a392b177@linux.microsoft.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <14de0095-db93-cf5b-e843-1554a392b177@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/12/22 01:41, Shyam Saini wrote:
> As per the JEDEC spec, tuning(command CMD21) is not allowed in
> RPMB partition.
> 
> To avoid retuning while switching to RPMB, hold_retune variable was
> introduced

No, mmc_retune_pause() is used:

/*
 * Pause re-tuning for a small set of operations.  The pause begins after the
 * next command and after first doing re-tuning.
 */
void mmc_retune_pause(struct mmc_host *host)
{
	if (!host->retune_paused) {
		host->retune_paused = 1;
		mmc_retune_needed(host);
		mmc_retune_hold(host);
	}
}

>            but it is not taken into account while making the tuning
> decision. As a consequence of this, mmc driver aborts while switching to
> RPMB partition:
>  mmc0: mmc_hs400_to_hs200 failed, error -84

Do you normally re-tune at all?  It could just be that re-tuning
doesn't work.

> 
> To fix this, take hold_retune variable into account while making retune
> decision in mmc_retune() function.
> 
> Fixes: 57da0c042f4a ("mmc: block: Pause re-tuning while switched to the RPMB partition")
> Reported-by: Judy Wang <wangjudy@linux.microsoft.com>
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> ---
>  drivers/mmc/core/host.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index b89dca1f15e9..342c1f5c256b 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -181,6 +181,9 @@ int mmc_retune(struct mmc_host *host)
>  	bool return_to_hs400 = false;
>  	int err;
>  
> +	if (host->hold_retune >= 1)
> +		return 0;

No, hold_retune is set *before* the command *after* which
tuning is not permitted.

> +
>  	if (host->retune_now)
>  		host->retune_now = 0;
>  	else
> -- 
> 2.34.1
> 
On 20/12/22 01:41, Shyam Saini wrote:
> Hi All,
> 
> Cc'ing Tyler
> 
> Please note that I am not 100 % sure about the fix.
> This issue is reproducible without this patch and the patch at least fix the issue without
> any regressions on our side.
> 
> We observed that hold_retune is always greater or equal to 1 in mmc_retune() function,
> 
> so it may always avoid  re-tuning when it is actually needed and there may
> 
> be a better fix for the issue.
> 
> Please let me know your any feedback or comments.
> 
> Best Regards,
> Shyam
> 
> 


