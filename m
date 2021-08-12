Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2044FC4338F
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Aug 2021 09:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA22760EB9
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Aug 2021 09:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbhHLJyg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Aug 2021 05:54:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:22918 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236556AbhHLJy3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Aug 2021 05:54:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="202481037"
X-IronPort-AV: E=Sophos;i="5.84,315,1620716400"; 
   d="scan'208";a="202481037"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 02:53:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,315,1620716400"; 
   d="scan'208";a="676707067"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga005.fm.intel.com with ESMTP; 12 Aug 2021 02:53:53 -0700
Subject: Re: [PATCH v4 2/5] mmc: sdhci: always obey programmable clock config
 in preset value
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>
References: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
 <e65dc96eb24caf8baa5431a51fe694b969e2d51f.1627204633.git.mirq-linux@rere.qmqm.pl>
 <fe01b20d-779b-1e2c-7702-5a4702900d84@intel.com>
 <YQ6TEhMLXH/4r4BS@qmqm.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <38e93996-d815-1b62-8d93-8b9bbed384a6@intel.com>
Date:   Thu, 12 Aug 2021 12:54:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQ6TEhMLXH/4r4BS@qmqm.qmqm.pl>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 7/08/21 5:05 pm, Micha³ Miros³aw wrote:
> On Wed, Aug 04, 2021 at 01:52:21PM +0300, Adrian Hunter wrote:
>> On 25/07/21 12:20 pm, Micha³ Miros³aw wrote:
>>> When host controller uses programmable clock presets but doesn't
>>> advertise programmable clock support, we can only guess what frequency
>>> it generates. Let's at least return correct SDHCI_PROG_CLOCK_MODE bit
>>> value in this case.
>> If the preset value doesn't make sense, why use it at all?
> 
> If I understand the spec correctly, when the preset value is used the
> values in Clock Control register are ignored by the module and so the
> module can also actually use a different clock source than the ones
> available to the driver directly.

I don't remember, does it say that in the spec?

>                                   So either way the driver can't be
> sure of the exact frequencu used. This is a cleanup to remove a case
> when the code ignores a bit's value based on other unspecified assumptions.

Is this fixing a real issue?  It seems like switching from one undefined
scenario to another.  Are either of which known to have ever happened?

Perhaps we should leave it as is.

> 
> [...]
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1859,11 +1859,14 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>>>  
>>>  			pre_val = sdhci_get_preset_value(host);
>>>  			div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
>>> -			if (host->clk_mul &&
>>> -				(pre_val & SDHCI_PRESET_CLKGEN_SEL)) {
>>> +			if (pre_val & SDHCI_PRESET_CLKGEN_SEL) {
>>>  				clk = SDHCI_PROG_CLOCK_MODE;
>>>  				real_div = div + 1;
>>>  				clk_mul = host->clk_mul;
>>> +				if (!clk_mul) {
>>> +					/* The clock frequency is unknown. Assume undivided base. */
>>> +					clk_mul = 1;
>>> +				}
>>>  			} else {
>>>  				real_div = max_t(int, 1, div << 1);
>>>  			}

