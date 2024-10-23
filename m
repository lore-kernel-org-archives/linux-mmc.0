Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632691FEFB3
	for <linux-mmc@vger.kernel.org>; Wed, 23 Oct 2024 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694698; cv=pass; b=gNtjz4CRNvi6gGI8hwXcRMzRhfMNIu3TTkJI4qolXPEFKzptOBbSrc6P5EQVL9188NyZsDl+7DsdFYMHzMyyGVaEzjTciPbGPEGlmVSHyXAHYCQV9Sn9kqstk57kVSe0n+iQO/X1KsfnlXIe7v2TGI01U40om5NJi6QjmMOenWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694698; c=relaxed/simple;
	bh=shhSIsRVGjC3jIHT+UAyXdmQ0iGV4spNHE0S6qbgvNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrPmRv0DMWLUbV/nyFkFQra/jYeFp5SBqeO0rTu729gvHUkkUoHl+NYxpBigvsE75BJVRzhdwilg3E+vytbozVt/0yWtDk4EyC++VqUFJAiuwu30FYXqDWokW0Z+Rf/0a5YgBOvJwgNP82mpnohMmY14QcrGT9seQuV9pQUbx5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=r4wr/TQj; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=ZDmP1t0K; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="r4wr/TQj";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="ZDmP1t0K"
ARC-Seal: i=1; a=rsa-sha256; t=1729694330; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YnR6hTkWFkLGXSmN8GkQWs6J/lN9JB8f7wpcVZT72Wv0pxfT6TMNxmbnlMIVvvFxWA
    5+GiglpgHVXL1RB8ZMaXmCO3liIXom7b09mbc3o1ZTZRNKgPRTz9zGeYTMa8dAZg8+BF
    k4vazdXoOQXxmQWZlHJtZ2EMktBc/aB6faCVZrt2shaecm6wyTiFubnNIFAK3WoaI4ik
    4xX5EiRYTor6vJWslp/ihSVol6j35hq8Czumb2sr+8Er+XdO028vsr7X3XivNG/iGb0L
    HaNnYzYlGJr17t7/VeX8HXwcSJ62DU5zsnzgxrO964f3R0bC1te5zd8ASSBnKs468Yll
    5l7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729694330;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HOfLSgPXwF+te9GVD5VBXThzLDka1ZwQ3T0UbMa7rR4=;
    b=Kv0rST8H3fhfHZiq1bUp7Mh7KX3clWqgr51Bj41SUusD6tZ92gjMlfYIqE07t/JX/v
    SeqG4UBEVZPUYkoAg07rLqpRd9B749Av6D5YbeAgSv40pGJXVPNt2yVa3kmMfaDzixOS
    jgX7U1EknXRbd675gzHQ/VYkacfy8XlMf9hEuJC8GfK7ijNkUKXofSWazD6TW6b+MBxM
    HajV7dOMdpEEspqlPfcAOfJ1necXSqgVnXTpGeJ0khg3uBAnIUQmJch0RTmUGnLbta3v
    51QhZeYndsJDxcbmm1xW+DEHDFMhnPcE6DKp/QlFEObYL0w1vFKvUwETVSN3MNzgJQQC
    1X4A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729694330;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HOfLSgPXwF+te9GVD5VBXThzLDka1ZwQ3T0UbMa7rR4=;
    b=r4wr/TQjDLnEnFqU4zq+JWEmjpheZHM6idUzTDT3C5KcpWtCqHcKJ+5q2lqeZgfl+o
    tdIqt0eulF+6BTwf43ru79ytYl33CaxWwXc/7Et4LIYpyZxa+hyOMKysISq7vwsXKamz
    kZDN/wa9gbYtkze/op2ywMrt3PrNC30ztuZcIZW5V8Y5MW8RKmJZfCGg1YWhLh4znncg
    gvcKX8dS+MZat2Y3HAVrkjQLyYmEPFX9m0+YbqgnNDVTCpeLWeb9dSBbKW5RUmm3Ctpp
    3Qm+Xl70A5qPz7qYulo1nZdo1lHv1CpXpZuad0+kLchHDbV7NdbDo8hI8xfhuqmiX47i
    jjTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729694330;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HOfLSgPXwF+te9GVD5VBXThzLDka1ZwQ3T0UbMa7rR4=;
    b=ZDmP1t0Kb5UlyokgbQVhWLWFICQsNkqiSP3FM2v2ARXEIWIWLRjp6KY9PPupyQ41xr
    1idedk6iUfy6MxvzEaDA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O2J2YOom0XQaPis+nU/xK"
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209NEcoTmB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 23 Oct 2024 16:38:50 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v4 4/5] mmc-utils: Add FFU mode 4 that uses CMD6 and CMD24 single-block write to download firmware
Date: Wed, 23 Oct 2024 16:38:38 +0200
Message-Id: <20241023143839.108572-5-beanhuo@iokpp.de>
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

