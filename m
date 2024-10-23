Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0F71E22FC
	for <linux-mmc@vger.kernel.org>; Wed, 23 Oct 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694518; cv=pass; b=cMizAnXmZQmjD1B2UXc5JdQY3u2xHd5ro/j13bRjQQM3q+/7uTS3+A9ZUz7rLb2buJ2kfQWiuKbgeDtZ7oQlr20YEPcSa0g1D+FnfQizpnKnlFV8Ipwn7rCCeJXimnteik00ausqiqYLqJDXS5vf5rU0YTwlVy+kRAJipObeH5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694518; c=relaxed/simple;
	bh=0A8k9TWam9yB/uf9TNe+kd6pqtKxOQyEhwAXy1k8/1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DL0J869LfAumBJBVW3ldbJxBkUVW+0G44LO3L2iEfy+ygOHvnKyPcoQw7FUGCjD/x8FMweyztApUob4Wq/zZIkF5Qft5xUjoEskKrTwX+zRX7G1nDVGWDwbVzQF0sO00EwkSrsrFgmDwPAxDKvWF2rFhMHYMa+Sub8e1QA3pboo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=GGn+SSZM; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=0qRlk2q/; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="GGn+SSZM";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="0qRlk2q/"
ARC-Seal: i=1; a=rsa-sha256; t=1729694330; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gkbQl8tbNBfyWYmkZrZvTaPeQl1Z7698WOmRlF7mLsw5B12nTqUCmRwjQyTtIgCOMr
    jXgJf6a07TxeCyW2ITlcPKgX6Nw2Pj6ddWDeEAGFLLsV1S7uA161qfnM2B7LudI9zpfi
    lw2+5Gggc6i0urJGOqqzO0wWD1uTtiv4XHW5LFMRvbrors1802dm5Ri0X7nSjWgcG88S
    NGEScENVpnHPWo3pDR1QVzm6s2LO7CUImfJbMlvcmuST3fzODHhSQEwTB6y9wWiHWuva
    6W9FisYtUlS3kK9GYKAAl3yV51bCeW5sazxBrAGy0d3kzqxmKGIyXIJitVnh7y40lFXC
    //xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729694330;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4UMj/6L75msqfl4ZuzDIdWw+0IgWgStcnjxHHsqRRO4=;
    b=IfzW2n9KvOCm0FFCnzPSJGpYsHF9ygV7H1Y3A+bfWUJFIUgThH+55p6RoKKt72rSQq
    57K/onRcATF5Gb8cxf8J8Jr3t/3TXPiWChhvgZkHSYmRkl0R31gK2VXsrBOUzDPd/HZh
    6g+rnrSe8GJlLXimqQ+g9k36yJ2x7ZEAV+SWLLUmYQ1F5QxJFGhUs5G1rKLQyhKkhRC+
    Pp2DOuDk7dH3+69556JiEPBmtwh0kjDQpyTp3feyVOhV2HN2SRRLfPjcPZyVloxJ+MS2
    UmzlbeTBrtazgJJehpbKeW2Bsqq1sKtJqUe1evrISvhM1WXiLaQ2lnUF7RV1PYZQTV3b
    MlGg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729694330;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4UMj/6L75msqfl4ZuzDIdWw+0IgWgStcnjxHHsqRRO4=;
    b=GGn+SSZMdCHYQgpkptvKk5HcxTRn3a5kzGXD+Myn66H7CjalQ0F1LEC2fg9pUMmQes
    nAFSXDUDQAL2QLhyUgfjP381GTsh3nDU/p71wRvxvfYSQcrZtws1Wtmqty79vNWlWqQx
    LyUYVrDsioG3fnBvdmW8rcz7PLHJY0u/BpEyUwTwiMVPFGwcxzSsNkWgdmV2WWKPpkZD
    WfOEdz7Rz9+TwJ7E3oZGZefgqiRTH3I23Jb4Nz40q1iocCIaFu50q6s8Gs4yP/Jv2hSw
    GuyBbZMIg8GzFFd+JSIo6ikb3SzrSTHPBoWuJq+run8ns23dwsWyFryJwCBdN/NUMAtw
    6fkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729694330;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4UMj/6L75msqfl4ZuzDIdWw+0IgWgStcnjxHHsqRRO4=;
    b=0qRlk2q/oU2At0n2eAn+SpkEhvAh9mOEQiuQ7NFXxoYO+d6SusBbSM4NUrARkDQEDM
    uu+AVE1lmI6DEck2HpAw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O2J2YOom0XQaPis+nU/xK"
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209NEcnTmA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 23 Oct 2024 16:38:49 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v4 3/5] mmc-utils: Add new FFU mode using CMD25+CMD12 for Open-ended write download FW
Date: Wed, 23 Oct 2024 16:38:37 +0200
Message-Id: <20241023143839.108572-4-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023143839.108572-1-beanhuo@iokpp.de>
References: <20241023143839.108572-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Bean Huo <beanhuo@micron.com>

