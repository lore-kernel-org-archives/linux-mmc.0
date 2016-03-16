From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RFC v2] Documentation: mmc: Add the introduction for mmc-utils
Date: Wed, 16 Mar 2016 20:02:49 +0800
Message-ID: <3a35aa84d79119536fb67bc423f928a930167a73.1458031864.git.baolin.wang@linaro.org>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: corbet@lwn.net
Cc: chris@printf.net, broonie@kernel.org, linus.walleij@linaro.org, arnd@arndb.de, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, baolin.wang@linaro.org
List-Id: linux-mmc@vger.kernel.org

This patch introduces one mmc test tools called mmc-utils, which is convenient
if someone wants to exercise and test MMC/SD devices from userspace.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 Documentation/mmc/00-INDEX      |    2 ++
 Documentation/mmc/mmc-tools.txt |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 Documentation/mmc/mmc-tools.txt

diff --git a/Documentation/mmc/00-INDEX b/Documentation/mmc/00-INDEX
index a9ba672..4623bc0 100644
--- a/Documentation/mmc/00-INDEX
+++ b/Documentation/mmc/00-INDEX
@@ -6,3 +6,5 @@ mmc-dev-parts.txt
         - info on SD and MMC device partitions
 mmc-async-req.txt
         - info on mmc asynchronous requests
+mmc-tools.txt
+	- info on mmc-utils tools
diff --git a/Documentation/mmc/mmc-tools.txt b/Documentation/mmc/mmc-tools.txt
new file mode 100644
index 0000000..499b0f4
--- /dev/null
+++ b/Documentation/mmc/mmc-tools.txt
@@ -0,0 +1,34 @@
+MMC tools introduction
+======================
+
+There is one MMC test tools called mmc-utils, which is maintained by Chris Ball,
+you can find it at the below public git repository:
+http://git.kernel.org/cgit/linux/kernel/git/cjb/mmc-utils.git/
+
+Functions
+=========
+
+The mmc-utils tools can do the following:
+ - Print and parse extcsd data.
+ - Determine the eMMC writeprotect status.
+ - Set the eMMC writeprotect status.
+ - Set the eMMC data sector size to 4KB by disabling emulation.
+ - Create general purpose partition.
+ - Enable the enhanced user area.
+ - Enable write reliability per partition.
+ - Print the response to STATUS_SEND (CMD13).
+ - Enable the boot partition.
+ - Set Boot Bus Conditions.
+ - Enable the eMMC BKOPS feature.
+ - Permanently enable the eMMC H/W Reset feature.
+ - Permanently disable the eMMC H/W Reset feature.
+ - Send Sanitize command.
+ - Program authentication key for the device.
+ - Counter value for the rpmb device will be read to stdout.
+ - Read from rpmb device to output.
+ - Write to rpmb device from data file.
+ - Enable the eMMC cache feature.
+ - Disable the eMMC cache feature.
+ - Print and parse CID data.
+ - Print and parse CSD data.
+ - Print and parse SCR data.
-- 
1.7.9.5

