From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 2/4] mmc: tmio: Add tuning support
Date: Tue, 23 Aug 2016 17:02:56 +0200
Message-ID: <CAPDyKFpbMnOag7TZtQXxffXyq4XjTfz3vYM_atks15+d64QkfQ@mail.gmail.com>
References: <1469592803-13842-1-git-send-email-horms+renesas@verge.net.au>
 <1469592803-13842-3-git-send-email-horms+renesas@verge.net.au>
 <CAPDyKFq_Fs_bNx7LP-J+nC3iaNgB7gvZAvhCp--qVOh1iAh0vg@mail.gmail.com> <20160823135251.GA25665@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160823135251.GA25665@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>> > +static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>> > +{
>> > +       struct tmio_mmc_host *host = mmc_priv(mmc);
>> > +       unsigned int num;
>> > +       int i, ret = 0;
>> > +       bool *tap;
>> > +
>> > +       if (!host->init_tuning || !host->select_tuning)
>>
>> When defining these callbacks, it would be nice to know which ones are
>> optional and which ones are required.
>
> Would some comments in struct tmio_mmc_host be an appropriate way
> to achieve that?

Yes, that would be nice!

[...]

>> >  static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
>> > @@ -1202,6 +1276,9 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
>> >         struct mmc_host *mmc = dev_get_drvdata(dev);
>> >         struct tmio_mmc_host *host = mmc_priv(mmc);
>> >
>> > +       mmc_retune_timer_stop(host->mmc);
>> > +       mmc_retune_needed(host->mmc);
>>
>> I am wondering whether it would it be possible to keep a cache of the
>> currently used tuning values and then restore these values at
>> runtime_resume?
>>
>> In that way you wouldn't need to force new re-tuning cycle here.
>
> I will check with the hardware people to see if it is practical from
> that POV.

Okay!

>
> From a software POV that ought to be simple enough: a small bitmap ought
> to be sufficient to save the values for the hardware covered by this
> series.

Yes, indeed!

Kind regards
Uffe
