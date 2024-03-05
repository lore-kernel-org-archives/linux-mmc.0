Received: from smtpcmd15177.aruba.it (smtpcmd15177.aruba.it [62.149.156.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4ED199BC
	for <linux-mmc@vger.kernel.org>; Tue,  5 Mar 2024 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664747; cv=none; b=n2ClEvCevZqBdSYpfJoMzJ6HgbMKgqjCmfBI/Sfi+o/GntrTwv81sZMPuGVUeWJ0qThuhjFk/ulUSnVlAqnojAju4HneWFQ5Rm11UsIdnB9IEcdHdKCeGBmdPIbj8H7E4e/7az1lgDVlzY92v3tmlnTsZ1X+A025JXYvV34pkyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664747; c=relaxed/simple;
	bh=Hl1iMWJ5ZTZshuq7Gy73av13VvFRnb2K8g0w8K7k2g0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t+UNaJapkj9uSMtyPAunSW7sFlndHKywWmviKFHvkflYxagEaD69mONLlaSnIxhZFL6Sj59117chrFmfVFO6zX2HVxuFuwhGUb7AQVAHadm/oicMGdQ5rkUOV2gz2A2A3SDcJKCEZ9K17R57N5TdKT02A48EEJOcqJmQozczSAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benettiengineering.com; spf=pass smtp.mailfrom=benettiengineering.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=n5b8+buU; arc=none smtp.client-ip=62.149.156.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benettiengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benettiengineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="n5b8+buU"
Received: from localhost.localdomain ([84.33.84.190])
	by Aruba Outgoing Smtp  with ESMTPSA
	id hZmsrAB8YT8FyhZmsr4cl8; Tue, 05 Mar 2024 19:45:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1709664315; bh=Hl1iMWJ5ZTZshuq7Gy73av13VvFRnb2K8g0w8K7k2g0=;
	h=From:To:Subject:Date:MIME-Version;
	b=n5b8+buUZCpI5KE9hoj/PI+x8M+Qd5rl9kVu+y+pqWubpP4s8zNCEt34yzvQPlJzN
	 UqLNeoUlDI6ajrygkDA3XP5Kyv+5jmUrM+fLyhu1j4CHY8K26wtmQqce0/b6elDeNF
	 FemzbeAvJ8AqFeADWETVN3rsYqzLT1PStNQO9XNKTEkCly8hqLwvraSijYUCCZiCpH
	 4vwUm5ca6QrQJMAa8sfFcl33QxjCoEF/Xam9zNQDUGUPN7xY6O0pyNV2DPql8bRFIV
	 vn1IvFvkK8+jG8k4uZIGxaj29KYQxo8vPABJwa5IYHpHPL+uSRQVhK4K2CnL3ICrs9
	 6FsxQ5rnh3qbQ==
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
To: Avri Altman <Avri.Altman@wdc.com>
Cc: linux-mmc@vger.kernel.org,
	Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH v2] mmc-utils: mmc_cmds: fix type-punned warning on &ext_csd[] casting
Date: Tue,  5 Mar 2024 19:45:13 +0100
Message-Id: <20240305184513.400364-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DM6PR04MB657504D3DD4B66F9873E3094FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <DM6PR04MB657504D3DD4B66F9873E3094FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNQC2NHaAmJis0h5BKc8i1CSShn81OVlyL2Ne5sFPvUOzzSKy1cJQW5d9fF8vHXoJq3yLfRFpCfXkOwFMR9nhVCHSBzDMan4hRehHhieAIXe7GzMajsC
 VDTEqxRNSJKEkzInt5gqD6yxasYtd5c+qzBhLaWjKsDqgb8+po6p0qXlauOt/pF53pcxz04qq4UFj5ZCcx7dxjknuH9PDDXWzX7jxhuKsN0VfWGK5VE5djuL
 xumgXAfw8I8vPgu/X4OuksGaiV5WWEnN6Bbp5TQD5YZuU440TXxDCGAF/SXLY4RB/h2jWJrTH/DYOvFx2K+kYg==

When building with -Werror=strict-aliasing error is thrown:

mmc_cmds.c: In function 'do_ffu':
mmc_cmds.c:2972:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
  sect_done = htole32(*((__u32 *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]));
  ^
cc1: all warnings being treated as errors

Let's fix type-punned breaking strict-aliasing by implementing local
per_byte_htole32(__u8 *) and use it for the 2 present occurences of
htole32(). Let's also change sect_done type to __u32 for consistency.

Suggested-by: Avri Altman <Avri.Altman@wdc.com>
Fixes: a1b594ca735e ("mmc-utils: ffu: Simplify ext_csd bytes parsing")
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
V1->V2:
* implement local per_byte_htole32() as suggested by Avril Altman
---
 mmc_cmds.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index ae7b876..936e0c5 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -58,6 +58,11 @@
 #define WPTYPE_PWRON 2
 #define WPTYPE_PERM 3
 
+static inline __u32 per_byte_htole32(__u8 *arr)
+{
+	return arr[0] | arr[1] << 8 | arr[2] << 16 | arr[3] << 24;
+}
+
 int read_extcsd(int fd, __u8 *ext_csd)
 {
 	int ret = 0;
@@ -2807,7 +2812,7 @@ static void set_ffu_single_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
 			       __u8 *ext_csd, unsigned int bytes, __u8 *buf,
 			       off_t offset)
 {
-	__u32 arg = htole32(*((__u32 *)&ext_csd[EXT_CSD_FFU_ARG_0]));
+	__u32 arg = per_byte_htole32(&ext_csd[EXT_CSD_FFU_ARG_0]);
 
 	/* send block count */
 	set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0,
@@ -2827,7 +2832,7 @@ static void set_ffu_single_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
 int do_ffu(int nargs, char **argv)
 {
 	int dev_fd, img_fd;
-	int sect_done = 0, retry = 3, ret = -EINVAL;
+	int retry = 3, ret = -EINVAL;
 	unsigned int sect_size;
 	__u8 ext_csd[512];
 	__u8 *buf = NULL;
@@ -2835,6 +2840,7 @@ int do_ffu(int nargs, char **argv)
 	char *device;
 	struct mmc_ioc_multi_cmd *multi_cmd = NULL;
 	unsigned int default_chunk = MMC_IOC_MAX_BYTES;
+	__u32 sect_done = 0;
 
 	assert (nargs == 3 || nargs == 4);
 
@@ -2968,7 +2974,7 @@ do_retry:
 	}
 
 	/* Test if we need to restart the download */
-	sect_done = htole32(*((__u32 *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]));
+	sect_done = per_byte_htole32(&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]);
 	/* By spec, host should re-start download from the first sector if sect_done is 0 */
 	if (sect_done == 0) {
 		if (retry--) {
-- 
2.34.1

