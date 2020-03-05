Return-Path: <SRS0=i1XN=4W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41F3C3F2CD
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 07:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32CC2166E
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 07:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgCEHfq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Mar 2020 02:35:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:3524 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgCEHfq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 5 Mar 2020 02:35:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 23:35:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; 
   d="scan'208";a="229604424"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga007.jf.intel.com with ESMTP; 04 Mar 2020 23:35:44 -0800
Subject: Re: [PATCH v2] mmc: sdhci: make sure SDHCI_CLOCK_CARD_EN bit sticks
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20200219210730.27640-1-jeff.dagenais@gmail.com>
 <CAPDyKFr41yuESMuoKF_KUSW4sP_cZxzjW4gKMv_0ShtoEOmS3A@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a3ab359b-3f5a-90fb-a7d2-5e946c434713@intel.com>
Date:   Thu, 5 Mar 2020 09:35:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFr41yuESMuoKF_KUSW4sP_cZxzjW4gKMv_0ShtoEOmS3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/03/20 5:34 pm, Ulf Hansson wrote:
> On Wed, 19 Feb 2020 at 22:07, Jean-Francois Dagenais
> <jeff.dagenais@gmail.com> wrote:
>>
>> Regardless of the broken-cd quirk, when it silently doesn't stick,
>> no clock is applied to the bus lines, yet the code continues to
>> try to make CMDs and times out after 10 seconds for each. This
>> process can take up to a minute as mmc_rescan_try_freq tries the
>> different commands to discover the card.
>>
>> Short of changing sdhci_enable_clk's signature chain in all
>> dependent drivers, at least provide a hint that this might be the
>> problem. This will save tons of time for system integrators.
>>
>> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> 
> The change looks reasonable to me. However I would like to get an ack
> by Adrian before applying, as I may not have thought of all the
> consequences this change may have.
> 
> Kind regards
> Uffe
> 
> 
>> ---
>> Changes in v2:
>>  * removed redundant wmb()
>> ---
>>  drivers/mmc/host/sdhci.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 63db84481dff..42a02d034fda 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1894,6 +1894,20 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>>
>>         clk |= SDHCI_CLOCK_CARD_EN;
>>         sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>> +
>> +       clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>> +       if (clk & SDHCI_CLOCK_CARD_EN)
>> +               return;
>> +
>> +       /* The controller will clear this bit if card absent condition is

Please make the comment style consistent with the rest of sdhci.c e.g.

	/*
	 * The controller blah...
	 * blah ...
	 */

>> +        * detected. If card is indeed present, check platform configuration for
>> +        * how CD is reported to the SDHCI host controller. There may be an
>> +        * "assume present" mechanism in the platform registers, or your pin mux
>> +        * may be incorrect.
>> +        */
>> +       pr_err("%s: SDHCI_CLOCK_CARD_EN bit did not stick. Card absent?\n",
>> +               mmc_hostname(host->mmc));
>> +       sdhci_dumpregs(host);

The error message is ok, but for some controllers this could happen normally
if the card is removed suddenly, so let's not also do a register dump.

>>  }
>>  EXPORT_SYMBOL_GPL(sdhci_enable_clk);
>>
>> --
>> 2.25.0
>>
