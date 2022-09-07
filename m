Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84F3C54EE9
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Sep 2022 11:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiIGLDc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Sep 2022 07:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIGLDb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Sep 2022 07:03:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CA2A1D55
        for <linux-mmc@vger.kernel.org>; Wed,  7 Sep 2022 04:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662548610; x=1694084610;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P1rRniy6L71UzAtvB0COb6Wo9mD7rwYtZzJNnteouAQ=;
  b=PKt9UccGb84oynKR98XMOv4LByP1jBYBElpUBePPY/2FVFqSQ2d8J23C
   5g1W6C8bJ1twhN+iY/LMcK3mfO7imH1v1kBZQRvU3cMx2zFiAz1xLuDAY
   nmOst4d2Emf8CeIWRMj4M6QRlwoXy/+SUxYEgTzI4wLjv/5m5FYtEbQgK
   5yD9+Tk3+1Zgqky22HUWKBwNL9hs00UBY9H5YAtLEtaNx5th9QxOgSS/s
   dQUupG3GzT9IP/O4qxPi5MheSaBBAdDGDAkJFA8aoV5C4VCXFbKojMCx+
   sJcLHpN3OF8N0cNv3VJA59KeEo0WqFT6Z0iQbPWI1YbRmL7LiLcmYEsTw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276582331"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="276582331"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 04:03:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="676139274"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 04:03:28 -0700
Message-ID: <d85a246e-0a37-6e05-33f6-3016120cd03e@intel.com>
Date:   Wed, 7 Sep 2022 14:03:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] mmc: sdhci: check host->cmd is null or not in
 sdhci_cqe_irq()
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
        linux-mmc@vger.kernel.org, Ram Muthiah <rammuthiah@google.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>
References: <20220831124359.2005165-1-paulliu@debian.org>
 <20220831124359.2005165-2-paulliu@debian.org>
 <3648678c-3c42-2555-aa84-a21b1e7c661f@intel.com>
 <CAPDyKFpmeAPFvLqA3wp8p_O4qQ_svrGPZquznSViiz+Sc3Y=mQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFpmeAPFvLqA3wp8p_O4qQ_svrGPZquznSViiz+Sc3Y=mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 7/09/22 13:03, Ulf Hansson wrote:
> Hi Adrian,
> 
> On Wed, 7 Sept 2022 at 09:06, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 31/08/22 15:43, Ying-Chun Liu (PaulLiu) wrote:
>>> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>>>
>>> If we don't check host->cmd. We will get the following oops
>>> when booting from eMMC on RockPi4.
>>>
>>>  Unable to handle kernel read from unreadable memory at
>>>    virtual address 0000000000000000
>>>  Call trace:
>>>    sdhci_cqe_irq+0x40/0x254
>>
>> Thank you!  However, I prefer this patch:
>>
>> https://lore.kernel.org/linux-mmc/20220907035847.13783-1-wenchao.chen666@gmail.com/
> 
> That patch means that we need to do a sdhci_readw() to figure out what
> command we are running, rather than just checking for a valid pointer.
> Maybe it's not a big deal as this code isn't executed that often?

That was my thinking, but CQE/CQHCI does not set host->cmd either.
It is the same approach taken in sdhci_data_irq() so consistent at
least.

> 
> Anyway, it's your call to make, I pick the patch that you prefer.
> 
> Kind regards
> Uffe
> 
>>
>>>
>>> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
>>> Signed-off-by: Ram Muthiah <rammuthiah@google.com>
>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>> Cc: Ritesh Harjani <riteshh@codeaurora.org>
>>> Cc: Asutosh Das <asutoshd@codeaurora.org>
>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>> Cc: linux-mmc@vger.kernel.org
>>> ---
>>>  drivers/mmc/host/sdhci.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 7689ffec5ad1..e0e7768bd6c0 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -3928,7 +3928,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>>>
>>>       if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC)) {
>>>               *cmd_error = -EILSEQ;
>>> -             if (!mmc_op_tuning(host->cmd->opcode))
>>> +             if (host->cmd && !mmc_op_tuning(host->cmd->opcode))
>>>                       sdhci_err_stats_inc(host, CMD_CRC);
>>>       } else if (intmask & SDHCI_INT_TIMEOUT) {
>>>               *cmd_error = -ETIMEDOUT;
>>> @@ -3938,7 +3938,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>>>
>>>       if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
>>>               *data_error = -EILSEQ;
>>> -             if (!mmc_op_tuning(host->cmd->opcode))
>>> +             if (host->cmd && !mmc_op_tuning(host->cmd->opcode))
>>>                       sdhci_err_stats_inc(host, DAT_CRC);
>>>       } else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>>>               *data_error = -ETIMEDOUT;
>>

