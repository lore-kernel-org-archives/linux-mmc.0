From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [patch 4/9] mmc: add the new linux-mmc mailing list to MAINTAINERS
Date: Tue, 18 Aug 2009 17:08:40 -0500
Message-ID: <003c01ca2050$71d72c80$544ff780@am.dhcp.ti.com>
References: <200908182111.n7ILBCSc017248@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60800 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845AbZHRWKC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 18 Aug 2009 18:10:02 -0400
In-Reply-To: <200908182111.n7ILBCSc017248@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc: HaraldWelte@viatech.com, JosephChan@via.com.tw, ben-linux@fluff.org, drzeus@drzeus.cx, ian@mnementh.co.uk, jarkko.lavinen@nokia.com, linux-mmc@vger.kernel.org, manuel.lauss@gmail.com, nico@cam.org, ppisa@pikron.com, saschasommer@freenet.de



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of akpm@linux-foundation.org
> Sent: Tuesday, August 18, 2009 4:11 PM
> To: torvalds@linux-foundation.org
> Cc: akpm@linux-foundation.org; HaraldWelte@viatech.com;
> JosephChan@via.com.tw; ben-linux@fluff.org; drzeus@drzeus.cx;
> ian@mnementh.co.uk; jarkko.lavinen@nokia.com; linux-mmc@vger.kernel.org;
> manuel.lauss@gmail.com; nico@cam.org; ppisa@pikron.com;
> saschasommer@freenet.de
> Subject: [patch 4/9] mmc: add the new linux-mmc mailing list to
> MAINTAINERS
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> There are a number of individual MMC drivers listed in MAINTAINERS.  I
> didn't modify those records.  Perhaps I should have.
> 
Does this mean that the individual MMC drivers list needs to be changed to
linux-mmc@vger.kernel.org? 

For e.g. the OMAP MMC support currently listed as 

L:     linux-omap@vger.kernel.org

Should now be changed as below?

L:     linux-mmc@vger.kernel.org

Regards,
Madhu

> Cc: <linux-mmc@vger.kernel.org>
> Cc: Manuel Lauss <manuel.lauss@gmail.com>
> Cc: Nicolas Pitre <nico@cam.org>
> Cc: Pierre Ossman <drzeus@drzeus.cx>
> Cc: Pavel Pisa <ppisa@pikron.com>
> Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Sascha Sommer <saschasommer@freenet.de>
> Cc: Ian Molton <ian@mnementh.co.uk>
> Cc: Joseph Chan <JosephChan@via.com.tw>
> Cc: Harald Welte <HaraldWelte@viatech.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  MAINTAINERS |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -puN MAINTAINERS~mmc-add-the-new-linux-mmc-mailing-list-to-
> maintainers MAINTAINERS
> --- a/MAINTAINERS~mmc-add-the-new-linux-mmc-mailing-list-to-maintainers
> +++ a/MAINTAINERS
> @@ -3429,6 +3429,7 @@ F:	drivers/mfd/
> 
>  MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND SDIO SUBSYSTEM
>  S:	Orphan
> +L:	linux-mmc@vger.kernel.org
>  F:	drivers/mmc/
>  F:	include/linux/mmc/
> 
> _
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


