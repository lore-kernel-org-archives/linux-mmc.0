Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1279EC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 10:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1DA8610F7
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 10:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245299AbhIXKIU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 06:08:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:29010 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244963AbhIXKIU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 24 Sep 2021 06:08:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="204198561"
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="204198561"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 03:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="703468211"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.84]) ([10.237.72.84])
  by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2021 03:06:35 -0700
Subject: Re: [PATCH v1 2/2] mmc: sdhci: Use the SW timer when the HW timer
 cannot meet the timeout value required by the device
To:     Bean Huo <huobean@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bean Huo <beanhuo@micron.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210917172727.26834-1-huobean@gmail.com>
 <20210917172727.26834-3-huobean@gmail.com>
 <fc14d8e1-9438-d4b0-80f4-ccf9055ab7d3@intel.com>
 <beda2d5ecc3c15e9bf9aa18383c22c2a90d31dab.camel@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <93292ef4-8548-d2ba-d803-d3b40b7e6c1d@intel.com>
Date:   Fri, 24 Sep 2021 13:07:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <beda2d5ecc3c15e9bf9aa18383c22c2a90d31dab.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/09/21 12:17 pm, Bean Huo wrote:
> On Fri, 2021-09-24 at 08:29 +0300, Adrian Hunter wrote:
>>> If the data transmission timeout value required by the device
>>> exceeds
>>> the maximum timeout value of the host HW timer, we still use the HW
>>> timer with the maximum timeout value of the HW timer. This setting
>>> is
>>> suitable for most R/W situations. But sometimes, the device will
>>> complete
>>> the R/W task within its required timeout value (greater than the HW
>>> timer).
>>> In this case, the HW timer for data transmission will time out.
>>> Currently, in this condition, we  disable the HW timer and use the
>>> SW
>>> timer only when the SDHCI_QUIRK2_DISABLE_HW_TIMEOUT quirk is set by
>>> the
>>> host driver. The patch is to remove this if statement restriction
>>> and
>>> allow data transmission to use the SW timer when the hardware timer
>>> cannot
>>> meet the required timeout value.
>>
>>
>> The reason it is a quirk is because it does not work for all
>> hardware.
>>
>> For some controllers the timeout cannot really be disabled, only the
>>
>> interrupt is disabled, and then the controller never indicates
>> completion
>>
>> if the timeout is exceeded.
> 
> Hi Adrian,
> Thanks for your review.
> 
> Yes, you are right. But this quirk prevents disabling the hardware timeoutIRQ. The purpose of this patch is to disable the hardware timeout IRQ and
> select the software timeout.
> 
> void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command
> *cmd)
> {
>         bool too_big = false;
>         u8 count = sdhci_calc_timeout(host, cmd, &too_big);
> 
>         if (too_big) {
>                 sdhci_calc_sw_timeout(host, cmd);
>                 sdhci_set_data_timeout_irq(host, false); // disable IRQ
>         } else if (!(host->ier & SDHCI_INT_DATA_TIMEOUT)) {
>                 sdhci_set_data_timeout_irq(host, true);
>         }
> 
>         sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
> }
> 
> 
> The driver has detected that the hardware timer cannot meet the timeout
> requirements of the device, but we still use the hardware timer, which will
> allow potential timeout issuea . Rather than allowing a potential
> problem to exist, why can’t software timing be used to avoid this
> problem?

Timeouts aren't that accurate.  The maximum is assumed still to work.
mmc->max_busy_timeout is used to tell the core what the maximum is.
