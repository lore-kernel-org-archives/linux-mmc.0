From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH] mmc: mmci: assume maintainership
Date: Thu, 15 Mar 2012 14:52:26 +0000
Message-ID: <1331823146.2066.5.camel@hornet.cambridge.arm.com>
References: <1331821836-14641-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:58228 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757788Ab2COOwy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 10:52:54 -0400
In-Reply-To: <1331821836-14641-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>

On Thu, 2012-03-15 at 14:30 +0000, Linus Walleij wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3321d75..3f280f6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -630,7 +630,8 @@ F:	drivers/input/serio/ambakmi.*
>  F:	include/linux/amba/kmi.h
> =20
>  ARM PRIMECELL MMCI PL180/1 DRIVER
> -S:	Orphan

You probably meant

+S:	Maintained

> +M:	Linus Walleij <linus.walleij@linaro.org>
> +L:	linux-mmc@vger.kernel.org
>  F:	drivers/mmc/host/mmci.*
> =20
>  ARM PRIMECELL BUS SUPPORT

By all means!

Acked-by: Pawel Moll <pawel.moll@arm.com>

Cheers!

Pawe=C5=82


