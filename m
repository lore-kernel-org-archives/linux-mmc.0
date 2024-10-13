Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0685148314
	for <linux-mmc@vger.kernel.org>; Sun, 13 Oct 2024 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728853297; cv=pass; b=Svoo4BJ/hLWsVQ4RCAqHthQn/YD9wD7skp5CAzdmTkJvrvuktPZkNWct+LTyon1S0mawb3DQ6LuRqlfTo2YNWArP0wxItr0fesqep3morMhaPTfD6JRav8HFZaegcEPa02qZF8FLT3V/Nsnq8YuqqL5fgwPWNsk4ouizNmKXlzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728853297; c=relaxed/simple;
	bh=8oW5Dsyc/RpFudOVLoMeeD4uX9PAwHtRT1OyfCt0l5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAuH4fk4y+MZCJjuq+QfMt3jt57vleaoYqokQSY1dFAcaNUNXV5nK+VCojBg8ALStLw+IaAp4jjQvBtkPQ4pCD0dNhjKl+B1+SBePxdLs/hbLlbI8sVhub/G/teIifR6xTpSOZZ/k3ZEPT9UTRqctHM4JKOpxzEZwFhjjx8PFDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=qFyDFIGF; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=7gEB+mao; arc=pass smtp.client-ip=81.169.146.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="qFyDFIGF";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="7gEB+mao"
ARC-Seal: i=1; a=rsa-sha256; t=1728853102; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NrT2Cma/lcOn95+AB7trCoylxv35GQg00WWAEk3VgtbRPVZkdAimo/RNgSsfz4oRjR
    VTbmBCqB6yz57mI3hmK3+VBcHqPyjEQlwBlJRTZKr+6dmnpm57ONZ4bFI+5d7c4d5hBi
    U9e8u+zAchgCBsZPGo9l4YWZVmJx23V+SVU4d25v+/RTE2qbW4ruhc6nZ8O+QaiDTicS
    KuRvU5fCqas6dxxxlXe69GeRUVTxnBeKivc6Kj5BI/v7OymAs7rFbZQcUY0+vk6Rv5Us
    vuWORBfW7Wgr0/BeSGHPTH00GDDgkqMZEUXLk94VV2yX4WbjcIfTpVczr17EQVf9MCM8
    GGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853102;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0+fg29ijt/vicpmsBPgGVe5s3S4w+t2hVEcOX11Cs60=;
    b=PliFMQUn8M786VtXbvaLXSTrnkqiV3zeNLkbExHpy97CyZrb2G74FdO9jkZTrJZyxH
    p47Rw69R0sy5UAFngTApg44bAsK/RwFfqPmo+0Lp8t6SKRuLYDU3VZUd8qjYq9Tt9lED
    2LyefIjNv61HM2frhdch2+TiAMyEIIFzsqjxk3iDfhws+PbOglGh88cMcwtk/CTVdA15
    ikT7giAC7JuTr8zLEu1rgw3n+MA8ud5ISmOvpF5AaSi3dr9gYoZKkuF7kVW72NI24ZSF
    FAGLCvDqrAvaA3DNE6/s7A/4NstK1yVptfwZ6m4hFcZTWmrEqFkdn/Fu8Zx2yhp1c7Bi
    6TbA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728853102;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0+fg29ijt/vicpmsBPgGVe5s3S4w+t2hVEcOX11Cs60=;
    b=qFyDFIGF7RF49xs6shb2n5RyENshgdHamMBVhirCoULP2RBA00YeSTuPcEzMYVqPUI
    Gf5V3mDPjnn6EuicUItpY5PyBXRK6mReOFFwBWyC24tkX1pz99GIBbzG/5Y9ohxip95H
    eB+v6wplpbZP9PK+RgzWWVIohSkNkfCTC/R86lJypAJfN6nAvEBPS32eAMZntT2FWUzs
    7GmJfmCGBuUQl50xxyZJyuVtrXMRsnQ0NVCU+vnxXe9D0DiJzNXmfDw9g8x4MvyMsg1c
    UckyxyWNO6rxPZZPf1NDtNZPaTZNIijrq2YeEtbLY9/pDWGQtns7h/Q93a3pnFWblVap
    bbbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728853102;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0+fg29ijt/vicpmsBPgGVe5s3S4w+t2hVEcOX11Cs60=;
    b=7gEB+maohEnk7DCc/EMaswbHYpBCxkOHQWKmQsoBb27+5sInY2GrNtG2ecRXTPyscM
    mF0Q/n0ajIONd3sw51AQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD+6IXG87q6MA1dHIkU4bBBNmkv0kIa54BlKI8="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b009DKwMB79
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 13 Oct 2024 22:58:22 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf,
	hansson@linaro.org,
	vfazio@xes-inc.com,
	linux-mmc@vger.kernel.org
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v3 4/5] mmc-utils: Added FFU mode 4 that uses CMD6 and CMD24 for single-block firmware download
Date: Sun, 13 Oct 2024 22:58:06 +0200
Message-Id: <20241013205807.121932-5-beanhuo@iokpp.de>
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

