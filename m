From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: UHS-I bus speed mode should be set last in UHS initialization
Date: Mon, 6 Jun 2011 15:44:10 -0700 (PDT)
Message-ID: <1cf840ce9d2fa852cb8d4e0e1bf9b559.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:50953 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758431Ab1FFWoL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jun 2011 18:44:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi Chris, Arindam,

mmc_sd_init_uhs_card function sets the driver type, current limit and bus
speed mode on card as well as on host controller side. Currently bus speed
mode is set by sending CMD6 to card and setting timing mode in host
controller and then before initiating tuning sequence, it also tries to
set current limit by sending CMD6 to card which fails on our host
controller (due to data CRC or timeout errors) if bus speed mode is
SDR50/SDR104 mode.

So basically bus speed mode should be set only after current limit is set
in the card and immediately after setting the bus speed mode, tuning
sequence should be initiated. So following changes is needed. If it looks
fine then I can send you this change in patch.

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
0da37eb..19634d5 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -610,13 +610,13 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
        if (err)
                goto out;

-       /* Set bus speed mode of the card */
-       err = sd_set_bus_speed_mode(card, status);
+       /* Set current limit for the card */
+       err = sd_set_current_limit(card, status);
        if (err)
                goto out;

-       /* Set current limit for the card */
-       err = sd_set_current_limit(card, status);
+       /* Set bus speed mode of the card */
+       err = sd_set_bus_speed_mode(card, status);
        if (err)
                goto out;

Regards,
Subhash

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.


