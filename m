From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] tmio_mmc_pio: test TMIO_MMC_WRPROTECT_DISABLE earlier
Date: Tue, 29 Sep 2015 17:05:01 +0300
Message-ID: <560A9A8D.1080808@cogentembedded.com>
References: <1513691.2yatcrs42i@wasted.cogentembedded.com>
 <CAPDyKFqt3AygyfXG5M-jTVqdvLi0CxWuyUmPFjg+A0dmz+o7qA@mail.gmail.com>
 <5605C712.3060400@cogentembedded.com>
 <CAPDyKFrFfN9ty25=rGrQ_TuaSDG-qtM8Dd_HxhB4oW+mhNM4vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrFfN9ty25=rGrQ_TuaSDG-qtM8Dd_HxhB4oW+mhNM4vQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello.

On 09/29/2015 01:22 PM, Ulf Hansson wrote:

> [...]

>>> Actually this change won't have the desired effect, as the mmc core
>>> already done a pm_runtime_get_sync() since it has claimed the mmc
>>> host[1].
>>
>>> I do realize that most drivers are still maintaining the
>>> pm_runtime_get|put() calls, but in most cases that's not needed any
>>> more.
>>
>>     Hm, OK. Should be OK to remove the RPM dances from at least this
>> particular driver, right?
>
> In most cases, yes.
>
> There may be corner cases where the host is accessed without having
> the mmc core involved (and thus the host hasn't been claimed).

    OK, I'll try to look into this further...

>>> [1]
>>> commit 9250aea76bfc ("mmc: core: Enable runtime PM management of host
>>> devices")
>>
>>     Looking at the code, the following fragment of mmc_attach_sd() doesn't
>> make much sense to me:
>>
>>          mmc_release_host(host);
>>          err = mmc_add_card(host->card);
>>          mmc_claim_host(host);
>>          if (err)
>>                  goto remove_card;
>>
>>          return 0;
>>
>> remove_card:
>>          mmc_release_host(host);
>>          mmc_remove_card(host->card);
>>          host->card = NULL;
>>          mmc_claim_host(host);
>>
>>     Why claim the host and immediately release it on mmc_add_card() error?
>> Can we only claim on success and save a call here?

> You are right, we can simplify the sequence!

    OK, what about calling mmc_remove_card() on mmc_add_card() failure?
Isn't it also superfluous?

> Do you want to send a patch?

    Yes, I have it almost ready...

> Actually, it's similar for mmc_attach_mmc()...

    Hm, will look into this case as well...

> Kind regards
> Uffe

MBR, Sergei

