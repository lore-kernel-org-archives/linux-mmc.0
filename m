From: merez@codeaurora.org
Subject: RE: [PATCH v6 1/3] mmc: core: Add packed command feature of eMMC4.5
Date: Thu, 31 May 2012 12:19:48 -0700 (PDT)
Message-ID: <4cff1edb39da3b03e37840871a75c2c4.squirrel@www.codeaurora.org>
References: <009d01cd3411$0febc350$2fc349f0$%jun@samsung.com>
    <d98d78ec2312cbc5edb1b2c337ab788d.squirrel@www.codeaurora.org>
    <000001cd3d98$f015db60$d0419220$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000001cd3d98$f015db60$d0419220$@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: merez@codeaurora.org, 'Seungwon Jeon' <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


>
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of merez@codeaurora.org
>> Sent: Tuesday, May 29, 2012 5:08 PM
>> To: Seungwon Jeon
>> Cc: linux-mmc@vger.kernel.org; 'Chris Ball'; merez@codeaurora.org;
>> linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH v6 1/3] mmc: core: Add packed command feature of
>> eMMC4.5
>>
>> > @@ -1244,6 +1249,25 @@ static int mmc_init_card(struct mmc_host *host,
>> > u32 ocr,
>> >  		}
>> >  	}
>> >
>> > +	if ((host->caps2 & MMC_CAP2_PACKED_CMD) &&
>> > +			(card->ext_csd.max_packed_writes > 0) &&
>> > +			(card->ext_csd.max_packed_reads > 0)) {
>> > +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> > +				EXT_CSD_EXP_EVENTS_CTRL,
>> > +				EXT_CSD_PACKED_EVENT_EN,
>> > +				card->ext_csd.generic_cmd6_time);
>> > +		if (err && err != -EBADMSG)
>> > +			goto free_card;
>> > +		if (err) {
>> > +			pr_warning("%s: Enabling packed event failed\n",
>> > +					mmc_hostname(card->host));
>> > +			card->ext_csd.packed_event_en = 0;
>> > +			err = 0;
>> > +		} else {
>> > +			card->ext_csd.packed_event_en = 1;
>> > +		}
>> > +	}
>> > +
>> The above shoud not be performed in case of resume. Therefore it needs
>> to
> be
>> done only if (!oldcard)
>
> Maya,
> What if eMMC power (VCC and VCCQ) was removed during suspend? Then in that
> case during resume, we have to send this mmc_switch() command again. So
> this
> operation should not be under "if (!oldcard)" check.
>
> Regards,
> Subhash
Thanks for the correction, my mistake.

Thanks,
Maya Erez
Consultant for Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
