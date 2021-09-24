Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFB5C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 13:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA10761076
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 13:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344853AbhIXN1h (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 09:27:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:45048 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346449AbhIXN1e (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 24 Sep 2021 09:27:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="203567688"
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="203567688"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 06:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="559621419"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.84]) ([10.237.72.84])
  by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2021 06:25:58 -0700
Subject: Re: [PATCH v1 2/2] mmc: sdhci: Use the SW timer when the HW timer
 cannot meet the timeout value required by the device
To:     Bean Huo <huobean@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bean Huo <beanhuo@micron.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210917172727.26834-1-huobean@gmail.com>
 <20210917172727.26834-3-huobean@gmail.com>
 <fc14d8e1-9438-d4b0-80f4-ccf9055ab7d3@intel.com>
 <beda2d5ecc3c15e9bf9aa18383c22c2a90d31dab.camel@gmail.com>
 <93292ef4-8548-d2ba-d803-d3b40b7e6c1d@intel.com>
 <40e525300cd656dd17ffc89e1fcbc9a47ea90caf.camel@gmail.com>
 <79056ca7-bfe3-1b25-b6fd-de8a9388b75f@intel.com>
 <5a5db6c2eed2273a8903b5052312f039dd629401.camel@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5072935e-d855-7029-1ac0-0883978f66e5@intel.com>
Date:   Fri, 24 Sep 2021 16:26:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5a5db6c2eed2273a8903b5052312f039dd629401.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/09/21 4:08 pm, Bean Huo wrote:
> On Fri, 2021-09-24 at 15:17 +0300, Adrian Hunter wrote:
>>>>>          sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
>>>>> }
>>>>> The driver has detected that the hardware timer cannot meet the
>>>>> timeout
>>>>> requirements of the device, but we still use the hardware
>>>>> timer,
>>>>> which will
>>>>> allow potential timeout issuea . Rather than allowing a
>>>>> potential
>>>>> problem to exist, why can’t software timing be used to avoid
>>>>> this
>>>>> problem?
>>>> Timeouts aren't that accurate.  The maximum is assumed still to
>>>> work.
>>>> mmc->max_busy_timeout is used to tell the core what the maximum
>>>> is.
>>> mmc->max_busy_timeout is still a representation of Host HW timer
>>> maximum timeout count, isn't it? 
>>
>>
>> Not necessarily.  For SDHCI_QUIRK2_DISABLE_HW_TIMEOUT it would be
>>
>> set to zero to indicate no maximum.
> 
> yes, this is the purpose of the patch, for the host controller without
> quirk SDHCI_QUIRK2_DISABLE_HW_TIMEOUT, if the timeout count required by
> device is beyond the HW timer max count, we choose SW timer to avoid the HW timer timeout IRQ.
> 
> I don't know if I get it correctly.

Why can't drivers that want the behaviour just set the quirk?

Drivers that do not work with the quirk, do not have to set it.