FFU mode 4 initiates firmware download with CMD6 to enter FFU mode, followed by CMD24 for
single-block write. After each block is written, CMD6 is used to exit FFU mode.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mmc.1      |  3 +++
 mmc.c      |  5 +++++
 mmc_cmds.c | 17 ++++++++++++++++-
 mmc_cmds.h |  1 +
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/mmc.1 b/mmc.1
index d1598f7..5e147d7 100644
--- a/mmc.1
+++ b/mmc.1
@@ -198,6 +198,9 @@ Same as 'ffu', but uses CMD23+CMD25 for repeated downloads and remains in FFU mo
 .BI ffu3 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
 Same as 'ffu', but uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.
 .TP
+.BI ffu4 " \fIimage\-file\-name\fR " " \fIdevice\fR " " [\fIchunk\-bytes\fR]
+Same as 'ffu', but uses CMD24 Single-block write to download, exiting FFU mode after each block is written.
+.TP
 .BI erase " " \fItype\fR " " \fIstart-address\fR " " \fIend\-address\fR " " \fIdevice\fR
 Send Erase CMD38 with specific argument to the device.
 .br
diff --git a/mmc.c b/mmc.c
index a0227ca..fd78f9b 100644
--- a/mmc.c
+++ b/mmc.c
@@ -244,6 +244,11 @@ static struct Command commands[] = {
 		"Same as 'ffu', but uses CMD25+CMD12 Open-ended Multiple-block write to download and remains in FFU mode until completion.\n",
 	  NULL
 	},
+	{ do_ffu4, -2,
+	  "ffu4", "<image name> <device> [chunk-bytes]\n"
+		"Same as 'ffu', but uses CMD24 Single-block write to download, exiting FFU mode after each block written.\n",
+	  NULL
+	},
 	{ do_erase, -4,
 	"erase", "<type> " "<start address> " "<end address> " "<device>\n"
 		"Send Erase CMD38 with specific argument to the <device>\n\n"
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 6c38387..6290440 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2839,6 +2839,11 @@ static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd, __u8 *ext_
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
 static int enter_ffu_mode(int *dev_fd)
@@ -2924,8 +2929,10 @@ static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_si
 		return -EINVAL;
 	}
 
-	if (ffu_mode != 1) /* in FFU mode 1, mmc_ioc_multi_cmd contains 4 commands */
+	if (ffu_mode == 2 || ffu_mode == 3) /* in FFU mode 2, 3, mmc_ioc_multi_cmd contains 2 commands */
 		num_of_cmds = 2;
+	else if (ffu_mode == 4)
+		num_of_cmds = 3; /* in FFU mode 4, mmc_ioc_multi_cmd contains 3 commands */
 
 	/* allocate maximum required */
 	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) + num_of_cmds * sizeof(struct mmc_ioc_cmd));
@@ -3068,6 +3075,10 @@ static int __do_ffu(int nargs, char **argv, __u8 ffu_mode)
 		goto out;
 	}
 
+	if (ffu_mode ==4)
+		/* FFU mode 4 uses CMD24, the write is limited to single-block operations*/
+		default_chunk = 512;
+
 	sect_done = do_ffu_download((int *)&dev_fd, ext_csd, fw_buf, fw_size, default_chunk, ffu_mode);
 
 	/* Check programmed sectors */
@@ -3150,6 +3161,10 @@ int do_ffu3(int nargs, char **argv) {
 	return __do_ffu(nargs, argv, 3);
 }
 
+int do_ffu4(int nargs, char **argv) {
+	return __do_ffu(nargs, argv, 4);
+}
+
 int do_general_cmd_read(int nargs, char **argv)
 {
 	int dev_fd;
diff --git a/mmc_cmds.h b/mmc_cmds.h
index e3e9192..27dc6c4 100644
--- a/mmc_cmds.h
+++ b/mmc_cmds.h
@@ -44,6 +44,7 @@ int do_cache_dis(int nargs, char **argv);
 int do_ffu(int nargs, char **argv);
 int do_ffu2(int nargs, char **argv);
 int do_ffu3(int nargs, char **argv);
+int do_ffu4(int nargs, char **argv);
 int do_read_scr(int argc, char **argv);
 int do_read_cid(int argc, char **argv);
 int do_read_csd(int argc, char **argv);
-- 
2.34.1

