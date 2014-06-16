From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 3/3] mmc: mmci: Reverse IRQ handling for the arm_variant
Date: Mon, 16 Jun 2014 23:20:54 +0200
Message-ID: <CAPDyKFqK5G0j7ZKAYJqD+ZqBFCjuLTw=NtjBcAsfM=Xzd4cghA@mail.gmail.com>
References: <1402906147-26596-1-git-send-email-ulf.hansson@linaro.org>
	<CALAqxLWs5HLhLo+BspcgyJe0O++PB1HU2G1GpsoQ=cVP34=v=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:56182 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312AbaFPVUz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 17:20:55 -0400
Received: by mail-qc0-f169.google.com with SMTP id c9so8908117qcz.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2014 14:20:54 -0700 (PDT)
In-Reply-To: <CALAqxLWs5HLhLo+BspcgyJe0O++PB1HU2G1GpsoQ=cVP34=v=A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Peter Maydell <peter.maydell@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On 16 June 2014 20:58, John Stultz <john.stultz@linaro.org> wrote:
> On Mon, Jun 16, 2014 at 1:09 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Commit "mmc: mmci: Handle CMD irq before DATA irq", caused an issue
>> when using the ARM model of the PL181 and running QEMU.
>>
>> The bug was reported for the following QEMU version:
>> $ qemu-system-arm -version
>> QEMU emulator version 2.0.0 (Debian 2.0.0+dfsg-2ubuntu1.1), Copyright
>> (c) 2003-2008 Fabrice Bellard
>>
>> To resolve the problem, let's restore the old behavior were the DATA
>> irq is handled prior the CMD irq, but only for the arm_variant, which
>> the problem was reported for.
>>
>> Reported-by: John Stultz <john.stultz@linaro.org>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Hey Ulf,
>   Thanks for sending these out (though I wasn't cc'ed on this 3'rd
> patch). The first two apply for me, but this one doesn't. What should
> I be basing this off of?

Hi John,

Thanks for helping out testing!

This patch based upon my latest mmc tree and the next branch. I tried
to apply it for 3.15, and I think you will be able resolve the
conflict - I should be quite trivial.

Patch 1 and 2 applies on 3.15 as well. So I guess testing this on 3.15
will provide us with answers if it solves our problem.

Kind regards
Uffe
