From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v11] mmc: support BKOPS feature for eMMC
Date: Mon, 27 Aug 2012 18:21:44 -0400
Message-ID: <87ehmsyo07.fsf@octavius.laptop.org>
References: <500E00E8.7040504@samsung.com>
	<CAEwNFnA0CKaORGJ1TVnjYgLgi6dtgebVZ1xUVeY6MU92LWb9RA@mail.gmail.com>
	<50164D28.4030907@samsung.com>
	<5d379475a64b20988a535fa01213d62a.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37917 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754813Ab2H0WWE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Aug 2012 18:22:04 -0400
In-Reply-To: <5d379475a64b20988a535fa01213d62a.squirrel@www.codeaurora.org>
	(merez@codeaurora.org's message of "Tue, 31 Jul 2012 07:01:18 -0700
	(PDT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Minchan Kim <minchan@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Konstantin Dorfman <kdorfman@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Adrian Hunter <adrian.hunter@intel.com>, Per FORLIN <per.forlin@stericsson.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>

Hi,

On Tue, Jul 31 2012, merez@codeaurora.org wrote:
>>> 512 byte stack? Isn't it really a problem?
>> How about this?
>>
>> +int mmc_read_bkops_status(struct mmc_card *card)
>> +{
>> +	int err;
>> +	u8 *ext_csd;
>> +
>> +	ext_csd = kmalloc(512, GFP_KERNEL);
>> +	if (!ext_csd) {
>> +		pr_err("%s: could not allocate a buffer to "
>> +			"receive the ext_csd.\n", mmc_hostname(card->host));
>> +		return -ENOMEM;
>> +	}
>> +
>> +	mmc_claim_host(card->host);
>> +	err = mmc_send_ext_csd(card, ext_csd);
>> +	mmc_release_host(card->host);
>> +	if (err)
>> +		goto out;
>> +
>> +	card->ext_csd.raw_bkops_status = ext_csd[EXT_CSD_BKOPS_STATUS];
>> +	card->ext_csd.raw_exception_status = ext_csd[EXT_CSD_EXP_EVENTS_STATUS];
>> +out:
>> +	kfree(ext_csd);
>> +	return err;
>> +}
>> +EXPORT_SYMBOL(mmc_read_bkops_status);
>
> I'm not sure it would be a good idea to allocate the buffer every time the
> ext_csd is read since with the periodic BKOPs we might do it more often to
> see if there is a need for BKOPs.
> How about keeping the buffer in the card structure?

It's a little large for that, but it would be worth it if we really do
use it regularly.  Perhaps go with the kmalloc option for now, add a
comment explaining that we should consider storing the entire ext_csd
in mmc_card later, and revisit it when the periodic bkops support is
submitted and we know how often we need to read the status?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
