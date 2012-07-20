From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RESEND PATCH v10] mmc: support BKOPS feature for eMMC
Date: Fri, 20 Jul 2012 15:57:04 +0300
Message-ID: <500955A0.10205@intel.com>
References: <500823C5.4010503@samsung.com> <0af2721026286ee4d196ead20848664e.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33952 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753473Ab2GTM4E (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 Jul 2012 08:56:04 -0400
In-Reply-To: <0af2721026286ee4d196ead20848664e.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Konstantin Dorfman <kdorfman@codeaurora.org>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>

On 20/07/12 14:58, merez@codeaurora.org wrote:
> 
> On Thu, July 19, 2012 8:12 am, Jaehoon Chung wrote:
>> +void mmc_start_bkops(struct mmc_card *card, bool from_exception)
>> +{
>> +        int err;
>> +        int timeout;
>> +        bool use_busy_signal;
>> +
>> +        BUG_ON(!card);
>> +
>> +        if (!card->ext_csd.bkops_en || mmc_card_doing_bkops(card) ||
>> +                !(card->host->caps2 & MMC_CAP2_BKOPS))
>> +                return;
> To my opinion, the host cannot decide not to support BKOPs if it is
> enabled by the card. In such a case, the card will expect the host to
> start the BKOPs and may get into performance degradation.
> I think the MMC_CAP2_BKOPS should be removed.
> Does everyone agree or do I miss something?

I agree.  The spec says of bkops_en "Host is indicating that it shall
periodically write to BKOPS_START field to manually start
background operations."
