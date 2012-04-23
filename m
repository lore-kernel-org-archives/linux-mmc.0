From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 12/12] Add removal of old OMAP private DMA implementation to
 feature removal
Date: Mon, 23 Apr 2012 17:08:13 +0100
Message-ID: <E1SMLoD-0002Wr-6z@rmk-PC.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 Documentation/feature-removal-schedule.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 03ca210..aec6f37 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -539,3 +539,14 @@ When:	3.6
 Why:	setitimer is not returning -EFAULT if user pointer is NULL. This
 	violates the spec.
 Who:	Sasikantha Babu <sasikanth.v19@gmail.com>
+
+----------------------------
+
+What:	OMAP private DMA implementation
+When:	2013
+Why:	We have a DMA engine implementation; all users should be updated
+	to use this rather than persisting with the old APIs.  The old APIs
+	block merging the old DMA engine implementation into the DMA
+	engine driver.
+Who:	Russell King <linux@arm.linux.org.uk>,
+	Santosh Shilimkar <santosh.shilimkar@ti.com>
-- 
1.7.4.4

