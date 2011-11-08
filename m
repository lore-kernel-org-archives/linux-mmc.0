From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH] SD/MMC: fix the issue of SDHC performance regression
Date: Tue, 8 Nov 2011 17:47:36 +0800
Message-ID: <20111108094734.GA1592@ladygaga>
References: <1320658589-13143-1-git-send-email-b32616@freescale.com>
 <m2ipmw133p.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:21839
	"EHLO AM1EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750816Ab1KHJu3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2011 04:50:29 -0500
Content-Disposition: inline
In-Reply-To: <m2ipmw133p.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Qiang Liu <b32616@freescale.com>, linux-mmc@vger.kernel.org, leoli@freescale.com, kumar.gala@freescale.com, subhashj@codeaurora.org

On Mon, Nov 07, 2011 at 08:20:10AM -0500, Chris Ball wrote:
> Have you seen:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=f2815f68dabbb373fd1c9f0fd4a609d486697c2b 
> ("mmc: sd: Handle SD3.0 cards not supporting UHS-I bus speed mode")
> 
> which is already in mainline?  I think your patch is identical.
Hi Chris,

I think the existing code is somewhat confusing, since SDR50 means
100MHZ frequency while high speed is 50MHZ.
The reason it is correct is UHS_SDR50_BUS_SPEED is defined as 2,
which happened to be the same value as (1 << UHS_SDR25_BUS_SPEED).

How about change it like this:

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index a230e7f..670fd7f 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -306,7 +306,7 @@ static int mmc_read_switch(struct mmc_card *card)
                goto out;
        }
 
-       if (status[13] & UHS_SDR50_BUS_SPEED)
+       if (status[13] & SD_MODE_UHS_SDR25)
                card->sw_caps.hs_max_dtr = 50000000;
 
        if (card->scr.sda_spec3) {

SDR25 is also 50MHZ, the same frequency as high speed.
Or we can add a new macro for high speed like qiang has done,
which one you prefer?

Thanks,
Aaron

