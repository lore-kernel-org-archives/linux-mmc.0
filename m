From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] tmio_mmc_pio: test TMIO_MMC_WRPROTECT_DISABLE earlier
Date: Wed, 30 Sep 2015 12:07:08 +0200
Message-ID: <CAPDyKFp7JZNfw7BCGSZ07LzJ6iXG_DFZwemZRrGBPo_QPybi6Q@mail.gmail.com>
References: <1513691.2yatcrs42i@wasted.cogentembedded.com>
	<CAPDyKFqt3AygyfXG5M-jTVqdvLi0CxWuyUmPFjg+A0dmz+o7qA@mail.gmail.com>
	<5605C712.3060400@cogentembedded.com>
	<CAPDyKFrFfN9ty25=rGrQ_TuaSDG-qtM8Dd_HxhB4oW+mhNM4vQ@mail.gmail.com>
	<560A9A8D.1080808@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <560A9A8D.1080808@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>>>     Looking at the code, the following fragment of mmc_attach_sd()
>>> doesn't
>>> make much sense to me:
>>>
>>>          mmc_release_host(host);
>>>          err = mmc_add_card(host->card);
>>>          mmc_claim_host(host);
>>>          if (err)
>>>                  goto remove_card;
>>>
>>>          return 0;
>>>
>>> remove_card:
>>>          mmc_release_host(host);
>>>          mmc_remove_card(host->card);
>>>          host->card = NULL;
>>>          mmc_claim_host(host);
>>>
>>>     Why claim the host and immediately release it on mmc_add_card()
>>> error?
>>> Can we only claim on success and save a call here?
>
>
>> You are right, we can simplify the sequence!
>
>
>    OK, what about calling mmc_remove_card() on mmc_add_card() failure?
> Isn't it also superfluous?

Nope.

Kind regards
Uffe
