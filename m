From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc-utils: add the way to enable boot-partition
Date: Thu, 19 Apr 2012 13:19:20 -0400
Message-ID: <87aa27k5bb.fsf@laptop.org>
References: <1334825917-2146-1-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54505 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754242Ab2DSRTI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Apr 2012 13:19:08 -0400
In-Reply-To: <1334825917-2146-1-git-send-email-peppe.cavallaro@st.com>
	(Giuseppe CAVALLARO's message of "Thu, 19 Apr 2012 10:58:37 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org

Hi Giuseppe,

On Thu, Apr 19 2012, Giuseppe CAVALLARO wrote:
> This adds a new option to enable the boot from eMMC
> by writing to the 179 ext_csd register.
>
> The example below shows as to enable the mmcblk0boot0
> partition and also set/reset the ACK bit).
>
> $ ./mmc booten 1 1 /dev/mmcblk0boot0
> $ ./mmc extcsd read /dev/mmcblk0boot0 | grep PARTITION_CON
> Boot configuration bytes [PARTITION_CONFIG: 0x49]
>
> Reported-by: Youssef TRIKI <youssef.triki@st.com>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

Looks good, thanks -- do you mind if I make the following changes for
readability (and are they correct)?  I can update the commit message too:

diff --git a/mmc.c b/mmc.c
index c295885..6927b70 100644
--- a/mmc.c
+++ b/mmc.c
@@ -66,8 +66,8 @@ static struct Command commands[] = {
 	  NULL
 	},
 	{ do_write_boot_en, -3,
-	  "booten", "<boot_partition> " "<ack> " "<device>\n"
-		"Enable the boot partition for the <device>.",
+	  "bootpart enable", "<boot_partition> " "<send_ack> " "<device>\n"
+		"Enable the boot partition for the <device>.\nTo receive acknowledgment of boot from the card set <send_ack>\nto 1, else set it to 0.",
 	  NULL
 	},
 	{ 0, 0, 0, 0 }
diff --git a/mmc_cmds.c b/mmc_cmds.c
index f588b17..2ab4185 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -174,13 +174,18 @@ int do_write_boot_en(int nargs, char **argv)
 	__u8 value = 0;
 	int fd, ret;
 	char *device;
-	int boot_area, ack;
+	int boot_area, send_ack;
 
-	CHECK(nargs != 4, "Usage: mmc booten <partition_number> "
-			  "<ack> </path/to/mmcblkX>\n", exit(1));
+	CHECK(nargs != 4, "Usage: mmc bootpart enable <partition_number> "
+			  "<send_ack> </path/to/mmcblkX>\n", exit(1));
 
+	/*
+	 * If <send_ack> is 1, the device will send acknowledgment
+	 * pattern "010" to the host when boot operation begins.
+	 * If <send_ack> is 0, it won't.
+	 */
 	boot_area = strtol(argv[1], NULL, 10);
-	ack = strtol(argv[2], NULL, 10);
+	send_ack = strtol(argv[2], NULL, 10);
 	device = argv[3];
 
 	fd = open(device, O_RDWR);
@@ -214,7 +219,7 @@ int do_write_boot_en(int nargs, char **argv)
 		fprintf(stderr, "Cannot enable the boot area\n");
 		exit(1);
 	}
-	if (ack)
+	if (send_ack)
 		value |= EXT_CSD_PART_CONFIG_ACC_ACK;
 	else
 		value &= ~EXT_CSD_PART_CONFIG_ACC_ACK;

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
