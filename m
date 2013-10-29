From: Richard Retanubun <RichardRetanubun@RuggedCom.com>
Subject: [PATCH 1/2] Allow 'mmc bootpart enable' to set things back to default
Date: Tue, 29 Oct 2013 16:37:16 -0400
Message-ID: <1383079036-20794-1-git-send-email-RichardRetanubun@RuggedCom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail2.ruggedcom.com ([204.50.148.11]:22805 "EHLO
	mail2.ruggedcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932Ab3J2UnH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Oct 2013 16:43:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: ben.l.gardiner@gmail.com, linux-mmc@vger.kernel.org, Richard Retanubun <RichardRetanubun@RuggedCom.com>

Passing bootpart argument as 0 will cause the BOOT_ACK (Bit[6]) and
BOOT_PARTITION_ENABLE (Bit[5:3]) to be set back to the device default.
---
 mmc.h      |    1 +
 mmc_cmds.c |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/mmc.h b/mmc.h
index 9871d62..1127d75 100644
--- a/mmc.h
+++ b/mmc.h
@@ -99,6 +99,7 @@
 #define EXT_CSD_HW_RESET_EN		(0x01)
 #define EXT_CSD_HW_RESET_DIS		(0x02)
 #define EXT_CSD_PART_CONFIG_ACC_MASK	  (0x7)
+#define EXT_CSD_PART_CONFIG_ACC_NO_BOOT	  (0x0)
 #define EXT_CSD_PART_CONFIG_ACC_BOOT0	  (0x1)
 #define EXT_CSD_PART_CONFIG_ACC_BOOT1	  (0x2)
 #define EXT_CSD_PART_CONFIG_ACC_USER_AREA (0x7)
diff --git a/mmc_cmds.c b/mmc_cmds.c
index b8afa74..af6f09f 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -280,6 +280,9 @@ int do_write_boot_en(int nargs, char **argv)
 	case EXT_CSD_PART_CONFIG_ACC_USER_AREA:
 		value |= (boot_area << 3);
 		break;
+	case EXT_CSD_PART_CONFIG_ACC_NO_BOOT:
+		value &= 0x87; /* Zero out Bit[6] and Bit[5:3] */
+		break;
 	default:
 		fprintf(stderr, "Cannot enable the boot area\n");
 		exit(1);
-- 
1.7.10.4

