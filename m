Return-Path: <SRS0=ySr4=3G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1718C33CB1
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jan 2020 14:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE84420842
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jan 2020 14:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgAQOQK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:16:10 -0500
Received: from mga11.intel.com ([192.55.52.93]:27960 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAQOQK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Jan 2020 09:16:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 06:16:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,330,1574150400"; 
   d="scan'208";a="218919467"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga008.jf.intel.com with ESMTP; 17 Jan 2020 06:16:07 -0800
Subject: Re: [PATCH] mmc: sdhci: fix up CMD12 sending
To:     Ulf Hansson <ulf.hansson@linaro.org>, "Y.b. Lu" <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Sachin Miglani <sachin.miglani@nxp.com>
References: <20191114111814.35199-1-yangbo.lu@nxp.com>
 <CAPDyKFqfMzv1hFzPzS7w5BVHyXybu--7p11wHYa8WTQAVB7r4g@mail.gmail.com>
 <AM7PR04MB68856B9D41A5867AB39D37F2F83E0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <CAPDyKFq7VnfYAs=RcjUpskAfSC_fatksQ1_sJ6wEOinbPDKmkQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <88442ced-8bf0-5f29-ad47-cc53162f157b@intel.com>
Date:   Fri, 17 Jan 2020 16:15:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq7VnfYAs=RcjUpskAfSC_fatksQ1_sJ6wEOinbPDKmkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/01/20 5:36 pm, Ulf Hansson wrote:
> On Wed, 8 Jan 2020 at 10:37, Y.b. Lu <yangbo.lu@nxp.com> wrote:
>>
>> Hi Uffe and Adrian,
>>
>> Back again on this topic. Actually we are trying to make the error recovery work after data error of CMD18 in linux-4.14.
>> With this patch, when CMD18 data error got, manual CMD12 would be sent. And then went into mmc_blk_cmd_recovery(). (Should be mmc_blk_mq_rw_recovery() in latest linux-5.5-rc2.)
>> In mmc_blk_cmd_recovery(), re-tuning would fail before sending CMD13 on our specific board.
>> This may be some issue related to specific eMMC card we are investigating.
>>
>> The above is just background introduction, and you may not care about that:)
>> I'd like to have some queries on CMD12 usage in MMC driver.
>> 1. It seems CMD12 is always not using ABORT type for sending in sdhci.c. The SDHCI_CMD_ABORTCMD hasn't been used. Is this issue?
> 

AFAIK it is not an issue, but support for it can be added if you need it.

> 
>> 2. In block.c, CMD12 uses R1 response for data reading and R1B response for writing. Is it ok to use R1 response for SD? The SD spec mentions only R1B response for CMD12.
> 
> I think the specs isn't that clear on this. In this case, the R1B, is
> an R1 with an *optional* busy signaling on DAT0, unless it has been
> changed lately.

Also SDHCI offers SDHCI_QUIRK2_STOP_WITH_TC to turn all CMD12 responses into R1B

> 
> Additionally, as far as can tell, there have been no reports about
> problems with the current approach for "reads". Are you saying there
> is?
> 
> [...]
> 
> Kind regards
> Uffe
> 

