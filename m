From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1] mmc: sdhci-dove: remove duplicate inclusion of linux/err.h
Date: Sun, 25 Nov 2012 15:11:36 -0500
Message-ID: <87624t8mtj.fsf@octavius.laptop.org>
References: <1353326113-9615-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58198 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753373Ab2KYULk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Nov 2012 15:11:40 -0500
In-Reply-To: <1353326113-9615-1-git-send-email-sachin.kamat@linaro.org>
	(Sachin Kamat's message of "Mon, 19 Nov 2012 17:25:13 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, sebastian.hesselbarth@googlemail.com, patches@linaro.org

Hi,

On Mon, Nov 19 2012, Sachin Kamat wrote:
> linux/err.h was included twice.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/sdhci-dove.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
> index 8fd50a2..2a03f30 100644
> --- a/drivers/mmc/host/sdhci-dove.c
> +++ b/drivers/mmc/host/sdhci-dove.c
> @@ -22,7 +22,6 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/clk.h>
> -#include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/mmc/host.h>
>  #include <linux/of.h>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
