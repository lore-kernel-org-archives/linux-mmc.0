From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH V2 3/3] mmc: mmci: Reverse IRQ handling for the arm_variant
Date: Mon, 16 Jun 2014 11:58:02 -0700
Message-ID: <CALAqxLWs5HLhLo+BspcgyJe0O++PB1HU2G1GpsoQ=cVP34=v=A@mail.gmail.com>
References: <1402906147-26596-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:60179 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441AbaFPS6D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 14:58:03 -0400
Received: by mail-vc0-f180.google.com with SMTP id im17so5413530vcb.11
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2014 11:58:02 -0700 (PDT)
In-Reply-To: <1402906147-26596-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Peter Maydell <peter.maydell@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>

On Mon, Jun 16, 2014 at 1:09 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Commit "mmc: mmci: Handle CMD irq before DATA irq", caused an issue
> when using the ARM model of the PL181 and running QEMU.
>
> The bug was reported for the following QEMU version:
> $ qemu-system-arm -version
> QEMU emulator version 2.0.0 (Debian 2.0.0+dfsg-2ubuntu1.1), Copyright
> (c) 2003-2008 Fabrice Bellard
>
> To resolve the problem, let's restore the old behavior were the DATA
> irq is handled prior the CMD irq, but only for the arm_variant, which
> the problem was reported for.
>
> Reported-by: John Stultz <john.stultz@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Hey Ulf,
  Thanks for sending these out (though I wasn't cc'ed on this 3'rd
patch). The first two apply for me, but this one doesn't. What should
I be basing this off of?

thanks
-john
