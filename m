From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v3 0/9] mtd: sharpslpart partition parser
Date: Thu, 8 Jun 2017 18:35:21 -0700
Message-ID: <20170609013521.GL102137@google.com>
References: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35457 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdFIBf0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 21:35:26 -0400
Content-Disposition: inline
In-Reply-To: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrea Adami <andrea.adami@gmail.com>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jun 01, 2017 at 12:40:49AM +0200, Andrea Adami wrote:
> This patchset introduces a simple partition parser for the Sharp SL
> Series PXA handhelds. More details in the commit text.
> 
> I have set in cc the ARM PXA maintainers because this is the MTD part of
> a planned wider patchset cleaning the Zaurus board files. The MFD maintainers
> are also in cc (tmio.h change).
> 
> Changelog:
> v1 initial import of 2.4 sources [1]
> v2 refactor applying many suggested fixes [2]
> v3 put the partition parser types in the platform data
> 
> [1] https://github.com/LinuxPDA/Sharp_FTL_2.4.20
> [2] https://github.com/LinuxPDA/linux/commits/sharpslpart_v2
> 
> Andrea Adami (9):
>   mtd: sharpslpart: add sharpslpart MTD partition parser
>   mtd: nand: sharpsl.h: support partition parser types
>   mfd: nand: tmio.h: support partition parser types
>   mtd: nand: sharpsl.c: take in account partition parser types
>   mtd: nand: tmio_nand.c: take in account partition parser types
>   arm: pxa: corgi.c: remove hardcoded partitioning, use sharpslpart
>     parser
>   arm: pxa: tosa.c: remove hardcoded partitioning, use sharpslpart
>     parser
>   arm: pxa: spitz.c: remove hardcoded partitioning, use sharpslpart
>     parser
>   arm: pxa: poodle.c: remove hardcoded partitioning, use sharpslpart
>     parser

Barring my comments on patch 1 and Wolfram's comments on a few of the
others, for the whole series:

Reviewed-by: Brian Norris <computersforpeace@gmail.com>

Once things are fixed up, this should probably go through MTD.

Brian
