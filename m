From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: TRIM timeout calculation
Date: Mon, 5 May 2014 18:55:29 +0200
Message-ID: <OF5115E52C.11615B85-ONC1257CCF.005BB35E-C1257CCF.005CF8B5@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw1.transmode.se ([195.58.98.146]:58915 "EHLO gw1.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753881AbaEEQzd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 5 May 2014 12:55:33 -0400
Received: from mail1.transmode.se (mail1.transmode.se [192.168.201.18])
	by gw1.transmode.se (Postfix) with ESMTP id 48B48484199
	for <linux-mmc@vger.kernel.org>; Mon,  5 May 2014 18:55:30 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I got a Micron eMMC 4.41 memory and I am trying to use the TRIM function.
my EXT_CSD_TRIM_MULT is 15 which gets me a tmo of 15*300=4500 ms
Then in  mmc_calc_max_discard() I have:
        max_discard = mmc_do_calc_max_discard(card, MMC_ERASE_ARG);
        if (mmc_can_trim(card)) {
                max_trim = mmc_do_calc_max_discard(card, MMC_TRIM_ARG);
                if (max_trim < max_discard)
                        max_discard = max_trim;
        } else if (max_discard < card->erase_size) {
                max_discard = 0;
        }
        pr_debug("%s: calculated max. discard sectors %u for timeout %u 
ms\n",
                 mmc_hostname(host), max_discard, host->max_busy_timeout);
Now  mmc_do_calc_max_discard(card, MMC_TRIM_ARG) returns 0 because the 
initial trim
timeout is so high, 4500 ms:
  mmc0: calculated max. discard sectors 0 for timeout 2684 ms

How is this supposed to work?

 Jocke
