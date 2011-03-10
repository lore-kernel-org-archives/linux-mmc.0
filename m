From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: export function mmc_do_release_host
Date: Thu, 10 Mar 2011 10:27:58 -0500
Message-ID: <m3aah3knb5.fsf@pullcord.laptop.org>
References: <1299658262-1337-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54646 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752995Ab1CJPaW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Mar 2011 10:30:22 -0500
In-Reply-To: <1299658262-1337-1-git-send-email-linus.walleij@stericsson.com>
	(Linus Walleij's message of "Wed, 9 Mar 2011 09:11:02 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

Hi,

On Wed, Mar 09 2011, Linus Walleij wrote:
> From: Ulf Hansson <ulf.hansson@stericsson.com>
>
> When using mmc_try_claim_host the corresponding release
> function is mmc_do_release_host, which then also must
> be exported.
>
> Reviewed-by: Jonas Aberg <jonas.aberg@stericsson.com>
> Reviewed-by: Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> V2: updated with kerneldoc

Thanks, pushed to mmc-next for .39.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
