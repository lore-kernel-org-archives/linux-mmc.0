From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: Re: [PATCH 0/8] sdhci: Move real work out of an atomic context
Date: Thu, 13 Jun 2013 16:23:16 +0200
Message-ID: <51B9D5D4.9040907@parrot.com>
References: <1369411242-20515-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:43370 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358Ab3FMOYW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 Jun 2013 10:24:22 -0400
In-Reply-To: <1369411242-20515-1-git-send-email-jeremie.samuel.ext@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: =?ISO-8859-1?Q?J=E9r=E9mie_Samuel?= <jeremie.samuel.ext@parrot.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Matthieu Castet <matthieu.castet@parrot.com>, =?ISO-8859-1?Q?Gr=E9gor_?= =?ISO-8859-1?Q?BOIRIE?= <gregor.boirie@parrot.com>

Hi,

I posted these patches a few weeks ago. Is it possible to get a feedbac=
k for this submission?

Thank you for your help.

--=20
Jeremie Samuel              Parrot S.A.
Software Engineer           14, quai de Jemmapes
R&D/OS Platform             75010 Paris, France
http://www.parrot.com

On 24/05/2013 18:00, J=E9r=E9mie Samuel wrote:

> Hi all,
>
> Currently the sdhci driver does everything in the atomic context.
> And what is worse, PIO transfers are made from the IRQ handler.
>
> Some patches were already submitted to solve this issue. But there we=
re
> rejected because they involved new issues.
>
> This set of patches is an evolution of an old patch from Anton Voront=
sov.
> I tried to fix all the problems involved by the patches. I tested it =
for
> several time now with SD cards and SDIO.
>
> So, this patch set reworks sdhci code to avoid atomic context,
> almost completely.
>
> Thanks,
>
> Jeremie Samuel
>
> Jeremie Samuel (8):
>    sdhci: Turn timeout timer into delayed work
>    sdhci: Turn tuning timeout timer into delayed work
>    sdhci: Use work structs instead of tasklets
>    sdhci: Use threaded IRQ handler
>    sdhci: Delay led blinking
>    sdhci: Turn host->lock into a mutex
>    sdhci: Get rid of mdelay()s where it is safe and makes sense
>    sdhci: Use jiffies instead of a timeout counter
>
>   drivers/mmc/host/sdhci.c  |  327 ++++++++++++++++++++++------------=
-----------
>   include/linux/mmc/sdhci.h |   13 +-
>   2 files changed, 168 insertions(+), 172 deletions(-)
>
