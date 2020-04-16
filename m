Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DFFC2BB85
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 08:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DAE6216FD
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 08:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502321AbgDPIbs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:31:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:18301 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502185AbgDPIbY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Apr 2020 04:31:24 -0400
IronPort-SDR: P6Li/rzeg7v+8Iq4r+KkGeBe8q5WmkA12swj9pwUEeDBaGl/NkPWmTS9X7MAX6XZHP5pPWrpVo
 A5QDu7/H8E7w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:27:34 -0700
IronPort-SDR: qG0NwaN6qsBa8hWHeVRPyQlV8nKbWjYEmpdj2pT06VRmTIx5tQnNTR9poWjqA0wOvSO2aHApsT
 FIEW39hl3jEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="363917386"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2020 01:27:30 -0700
Subject: Re: [PATCH 1/7] mmc: sdhci: fix base clock usage in preset value
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
 <23c3fe72b0ff0eabdbf3a45023a76da1b18a7e90.1585827904.git.mirq-linux@rere.qmqm.pl>
 <218dd61b-48cc-a161-240f-b3823e8f48cb@intel.com>
 <20200415162839.GD19897@qmqm.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <57b494b8-cae9-df10-2a4d-db02e7212f23@intel.com>
Date:   Thu, 16 Apr 2020 11:26:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415162839.GD19897@qmqm.qmqm.pl>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/04/20 7:28 pm, Micha³ Miros³aw wrote:
> On Wed, Apr 15, 2020 at 03:25:52PM +0300, Adrian Hunter wrote:
>> On 2/04/20 2:54 pm, Micha³ Miros³aw wrote:
>>> Fixed commit added an unnecessary read of CLOCK_CONTROL. The value read
>>> is overwritten for programmable clock preset, but is carried over for
>>> divided clock preset. This can confuse sdhci_enable_clk() if the register
>>> has enable bits set for some reason at time time of clock calculation.
>>> value to be ORed with enable flags. Remove the read.
>>
>> The read is not needed, but drivers usually manage the enable bits,
>> especially disabling the clock before changing the frequency.  What driver
>> is it?
> 
> Hopefully no driver requires this. It's just removing a trap.

The only driver that looks like it would benefit is sdhci-brcmstb because it
does not clear enable bits in sdhci_brcmstb_set_clock().  Adding Al Cooper.
Al, can you ack this?
