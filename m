From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/6] memstick: rtsx_usb_ms: Runtime resume the device when polling for cards
Date: Thu, 13 Oct 2016 13:37:37 +0200
Message-ID: <1476358660-8338-4-git-send-email-ulf.hansson@linaro.org>
References: <1476358660-8338-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1476358660-8338-1-git-send-email-ulf.hansson@linaro.org>
Sender: stable-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ritesh Raj Sarraf <rrs@researchut.com>, Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.com>, USB list <linux-usb@vger.kernel.org>, Roger Tseng <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

Accesses to the rtsx usb device, which is the parent of the rtsx memstick
device, must not be done unless it's runtime resumed.

Therefore when the rtsx_usb_ms driver polls for inserted memstick cards,
let's add pm_runtime_get|put*() to make sure accesses is done when the
rtsx usb device is runtime resumed.

Reported-by: Ritesh Raj Sarraf <rrs@researchut.com>
Tested-by: Ritesh Raj Sarraf <rrs@researchut.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/memstick/host/rtsx_usb_ms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index d34bc35..1b99489 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -681,6 +681,7 @@ static int rtsx_usb_detect_ms_card(void *__host)
 	int err;
 
 	for (;;) {
+		pm_runtime_get_sync(ms_dev(host));
 		mutex_lock(&ucr->dev_mutex);
 
 		/* Check pending MS card changes */
@@ -703,6 +704,7 @@ static int rtsx_usb_detect_ms_card(void *__host)
 		}
 
 poll_again:
+		pm_runtime_put(ms_dev(host));
 		if (host->eject)
 			break;
 
-- 
1.9.1
