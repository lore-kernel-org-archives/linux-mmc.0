From: Zoran Markovic <zoran.markovic@linaro.org>
Subject: Re: [RFC/PATCH] mmc: core: Signal wakeup event at card insert/removal
Date: Thu, 10 Oct 2013 11:41:18 -0700
Message-ID: <CAME+o4kfkVOsc+gwQSTfgZawx8kWocf2rwO7kht-qW9WiZJepw@mail.gmail.com>
References: <1379670523-13229-1-git-send-email-ulf.hansson@linaro.org>
	<CAME+o4kCPRu0EXvKPijC9bdfEZGefO9XyE=xUARpvRstunLTCA@mail.gmail.com>
	<CAPDyKFpR3rnLHs-teD5VhPEnsJbsV01zeooggQcD8884YWWGKA@mail.gmail.com>
	<5241C4CD.4080200@linaro.org>
	<CAPDyKFoSr_iExmxUpx8g+padMWSas97pEasnwk_MH6Ho7q70sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36947 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab3JJSlT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Oct 2013 14:41:19 -0400
Received: by mail-ob0-f181.google.com with SMTP id va2so1999818obc.40
        for <linux-mmc@vger.kernel.org>; Thu, 10 Oct 2013 11:41:19 -0700 (PDT)
In-Reply-To: <CAPDyKFoSr_iExmxUpx8g+padMWSas97pEasnwk_MH6Ho7q70sQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: John Stultz <john.stultz@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, San Mehat <san@google.com>, Colin Cross <ccross@android.com>

I like the simplified approach taken in this patch. Shortening the
awake time by trying to call __pm_relax() in all corner cases turned
out to be too complex.

Reviewed-by: Zoran Markovic <zoran.markovic@linaro.org>

Regards, Zoran

On 1 October 2013 02:22, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Hi John,
>
>> So how does the notification done to userspace? I wonder if you could
>> use the select/lock/read style method for releasing the kernel space
>> wakeup_source, as is done in the input layer?
>
> If I understand what you mean correctly, it is very similar what Zoran
> tried to do before in his patch!?
>
> For the mmc subsystem, especially considering the pitfalls around the
> scheduled detect work, I think it will be hard to get this right, if
> implementing like this. I fear we might end up in situations were the
> wakeup_source is never "relaxed".
>
>>
>>
>>> Not sure how to set the time-out value to meet all expectations. I
>>> believe we could also consider that inserting/removing a card is a
>>> quite seldom operation, so using a bit higher value than necessary
>>> might be okay. What do you think?
>>
>> As long as its sure to be *very* rare, then slightly longer delays
>> aren't a major problem.  The trouble with the timeout style wakelocks is
>> that they are easy to misuse and that hurts power efficiency. (I've
>> heard stories of badly written wifi drivers that took 5 minute timed
>> wakelocks on packets, which effectively kept devices from ever sleeping).
>
> In this case, I am more confident that this would actually simplify
> code that much, so we can get around all the scary pitfalls.
>
> I can only think of one case which could lead to problem. If there is
> a host driver, enabled for wakeup, that gets spurious card detect
> irqs, outside the window were you expect a card to be
> detected/removed, and at the same time do not have a software
> mechanism to "debounce" the irqs. But, should we even consider this as
> a valid case?
>
> Kind regards
> Ulf Hansson
>
>>
>> So if possible, its much better to have a normal path where the pm_relax
>> is called in most cases, using the timeout for only the few places where
>> you really can't get an end point.
>>
>> thanks
>> -john
