From: Philip Rakity <prakity@marvell.com>
Subject: Re: [BUG] CMD52 sent as first command not CMD0
Date: Sat, 5 Feb 2011 17:35:46 -0800
Message-ID: <173274DF-475D-44FB-8C34-25728D12ADBB@marvell.com>
References: <C85F98EE-B8C5-4037-A0FF-203265A7575C@marvell.com>
 <20110206003845.GA15019@void.printf.net>
 <BC6C6C10-631A-4482-BA1B-C6F0057BC54A@marvell.com>
 <20110206011514.GA15322@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:52019 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751948Ab1BFBfw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 5 Feb 2011 20:35:52 -0500
In-Reply-To: <20110206011514.GA15322@void.printf.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Albert Herranz <albert_herranz@yahoo.es>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


proposed solution:  I cannot verify this fix until Monday.
=====

CMD52 is a reset for SDIO cards.  CMD0 is not sufficient when
the card is being re-initialized.  Only send CMD52 if
a) doing a reinitialize
b) card is SDIO or SDIO_COMBO

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/core/core.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 30d4da4..f0ce6f6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1521,7 +1521,12 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 		mmc_hostname(host), __func__, host->f_init);
 #endif
 	mmc_power_up(host);
-	sdio_reset(host);
+
+	/* reset sdio before CMD0 when card is being reinitialized */
+	if (host->card &&
+		(host->card->type == MMC_TYPE_SDIO ||
+		host->card->type == MMC_TYPE_SD_COMBO))
+			sdio_reset(host);
 	mmc_go_idle(host);
 	mmc_hwungate_clock(host);
 
-- 
1.7.0.4



On Feb 5, 2011, at 5:15 PM, Chris Ball wrote:

> On Sat, Feb 05, 2011 at 04:52:12PM -0800, Philip Rakity wrote:
>> nothing negative but reset is meant to reinit the card.  This is the power up sequence for the 1st time a card is detected.
>> There is no reason to do this if no card has yet enumerated.  If a sdio card was there I completely agree with the mod since we need to reset 
>> the card. 
>> 
>> CMD0 should be the 1st command on an initial power up sequence.  Does my code suggestion work for you ?
> 
> Okay -- yes, looks fine.  Let's add a comment beforehand; something like:
> 
> /* If reinitalizing, we must send CMD52 before CMD0 for SDIO. */
> 
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

