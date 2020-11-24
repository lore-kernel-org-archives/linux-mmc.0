Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BE1C2D0E4
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93037206F9
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbgKXOv5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:51:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:34401 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388162AbgKXOv4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Nov 2020 09:51:56 -0500
IronPort-SDR: vwC4ng6bvd+yOdMLdxOz4/LmXbHhXB432kawJtavfRF8CH0q+xRAjDOxd+AzwPV5pLiX3iDF2K
 G5PsL1+zBbmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="171174706"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="171174706"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 06:51:56 -0800
IronPort-SDR: BYyQROwMjLO5yJfRwUywUuN2ZM4/uJJKiihUPEbWxsMgpkNEjubavR+z5QyZKUmeMOeA6sZnua
 VB7/rGD4qfpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="312598315"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga008.fm.intel.com with ESMTP; 24 Nov 2020 06:51:55 -0800
Subject: Re: [PATCH] mmc: sdhci: Update firmware interface API
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201120233831.447365-1-jeremy.linton@arm.com>
 <CAPDyKFq-pMKAJdS8qPpkR_QZ_QLW70Y7PPGxA=d_HOBRd-Su=A@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <be00e2df-572b-2bdb-85c2-675ca16e5d01@intel.com>
Date:   Tue, 24 Nov 2020 16:51:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq-pMKAJdS8qPpkR_QZ_QLW70Y7PPGxA=d_HOBRd-Su=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/11/20 4:25 pm, Ulf Hansson wrote:
> On Sat, 21 Nov 2020 at 00:39, Jeremy Linton <jeremy.linton@arm.com> wrote:
>>
>> The device_* calls were added a few years ago to abstract
>> DT/ACPI/fwnode firmware interfaces. Lets convert the two
>> sdhci caps fields to use the generic calls rather than the OF
>> specific ones. This has the side effect of allowing
>> ACPI based devices to quirk themselves when the caps field
>> is broken.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> 
> Applied for next, thanks!
> 
> Kind regards
> Uffe
> 
> 
>> ---
>>  drivers/mmc/host/sdhci.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 592a55a34b58..feba64fbde16 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -3992,10 +3992,10 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
>>         if (host->v4_mode)
>>                 sdhci_do_enable_v4_mode(host);
>>
>> -       of_property_read_u64(mmc_dev(host->mmc)->of_node,
>> -                            "sdhci-caps-mask", &dt_caps_mask);
>> -       of_property_read_u64(mmc_dev(host->mmc)->of_node,
>> -                            "sdhci-caps", &dt_caps);
>> +       device_property_read_u64_array(mmc_dev(host->mmc),
>> +                                      "sdhci-caps-mask", &dt_caps_mask, 1);
>> +       device_property_read_u64_array(mmc_dev(host->mmc),
>> +                                      "sdhci-caps", &dt_caps, 1);

But why not use device_property_read_u64()?

>>
>>         v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
>>         host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
>> --
>> 2.26.2
>>

