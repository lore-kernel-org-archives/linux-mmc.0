From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v5 0/9] mtd: sharpslpart partition parser
Date: Mon, 21 Aug 2017 22:13:39 +0200
Message-ID: <20170821221339.70cfcfb7@bbrezillon>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:33744 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753541AbdHUUNv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Aug 2017 16:13:51 -0400
In-Reply-To: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrea Adami <andrea.adami@gmail.com>
Cc: linux-mtd@lists.infradead.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Richard Weinberger <richard@nod.at>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Lee Jones <lee.jones@linaro.org>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Mack <daniel@zonque.org>

Le Mon, 14 Aug 2017 22:48:31 +0200,
Andrea Adami <andrea.adami@gmail.com> a écrit :

> This patchset introduces a simple partition parser for the Sharp SL
> Series PXA handhelds. More details in the commit text.
> 
> I have set in cc the ARM PXA maintainers because this is the MTD part of
> a planned wider patchset cleaning the Zaurus board files. The MFD maintainers
> are also in cc (tmio.h change).
> 
> Changelog:
> v1 firt version, initial import of 2.4 sources
> v2 refactor applying many suggested fixes
> v3 put the partition parser types in the platform data
> v4 refactor after ML review
> v5 fix commit messages and subject texts, remove global, fixes after v4 review
> 
> GPL sources: http://support.ezaurus.com/developer/source/source_dl.asp
> 
> Andrea Adami (9):
>   mtd: sharpslpart: Add sharpslpart partition parser
>   mtd: nand: sharpsl: Add partition parsers platform data
>   mfd: tmio: Add partition parsers platform data
>   mtd: nand: sharpsl: Register partitions using the parsers
>   mtd: nand: tmio: Register partitions using the parsers

Applied patches 2, to 5 to nand/next.

Thanks,

Boris

>   ARM: pxa/corgi: Remove hardcoded partitioning, use sharpslpart parser
>   ARM: pxa/tosa: Remove hardcoded partitioning, use sharpslpart parser
>   ARM: pxa/spitz: Remove hardcoded partitioning, use sharpslpart parser
>   ARM: pxa/poodle: Remove hardcoded partitioning, use sharpslpart parser
> 
>  arch/arm/mach-pxa/corgi.c         |  31 +---
>  arch/arm/mach-pxa/poodle.c        |  28 +--
>  arch/arm/mach-pxa/spitz.c         |  34 +---
>  arch/arm/mach-pxa/tosa.c          |  28 +--
>  drivers/mtd/nand/sharpsl.c        |   2 +-
>  drivers/mtd/nand/tmio_nand.c      |   4 +-
>  drivers/mtd/parsers/Kconfig       |   8 +
>  drivers/mtd/parsers/Makefile      |   1 +
>  drivers/mtd/parsers/sharpslpart.c | 376 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/tmio.h          |   1 +
>  include/linux/mtd/sharpsl.h       |   1 +
>  11 files changed, 424 insertions(+), 90 deletions(-)
>  create mode 100644 drivers/mtd/parsers/sharpslpart.c
> 

