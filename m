Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FB920F3F6
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887916; cv=pass; b=b7a0t+ABSvgJaR0/AQcHn/bNUCjbd+84S7fv1YqjOBXmSbaXuo8ds7aPE/u5wNIXgn33zb0/mP1MUWWgwd7LIOXxzEptNu0cmyR+myHG0uIC/ZV7xpiFIR43hhnLV/JH9n0FFZltSVJo6T/oyFivu4EJoywY93umsfaiY8ku7Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887916; c=relaxed/simple;
	bh=3BUn02X0fHs8bKvwX3NuCU9yIk3EnJF4E7rceUcVTcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQEDhQG8kf9fhIzhQQBvEqtxJxu6MK40GbeYpgbM1LSr5sOMIeUpXHc/cMp59B0d0kJ0o605bbHLinD00K95R3hZGX4949rWaI6Cs4xLInlwZK1dCUynsdJPh+DYu9k78r3fMnqOr7Z+KghG/sl7dlXz9t+3vCgVJHxZKH2PmnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=rZjCP2lh; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=vcYhNbv+; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="rZjCP2lh";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="vcYhNbv+"
ARC-Seal: i=1; a=rsa-sha256; t=1729887719; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VbcmF/BIxHl1yrX2s+V0bfEDetnZXRPTzyNzK0BEMfJx08sV5X1U65xXlYR0cdzrbF
    72D9hT0cmvPS9pdLJAL7Hy3SrQ3UXt13hlfYCHMs7FId6SyJV99HoHiIqOZQb28gmbTh
    dD7vVs1uvuHYOacaAuA8jd2/x9L7/qv0gkTHGYQBZ82t7rr5ODQTYIJFuXBsJ2eAoiFI
    WeTzTwqWGZDNHvAjmbjyNkY8b/Fp4XSeg+3SD3wapzqqY7v4kzpjxqhz5DAT6B5/QQuU
    VNXNeYbA4SE+wq9eTg3O2jUKVaMCyiupu6akI3Xfh+lM5V6Q8r4emH8O7CyrItUEQUbw
    K0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1729887719;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=W2jTWpp1FTgpkwAASe7cSc1004YrfOqCbSUm0hlMca0=;
    b=g8QUhZIsRNSmY8PD1K0VJku2MlfUFoi3+zT53wRsqYE4hpWejXNEM8MwCctRo6Mygx
    OjoBvIfK5Rm/s+gRPFDkVgwIjGq1h0yER1fQe9GSG68ENe3CwWDz94F5ogE+5uYk5QY9
    UT/xrtLBAvZr2aNlSj0O6Irzx042jgskmVlnd2Yfly0k6K6BFqnw26IwsKEjWLnVYk1N
    J+s0BqcLT6er6utgBf2MpQgPCNZmMzO2r2g68X3b2WlGUZCskCULNNlbfIDrMjY1VYK2
    /KIEGkAgTeWqx4BeAU+lTQUuiBrAlt3Jd7d4reUmXWEICuLEJdHCkLIk4hedTg3mufFx
    bm3w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1729887719;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=W2jTWpp1FTgpkwAASe7cSc1004YrfOqCbSUm0hlMca0=;
    b=rZjCP2lhnUWgz6Z06nf1EG9sQZHhMyvP6mdru2j5XUCOcvzIJUbTNwW5D72Sjx+Jld
    thVawOWEIPPehQAXwWka5CYkUDz+5/orBAbhaRbZ08eE+dnEzZbRuSdxXo4wm4wHH/jq
    mmKa1Pa9ak5XJfo0JNij6RebpnfolzkPoWvg4Or3lUhd7RisF/wcDMSscVDJbuke3UBc
    VQJIDFaxsTCcK1Nj5ldZ8MltM68yhno5RIEKnnHT2GPijmRXNAXuvSnmr+dpf+QE2xEk
    6xwPNgsdSA6K4BZiD3XixSsmD+OejWpIOhGMBUjKcsh0GaCSP6W7Gw//51PKt8mHoaEi
    wMpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1729887719;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=W2jTWpp1FTgpkwAASe7cSc1004YrfOqCbSUm0hlMca0=;
    b=vcYhNbv+Nuqkvvzxs7TZ6uWz4l6rxEEO0GZHVfttIzIn+3Mc4GzCb+JNtviV4LzT4Y
    Ox0jBGME8ZYtW9QlKwCw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXGo7S6YVZbGYm2ZHbmjWFWcm6Nbb9lHw=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id za0ed209PKLxbez
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 25 Oct 2024 22:21:59 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v5 4/5] mmc-utils: Add FFU optional mode 4 that uses CMD6 and CMD24 single-block write to download firmware
Date: Fri, 25 Oct 2024 22:21:47 +0200
Message-Id: <20241025202148.161586-5-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025202148.161586-1-beanhuo@iokpp.de>
References: <20241025202148.161586-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Bean Huo <beanhuo@micron.com>

Add FFU optional mode 3, which initiates firmware download with CMD6 to enter FFU mode, followed
by CMD24 for single-block write, after each CMD24 single-block write, CMD6 is issued to exit FFU
mode. Which means in this mode, during FW downloading, the device will not remain FFU mode.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Acked-by: Avri Altman <avri.altman@wdc.com>
---
 mmc.1      |  3 +++
 mmc.c      |  5 +++++
 mmc_cmds.c | 28 ++++++++++++++++++++++------
 mmc_cmds.h |  1 +
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/mmc.1 b/mmc.1
index bc2f1b8..acb37c1 100644
--- a/mmc.1
+++ b/mmc.1
@@ -198,6 +198,9 @@ Optional FFU mode 1, it's the same as 'ffu', but uses CMD23+CMD25 for repeated d
 .BI opt_ffu2 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
 Optional FFU mode 2, uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.
 .TP
