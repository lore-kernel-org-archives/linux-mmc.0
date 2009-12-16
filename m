From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [RFC PATCH v2 0/4] mmc: wii: sdhci controller support
Date: Wed, 16 Dec 2009 16:06:34 +0300
Message-ID: <20091216130634.GA31326@oksana.dev.rtsoft.ru>
References: <1260829459-23518-1-git-send-email-albert_herranz@yahoo.es>
 <20091214224552.GA21934@oksana.dev.rtsoft.ru>
 <20091216124234.GB4283@pengutronix.de>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:45544 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753037AbZLPNNR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2009 08:13:17 -0500
Content-Disposition: inline
In-Reply-To: <20091216124234.GB4283@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linux-mmc@vger.kernel.org, akpm@linux-foundation.org

On Wed, Dec 16, 2009 at 01:42:34PM +0100, Wolfram Sang wrote:
> On Tue, Dec 15, 2009 at 01:45:52AM +0300, Anton Vorontsov wrote:
> > On Mon, Dec 14, 2009 at 11:24:15PM +0100, Albert Herranz wrote:
> > > This patch set adds support for the SDHCI controllers found in the
> > > "Hollywood" chipset of the Nintendo Wii video game console.
> > > 
> > > First, the existing sdhci-of driver is splitted into a core part and
> > > a eSDHC-only part. Then the Nintendo Wii SDHCI support is added as an
> > > add-on to that, re-using common code.
> > 
> > All four patches
> > 
> > Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> Interesting coincidence, I'd need to tackle these parts right now, too, just
> with a different aim. The eSDHC-core was also used in the ARM-based imx35,
> which means I need the code using a platform device.

Not necessary. There is another option, we might add OF support to the
ARM platforms. :-) Or at least "fake" (statically initialize) some OF
nodes, as proposed by Sparc/PPC/OF folks:
http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-December/078835.html

Though, I'm not sure what state the ARM OF/static-OF support is
in, IIUC Grant started implementing some proof-of-concepts.

In anyway, I'll happily ack your work regardless ARM OF, since OF
acceptance could be a long story. I.e., all the above is FYI, just
an interesting idea.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
