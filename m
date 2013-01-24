From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Add new VE MMCI variant
Date: Thu, 24 Jan 2013 14:04:33 +0100
Message-ID: <CAPDyKFoRpig+nYuPFKcBFx2AYA7R=_Mjfc91DWwvRX=DDz_NUg@mail.gmail.com>
References: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
	<1359032068.26878.50.camel@hornet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:58610 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868Ab3AXNEf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jan 2013 08:04:35 -0500
Received: by mail-la0-f41.google.com with SMTP id fo12so4613227lab.28
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jan 2013 05:04:33 -0800 (PST)
In-Reply-To: <1359032068.26878.50.camel@hornet>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

On 24 January 2013 13:54, Pawel Moll <pawel.moll@arm.com> wrote:
> Hi Chris,
>
> On Fri, 2012-12-14 at 15:38 +0000, Pawel Moll wrote:
>> The Versatile Express IOFPGA as shipped on VECD 5.0 (bitfiles v108/208
>> and v116/216) contains a modified version of the PL180 MMCI, with
>> PeriphID Configuration value changed to 0x2.
>>
>> This version adds an optional "hardware flow control" feature. When
>> enabled MMC card clock will be automatically disabled when FIFO is
>> about to over/underflow and re-enabled once the host retrieved some
>> data. This makes the controller immune to over/underrun errors caused
>> by big interrupt handling latencies.
>>
>> This patch adds relevant device variant in the driver.
>>
>> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
>
> This is just a polite, post-holiday, reminder about this patch... It has
> been "Reviewed-by: Linus Walleij <linus.walleij@linaro.org>".
>
> Cheers!
>
> Pawel
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Of course you may have my Ack for this as well.

Normally we use Russell's tree for mmci patches. So I suppose you
should upload this patch into his patchtracker instead!?

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Ulf Hansson
