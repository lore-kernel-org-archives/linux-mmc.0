From: Yousong Zhou <yszhou4tech-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC] mmc: core: Set clock before switching to
 highspeed mode.
Date: Sat,  5 Sep 2015 18:19:18 +0800
Message-ID: <1441448358-13129-1-git-send-email-yszhou4tech@gmail.com>
Reply-To: yszhou4tech-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDE25RXKR4PRBGEFVOXQKGQEDKBVAZA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org, Yousong Zhou <yszhou4tech-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

A SD card with sunxi-mmc can fail with the following error message (RCD for
response CRC error) when trying to switch to highspeed mode.  Setting the bus
clock before the access mode switch fixed it.

    [    1.112060] mmc0: host does not support reading read-only switch, assuming write-enable
    [    1.120203] ehci-platform 1c1c000.usb: irq 31, io mem 0x01c1c000
    [    1.126527] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 6, RD RCE !!
    [    1.132388] sunxi-mmc 1c0f000.mmc: data error, sending stop command
    [    1.139451] sunxi-mmc 1c0f000.mmc: send stop command failed
    [    1.145056] mmc0: error -110 whilst initialising SD card
    [    1.150424] ehci-platform 1c1c000.usb: USB 2.0 started, EHCI 1.00
    [    1.156533] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 1, RTO !!

Signed-off-by: Yousong Zhou <yszhou4tech-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/mmc/core/sd.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 4e7366a..402a8db 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -366,6 +366,11 @@ int mmc_sd_switch_hs(struct mmc_card *card)
 		return -ENOMEM;
 	}
 
+	/*
+	 * Set bus frequency to match highspeed mode.
+	 */
+	mmc_set_clock(card->host, mmc_sd_get_max_clock(card));
+
 	err = mmc_sd_switch(card, 1, 0, 1, status);
 	if (err)
 		goto out;
@@ -969,11 +974,6 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 
 		/*
-		 * Set bus speed.
-		 */
-		mmc_set_clock(host, mmc_sd_get_max_clock(card));
-
-		/*
 		 * Switch to wider bus (if supported).
 		 */
 		if ((host->caps & MMC_CAP_4_BIT_DATA) &&
-- 
1.7.10.4
