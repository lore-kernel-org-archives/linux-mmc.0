From: John Calixto <john.calixto@modsystems.com>
Subject: RE: [PATCH resend] mmc: Added ioctl to let userspace apps send
 ACMDs
Date: Fri, 18 Mar 2011 17:24:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1103181706450.6084@peruna>
References: <203F41F6E33F954E8E8B02559FDC906F743176BFD2@modex01> <201103172255.51442.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:45497 "EHLO
	elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932177Ab1CSAYb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Mar 2011 20:24:31 -0400
In-Reply-To: <201103172255.51442.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org

Hello Arnd,

I need some clarification on the last bit of your initial feedback below:

On Thu, 17 Mar 2011, Arnd Bergmann wrote:
> On Thursday 17 March 2011 19:28:55 John Calixto wrote:

<snip>

> > diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> > index 797cdb5..0453dcd 100644
> > --- a/drivers/mmc/core/sd_ops.c
> > +++ b/drivers/mmc/core/sd_ops.c
> > @@ -20,7 +20,7 @@
> >  #include "core.h"
> >  #include "sd_ops.h"
> >
> > -static int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
> > +int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
> >  {
> >         int err;
> >         struct mmc_command cmd;
> > @@ -48,6 +48,7 @@ static int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
> >
> >         return 0;
> >  }
> > +EXPORT_SYMBOL(mmc_app_cmd);
>
> Why not EXPORT_SYMBOL_GPL?
>

I was just using the convention already used in sd_ops.c.  I can send a
pre-patch that sets all of the symbol exports in that file to be
EXPORT_SYMBOL_GPL, but without confirmation from you and others on this
list, that seems like overstepping my "jurisdiction".  Is that preferable?

> > @@ -84,5 +86,21 @@
> >  #define SD_SWITCH_ACCESS_DEF   0
> >  #define SD_SWITCH_ACCESS_HS    1
> >
> > +struct sd_ioc_cmd {
> > +    unsigned int struct_version;
> > +#define SD_IOC_CMD_STRUCT_VERSION 0
> > +    int write_flag;  /* implies direction of data.  true = write, false = read */
> > +    unsigned int opcode;
> > +    unsigned int arg;
> > +    unsigned int flags;
> > +    unsigned int postsleep_us;  /* apply usecond delay *after* issuing command */
> > +    unsigned int force_timeout_ns;  /* force timeout to be force_timeout_ns ns */
> > +    unsigned int response[4];  /* CMD response */
> > +    unsigned int blksz;
> > +    unsigned int blocks;
> > +    unsigned char *data;  /* DAT buffer */
> > +};
> > +#define SD_IOC_ACMD _IOWR(MMC_BLOCK_MAJOR, 0, struct sd_ioc_cmd *)
> > +
> >  #endif
> >
>
> As I mentioned, any ioctl command that gets introduced needs to be
> designed very carefully to make sure we don't need to change it in the
> future. The only two things I can see here are:
>
> * The struct_version should be removed
> * The data pointer is not compatible between 32 and 64 bits.
>   One solution for this would be to make it a __u64 argument
>   and require the user to cast the pointer to a 64 bit type.
>
>       Arnd

I don't understand your comment about the data pointer not being
compatible between 32 and 64 bits.  Wouldn't the compiler take care of
pointer size?

Thanks,

John
