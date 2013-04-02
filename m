From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] wait while adding MMC host to ensure root mounts
Date: Tue, 2 Apr 2013 19:45:28 +0200
Message-ID: <CAPDyKFpOf7G_f=J=6sDdH1NQXow5uq1+rkACGGSvpEQ-LWsm4g@mail.gmail.com>
References: <1363223183-3772-1-git-send-email-ynvich@gmail.com>
	<1363224194-7366-1-git-send-email-ynvich@gmail.com>
	<87620jmkoe.fsf@octavius.laptop.org>
	<CAPDyKFp27MUOjhydLXf92vN3cua=XcX4oTJnMGfOJPpBhtwM8Q@mail.gmail.com>
	<CAL0eWdGjPKUUcm6mStAHgHKHLABmPw7nMwDhR8D5rbvg+DPzfQ@mail.gmail.com>
	<CAPDyKFroki00+SCLjUXYN_=+qcVZwZ2H4NJacH+d8p3dFXoLPg@mail.gmail.com>
	<1364898904.2556.26.camel@host5.opentask.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:44434 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759195Ab3DBRp3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Apr 2013 13:45:29 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz10so835810veb.31
        for <linux-mmc@vger.kernel.org>; Tue, 02 Apr 2013 10:45:28 -0700 (PDT)
In-Reply-To: <1364898904.2556.26.camel@host5.opentask.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergey Yanovich <ynvich@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Namjae Jeon <linkinjeon@gmail.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On 2 April 2013 12:35, Sergey Yanovich <ynvich@gmail.com> wrote:
> On Tue, 2013-04-02 at 12:13 +0200, Ulf Hansson wrote:
>> Consider a platform having two eMMCs and one SD-card. Each eMMC card
>> will take around 400 ms to initialize and the SD-card 700 ms. The card
>> initialization times are real examples from eMMCs and SD-cards,
>> moreover those are typical values not worth cases. In total we have
>> around 1.5 s to initialize the cards.
>
> We have a separate workqueue per host, so all probes go in parallel.
> They also go in parallel with probing for other devices. So the actual
> delay is 700 ms minus maximum probing time for other devices. The time
> is either zero or small (dozen us) on the hardware I have access to
> (intel laptop, arm controller).
>
>> Now, suppose you boot using an initrd image. Thus neither of the cards
>> needs to be accessible immediately after the kernel has booted. It all
>> depends what the init process decides to do. With this patch the init
>> process will always be delayed to wait for each and every card to be
>> initialized. I would prefer a solution where this can be configurable
>> somehow, since certainly this is not the scenario you want for all
>> cases.
>
> If the system is booted using initrd and root is not on an mmc card,
> then mmc modules can be omitted from initrd. The probing will happen
> only after root is mounted.

This will not solve the problem when having one device intended for
rootfs and some other for something else. Of course, as long as the
devices uses the same mmc module. Once inserted, all devices will be
probed.

>
> If root is on an mmc, kernel needs to wait for the mmc probe.
>

True, although your patch is preventing the parallelism and instead
doing things in synchronized manner.

I think we must discuss alternative solutions instead.

Like an "mmc detect flush" mechanism or a "new card device notification" event.

Kind regards
Ulf Hansson
