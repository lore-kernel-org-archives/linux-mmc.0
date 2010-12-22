From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/3] sdhci: don't finish commands in flight
Date: Wed, 22 Dec 2010 01:38:58 -0800
Message-ID: <AANLkTimEBCRQYmXStOY+v1Fg3bq8w-LjADEGqHJ1msk-@mail.gmail.com>
References: <1293004871-1918-1-git-send-email-olof@lixom.net>
	<1293004871-1918-3-git-send-email-olof@lixom.net>
	<20101222080821.GB19898@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62858 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab0LVJi7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 04:38:59 -0500
In-Reply-To: <20101222080821.GB19898@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

Hi,

On Wed, Dec 22, 2010 at 12:08 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Olof,
>
> On Wed, Dec 22, 2010 at 02:01:10AM -0600, Olof Johansson wrote:
>> Don't schedule the finish_tasklet unless the command complete bit is
>> set in the interrupt status register.
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>
> Could we have some more detail here, please? =A0What are the symptoms=
 of
> running without this patch? =A0Should we apply it to the stable tree =
too?

Hmm, good question. I hadn't gotten to the bottom of why this specific
change was needed in the past -- it's something the original driver
did that I just ended up inheriting behavior from. Thanks for asking.
:-)

=46rom some further investigation, it seems like the underlying problem
is that the controller reports spurious timeout and crc errors, in
spite of the transactions completing successfully.

My main worry with this fix as it was is that it would disable
behavior on controllers where the error bits are set and handled
correctly. So, what I think I will do instead is that I will simply
mask those two errors from generating interrupts (i.e. masking the two
bits when writing the SDHCI_SIGNAL_ENABLE register). That seems to
result in the equivalent behavior, and I no longer see the spurious
interrupts and controller resets. In case of real timeouts and/or CRC
errors, the existing software timer should take care of eventually
unfreezing the controller if need be.

I'll repost the series with these changes after letting this version
sit out for review for a bit longer.


-Olof
