Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C262C10F29
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 15:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338E620738
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 15:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgCQPHK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:07:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:23049 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgCQPHK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Mar 2020 11:07:10 -0400
IronPort-SDR: W+pmRMzMsWWIonsSDVOoS0JiKVoVBdMnAEqGhq1KB+/RK2vfyOjQSmkwwkKbpsAWLqD+41LJl9
 TXCIaMyYNgtg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 08:07:09 -0700
IronPort-SDR: +8+4g4cTydYa/j7bUY6QqCEIpWQSFEJnJ6LCC7IGQCOV3sCnsQhbFyB0u4NH4Op51mh7L5JV/y
 J0Zwp5bkIa7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="445524084"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga006.fm.intel.com with ESMTP; 17 Mar 2020 08:07:07 -0700
Subject: Re: [PATCH v2 0/3] Introduce the request_atomic() for the host
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1584428736.git.baolin.wang7@gmail.com>
 <7866e519-80ad-8678-6708-7726a53ea4f5@intel.com>
 <CADBw62q7q=wqKGBnLRA+npYLVZVXeMiFwGP-K1TLkG2GPCwLjg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ce622b0c-6ec0-10c8-f71f-fa2bba8b4a66@intel.com>
Date:   Tue, 17 Mar 2020 17:06:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CADBw62q7q=wqKGBnLRA+npYLVZVXeMiFwGP-K1TLkG2GPCwLjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/03/20 3:49 pm, Baolin Wang wrote:
> On Tue, Mar 17, 2020 at 9:25 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 17/03/20 12:14 pm, Baolin Wang wrote:
>>> This patch set introduces a new request_atomic() interface for the
>>> MMC host controller, which is used to submit a request to host in
>>> the atomic context, such as in the irq hard handler, to reduce the
>>> request latency.
>>>
>>> Any comments are welcome. Thanks.
>>>
>>> Note: Adrian pointed out that it is not good if moving the polling of
>>> inhibit bits in sdhci_send_command() into the interrupt context, but
>>> now I have not found a better way to address Adrian's concern. Moveover
>>> this is an unusual abnormal case and the original code has the same
>>> problem, so I plan to create another patch set to talk about and fix
>>> this issue.
>>
>> I tend to think the API requires the possibility for host controllers to
>> return "busy", so that should be sorted out first.
> 
> If request_atomic() can return 'busy', the HSQ need queue a work to
> dispatch this request to host again?

Sounds reasonable

> 
> I am thinking if I can introduce a new flag to avoid polling the
> status before sending commands, cause from the datasheet, I did not
> see we should need do this if the command complete and transfer
> complete interrupts are processed normally. At least on my platfrom, I
> did not see the inhibit bits are set. If we meet this issue, I think
> some abormal things are happened, we should give out errors. How do
> you think?

For the atomic path, some kind of warning would be ok.

> 
>>>
>>> Changes from v1:
>>>  - Re-split the changes to make them more clear suggested by Ulf.
>>>  - Factor out the auto CMD23 checking into a separate function.
>>>
>>> Baolin Wang (3):
>>>   mmc: host: Introduce the request_atomic() for the host
>>>   mmc: host: sdhci: Implement the request_atomic() API
>>>   mmc: host: sdhci-sprd: Implement the request_atomic() API
>>>
>>>  drivers/mmc/host/mmc_hsq.c    |  5 ++++-
>>>  drivers/mmc/host/sdhci-sprd.c | 23 ++++++++++++++++++++---
>>>  drivers/mmc/host/sdhci.c      | 27 +++++++++++++++++++--------
>>>  drivers/mmc/host/sdhci.h      |  1 +
>>>  include/linux/mmc/host.h      |  3 +++
>>>  5 files changed, 47 insertions(+), 12 deletions(-)
>>>
>>
> 
> 

