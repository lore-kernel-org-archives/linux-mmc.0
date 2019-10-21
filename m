From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/7] debugfs: Add debugfs_create_xul() for hexadecimal unsigned long
Date: Mon, 21 Oct 2019 16:37:36 +0200
Message-ID: <20191021143742.14487-2-geert+renesas@glider.be>
References: <20191021143742.14487-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021143742.14487-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jaehoon Chung <jh80.chung@samsung.com>, "David S . Miller" <davem@davemloft.net>, "Rafael J . Wysocki" <rafael@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-mmc@vger.kernel.org

The existing debugfs_create_ulong() function supports objects of
type "unsigned long", which are 32-bit or 64-bit depending on the
platform, in decimal form.  To format objects in hexadecimal, various
debugfs_create_x*() functions exist, but all of them take fixed-size
types.

Add a debugfs helper for "unsigned long" objects in hexadecimal format.
This avoids the need for users to open-code the same, or introduce
bugs when casting the value pointer to "u32 *" or "u64 *" to call
debugfs_create_x{32,64}().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/debugfs.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 33690949b45d6904..d7b2aebcc277d65e 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -356,4 +356,14 @@ static inline ssize_t debugfs_write_file_bool(struct file *file,
 
 #endif
 
+static inline void debugfs_create_xul(const char *name, umode_t mode,
+				      struct dentry *parent,
+				      unsigned long *value)
+{
+	if (sizeof(*value) == sizeof(u32))
+		debugfs_create_x32(name, mode, parent, (u32 *)value);
+	else
+		debugfs_create_x64(name, mode, parent, (u64 *)value);
+}
+
 #endif
-- 
2.17.1
