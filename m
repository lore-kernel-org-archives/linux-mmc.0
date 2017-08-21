From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 3/9] mfd: tmio: Add partition parsers platform data
Date: Mon, 21 Aug 2017 08:27:03 +0100
Message-ID: <20170821072703.nmzarvksj6l7omrg@dell>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
 <1502743720-28672-4-git-send-email-andrea.adami@gmail.com>
 <20170815065835.jcuweb377lqioddc@dell>
 <20170819092603.1c919b4b@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:37380 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbdHUH1I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Aug 2017 03:27:08 -0400
Received: by mail-wr0-f175.google.com with SMTP id z91so89582131wrc.4
        for <linux-mmc@vger.kernel.org>; Mon, 21 Aug 2017 00:27:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170819092603.1c919b4b@bbrezillon>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Andrea Adami <andrea.adami@gmail.com>, linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, 19 Aug 2017, Boris Brezillon wrote:

> Hi Lee,
> 
> Le Tue, 15 Aug 2017 07:58:35 +0100,
> Lee Jones <lee.jones@linaro.org> a écrit :
> 
> > On Mon, 14 Aug 2017, Andrea Adami wrote:
> > 
> > > With the introduction of sharpslpart partition parser we can now read the
> > > offsets from NAND: we specify the list of the parsers as platform data, with
> > > cmdlinepart and ofpart parsers first allowing to override the part. table
> > > written in NAND. This is done in the board files using this driver.
> > > 
> > > Thus, we need to extend tmio_nand_data to consider the partition parsers.
> > > 
> > > Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
> > > ---
> > >  include/linux/mfd/tmio.h | 1 +
> > >  1 file changed, 1 insertion(+)  
> > 
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > 
> 
> I'm about to apply patches 1 to 5 of this series to the nand/next
> branch. Do you want me to create an immutable branch with this patch?

No, not for a single line change.  Git should figure that out.

Thanks for asking though.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
