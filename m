Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E23C388F7
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF76422248
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 13:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgKLNjv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Nov 2020 08:39:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:1274 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbgKLNjv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Nov 2020 08:39:51 -0500
IronPort-SDR: SBDcYeHQ5YyulDtb01IFTTBYzCcQAJfXVvUCZiML7iK0nWKPWI++mMVYpqNeG9lFN2fTHgGuoA
 tKWO8o0Nip4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="167723944"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="167723944"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 05:39:50 -0800
IronPort-SDR: dlYunsw92A/5AikEbngWkT9rKUmRea+Z4f3lMh1HD9F57b0XEPcBecaOv1Ib8r0+qFwqb1O9Mg
 RCUSfZOIRJtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="357091195"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga004.fm.intel.com with ESMTP; 12 Nov 2020 05:39:49 -0800
Subject: Re: [PATCH] mmc: sdhci-pci: Prefer SDR25 timing for High Speed mode
 for BYT-based Intel controllers
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
References: <20201106134807.9076-1-adrian.hunter@intel.com>
 <CAPDyKFrAZgj04=fToHBo3g+XQH6ABvOTp7=V9r8LLFiKFmNt8A@mail.gmail.com>
 <19fb268c-dc24-b902-871b-a933da0cbdcb@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3ddee4dc-7cf5-ff38-c367-62ccf9470477@intel.com>
Date:   Thu, 12 Nov 2020 15:39:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <19fb268c-dc24-b902-871b-a933da0cbdcb@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/11/20 7:34 am, Adrian Hunter wrote:
> On 10/11/20 2:01 pm, Ulf Hansson wrote:
>> On Fri, 6 Nov 2020 at 14:48, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>
>>> A UHS setting of SDR25 can give better results for High Speed mode.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>> Cc: stable@vger.kernel.org # v5.4+
>>> ---
>>>  drivers/mmc/host/sdhci-pci-core.c | 13 +++++++++++--
>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>>> index 23da7f7fe093..9552708846ca 100644
>>> --- a/drivers/mmc/host/sdhci-pci-core.c
>>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>>> @@ -665,6 +665,15 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
>>>         }
>>>  }
>>>
>>> +static void sdhci_intel_set_uhs_signaling(struct sdhci_host *host,
>>> +                                         unsigned int timing)
>>> +{
>>> +       /* Set UHS timing to SDR25 for High Speed mode */
>>> +       if (timing == MMC_TIMING_MMC_HS || timing == MMC_TIMING_SD_HS)
>>> +               timing = MMC_TIMING_UHS_SDR25;
>>
>> I don't quite get this. If the mmc core requests high speed mode, you
>> override this with timing settings corresponding to UHS_SDR25, right?
> 
> Yes.  There is no setting corresponding to high speed.  Currently SDHCI sets
> no value, which means zero which is also the setting for SDR12.  There was
> an attempt to change this in sdhci.c but it caused problems for some
> drivers, so it was reverted and the change was made to sdhci-brcmstb in
> commit 2fefc7c5f7d16e ("mmc: sdhci-brcmstb: Fix incorrect switch to HS
> mode").  Several other drivers also do this.
> 

Send V2 with expanded commit message
