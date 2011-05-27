From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] drivers:mmc:add the NO_IRQ define to of_mmc_spi.c
Date: Thu, 26 May 2011 23:44:38 -0400
Message-ID: <m34o4gu7rt.fsf@pullcord.laptop.org>
References: <1306242202-9252-1-git-send-email-wanlong.gao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39450 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753731Ab1E0Dn2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 May 2011 23:43:28 -0400
In-Reply-To: <1306242202-9252-1-git-send-email-wanlong.gao@gmail.com> (Wanlong
	Gao's message of "Tue, 24 May 2011 21:03:22 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wanlong Gao <wanlong.gao@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Tue, May 24 2011, Wanlong Gao wrote:
> For archs that don't support NO_IRQ (such as mips),
> provide a dummy value. Fix the build error for mips.
>
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
> ---
>  drivers/mmc/host/of_mmc_spi.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
> index e2aecb7..ab66f24 100644
> --- a/drivers/mmc/host/of_mmc_spi.c
> +++ b/drivers/mmc/host/of_mmc_spi.c
> @@ -25,6 +25,11 @@
>  #include <linux/mmc/core.h>
>  #include <linux/mmc/host.h>
>  
> +/* For archs that don't support NO_IRQ (such as mips), provide a dummy value */
> +#ifndef NO_IRQ
> +#define NO_IRQ 0
> +#endif
> +
>  MODULE_LICENSE("GPL");
>  
>  enum {

Thanks, queued for Linus with Grant's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
