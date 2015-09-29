From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] tmio_mmc_pio: test TMIO_MMC_WRPROTECT_DISABLE earlier
Date: Tue, 29 Sep 2015 12:22:48 +0200
Message-ID: <CAPDyKFrFfN9ty25=rGrQ_TuaSDG-qtM8Dd_HxhB4oW+mhNM4vQ@mail.gmail.com>
References: <1513691.2yatcrs42i@wasted.cogentembedded.com>
	<CAPDyKFqt3AygyfXG5M-jTVqdvLi0CxWuyUmPFjg+A0dmz+o7qA@mail.gmail.com>
	<5605C712.3060400@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <5605C712.3060400@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>>
>> Actually this change won't have the desired effect, as the mmc core
>> already done a pm_runtime_get_sync() since it has claimed the mmc
>> host[1].
>
>
>> I do realize that most drivers are still maintaining the
>> pm_runtime_get|put() calls, but in most cases that's not needed any
>> more.
>
>
>    Hm, OK. Should be OK to remove the RPM dances from at least this
> particular driver, right?

In most cases, yes.

There may be corner cases where the host is accessed without having
the mmc core involved (and thus the host hasn't been claimed).

>
>> [1]
>> commit 9250aea76bfc ("mmc: core: Enable runtime PM management of host
>> devices")
>
>
>    Looking at the code, the following fragment of mmc_attach_sd() doesn't
> make much sense to me:
>
>         mmc_release_host(host);
>         err = mmc_add_card(host->card);
>         mmc_claim_host(host);
>         if (err)
>                 goto remove_card;
>
>         return 0;
>
> remove_card:
>         mmc_release_host(host);
>         mmc_remove_card(host->card);
>         host->card = NULL;
>         mmc_claim_host(host);
>
>    Why claim the host and immediately release it on mmc_add_card() error?
> Can we only claim on success and save a call here?

You are right, we can simplify the sequence!

Do you want to send a patch? Actually, it's similar for mmc_attach_mmc()...

Kind regards
Uffe
