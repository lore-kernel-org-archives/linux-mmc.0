From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: mmci: assume maintainership
Date: Thu, 15 Mar 2012 15:36:01 +0100
Message-ID: <4F61FE51.9090804@stericsson.com>
References: <1331821836-14641-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:33201 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761437Ab2COOhN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 10:37:13 -0400
In-Reply-To: <1331821836-14641-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus WALLEIJ <linus.walleij@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>

Hi Linus,

Great initiative! Of course you get my Ack.

Acked-by: Ulf Hansson <ulf.hansson@stericsson.com>

Br
Ulf Hansson

On 03/15/2012 03:30 PM, Linus WALLEIJ wrote:
> From: Linus Walleij<linus.walleij@linaro.org>
>
> So since this driver is crucial for us (as in ST-Ericsson)
> to have actively maintained, and since it is marked orphaned
> I will assume maintainership for it starting with the 3.5
> integration cycle. The idea is to collect patches and send
> either patch sets of pull requests to Chris.
>
> Cc: Ulf Hansson<ulf.hansson@stericsson.com>
> Cc: Per Forlin<per.forlin@stericsson.com>
> Cc: Pawel Moll<pawel.moll@arm.com>
> Cc: Russell King<rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Linus Walleij<linus.walleij@linaro.org>
> ---
>   MAINTAINERS |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3321d75..3f280f6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -630,7 +630,8 @@ F:	drivers/input/serio/ambakmi.*
>   F:	include/linux/amba/kmi.h
>
>   ARM PRIMECELL MMCI PL180/1 DRIVER
> -S:	Orphan
> +M:	Linus Walleij<linus.walleij@linaro.org>
> +L:	linux-mmc@vger.kernel.org
>   F:	drivers/mmc/host/mmci.*
>
>   ARM PRIMECELL BUS SUPPORT

