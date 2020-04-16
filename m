Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F18BC2BA2B
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 07:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF382064A
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 07:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439503AbgDPHoC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:44:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:9208 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439534AbgDPHoA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Apr 2020 03:44:00 -0400
IronPort-SDR: QSH5PHezF+hVDxhYpnQIP9HcnSLNQwroc034/KLkq34/fxlyKqlFthGc4TSDxTHLbHlQZe2Q+c
 qPLw0APu+hYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 00:44:00 -0700
IronPort-SDR: S2f9P+GnLGDfvB0ocHt6/lpFaCcT0MCt9Dw3b0nRU8GBGYosOuAV4bxZjmKggDLfmKhg8A7ZHJ
 YIuEbVcXhWbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="363907058"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2020 00:43:58 -0700
Subject: Re: [PATCH 4/7] mmc: sdhci: move SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
 frequency limit
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Kevin Liu <kliu5@marvell.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
 <637b9bea4c28a0eeacf754d2930596b8e6673808.1585827904.git.mirq-linux@rere.qmqm.pl>
 <2b111407-0f35-3c5e-f7f0-4a05a281dce2@intel.com>
 <20200415161657.GC19897@qmqm.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e038a984-2f6d-4940-8d28-e39e060b36c2@intel.com>
Date:   Thu, 16 Apr 2020 10:43:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415161657.GC19897@qmqm.qmqm.pl>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/04/20 7:16 pm, Micha³ Miros³aw wrote:
> On Wed, Apr 15, 2020 at 04:16:04PM +0300, Adrian Hunter wrote:
>> On 2/04/20 2:54 pm, Micha³ Miros³aw wrote:
>>> Move clock frequency limit for SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN where
>>> it belongs.
>>
>> Did you consider getting rid of SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN and
>> handling it in sdhci-of-arasan instead?
> 
> I'm expecting to use this quirk for DDR mode support in other host drivers,
> but I can't test this, yet.

I didn't mean get rid of the functionality.  I meant implement it in
sdhci-of-arasan.  In general we want to reduce the quirks in sdhci.c and
implement them instead in vendor drivers.

