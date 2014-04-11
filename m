From: <rogerable@realtek.com>
Subject: [PATCH v7 2/4] [v6 fix] mfd/rtsx_usb: add comment in rtsx_usb_suspend
Date: Fri, 11 Apr 2014 14:53:21 +0800
Message-ID: <1397199203-2235-3-git-send-email-rogerable@realtek.com>
References: <1397199203-2235-1-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1397199203-2235-1-git-send-email-rogerable@realtek.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Chris Ball <chris@printf.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Oliver Neukum <oneukum@suse.de>
Cc: driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, rogerable@realtek.com
List-Id: linux-mmc@vger.kernel.org

From: Roger Tseng <rogerable@realtek.com>

Explain why there is no need to have a symmetric LED turn-on in resume handler
while calling rtsx_usb_turn_off_led() in suspend handler.

Signed-off-by: Roger Tseng <rogerable@realtek.com>
---
 drivers/mfd/rtsx_usb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mfd/rtsx_usb.c b/drivers/mfd/rtsx_usb.c
index 0ca7973..141ea52 100644
--- a/drivers/mfd/rtsx_usb.c
+++ b/drivers/mfd/rtsx_usb.c
@@ -687,9 +687,15 @@ static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
 	dev_dbg(&intf->dev, "%s called with pm message 0x%04u\n",
 			__func__, message.event);
 
+	/*
+	 * Call to make sure LED is off during suspend to save more power.
+	 * It is NOT a permanent state and could be turned on anytime later.
+	 * Thus no need to call turn_on when resunming.
+	 */
 	mutex_lock(&ucr->dev_mutex);
 	rtsx_usb_turn_off_led(ucr);
 	mutex_unlock(&ucr->dev_mutex);
+
 	return 0;
 }
 
-- 
1.8.2
