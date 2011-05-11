From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4 02/15] mmc: sd: query function modes for uhs cards
Date: Tue, 10 May 2011 23:34:33 -0400
Message-ID: <m3vcxh52ra.fsf@pullcord.laptop.org>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-3-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38194 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754134Ab1EKDcF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2011 23:32:05 -0400
In-Reply-To: <1304578151-1775-3-git-send-email-arindam.nath@amd.com> (Arindam
	Nath's message of "Thu, 5 May 2011 12:18:58 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: prakity@marvell.com, zhangfei.gao@gmail.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

Hi,

On Thu, May 05 2011, Arindam Nath wrote:
> SD cards which conform to Physical Layer Spec v3.01 can support
> additional Bus Speed Modes, Driver Strength, and Current Limit
> other than the default values. We use CMD6 mode 0 to read these
> additional card functions. The values read here will be used
> during UHS-I initialization steps.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Thanks, pushed to mmc-next for .40 with the trivial changes below:

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index d4410c9..027d7cb 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -190,7 +190,7 @@ static int mmc_decode_scr(struct mmc_card *card)
 	scr->sda_vsn = UNSTUFF_BITS(resp, 56, 4);
 	scr->bus_widths = UNSTUFF_BITS(resp, 48, 4);
 	if (scr->sda_vsn == SCR_SPEC_VER_2)
-		/* Check if Physical Layer Spec v3.0 is supported*/
+		/* Check if Physical Layer Spec v3.0 is supported */
 		scr->sda_spec3 = UNSTUFF_BITS(resp, 47, 1);
 
 	if (UNSTUFF_BITS(resp, 55, 1))
@@ -288,13 +288,11 @@ static int mmc_read_switch(struct mmc_card *card)
 		 * If the host or the card can't do the switch,
 		 * fail more gracefully.
 		 */
-		if ((err != -EINVAL)
-		&& (err != -ENOSYS)
-		&& (err != -EFAULT))
+		if (err != -EINVAL && err != -ENOSYS && err != -EFAULT)
 			goto out;
 
 		printk(KERN_WARNING "%s: problem reading Bus Speed modes.\n",
@@ -310,14 +308,11 @@ static int mmc_read_switch(struct mmc_card *card)
 			 * If the host or the card can't do the switch,
 			 * fail more gracefully.
 			 */
-			if ((err != -EINVAL)
-			&& (err != -ENOSYS)
-			&& (err != -EFAULT))
+			if (err != -EINVAL && err != -ENOSYS && err != -EFAULT)
 				goto out;
 
 			printk(KERN_WARNING "%s: problem reading "
@@ -332,14 +327,11 @@ static int mmc_read_switch(struct mmc_card *card)
 			 * If the host or the card can't do the switch,
 			 * fail more gracefully.
 			 */
-			if ((err != -EINVAL)
-			&& (err != -ENOSYS)
-			&& (err != -EFAULT))
+			if (err != -EINVAL && err != -ENOSYS && err != -EFAULT)
 				goto out;
 
 			printk(KERN_WARNING "%s: problem reading "


- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
