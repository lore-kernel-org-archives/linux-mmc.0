Return-Path: <SRS0=Ofta=42=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B99C10F29
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 11:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6466220409
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 11:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgCIL4P (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:56:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:23453 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgCIL4P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Mar 2020 07:56:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 04:56:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,533,1574150400"; 
   d="scan'208";a="235664047"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga008.jf.intel.com with ESMTP; 09 Mar 2020 04:56:11 -0700
Subject: Re: [PATCH v2 06/11] mmc: sdhci: xenon: Use
 sdhci_set_power_and_voltage()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, Hu Ziji <huziji@marvell.com>
Cc:     phil@raspberrypi.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        stefan.wahren@i2se.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20200306174413.20634-1-nsaenzjulienne@suse.de>
 <20200306174413.20634-7-nsaenzjulienne@suse.de>
 <4e74203a-5444-2b7a-3555-9615cc45aaae@intel.com>
 <06fc4d492f66bfbe7260937efa849f77c7c12b0d.camel@suse.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <eb9cc6e8-0f15-a609-9f99-c8677eb3354f@intel.com>
Date:   Mon, 9 Mar 2020 13:55:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <06fc4d492f66bfbe7260937efa849f77c7c12b0d.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 9/03/20 12:53 pm, Nicolas Saenz Julienne wrote:
> On Mon, 2020-03-09 at 09:20 +0200, Adrian Hunter wrote:
>>> -static void xenon_set_power(struct sdhci_host *host, unsigned char mode,
>>> -		unsigned short vdd)
>>> -{
>>> -	struct mmc_host *mmc = host->mmc;
>>> -	u8 pwr = host->pwr;
>>> -
>>> -	sdhci_set_power_noreg(host, mode, vdd);
>>> -
>>> -	if (host->pwr == pwr)
>>> -		return;
>>> -
>>> -	if (host->pwr == 0)
>>> -		vdd = 0;
>>> -
>>> -	if (!IS_ERR(mmc->supply.vmmc))
>>> -		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>>> -}
>>
>> This code is different.  The commit message should explain why it is
>> equivalent.  Has it been tested?
> 
> Yes, I should've pointed it out. The rationale behind including sdhci-xenon and
> sdhci-pxav3 is based on xenon's original commit message (99c14fc360dbb):
> 
> 	mmc: sdhci-xenon: add set_power callback
> 
> 	Xenon sdh controller requests proper SD bus voltage select
> 	bits programmed even with vmmc power supply. Any reserved
> 	value(100b-000b) programmed in this field will lead to controller
> 	ignore SD bus power bit and keep its value at zero.
> 	Add set_power callback to handle this.
> 
> I can't test it, but it felt to me as the implementation differences are only
> there as different people wrote the code. Ultimately, I'll be happy to drop
> them from the series if you feel it's too much of an assumption, I can see how
> the controllers could react badly to the ordering change. If not I can send a
> v3 with fixed commit messages.

We can wait a bit and see if anyone provides a Tested-by tag, otherwise
safer to drop it.
