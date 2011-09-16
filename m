From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH] mmc: core: Set correct bus mode before card init
Date: Fri, 16 Sep 2011 10:05:24 +0800
Message-ID: <20110916020522.GA3691@lovegaga>
References: <1316101838-22660-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:18442
	"EHLO AM1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750991Ab1IPCGS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Sep 2011 22:06:18 -0400
Content-Disposition: inline
In-Reply-To: <1316101838-22660-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

Hi Ulf,

I'm not familiar with mmc, but I've some questions on sd below.

On Thu, Sep 15, 2011 at 05:50:38PM +0200, Ulf Hansson wrote:
> Earlier all cards where initiated with bus mode set as OPENDRAIN, and then
> later switched to PUSHPULL. According to the MMC/SD/SDIO specifications only
> MMC cards use OPENDRAIN during init. For both SD and SDIO the bus mode shall
> be PUSHPULL before attempting to init the card.
AFAIK, there is no open drain mode in sd, and the sd host controller
actually does not care about this setting(sdhci_set_ios does not
manipulate bus_mode stored in ios).
> 
> The consequence of having incorrect bus mode can lead to not being able
> to detect the card. Therefore the default behavior have now been changed to
> PUSHPULL in mmc_power_up, and will only be temporarily switched when trying
> to attach or init a MMC card.
Do you see any sd cards that failed to be detected due to the incorrect
bus_mode setting?

Anyway, your patch removed an unnecessary call to mmc_set_bus_mode which
should have no effect if the underlying controller is sdhci.

-Aaron

