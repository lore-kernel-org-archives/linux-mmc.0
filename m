From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pxamci: prepare and unprepare the clocks
Date: Tue, 2 Sep 2014 09:53:51 +0200
Message-ID: <CAPDyKFqZOthoLqVVkeGY2d+KgQbn4Hm2E48mJt0W1hX3bpxkDw@mail.gmail.com>
References: <1402343774-1072-1-git-send-email-robert.jarzmik@free.fr>
	<CAPDyKFr2SXz2yco5jzbkmrRZvCNQNbA7OjjX=WAtmcBJ1vYynw@mail.gmail.com>
	<871trv5y6t.fsf@free.fr>
	<CAPDyKFpaX4UHW-_z=yy7UA1Xuv2LZqQkttJ-tWugZYSXD4VwiQ@mail.gmail.com>
	<87sikb4gi5.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:38719 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbaIBHxx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Sep 2014 03:53:53 -0400
Received: by mail-lb0-f182.google.com with SMTP id u10so7159595lbd.27
        for <linux-mmc@vger.kernel.org>; Tue, 02 Sep 2014 00:53:51 -0700 (PDT)
In-Reply-To: <87sikb4gi5.fsf@free.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 1 September 2014 15:28, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> I understand your concern, but I don't see why there should be any
>> major difference in clock management code (clk tree wise), due to this
>> patch. It worked before, so likely it will work now!?
>
> It will ony work *differently*, it will change the clock management. It won't
> break, but again it's *not* the purpose of the patch.  The patch is aimed at
> removing a warning.

Sorry if I was to vague, you must have misinterpreted my proposal. Let
me try clarify how I think a patch should look like to solve the
warning.

1) In pxamci_set_ios() replace " clk_enable()" with clk_prepare_enable().
2) In pxamci_set_ios() replace " clk_disable()" with clk_disable_unprepare().

That should do the trick!

Kind regards
Uffe
