From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: add myself as a tmio-mmc maintainer
Date: Mon, 18 Jul 2011 21:56:42 -0400
Message-ID: <m21uxnav8l.fsf@bob.laptop.org>
References: <Pine.LNX.4.64.1107172157130.13485@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52690 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404Ab1GSB4s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Jul 2011 21:56:48 -0400
In-Reply-To: <Pine.LNX.4.64.1107172157130.13485@axis700.grange> (Guennadi
	Liakhovetski's message of "Sun, 17 Jul 2011 22:04:07 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>

Hi Guennadi,

On Sun, Jul 17 2011, Guennadi Liakhovetski wrote:
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> It would be nice if I could get hold of some non-sh-mobile tmio-mmc 
> hardware for regression tests. Until then I'll just do my best not to 
> break those systems, any testing by Ian or any other lucky owners would be 
> as always highly appreciated.
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 187282d..400ebbd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6242,9 +6242,14 @@ F:	drivers/char/toshiba.c
>  F:	include/linux/toshiba.h
>  
>  TMIO MMC DRIVER
> +M:	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>  M:	Ian Molton <ian@mnementh.co.uk>
> +L:	linux-mmc@vger.kernel.org
>  S:	Maintained
> -F:	drivers/mmc/host/tmio_mmc.*
> +F:	drivers/mmc/host/tmio_mmc*
> +F:	drivers/mmc/host/sh_mobile_sdhi.c
> +F:	include/linux/mmc/tmio.h
> +F:	include/linux/mmc/sh_mobile_sdhi.h

Thanks, pushed to mmc-next for 3.1.  I don't have any suggestions about
hardware -- I have even less tmio hardware than you do.  :)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