Introduced a new FFU mode 3 of leveraging CMD25+CMD12 for Open-ended Multiple-block write to
download the firmware bundle. In this mmode, the device remains in FFU mode during firmware
download until the downloading is completed.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Acked-by: Avri Altman <avri.altman@wdc.com>
---
 mmc.1      |  3 +++
 mmc.c      |  5 +++++
 mmc.h      |  1 +
 mmc_cmds.c | 11 +++++++++++
 mmc_cmds.h |  1 +
 5 files changed, 21 insertions(+)

diff --git a/mmc.1 b/mmc.1
index 256852b..220427b 100644
--- a/mmc.1
+++ b/mmc.1
@@ -195,6 +195,9 @@ if [\fIchunk\-bytes\fR] is omitted, mmc-utils will try to run ffu using the larg
 .BI ffu2 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
 Same as 'ffu1', but uses CMD23+CMD25 for repeated downloads and remains in FFU mode until completion.
 .TP
+.BI ffu3 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
+Same as 'ffu1', but uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.
+.TP
 .BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
 Send Erase CMD38 with specific argument to the device.
 .br
diff --git a/mmc.c b/mmc.c
index ffc98dc..e013fc6 100644
--- a/mmc.c
+++ b/mmc.c
@@ -239,6 +239,11 @@ static struct Command commands[] = {
 	 "Same as 'ffu1', but uses CMD23+CMD25 for repeated downloads and remains in FFU mode until completion.\n",
 	 NULL
 	},
+	{ do_ffu3, -2,
+	 "ffu3", "<image name> <device> [chunk-bytes]\n"
+	 "Same as 'ffu', but uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.\n",
+	 NULL
+	},
 	{ do_erase, -4,
 	"erase", "<type> " "<start address> " "<end address> " "<device>\n"
 		"Send Erase CMD38 with specific argument to the <device>\n\n"
diff --git a/mmc.h b/mmc.h
index 6f1bf3e..14dac38 100644
--- a/mmc.h
+++ b/mmc.h
@@ -27,6 +27,7 @@
 #define MMC_BOOT_INITIATION_ARG		0xFFFFFFFA
 #define MMC_SWITCH		6	/* ac	[31:0] See below	R1b */
 #define MMC_SEND_EXT_CSD	8	/* adtc				R1  */
+#define MMC_STOP_TRANSMISSION  12      /* ac                           R1b */
 #define MMC_SEND_STATUS		13	/* ac   [31:16] RCA        R1  */
 #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
 #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index c183a2d..4bec56d 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2846,6 +2846,12 @@ static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
 		multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 		set_single_cmd(&multi_cmd->cmds[1], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
 		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
+	} else if (ffu_mode == 3) {
+		set_single_cmd(&multi_cmd->cmds[0], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
+		multi_cmd->cmds[0].flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[0], buf + offset);
+		set_single_cmd(&multi_cmd->cmds[1], MMC_STOP_TRANSMISSION, 0, 0, 0);
+		multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 	}
 }
 
@@ -3197,6 +3203,11 @@ int do_ffu2(int nargs, char **argv)
 	return __do_ffu(nargs, argv, 2);
 }
 
+int do_ffu3(int nargs, char **argv)
+{
+	return __do_ffu(nargs, argv, 3);
+}
+
 int do_general_cmd_read(int nargs, char **argv)
 {
 	int dev_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index e2eba91..413bc85 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -43,6 +43,7 @@ int do_cache_en(int nargs, char **argv);
 int do_cache_dis(int nargs, char **argv);
 int do_ffu1(int nargs, char **argv);
 int do_ffu2(int nargs, char **argv);
+int do_ffu3(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
-- 
2.34.1

