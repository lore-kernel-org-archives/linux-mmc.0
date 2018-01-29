From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 11/16] mmc: tmio: deprecate
 "toshiba,mmc-wrprotect-disable" DT property
Date: Mon, 29 Jan 2018 11:18:51 -0600
Message-ID: <20180129171851.rlraudj2bq7irmdw@rob-hp-laptop>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-12-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQUJw-fjuJO68Kvskn8BRYW3rZj4YMtbo-Oxfv7c=6Ggg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNAQUJw-fjuJO68Kvskn8BRYW3rZj4YMtbo-Oxfv7c=6Ggg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Ulf Magnusson <ulfalizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jan 18, 2018 at 10:58:36AM +0900, Masahiro Yamada wrote:
> 2018-01-18 1:28 GMT+09:00 Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>:
> > This property is equivalent to "disable-wp" defined in
> > Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> 
> This is mistake.
> 
> "disable-wp" is defined in
> 
> Documentation/devicetree/bindings/mmc/mmc.txt
> 
> 
> 
> 
> > The TMIO MMC core calls mmc_of_parse(), and it sets
> > MMC_CAP2_NO_WRITE_PROTECT if "disable-wp" property is present.
> >
> > We do not need a vendor-specific property to do the same thing.
> >
> > Let's remove the description from the dt-binding to prevent new boards
> > from using it.
> >
> > I am keeping the driver code for existing DT files, but added
> > comments that this is deprecated.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
> > ---
> >
> > Changes in v3:
> >   - newly added
> >
> > Changes in v2: None
> >
> >  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 1 -

Other than the above,

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> >  drivers/mmc/host/tmio_mmc_core.c                   | 5 +++++
> >  2 files changed, 5 insertions(+), 1 deletion(-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
