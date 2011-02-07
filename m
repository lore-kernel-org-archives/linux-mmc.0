From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 1/2] dw_mmc: Run card detect tasklet during slot initialisation.
Date: Mon, 7 Feb 2011 10:13:34 +0000
Message-ID: <AANLkTinkCN0UxDTV1RLziF9qwGb5ucZxXcZ47VWMkGf9@mail.gmail.com>
References: <AANLkTikwVAKaiAy+0Vpcu97qxX3ZKgZ8k_LyNfOU9Ws=@mail.gmail.com>
	<20110204235027.3b93091b@mfleming-mobl1.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42719 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab1BGKNf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Feb 2011 05:13:35 -0500
Received: by bwz15 with SMTP id 15so4710808bwz.19
        for <linux-mmc@vger.kernel.org>; Mon, 07 Feb 2011 02:13:34 -0800 (PST)
In-Reply-To: <20110204235027.3b93091b@mfleming-mobl1.ger.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-mmc@vger.kernel.org

On Fri, Feb 4, 2011 at 11:50 PM, Matt Fleming <matt@console-pimps.org> wrote:
> On Fri, 4 Feb 2011 11:17:54 +0000
> Will Newton <will.newton@gmail.com> wrote:
>
>> We need to run the card detect tasklet at the end of slot
>> initialisation as it is possible that a card has been inserted prior
>> to boot, so we miss the insertion interrupt and now the card is
>> sitting there inserted but with no power to it.
>
> So when powering up the board with a card already inserted, an interrupt
> isn't generated? If that's the case then we haven't "missed" an
> interrupt as one was never generated, right?

I believe it starts up with interrupts masked so we don't actually see
any interrupts until
we unmask - and it isn't clear from the documentation whether or not
an interrupt is generated.

> If the answer to the above questions is "yes", then you can add my
> Reviewed-by (though it might be worth changing the bit about missing
> an interrupt in the commit message). Otherwise, I would have expected
> the usual interrupt machinery to take care of detecting the inserted
> card?

Ok I'll update that, thanks for the review!