+.BI opt_ffu3 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
+Optional FFU mode 3, uses CMD24 Single-block write for downloading, exiting FFU mode after each block is written.
+.TP
 .BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
 Send Erase CMD38 with specific argument to the device.
 .br
diff --git a/mmc.c b/mmc.c
index 53a708b..d2a4d2a 100644
--- a/mmc.c
+++ b/mmc.c
@@ -244,6 +244,11 @@ static struct Command commands[] = {
 	 "Optional FFU mode 2, uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.\n",
 	 NULL
 	},
+	{ do_opt_ffu3, -2,
+	"opt_ffu3", "<image name> <device> [chunk-bytes]\n"
+	"Optional FFU mode 3, uses CMD24 Single-block write for downloading, exiting FFU mode after each block written.\n",
+	NULL
+	},
 	{ do_erase, -4,
 	"erase", "<type> " "<start address> " "<end address> " "<device>\n"
 		"Send Erase CMD38 with specific argument to the <device>\n\n"
diff --git a/mmc_cmds.c b/mmc_cmds.c
index fb04821..2553de2 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -64,7 +64,8 @@
 enum ffu_download_mode {
 	FFU_DEFAULT_MODE, // Default mode: Uses CMD23+CMD25; exits FFU mode after each loop.
 	FFU_OPT_MODE1,	// Optional mode 1: Uses CMD23+CMD25; but stays in FFU mode during download.
-	FFU_OPT_MODE2	// Optional mode 2: Uses CMD25+CMD12 Open-ended Multiple-block write to download
+	FFU_OPT_MODE2,	// Optional mode 2: Uses CMD25+CMD12 Open-ended Multiple-block write to download
+	FFU_OPT_MODE3	// Optional mode 3: Uses CMD24 Single-block write to download
 };
 
 static inline __u32 per_byte_htole32(__u8 *arr)
@@ -2860,6 +2861,11 @@ static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
 		mmc_ioc_cmd_set_data(multi_cmd->cmds[0], buf + offset);
 		set_single_cmd(&multi_cmd->cmds[1], MMC_STOP_TRANSMISSION, 0, 0, 0);
 		multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	} else if (ffu_mode == FFU_OPT_MODE3) {
+		fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+		set_single_cmd(&multi_cmd->cmds[1], MMC_WRITE_BLOCK, 1, 1, arg);
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
+		fill_switch_cmd(&multi_cmd->cmds[2], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
 	}
 }
 
@@ -2961,8 +2967,13 @@ static int do_ffu_download(int dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_siz
 		return -EINVAL;
 	}
 
-	if (ffu_mode != FFU_DEFAULT_MODE) /* in default mode, mmc_ioc_multi_cmd contains 4 commands */
+	if (ffu_mode == FFU_OPT_MODE1 || ffu_mode == FFU_OPT_MODE2) {
+		/* in FFU_OPT_MODE1 and FFU_OPT_MODE2, mmc_ioc_multi_cmd contains 2 commands */
 		num_of_cmds = 2;
+	} else if (ffu_mode == FFU_OPT_MODE3) {
+		num_of_cmds = 3; /* in FFU_OPT_MODE3, mmc_ioc_multi_cmd contains 3 commands */
+		chunk_size = 512; /* FFU_OPT_MODE3 uses CMD24 single-block write */
+	}
 
 	/* allocate maximum required */
 	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
@@ -2972,9 +2983,9 @@ static int do_ffu_download(int dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_siz
 		return -ENOMEM;
 	}
 
-	if (ffu_mode != FFU_DEFAULT_MODE) {
+	if (ffu_mode == FFU_OPT_MODE1 || ffu_mode == FFU_OPT_MODE2) {
 		/*
-		 * If the device is not in FFU mode 1, the command to enter FFU mode will be sent
+		 * In FFU_OPT_MODE1 and FFU_OPT_MODE2, the command to enter FFU mode will be sent
 		 * independently, separate from the firmware bundle download command.
 		 */
 		ret = enter_ffu_mode(dev_fd);
@@ -3029,9 +3040,9 @@ do_retry:
 		off += bytes_per_loop;
 	}
 
-	if (ffu_mode != FFU_DEFAULT_MODE) {
+	if (ffu_mode == FFU_OPT_MODE1 || ffu_mode == FFU_OPT_MODE2) {
 		/*
-		 * If the device is not in FFU mode 1, the command to exit FFU mode will be sent
+		 * In FFU_OPT_MODE1 and FFU_OPT_MODE2, the command to exit FFU mode will be sent
 		 * independently, separate from the firmware bundle download command.
 		 */
 		ret = exit_ffu_mode(dev_fd);
@@ -3217,6 +3228,11 @@ int do_opt_ffu2(int nargs, char **argv)
 	return __do_ffu(nargs, argv, FFU_OPT_MODE2);
 }
 
+int do_opt_ffu3(int nargs, char **argv)
+{
+	return __do_ffu(nargs, argv, FFU_OPT_MODE3);
+}
+
 int do_general_cmd_read(int nargs, char **argv)
 {
 	int dev_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 4098931..0fbb2b5 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -44,6 +44,7 @@ int do_cache_dis(int nargs, char **argv);
 int do_ffu(int nargs, char **argv);
 int do_opt_ffu1(int nargs, char **argv);
 int do_opt_ffu2(int nargs, char **argv);
+int do_opt_ffu3(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
-- 
2.34.1

