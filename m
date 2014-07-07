From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: mmc: sdhci: Check mrq->cmd in sdhci_tasklet_finish
Date: Mon, 7 Jul 2014 15:00:25 +0300
Message-ID: <20140707120025.GA13887@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:29781 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbaGGMAi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jul 2014 08:00:38 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-mmc@vger.kernel.org

[ This is old but the inconsistent NULL check was added so deliberately
  that it looks odd so I'm sending the email. -dan ]

Hello Ben Dooks,

This is a semi-automatic email about new static checker warnings.

The patch b7b4d3426d2b: "mmc: sdhci: Check mrq->cmd in
sdhci_tasklet_finish" from Apr 27, 2011, leads to the following
Smatch complaint:

drivers/mmc/host/sdhci.c:2151 sdhci_tasklet_finish()
	 error: we previously assumed 'mrq->cmd' could be null (see line 2124)

drivers/mmc/host/sdhci.c
  2123		if (!(host->flags & SDHCI_DEVICE_DEAD) &&
  2124		    ((mrq->cmd && mrq->cmd->error) ||
                      ^^^^^^^^
Patch adds NULL check.

  2125			 (mrq->data && (mrq->data->error ||
  2126			  (mrq->data->stop && mrq->data->stop->error))) ||
  2127			   (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST))) {
  2128	
  2129			/* Some controllers need this kick or reset won't work here */
  2130			if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
  2131				/* This is to force an update */
  2132				host->ops->set_clock(host, host->clock);
  2133	
  2134			/* Spec says we should do both at the same time, but Ricoh
  2135			   controllers do not like that. */
  2136			sdhci_do_reset(host, SDHCI_RESET_CMD);
  2137			sdhci_do_reset(host, SDHCI_RESET_DATA);
  2138		}
  2139	
  2140		host->mrq = NULL;
  2141		host->cmd = NULL;
  2142		host->data = NULL;
  2143	
  2144	#ifndef SDHCI_USE_LEDS_CLASS
  2145		sdhci_deactivate_led(host);
  2146	#endif
  2147	
  2148		mmiowb();
  2149		spin_unlock_irqrestore(&host->lock, flags);
  2150	
  2151		mmc_request_done(host->mmc, mrq);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
But we "mrq->cmd" is not checked here and it's dereferenced inside the
mmc_request_done() function call.

  2152		sdhci_runtime_pm_put(host);
  2153	}

regards,
dan carpenter
