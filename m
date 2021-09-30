Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7653DC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 08:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3066B61882
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 08:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348339AbhI3JBj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Sep 2021 05:01:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:16390 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348225AbhI3JBj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 30 Sep 2021 05:01:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="224796284"
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="224796284"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 01:59:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="707851818"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga006.fm.intel.com with ESMTP; 30 Sep 2021 01:59:47 -0700
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
 <5072935e-d855-7029-1ac0-0883978f66e5@intel.com>
 <37497369a4cf5f729e7b3e31727a7d64be5482db.camel@gmail.com>
 <32b753ff-6702-fa51-2df2-32ff1d955a23@intel.com>
 <296607ef57f3fb632107997f4edca99a5722beab.camel@gmail.com>
 <b7fd4a22-65f6-d1c4-675c-5930452a1fea@intel.com>
 <3078b365b5ddfad198a5c8a097f2e7edb9730e2c.camel@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6d57e6bd-24ba-f07e-678c-691f202549d5@intel.com>
Date:   Thu, 30 Sep 2021 11:59:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3078b365b5ddfad198a5c8a097f2e7edb9730e2c.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/09/2021 11:34, Bean Huo wrote:
> Hi Adrian,
> 
> 
> Thanks.
> I want to give a short conclusion  for our discussion:
> 
> Based on your information, these sounds disable of HW timer timeout
> interrupt will make eMMC host controller malfunction, in another word,
> the disable of timeout interrupt will make the eMMC host cannot
> correctly provide the completion interrupt. And unless only when the
> SOC vendor signals that their SOC supports that the host side SW can
> disable this HW timeout interrupt, as TI does.
> 
> I studied the SDHCI Spec, and tried to see if there is this kind of
> support statement, but not been found yet. I will check with other SOC
> vendors.
> 
> I have one more question, if you know, please give me your information.
> 
> I did testing on HW timer bahevior in case CQE is on.  Currently, we
> always set the HW timer with the maximum timeout value if CQE is on.
> Based on my testing, the HW timer will never timeout when we enable
> CQE. I changed the HW timer value to be lower, it is the same result.
> Do you know that the HW timer will be inactivated in case CQE is
> on?  but its timeout interrupt is still enabled.

No I don't know how different CQE handle timeouts.

> 
> Kind regards,
> Bean
> 

