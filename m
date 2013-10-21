From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: Re: [PATCH v2 0/8] sdhci: Move real work out of an atomic context
Date: Mon, 21 Oct 2013 17:52:56 +0200
Message-ID: <52654DD8.1090806@parrot.com>
References: <1382369157-16129-1-git-send-email-jeremie.samuel.ext@parrot.com> <86hacaprmz.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:37382 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432Ab3JUPyT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Oct 2013 11:54:19 -0400
In-Reply-To: <86hacaprmz.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, =?ISO-8859-1?Q?Gr=E9gor_Boirie?= <gregor.boirie@parrot.com>, Matthieu Castet <matthieu.castet@parrot.com>

v2:
Patches on sdhci-bcm-kona.c, sdhci-dove.c, sdhci-s3c.c, sdhci-sirf.c, 
sdhci-spear.c in order to consider the change tasklet -> workqueue

Version of 16 oct 13:
Patches on sdhci-esdhc-imx.c, sdhci-pxav3.c, sdhci-s3c.c in order to 
consider the change spinlock -> mutex

Version of 06 jul 13:
Resend in order to include the patches in kernel 3.12

Version of 24 may 13:
First version of my patches (based on Anton Vorontsov's patches http://thread.gmane.org/gmane.linux.kernel.mmc/2579)

Sorry for the issues. It's my first submission on a Linux mailing list.

Cordially,

-- 
Jeremie Samuel              Parrot S.A.
Software Engineer           14, quai de Jemmapes
R&D/OS Platform             75010 Paris, France
http://www.parrot.com

On 21/10/2013 17:31, Chris Ball wrote:
> Hi Jeremie,
>
> On Mon, Oct 21 2013, Jeremie Samuel wrote:
>> Currently the sdhci driver does everything in the atomic context.
>> And what is worse, PIO transfers are made from the IRQ handler.
>>
>> Some patches were already submitted to solve this issue. But there were
>> rejected because they involved new issues.
>>
>> This set of patches is an evolution of an old patch from Anton Vorontsov.
>> I tried to fix all the problems involved by the patches. I tested it for
>> several time now with SD cards and SDIO.
>>
>> So, this patch set reworks sdhci code to avoid atomic context,
>> almost completely.
> Could we get a changelog from patchset v1 to v2, for the record?
> (And isn't this more like v4 of your series?)
>
> You don't have to resend the patchset, just replying with the
> changelog here is fine.
>
> Thanks!
>
> - Chris.

