From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: pxamci: prepare and unprepare the clocks
Date: Mon, 1 Sep 2014 14:49:03 +0200
Message-ID: <CAPDyKFpaX4UHW-_z=yy7UA1Xuv2LZqQkttJ-tWugZYSXD4VwiQ@mail.gmail.com>
References: <1402343774-1072-1-git-send-email-robert.jarzmik@free.fr>
	<CAPDyKFr2SXz2yco5jzbkmrRZvCNQNbA7OjjX=WAtmcBJ1vYynw@mail.gmail.com>
	<871trv5y6t.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:48065 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbaIAMtF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Sep 2014 08:49:05 -0400
Received: by mail-la0-f41.google.com with SMTP id gi9so6099255lab.0
        for <linux-mmc@vger.kernel.org>; Mon, 01 Sep 2014 05:49:03 -0700 (PDT)
In-Reply-To: <871trv5y6t.fsf@free.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 1 September 2014 14:20, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>>
>> I would suggest you to re-place the existing clk_enable() with
>> clk_prepare_enable() and clk_disable with clk_disable_unprepare()
>> instead of the approach taken in this patch.
>
> I don't think it works in this driver.
>
> Look at pxamci_set_ios(), and all the handling of host->clkrt (CLKRT_OFF,
> ...). This driver enables the clock only when transfers are required, not all
> the time. Therefore I'd rather let it be that way.

I understand your concern, but I don't see why there should be any
major difference in clock management code (clk tree wise), due to this
patch. It worked before, so likely it will work now!?

Kind regards
Uffe
