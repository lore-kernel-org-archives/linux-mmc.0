From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] gpio: fix warning of 'struct gpio_chip' declaration
Date: Thu, 17 Jan 2013 22:13:59 +0800
Message-ID: <20130117141355.GB29285@S2101-09.ap.freescale.net>
References: <1358239056-703-1-git-send-email-shawn.guo@linaro.org>
 <1358239056-703-2-git-send-email-shawn.guo@linaro.org>
 <CACRpkdaKhLcS9p9JOhViCkUcMVH1ByBR3v5A4+wOJnQUcuQrVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:46473
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754584Ab3AQON3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jan 2013 09:13:29 -0500
Content-Disposition: inline
In-Reply-To: <CACRpkdaKhLcS9p9JOhViCkUcMVH1ByBR3v5A4+wOJnQUcuQrVg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 17, 2013 at 02:30:01PM +0100, Linus Walleij wrote:
> Shawn can you please try to repost this with something that does not
> turn into quoted-printable? Look:
> 
Sorry for that.  Just resent it.

> MIME-Version: 1.0
> Content-Type: text/plain; charset="UTF-8"
> Content-Transfer-Encoding: quoted-printable
> (...)
> @@ -212,6 +212,43 @@ extern void gpio_unexport(unsigned gpio);
> =20
>  #endif	/* CONFIG_GPIO_SYSFS */
> =20
> +#ifdef CONFIG_PINCTRL
> 
> I can't apply that.
> 
> Second: if this is not an immediate regression I'd prefer to put it
> for-next now, as touching this file always brings down something.
> 
> OK?
> 
The warning the first patch tries to fix seems new to v3.8-rc, while
the second patch is definitely fine for -next.

Since I do not care much about the warning seen on blackfin, I'm fine
with both of them being for -next.

Shawn

