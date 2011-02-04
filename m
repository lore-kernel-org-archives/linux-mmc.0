From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 1/2] dw_mmc: Run card detect tasklet during slot
 initialisation.
Date: Fri, 4 Feb 2011 23:50:27 +0000
Message-ID: <20110204235027.3b93091b@mfleming-mobl1.ger.corp.intel.com>
References: <AANLkTikwVAKaiAy+0Vpcu97qxX3ZKgZ8k_LyNfOU9Ws=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:44939 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751969Ab1BDX6e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Feb 2011 18:58:34 -0500
In-Reply-To: <AANLkTikwVAKaiAy+0Vpcu97qxX3ZKgZ8k_LyNfOU9Ws=@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: linux-mmc@vger.kernel.org

On Fri, 4 Feb 2011 11:17:54 +0000
Will Newton <will.newton@gmail.com> wrote:

> We need to run the card detect tasklet at the end of slot
> initialisation as it is possible that a card has been inserted prior
> to boot, so we miss the insertion interrupt and now the card is
> sitting there inserted but with no power to it.

So when powering up the board with a card already inserted, an interrupt
isn't generated? If that's the case then we haven't "missed" an
interrupt as one was never generated, right?

If the answer to the above questions is "yes", then you can add my
Reviewed-by (though it might be worth changing the bit about missing
an interrupt in the commit message). Otherwise, I would have expected
the usual interrupt machinery to take care of detecting the inserted
card?
