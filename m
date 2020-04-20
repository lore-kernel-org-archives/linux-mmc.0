Return-Path: <SRS0=uOye=6E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A27EC3815B
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 05:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9E82080C
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 05:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgDTFcP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Apr 2020 01:32:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:12657 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgDTFcP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Apr 2020 01:32:15 -0400
IronPort-SDR: 6oyG2vKMOa0hTPyhx6mXHdG2FcqrGseStmRlPsCefKQyFBnnufZuAGktZOfGg2794v7FRvVAPa
 JPUCTw9UjV5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 22:32:14 -0700
IronPort-SDR: 7fDoYv9l9Nuy27x9AnxUCje9cd2+eP2LwqC5xaYbuGbM+HfhdtRo1YsWes/ZNbby+iL8aYNbQy
 qEDy1uX+gCGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; 
   d="scan'208";a="288382574"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga008.jf.intel.com with ESMTP; 19 Apr 2020 22:32:12 -0700
Subject: Re: [PATCH 1/7] mmc: sdhci: fix base clock usage in preset value
To:     Alan Cooper <alcooperx@gmail.com>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
 <23c3fe72b0ff0eabdbf3a45023a76da1b18a7e90.1585827904.git.mirq-linux@rere.qmqm.pl>
 <218dd61b-48cc-a161-240f-b3823e8f48cb@intel.com>
 <20200415162839.GD19897@qmqm.qmqm.pl>
 <57b494b8-cae9-df10-2a4d-db02e7212f23@intel.com>
 <CAOGqxeVB2FTTi4DFynVj4hc+EcagMCg1j8F29L+9zRt1DKfbBQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ed0f22ba-fe9f-d305-a685-169741782ad1@intel.com>
Date:   Mon, 20 Apr 2020 08:31:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAOGqxeVB2FTTi4DFynVj4hc+EcagMCg1j8F29L+9zRt1DKfbBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/04/20 4:55 pm, Alan Cooper wrote:
> Acked-by: Al Cooper <alcooperx@gmail.com>On Thu, Apr 16, 2020 at 4:27
> AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 15/04/20 7:28 pm, Michał Mirosław wrote:
>>> On Wed, Apr 15, 2020 at 03:25:52PM +0300, Adrian Hunter wrote:
>>>> On 2/04/20 2:54 pm, Michał Mirosław wrote:
>>>>> Fixed commit added an unnecessary read of CLOCK_CONTROL. The value read
>>>>> is overwritten for programmable clock preset, but is carried over for
>>>>> divided clock preset. This can confuse sdhci_enable_clk() if the register
>>>>> has enable bits set for some reason at time time of clock calculation.
>>>>> value to be ORed with enable flags. Remove the read.
>>>>
>>>> The read is not needed, but drivers usually manage the enable bits,
>>>> especially disabling the clock before changing the frequency.  What driver
>>>> is it?
>>>
>>> Hopefully no driver requires this. It's just removing a trap.
>>
>> The only driver that looks like it would benefit is sdhci-brcmstb because it
>> does not clear enable bits in sdhci_brcmstb_set_clock().  Adding Al Cooper.
>> Al, can you ack this?
> 
> sdhci_brcmstb_set_clock() assumed that sdhci_calc_clk() would always
> return the divider value without the enable set, so this fixes a case
> for DDR52 where the enable was not being cleared when the divider
> value was changed.
> Acked-by: Al Cooper <alcooperx@gmail.com>
> 

That is good to know.  The commit message needs to be updated with that
information, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
