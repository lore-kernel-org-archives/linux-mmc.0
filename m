From: merez@codeaurora.org
Subject: Re: [PATCH v10] mmc: support BKOPS feature for eMMC
Date: Wed, 18 Jul 2012 10:13:06 -0700 (PDT)
Message-ID: <f0809fa3331a60eb645490cae529c723.squirrel@www.codeaurora.org>
References: <c6e6e1f03f528666c9080b92a8e15317.squirrel@www.codeaurora.org>
    <50065ACE.1030802@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:32435 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529Ab2GRRNJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jul 2012 13:13:09 -0400
In-Reply-To: <50065ACE.1030802@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: merez@codeaurora.org, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@stericsson.com>


>>> +void mmc_start_bkops(struct mmc_card *card)
>>> +{
>>> +	int err;
>>> +	int timeout;
>>> +	u8 use_busy_signal;
>>> +
>>> +	BUG_ON(!card);
>>> +	if (!card->ext_csd.bkops_en || !(card->host->caps2 & MMC_CAP2_BKOPS))
>>
>> Can you please explain why we need to have MMC_CAP2_BKOPS in addition to
>> card->ext_csd.bkops_en?
> We can remove the MMC_CAP2_BKOPS. but if someone didn't want to use the
> bkops feature,
> then can control with that capability.

I don't think that the host can decide not to support BKOPs if it is
enabled on the card. In such a case we might run into performance
degradation or even non functionality of the card if it needs to perform
BKOPs.

Thanks,
Maya
-- 
Sent by consultant of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

