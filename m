From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH resend] mmc: Added ioctl to let userspace apps send ACMDs
Date: Sat, 19 Mar 2011 10:42:30 +0100
Message-ID: <201103191042.30718.arnd@arndb.de>
References: <203F41F6E33F954E8E8B02559FDC906F743176BFD2@modex01> <201103172255.51442.arnd@arndb.de> <alpine.DEB.2.00.1103181706450.6084@peruna>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50564 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180Ab1CSJmj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Mar 2011 05:42:39 -0400
In-Reply-To: <alpine.DEB.2.00.1103181706450.6084@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org

On Saturday 19 March 2011, John Calixto wrote:

> > > -static int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
> > > +int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
> > >  {
> > >         int err;
> > >         struct mmc_command cmd;
> > > @@ -48,6 +48,7 @@ static int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
> > >
> > >         return 0;
> > >  }
> > > +EXPORT_SYMBOL(mmc_app_cmd);
> >
> > Why not EXPORT_SYMBOL_GPL?
> >
> 
> I was just using the convention already used in sd_ops.c.  I can send a
> pre-patch that sets all of the symbol exports in that file to be
> EXPORT_SYMBOL_GPL, but without confirmation from you and others on this
> list, that seems like overstepping my "jurisdiction".  Is that preferable?

No, you shouldn't change existing symbols, we normally don't do that.
Some subsystems in the kernel generally allow regular EXPORT_SYMBOL
for everything, I don't know if that's the case here.

Chris, do you prefer to leave the new export as EXPORT_SYMBOL
along wiht the others or to use EXPORT_SYMBOL_GPL?

> > As I mentioned, any ioctl command that gets introduced needs to be
> > designed very carefully to make sure we don't need to change it in the
> > future. The only two things I can see here are:
> >
> > * The struct_version should be removed
> > * The data pointer is not compatible between 32 and 64 bits.
> >   One solution for this would be to make it a __u64 argument
> >   and require the user to cast the pointer to a 64 bit type.
> 
> I don't understand your comment about the data pointer not being
> compatible between 32 and 64 bits.  Wouldn't the compiler take care of
> pointer size?

The problem is when you have a 64 bit kernel that can run both
32 and 64 bit user applications. The compiler for the 32 bit user
process will create a smaller data structure than what a 64 bit
kernel expects. The two options here are to force the compiler
to use a compatible layout, or to use the compat_ioctl() function
to convert from one format to the other.

	Arnd
