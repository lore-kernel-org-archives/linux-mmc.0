From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2] mmc:Add pointer cast to uintptr_t for slave_id_rx and tx in the function, sh_mmcif_request_dma_one
Date: Wed, 24 Jun 2015 09:16:11 +0200
Message-ID: <7719575.AWrtW5tPaL@wuerfel>
References: <1431366550-22045-1-git-send-email-xerofoify@gmail.com> <5589FD65.7040807@gmail.com> <1435107273.2504.43.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:54351 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbbFXHQW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Jun 2015 03:16:22 -0400
In-Reply-To: <1435107273.2504.43.camel@perches.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: nick <xerofoify@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, ulf.hansson@linaro.org, ben.dooks@codethink.co.uk, ykaneko0929@gmail.com, laurent.pinchart+renesas@ideasonboard.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 23 June 2015 17:54:33 Joe Perches wrote:
> On Tue, 2015-06-23 at 20:44 -0400, nick wrote:
> > On 2015-06-23 08:40 PM, Joe Perches wrote:
> > > On Wed, 2015-06-24 at 00:24 +0000, Kuninori Morimoto wrote:
> > >>>>
> > >>>> It's far more common (~10:1) in the kernel to cast using
> > >>>>  (<type> *)(unsigned long)<foo>
> > >>>> than
> > >>>>  (<type> *)(uintptr_t)<foo>
> > >>>>
> > >>> Joe,
> > >>> I agree it's more common in the kernel but one of the maintainers when I sent
> > >>> this patch a month ago requested I use uintpr_t instead of unsigned long for
> > >>> the casting. Otherwise I would have done the cast to fix the build warning
> > >>> with unsigned long instead.
> > >>
> > >> This mail
> > >> http://thread.gmane.org/gmane.linux.kernel.mmc/32304
> > > 
> > > uintptr_t was introduced to avoid ptrdiff_t misuse in
> > > commit 142956af5250 ("fix abuses of ptrdiff_t") by Al Viro.
> > > 
> > > unsigned long is preponderant, long is used about 1/4 as
> > > often as unsigned long, uintptr_t is relatively uncommon.
> > > 
> > > If someone wants to go and convert the 800 or so casts to
> > > long or unsigned long to uintptr_t so that's the style most
> > > frequently used, that'd be different.  I'm not going to
> > > submit any patches for that.
> > > 
> > > 
> > I am not disagreeing it was just easier to listen to the maintainer rather
> > then get in a technical argument over which type is better for the cast.
> 
> Laurent has authored a couple patches to that file and he gave
> you his opinion about using uintptr_t.
> 
> I'm giving an opinion too, just with a little statistics.
> 
> I think it's better to use the style that the kernel generally
> uses.
> 
> I'll stop replying now.

Instead of debating the type of cast that is used here, it would be nicer
to do a patch that avoids the cast in the driver entirely, by changing
the pdata to contain a void* type from the start, and to pass the
shdma_chan_filter function pointer along with it from platform code.

That would make the sh_mmcif driver independent of the underlying dma
driver.

	Arnd
