From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH v3] mmc: sleep notification
Date: Tue, 25 Aug 2015 14:04:58 +0200
Message-ID: <CAPDyKFryzJH9UHd8QJssejjA=b--_1hjRaO+B9sM5HVHo2eFZQ@mail.gmail.com>
References: <FDD07FEB422EF948A392FDC201AEEAE64FAAD701@SACMBXIP02.sdcorp.global.sandisk.com>
	<CAPDyKFoPqwDC_w1QTe7zQtJfH_5m2Gp_5uewJKy=x_LeaFqYhA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED53343C1F6EA@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFoZuNoYB1KA4bt64+qoeEmjioW9qCnwkhYAnnSD4jMxag@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED53343C409C9@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFqV4pQYUUtZYJjFP72KNeAQJMV9qMV1uN2sKCT0At3s4g@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED53343C9F474@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33131 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542AbbHYMFA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 08:05:00 -0400
Received: by igfj19 with SMTP id j19so9438222igf.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 05:04:59 -0700 (PDT)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED53343C9F474@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, linux-mmc <linux-mmc@vger.kernel.org>

[...]

>> >> > The only case where HPI is used in this patch - is during
>> >> > sleep_notify
>> >> timeout error.
>> >>
>> >> Why?
>> >
>> > In case of timeout error, we would like to handle it by sending HPI - to let
>> device interrupt/stop the prg state.
>>
>> Is that according to the spec? I think it would be better to try a reset
>> sequence to recover, by using CMD0 and so forth, what do you think?
>
> Not must by the spec, but there are several options how to handle timeout error.
> Checking the existing driver, the '-ETIMEDOUT' error is handled by mmc_interrupt_hpi ()
> in case of  mmc_wait_for_req_done() function.
> Can we use the same approach?

Currently the logic to recover from errors during system PM suspend,
relies on the request-retry mechanism which is executed far later.

>From the ->suspend() callback we will only propagate the error code
towards the PM core. That means the PM core will bail out and reverse
the actions already done for suspended devices.

In this initial patch, I suggest we stick to that behaviour.

Although, I am open to discuss a more sophisticated error handling,
but let's do that from a separate patch.

[...]

Kind regards
Uffe