FFU mode 4 initiates firmware download with CMD6 to enter FFU mode, followed by CMD24 for
single-block write, after each CMD24 single-block write, CMD6 is issued to exit FFU mode.
Which means in this mode, during FW downloading, the device will not remain FFU mode.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Acked-by: Avri Altman <avri.altman@wdc.com>
---
 mmc.1      |  3 +++
 mmc.c      |  7 ++++++-
 mmc_cmds.c | 25 ++++++++++++++++++++-----
 mmc_cmds.h |  1 +
 4 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/mmc.1 b/mmc.1
index 220427b..273bdcc 100644
--- a/mmc.1
+++ b/mmc.1
@@ -198,6 +198,9 @@ Same as 'ffu1', but uses CMD23+CMD25 for repeated downloads and remains in FFU m
 .BI ffu3 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
 Same as 'ffu1', but uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.
 .TP
+.BI ffu4 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
+Same as 'ffu', but uses CMD24 Single-block write to download, exiting FFU mode after each block is written.
+.TP
 .BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
 Send Erase CMD38 with specific argument to the device.
 .br
diff --git a/mmc.c b/mmc.c
index e013fc6..a6474db 100644
--- a/mmc.c
+++ b/mmc.c
@@ -241,7 +241,12 @@ static struct Command commands[] = {
 	},
 	{ do_ffu3, -2,
 	 "ffu3", "<image name> <device> [chunk-bytes]\n"
-	 "Same as 'ffu', but uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.\n",
+	 "Same as 'ffu1', but uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.\n",
+	 NULL
+	},
+	{ do_ffu4, -2,
+	 "ffu4", "<image name> <device> [chunk-bytes]\n"
+	 "Same as 'ffu1', but uses CMD24 Single-block write to download, exiting FFU mode after each block written.\n",
 	 NULL
 	},
 	{ do_erase, -4,
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 4bec56d..c9db4b4 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2852,6 +2852,11 @@ static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
 		mmc_ioc_cmd_set_data(multi_cmd->cmds[0], buf + offset);
 		set_single_cmd(&multi_cmd->cmds[1], MMC_STOP_TRANSMISSION, 0, 0, 0);
 		multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	} else if (ffu_mode == 4) {
+		fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+		set_single_cmd(&multi_cmd->cmds[1], MMC_WRITE_BLOCK, 1, 1, arg);
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
+		fill_switch_cmd(&multi_cmd->cmds[2], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
 	}
 }
 
@@ -2952,8 +2957,13 @@ static int do_ffu_download(int dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_siz
 		return -EINVAL;
 	}
 
-	if (ffu_mode != 1) /* in FFU mode 1, mmc_ioc_multi_cmd contains 4 commands */
+	if (ffu_mode == 2 || ffu_mode == 3) {
+		/* in FFU mode 2, 3, mmc_ioc_multi_cmd contains 2 commands */
 		num_of_cmds = 2;
+	} else if (ffu_mode == 4) {
+		num_of_cmds = 3; /* in FFU mode 4, mmc_ioc_multi_cmd contains 3 commands */
+		chunk_size = 512; /* FFU mode 4 uses CMD24 single-block write */
+	}
 
 	/* allocate maximum required */
 	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
@@ -2963,9 +2973,9 @@ static int do_ffu_download(int dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_siz
 		return -ENOMEM;
 	}
 
-	if (ffu_mode != 1) {
+	if (ffu_mode == 2 || ffu_mode == 3) {
 		/*
-		 * If the device is not in FFU mode 1, the command to enter FFU mode will be sent
+		 * In FFU mode 2, mode 3, the command to enter FFU mode will be sent
 		 * independently, separate from the firmware bundle download command.
 		 */
 		ret = enter_ffu_mode(dev_fd);
@@ -3020,9 +3030,9 @@ do_retry:
 		off += bytes_per_loop;
 	}
 
-	if (ffu_mode != 1) {
+	if (ffu_mode == 2 || ffu_mode == 3) {
 		/*
-		 * If the device is not in FFU mode 1, the command to exit FFU mode will be sent
+		 * In FFU mode 2, FFU mode 3, the command to exit FFU mode will be sent
 		 * independently, separate from the firmware bundle download command.
 		 */
 		ret = exit_ffu_mode(dev_fd);
@@ -3208,6 +3218,11 @@ int do_ffu3(int nargs, char **argv)
 	return __do_ffu(nargs, argv, 3);
 }
 
+int do_ffu4(int nargs, char **argv)
+{
+	return __do_ffu(nargs, argv, 4);
+}
+
 int do_general_cmd_read(int nargs, char **argv)
 {
 	int dev_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 413bc85..a382349 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -44,6 +44,7 @@ int do_cache_dis(int nargs, char **argv);
 int do_ffu1(int nargs, char **argv);
 int do_ffu2(int nargs, char **argv);
 int do_ffu3(int nargs, char **argv);
+int do_ffu4(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
-- 
2.34.1

