From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: mmci: U300 "sync with blockend" broken for multi-block?
Date: Sun, 16 Jan 2011 22:16:59 +0100
Message-ID: <AANLkTimywaKn-jKmxzottNogYiRtwvSEcO6y0LxuKLR4@mail.gmail.com>
References: <AANLkTimYb6TxLj4SamxRwUgykf9JyW5y9gbejOUXqZ7K@mail.gmail.com>
	<20110101121048.GB25924@n2100.arm.linux.org.uk>
	<AANLkTi=4SrxX-oCx-XXd+oib64j8RhMLdsQD1oWGxgU1@mail.gmail.com>
	<20110105164344.GD8638@n2100.arm.linux.org.uk>
	<AANLkTim4J8xrj9axhsu4=_7YkEy_ndiJ6cjDNf2WfzEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:48048 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab1APVQ7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Jan 2011 16:16:59 -0500
Received: by pxi15 with SMTP id 15so733707pxi.19
        for <linux-mmc@vger.kernel.org>; Sun, 16 Jan 2011 13:16:59 -0800 (PST)
In-Reply-To: <AANLkTim4J8xrj9axhsu4=_7YkEy_ndiJ6cjDNf2WfzEg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rabin Vincent <rabin@rab.in>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Ulf Hansson <Ulf.Hansson@stericsson.com>, Sebastian Rasmussen <Sebastian.Rasmussen@stericsson.com>, linux-mmc@vger.kernel.org

2011/1/14 Linus Walleij <linus.ml.walleij@gmail.com>:

> What it problematic with the reads *and* writes is that
> sometimes there us a MCI_DATABLOCKEND missing, so the
> blocks simply don't add up! This is the real bug that
> the sync code was trying to solve, and not in a very
> good way.

Here is a follow-up explanation as to why the code as it
is today actually works: the sync code has a bug. It is
intended to check whether the *last* blockend interrupt
*and* the dataend interrupt has occurred. However it
actually checks whether *any* blockend interrupt and
the datend interrupt has occured.

Thus it works, with the side effect of ACK:ing multiblock
transfers on U300 while the host->data_xfered value is lower
that what was requested - the blocks have been read
but not all are accounted for, because there are blockend
IRQs missing.

I'll follow up with a patch fixing the *real* issue, in an
atleast a little more elegant way :-/

Yours,
Linus Walleij
