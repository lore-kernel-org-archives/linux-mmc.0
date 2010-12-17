From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] mmc: skip detection of nonremovable cards on rescan
Date: Fri, 17 Dec 2010 00:51:23 +0000
Message-ID: <20101217005123.GD17239@void.printf.net>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com> <1290921690-6133-2-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44030 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754493Ab0LQAvY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Dec 2010 19:51:24 -0500
Content-Disposition: inline
In-Reply-To: <1290921690-6133-2-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

Hi Ohad,

On Sun, Nov 28, 2010 at 07:21:28AM +0200, Ohad Ben-Cohen wrote:
> mmc_rescan checks whether registered cards are still present before
> skipping them, by calling the bus-specific ->detect() handler.
> 
> With buses that support runtime PM, the card may be powered off at
> this point, so they need to be powered on and fully reinitialized before
> ->detect() executes.
> 
> This whole process is redundant with nonremovable cards; in those cases,
> we can safely skip calling ->detect() and implicitly assume its success.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  drivers/mmc/core/core.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6286898..e8332d7 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1506,8 +1506,12 @@ void mmc_rescan(struct work_struct *work)
>  
>  	mmc_bus_get(host);
>  
> -	/* if there is a card registered, check whether it is still present */
> -	if ((host->bus_ops != NULL) && host->bus_ops->detect && !host->bus_dead)
> +	/*
> +	 * if there is a _removable_ card registered, check whether it is
> +	 * still present
> +	 */
> +	if ((host->bus_ops != NULL) && host->bus_ops->detect && !host->bus_dead
> +					&& mmc_card_is_removable(host))
>  		host->bus_ops->detect(host);
>  
>  	mmc_bus_put(host);

Thanks, pushed to mmc-next with trivial cleanup as below:

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e7c0c78..d9c98ee 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1506,8 +1506,12 @@ void mmc_rescan(struct work_struct *work)
 
 	mmc_bus_get(host);
 
-	/* if there is a card registered, check whether it is still present */
-	if ((host->bus_ops != NULL) && host->bus_ops->detect && !host->bus_dead)
+	/*
+	 * if there is a _removable_ card registered, check whether it is
+	 * still present
+	 */
+	if (host->bus_ops && host->bus_ops->detect && !host->bus_dead
+	    && mmc_card_is_removable(host))
 		host->bus_ops->detect(host);
 
 	mmc_bus_put(host);
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
