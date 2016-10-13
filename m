From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/6] memstick: rtsx_usb_ms: Manage runtime PM when accessing the device
Date: Thu, 13 Oct 2016 13:37:38 +0200
Message-ID: <1476358660-8338-5-git-send-email-ulf.hansson@linaro.org>
References: <1476358660-8338-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476358660-8338-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ritesh Raj Sarraf <rrs@researchut.com>, Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.com>, USB list <linux-usb@vger.kernel.org>, Roger Tseng <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Accesses to the rtsx usb device, which is the parent of the rtsx memstick
device, must not be done unless it's runtime resumed. This is currently not
the case and it could trigger various errors.

Fix this by properly deal with runtime PM in this regards. This means
making sure the device is runtime resumed, when serving requests via the
->request() callback or changing settings via the ->set_param() callbacks.

Cc: <stable@vger.kernel.org>
Cc: Ritesh Raj Sarraf <rrs@researchut.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/memstick/host/rtsx_usb_ms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index 1b99489..2e3cf01 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -524,6 +524,7 @@ static void rtsx_usb_ms_handle_req(struct work_struct *work)
 	int rc;
 
 	if (!host->req) {
+		pm_runtime_get_sync(ms_dev(host));
 		do {
 			rc = memstick_next_req(msh, &host->req);
 			dev_dbg(ms_dev(host), "next req %d\n", rc);
@@ -544,6 +545,7 @@ static void rtsx_usb_ms_handle_req(struct work_struct *work)
 						host->req->error);
 			}
 		} while (!rc);
+		pm_runtime_put(ms_dev(host));
 	}
 
 }
@@ -570,6 +572,7 @@ static int rtsx_usb_ms_set_param(struct memstick_host *msh,
 	dev_dbg(ms_dev(host), "%s: param = %d, value = %d\n",
 			__func__, param, value);
 
+	pm_runtime_get_sync(ms_dev(host));
 	mutex_lock(&ucr->dev_mutex);
 
 	err = rtsx_usb_card_exclusive_check(ucr, RTSX_USB_MS_CARD);
@@ -635,6 +638,7 @@ static int rtsx_usb_ms_set_param(struct memstick_host *msh,
 	}
 out:
 	mutex_unlock(&ucr->dev_mutex);
+	pm_runtime_put(ms_dev(host));
 
 	/* power-on delay */
 	if (param == MEMSTICK_POWER && value == MEMSTICK_POWER_ON)
-- 
1.9.1
