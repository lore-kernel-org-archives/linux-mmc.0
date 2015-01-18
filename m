From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH] mmc: vub300: remove unreachable return value handling
Date: Sun, 18 Jan 2015 02:51:02 +0100
Message-ID: <1421545862-24102-1-git-send-email-der.herr@hofr.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---

The return value of wait_for_completion_timeout is unsigned long, 
as it is used here for wait_for_completion_timeout only the type 
of commretval was changed to unsigned long.

As wait_for_completion_timeout does not return negative values
the commretval < 0 case is not reachable and can be removed.

This was only compile-tested for x86_64_defconfig + CONFIG_MMC=m,
CONFIG_MMC_VUB300=m

Patch is against 3.19.0-rc4 -next-20150116

 drivers/mmc/host/vub300.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 4262296..fbabbb8 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -659,7 +659,7 @@ static void __vub300_irqpoll_response(struct vub300_mmc_host *vub300)
 static void __do_poll(struct vub300_mmc_host *vub300)
 {
 	/* cmd_mutex is held by vub300_pollwork_thread */
-	long commretval;
+	unsigned long commretval;
 	mod_timer(&vub300->inactivity_timer, jiffies + HZ);
 	init_completion(&vub300->irqpoll_complete);
 	send_irqpoll(vub300);
@@ -671,8 +671,6 @@ static void __do_poll(struct vub300_mmc_host *vub300)
 		vub300->usb_timed_out = 1;
 		usb_kill_urb(vub300->command_out_urb);
 		usb_kill_urb(vub300->command_res_urb);
-	} else if (commretval < 0) {
-		vub300_queue_poll_work(vub300, 1);
 	} else { /* commretval > 0 */
 		__vub300_irqpoll_response(vub300);
 	}
-- 
1.7.10.4
