From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 3/9] mfd: tmio: Add partition parsers platform data
Date: Tue, 15 Aug 2017 07:58:35 +0100
Message-ID: <20170815065835.jcuweb377lqioddc@dell>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
 <1502743720-28672-4-git-send-email-andrea.adami@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36628 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753240AbdHOG6j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Aug 2017 02:58:39 -0400
Received: by mail-wr0-f177.google.com with SMTP id x43so445801wrb.3
        for <linux-mmc@vger.kernel.org>; Mon, 14 Aug 2017 23:58:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1502743720-28672-4-git-send-email-andrea.adami@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrea Adami <andrea.adami@gmail.com>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 14 Aug 2017, Andrea Adami wrote:

> With the introduction of sharpslpart partition parser we can now read the
> offsets from NAND: we specify the list of the parsers as platform data, with
> cmdlinepart and ofpart parsers first allowing to override the part. table
> written in NAND. This is done in the board files using this driver.
> 
> Thus, we need to extend tmio_nand_data to consider the partition parsers.
> 
> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
> ---
>  include/linux/mfd/tmio.h | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
