Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192A2C388F9
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Nov 2020 05:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9892053B
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Nov 2020 05:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgKKFev (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Nov 2020 00:34:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:26289 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKKFeu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 11 Nov 2020 00:34:50 -0500
IronPort-SDR: TC8xEbfRKatS/jwx4GZkuJCg8QyIW8GTJjnKRHEtBVmhb2xTjKpLCs7CIm0c0954A5PD4PSbff
 n48/gdyu4Lvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="231722066"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="231722066"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:34:49 -0800
IronPort-SDR: DZ4TLWgSSY7WnDICk25GOqVso2k94bciH3JrfWc6NWPSHje+U7NCBnK2EbhxC45GEUTcc6aBYl
 IDDh87C8V1lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="398908537"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by orsmga001.jf.intel.com with ESMTP; 10 Nov 2020 21:34:47 -0800
Subject: Re: [PATCH] mmc: sdhci-pci: Prefer SDR25 timing for High Speed mode
 for BYT-based Intel controllers
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
References: <20201106134807.9076-1-adrian.hunter@intel.com>
 <CAPDyKFrAZgj04=fToHBo3g+XQH6ABvOTp7=V9r8LLFiKFmNt8A@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <19fb268c-dc24-b902-871b-a933da0cbdcb@intel.com>
Date:   Wed, 11 Nov 2020 07:34:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrAZgj04=fToHBo3g+XQH6ABvOTp7=V9r8LLFiKFmNt8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/11/20 2:01 pm, Ulf Hansson wrote:
> On Fri, 6 Nov 2020 at 14:48, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> A UHS setting of SDR25 can give better results for High Speed mode.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> Cc: stable@vger.kernel.org # v5.4+
>> ---
>>  drivers/mmc/host/sdhci-pci-core.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>> index 23da7f7fe093..9552708846ca 100644
>> --- a/drivers/mmc/host/sdhci-pci-core.c
>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>> @@ -665,6 +665,15 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
>>         }
>>  }
>>
>> +static void sdhci_intel_set_uhs_signaling(struct sdhci_host *host,
>> +                                         unsigned int timing)
>> +{
>> +       /* Set UHS timing to SDR25 for High Speed mode */
>> +       if (timing == MMC_TIMING_MMC_HS || timing == MMC_TIMING_SD_HS)
>> +               timing = MMC_TIMING_UHS_SDR25;
> 
> I don't quite get this. If the mmc core requests high speed mode, you
> override this with timing settings corresponding to UHS_SDR25, right?

Yes.  There is no setting corresponding to high speed.  Currently SDHCI sets
no value, which means zero which is also the setting for SDR12.  There was
an attempt to change this in sdhci.c but it caused problems for some
drivers, so it was reverted and the change was made to sdhci-brcmstb in
commit 2fefc7c5f7d16e ("mmc: sdhci-brcmstb: Fix incorrect switch to HS
mode").  Several other drivers also do this.

> 
>> +       sdhci_set_uhs_signaling(host, timing);
>> +}
>> +
>>  #define INTEL_HS400_ES_REG 0x78
>>  #define INTEL_HS400_ES_BIT BIT(0)
>>
>> @@ -721,7 +730,7 @@ static const struct sdhci_ops sdhci_intel_byt_ops = {
>>         .enable_dma             = sdhci_pci_enable_dma,
>>         .set_bus_width          = sdhci_set_bus_width,
>>         .reset                  = sdhci_reset,
>> -       .set_uhs_signaling      = sdhci_set_uhs_signaling,
>> +       .set_uhs_signaling      = sdhci_intel_set_uhs_signaling,
>>         .hw_reset               = sdhci_pci_hw_reset,
>>  };
>>
>> @@ -731,7 +740,7 @@ static const struct sdhci_ops sdhci_intel_glk_ops = {
>>         .enable_dma             = sdhci_pci_enable_dma,
>>         .set_bus_width          = sdhci_set_bus_width,
>>         .reset                  = sdhci_cqhci_reset,
>> -       .set_uhs_signaling      = sdhci_set_uhs_signaling,
>> +       .set_uhs_signaling      = sdhci_intel_set_uhs_signaling,
>>         .hw_reset               = sdhci_pci_hw_reset,
>>         .irq                    = sdhci_cqhci_irq,
>>  };
>> --
>> 2.17.1
>>
> 
> Kind regards
> Uffe
> 

