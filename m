From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 2/2] mmc: block: Enable runtime pm for mmc blkdevice
Date: Thu, 11 Apr 2013 11:31:56 +0300
Message-ID: <516674FC.60704@intel.com>
References: <1365421497-4661-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:55560 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753083Ab3DKI1d (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Apr 2013 04:27:33 -0400
In-Reply-To: <1365421497-4661-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>

On 08/04/13 14:44, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Once the mmc blkdevice is being probed, runtime pm will be enabled.
> By using runtime autosuspend, the power save operations can be done
> when request inactivity occurs for a certain time. Right now the
> selected timeout value is set to 3 s.
> 
> Moreover, when the blk device is being suspended, we make sure the device
> will be runtime resumed. The reason for doing this is that we want the
> host suspend sequence to be unaware of any runtime power save operations,
> so it can just handle the suspend as the device is fully powered from a
> runtime perspective.
> 
> This patch is preparing to make it possible to move BKOPS handling into
> the runtime callbacks for the mmc bus_ops. Thus IDLE BKOPS can be
> accomplished.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Maya Erez <merez@codeaurora.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Kevin Liu <kliu5@marvell.com>
> ---
>  drivers/mmc/card/block.c |   28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 

There are debugfs uses of the card also (e.g.mmc_dbg_card_status_get)
that will need get/put added.

There might be others.  Please check.

It might be worth adding helpers e.g. mmc_claim_card()/mmc_release_card
so that it is easy to see the places that the host is claimed but runtime pm
is not used.

void mmc_claim_card(card)
{
	pm_runtime_get_sync(&card->dev);
	mmc_claim_host(card->host);
}

void mmc_release_card(card)
{
	mmc_release_host(card->host);
	pm_runtime_mark_last_busy(&card->dev);
	pm_runtime_put_autosuspend(&card->dev);
}



