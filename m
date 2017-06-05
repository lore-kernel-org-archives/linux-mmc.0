From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 3/9] mfd: tmio.h: support partition parser types
Date: Mon, 5 Jun 2017 08:59:07 +0100
Message-ID: <20170605075906.2rdf74lzemys77to@dell>
References: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
 <1496270458-6479-4-git-send-email-andrea.adami@gmail.com>
 <20170601143535.s6ovk5ts3cbehw3f@dell>
 <CAAQYJAs_EMHUUBObbhOQ6gk4rh=MsO4d2qi9KpDdhMiHMrsyTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:36357 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdFEH7L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jun 2017 03:59:11 -0400
Received: by mail-wr0-f182.google.com with SMTP id v111so27165901wrc.3
        for <linux-mmc@vger.kernel.org>; Mon, 05 Jun 2017 00:59:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAAQYJAs_EMHUUBObbhOQ6gk4rh=MsO4d2qi9KpDdhMiHMrsyTA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrea Adami <andrea.adami@gmail.com>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, 03 Jun 2017, Andrea Adami wrote:

> On Thu, Jun 1, 2017 at 4:35 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Thu, 01 Jun 2017, Andrea Adami wrote:
> >
> >> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
> >> ---
> >>  include/linux/mfd/tmio.h | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> >> index a1520d8..23bb069 100644
> >> --- a/include/linux/mfd/tmio.h
> >> +++ b/include/linux/mfd/tmio.h
> >> @@ -139,6 +139,7 @@ struct tmio_nand_data {
> >>       struct nand_bbt_descr   *badblock_pattern;
> >>       struct mtd_partition    *partition;
> >>       unsigned int            num_partitions;
> >> +     const char *const       *types; /* names of parsers to use if any */
> >
> > Please use kerneldoc instead.
> >
> Thanks for the review.
> 
> tmio.h is not consistent and uses inline comments so I did not change the style.
> Another round of patches will be necessary to sanitize the comments,
> out of the scope of this little patchset.

Will you do the work?

> >>  };
> >>
> >>  #define FBIO_TMIO_ACC_WRITE  0x7C639300
> >

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
