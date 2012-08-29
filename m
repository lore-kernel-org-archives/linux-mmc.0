From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v6] mmc: card: Skip secure option for MoviNAND.
Date: Wed, 29 Aug 2012 06:26:59 -0400
Message-ID: <873936vvrg.fsf@octavius.laptop.org>
References: <503DB130.8090807@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40703 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751Ab2H2K1K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Aug 2012 06:27:10 -0400
In-Reply-To: <503DB130.8090807@samsung.com> (IAN CHEN's message of "Wed, 29
	Aug 2012 15:05:36 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: IAN CHEN <ian.cy.chen@samsung.com>
Cc: linkinjeon@gmail.com, adrian.hunter@intel.com, subhashj@codeaurora.org, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, d.j.shin@samsung.com, jongtae22.kim@samsung.com, kyungmin.park@samsung.com, jh80.chung@samsung.com

Hi,

On Wed, Aug 29 2012, IAN CHEN wrote:
> For several MoviNAND, there are some known issue with secure option.
> For these specific MoviNAND device, we skip secure option.
>
> You could refer this discussion in XDA developers.
> http://forum.xda-developers.com/showthread.php?t=1644364
> https://plus.google.com/111398485184813224730/posts/21pTYfTsCkB#111398485184813224730/posts/21pTYfTsCkB
>
> Signed-off-by: Ian Chen <ian.cy.chen@samsung.com>
> Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks.  We should explain the nature of the bug in the commit message,
so that users and the stable@ maintainers know how bad the problem is
by reading the patch.  (This should go to stable@, right?  Do you know
which kernel versions are affected?)

I'll add something like this, unless you have a better proposal:

==
For several MoviNAND, there are some known issues with secure option.
For these specific MoviNAND device, we skip secure option.

Specifically, there is a bug in the eMMC firmware that causes 
unrecoverable corruption when the MMC is erased with MMC_CAP_ERASE
enabled.

You could refer this discussion in XDA developers.
http://forum.xda-developers.com/showthread.php?t=1644364
https://plus.google.com/111398485184813224730/posts/21pTYfTsCkB#111398485184813224730/posts/21pTYfTsCkB
==

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
