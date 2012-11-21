From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Fixup and cleanup code for DMA handling
Date: Wed, 21 Nov 2012 16:22:37 +0100
Message-ID: <CAPDyKFqt-yaA9LNAMEH0bE+109bceAuO94B+W5UbMmGUsVWFKw@mail.gmail.com>
References: <1350056012-18625-1-git-send-email-ulf.hansson@stericsson.com>
	<CACRpkdZqe3uB9wGM5g5LUJuZEtzeBW=Hs5RF=5_CKU0CBWJRyA@mail.gmail.com>
	<CAPDyKFr=aN+MN+VCvbAqNa7mu+fxTTeHdcA1oCv8QWqpdT8MGQ@mail.gmail.com>
	<CACRpkdZPbrvfk0QNB7x8YZ+DVibPJMTLsLDSf310CcBEeOTuww@mail.gmail.com>
	<CAPDyKFqfjaDcj361eoMtp3BwQMAW5JcUcyoovFPzXdL0a3dzUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:61854 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856Ab2KUPWi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Nov 2012 10:22:38 -0500
Received: by mail-wi0-f178.google.com with SMTP id hm6so2002925wib.1
        for <linux-mmc@vger.kernel.org>; Wed, 21 Nov 2012 07:22:37 -0800 (PST)
In-Reply-To: <CAPDyKFqfjaDcj361eoMtp3BwQMAW5JcUcyoovFPzXdL0a3dzUg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Per Forlin <per.forlin@stericsson.com>

On 16 October 2012 13:44, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 16 October 2012 10:17, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, Oct 16, 2012 at 9:16 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>>> This code has not been tested on a "legacy" ARM PL180 but only for
>>> ux500 boards. Even if it should affect DMA handling we should test
>>> this properly. Would be great if you were able to help out, I guess
>>> you still have available hardware for these tests?
>>
>> I can test the Integrator/CP and Realview in IRQ/PIO mode and
>> the U300 in DMA mode.
>
> Great!
>
>>
>> I need some help to provoke errorpath in DMA mode though,
>> so any hints are welcome...
>
> One good option could be to stress test card insert/removal sequences,
> while at the same time doing read/write requests.
>
>>
>> Yours,
>> Linus Walleij
>
> Kind regards
> Ulf Hansson

Just a kind reminder for Linus; did you manage to do some tests for
these patches?

Kind regards
Ulf Hansson
