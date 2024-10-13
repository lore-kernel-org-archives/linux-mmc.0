Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0697F13C9B8
	for <linux-mmc@vger.kernel.org>; Sun, 13 Oct 2024 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728853295; cv=pass; b=mdRAWFKe0xxWlwtxqix/avz4q5XTQhk+Vkx1CKDCO93h2rc7MlnGeeehNzLezhs/qnJRqLm4rtafiDZoS5DiSArCWCT/J6NC0yZEcC9ED8TAvWI2tItonBV/pEmdgUIQAvldERDV8h589vkW4vrCOm4f8uilbQbXrM7Wy9/5848=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728853295; c=relaxed/simple;
	bh=WjLJiEacKb8JAvYDydKxrhgcovKSHovR0j+uJ01QUKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRP+a8F1i77z6JRzz6BHp4CVKeX+pR1ZaiTr1aToAuOCIXnyvn6aLc8asnGcT53atbE1zdpLR8JQFqSoOyd32z7DAwrdvN6mCHYYIh7Zhz+nVYCpjlB6o+TipyauK4c9+3gudtqgTG5Mz9jVsGQw4fzCGX47hAUndkaoGY7bt2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=JLcqpu9N; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=4GbYZIE/; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="JLcqpu9N";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="4GbYZIE/"
ARC-Seal: i=1; a=rsa-sha256; t=1728853102; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LVASBCTksY85ME3/8xTQxgVq3iYNnCS+Dm1+8Hwc7KFjwtnAm2MdWT67vPL4Ylxzja
    26QqYAox8NKdKXSXjzC7v3XtspnP9y/YgqKapwe7VuAS0ygebgUG5KTzZiI0sK14kCK0
    27FKW77+bWJtGfBNZV+JShWLkuzMGZ8mIwvMyKA4c53d8VsrdYnIBDO/wY32Dq2T3fmm
    IyLNtbyolOHOnyZs0qG5GrcSlZMP1ay5gYB5r5bfM/z1Ac7KOlRH2CS2LRKnWsjyFfW5
    8XMoGIiuk/Zum4J3EQE1a+RHrjpsEulnrEfqLVSgzPDU/nSxeP0KxghzSaiWI+0aTS6V
    uLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853102;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=RdBopfiREmrEDreANTvHX4y8entyR9v9QOKpsuVJl58=;
    b=AtOl1GtxomnNxbXw3BB27MpMZwWr+0idgqvG4oZZp/BWYPY7TKvIGfBIqEM7BYBag5
    9lq/Hf/v8RMsSjyf7wKsE3rqi5UIjmbbsdmm9H4iUILu05VlPY9uApHRYK9ZJqwHJW+I
    TZxrH98Vf0rP/1vZe5cJFR/0ty5Al9V1cjDvYDrBD4d89YxoCmWx6/8UC2WWIwOMJHFF
    8IdFib51zDjZAB4tYSMMlQUf8ayEXEObmntJZWiINtHUuCU57FQudsyslxDKx0fLlMXC
    XOIqJdhB8PyVrHuPneZbVSqvX9H1hxkx8kfeprG1nGEHzreLKqXGcb37hMCF1SImdNIl
    YgqQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853102;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=RdBopfiREmrEDreANTvHX4y8entyR9v9QOKpsuVJl58=;
    b=JLcqpu9N+rsYF+KWK7o30zTftrsUJC8qUGa4VfC/QZfBZXqpFlPOsPI2nhMX5hNyL+
    HzypNwspT9LlYSsbAyuc9UdS79Ld20iX2gb5pIX/yMR30Q4g0m+ZFLf2O25aocFTjUXO
    turmQC5wBntQjhtSaHvkAYiHcecQokCt7pSTvK1g5xqs3dTvBbwsywVjQSFm7SeQkrWx
    D5WoRRyFVwC1/YzHicvS6aB7nqwPIpUS5V72A2xTwg5vcdsMa7OcYWu7IPz5g5OGwDxo
    ifbPhgomteqN9fVI15nhvjNJZs40B91gnzEZdPlqnyXaDWCYfjndoxlpgh56g6RkFO64
    e8SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728853102;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=RdBopfiREmrEDreANTvHX4y8entyR9v9QOKpsuVJl58=;
    b=4GbYZIE/szKBdNCBY6wf9HeJfpb3kEEGImQAEnaBpd+XAi4gSkc27IlbOWy3S7LjLf
    iR1RjQufKVxojxPJcaBQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXG87q6MA1dHIkU4bBBNmkv0kIa54BlKI8="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b009DKwLB78
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 13 Oct 2024 22:58:21 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf,
	hansson@linaro.org,
	vfazio@xes-inc.com,
	linux-mmc@vger.kernel.org
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v3 3/5] mmc-utils: Add new FFU mode using CMD25+CMD12 for  Open-ended write download FW
Date: Sun, 13 Oct 2024 22:58:05 +0200
Message-Id: <20241013205807.121932-4-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241013205807.121932-1-beanhuo@iokpp.de>
References: <20241013205807.121932-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Bean Huo <beanhuo@micron.com>

Introduced a new FFU mode leveraging CMD25+CMD12 for Open-ended Multiple-block write to
download the firmware bundle.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mmc.1      |  3 +++
 mmc.c      |  5 +++++
 mmc.h      |  1 +
 mmc_cmds.c | 10 ++++++++++
 mmc_cmds.h |  1 +
 5 files changed, 20 insertions(+)

diff --git a/mmc.1 b/mmc.1
index b98b63f..d1598f7 100644
--- a/mmc.1
+++ b/mmc.1
@@ -195,6 +195,9 @@ if [\fIchunk\-bytes\fR] is omitted, mmc-utils will try to run ffu using the larg
 .BI ffu2 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
 Same as 'ffu', but uses CMD23+CMD25 for repeated downloads and remains in FFU mode until completion.
 .TP
+.BI ffu3 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
+Same as 'ffu', but uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.
+.TP
 .BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
 Send Erase CMD38 with specific argument to the device.
 .br
diff --git a/mmc.c b/mmc.c
index f1d98e6..a0227ca 100644
--- a/mmc.c
+++ b/mmc.c
@@ -239,6 +239,11 @@ static struct Command commands[] = {
 		"Same as 'ffu', but uses CMD23+CMD25 for repeated downloads and remains in FFU mode until completion.\n",
 	  NULL
 	},
+	{ do_ffu3, -2,
+	  "ffu3", "<image name> <device> [chunk-bytes]\n"
+		"Same as 'ffu', but uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.\n",
+	  NULL
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
index b507bff..6c38387 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2833,6 +2833,12 @@ static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd, __u8 *ext_
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
 static int enter_ffu_mode(int *dev_fd)
@@ -3140,6 +3146,10 @@ int do_ffu2(int nargs, char **argv) {
 	return __do_ffu(nargs, argv, 2);
 }
 
+int do_ffu3(int nargs, char **argv) {
+	return __do_ffu(nargs, argv, 3);
+}
+
 int do_general_cmd_read(int nargs, char **argv)
 {
 	int dev_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index 81364f4..e3e9192 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -43,6 +43,7 @@ int do_cache_en(int nargs, char **argv);
 int do_cache_dis(int nargs, char **argv);
 int do_ffu(int nargs, char **argv);
 int do_ffu2(int nargs, char **argv);
+int do_ffu3(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
-- 
2.34.1

