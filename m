Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5841A3A9B
	for <linux-mmc@vger.kernel.org>; Thu,  3 Oct 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980936; cv=pass; b=PONsRiYUVVDqB69DxdrmlFGHnX5AxrG5oj83rJ2svNmWp776mg4GfsHqNL5JCeV0npsK/MUmNd7B6P/t4wfLksFYuuyZ0TV4ZrhK9JltrfFbyD8X0UgO2oQh01xwNbYDoJXuSB6X+bojADFI7gSiyFtZCi3i51KVfhB9l8A0RMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980936; c=relaxed/simple;
	bh=6oAuR3Bzq0V4CSZOhoX/ETkHdfftfYHeRQyT59JK4qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Il+fSwNETqlvr6dvRYdDvJERWBaLK7wekEv8MG5kfKPCkOW4wzg+O6ZNYy+PhArEB8EaskNGUp2nyIy+25CiKoTze9//pZ2p4FXCe3TBy5nz/1EhY30Ge/fWLlLdvTQZInzrU+uzg0ecvf20P9ZsrDyzzZFZCLiaiCr5IHyvl9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=q8AuEU07; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=GZfnsivO; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="q8AuEU07";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="GZfnsivO"
ARC-Seal: i=1; a=rsa-sha256; t=1727980742; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FGopzb1Pdecx34GDvaeqiGf7A9lqeDD+ng2u1EX3mGlP7SeD74jILKkZqLrFyILRS2
    lJf5cMoCaKmLgBsa7B2/56DawLpgogEBIeYqbHpFM/IMhlvg+5k3ZjVdDrlc8qZsnP/v
    EJ8r0WDrM51JTFerO9MWGexmTuaekYqE53A72XduJuEZa+1kmG5aE8q5TXbsBHdfLuhN
    uyYOSULVrWiyGRJWF+jLJvZ6M17IJUyaGg3NZwkK43Tmzigpa3yXNYK6C6dtMGNvE6x6
    rYorcDDXLOg65mtj978RyT3YLscI8HJkIFbLfwp5oZtEdWU4rnkXywv/LH4wcf+nL+6G
    BGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1727980742;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=zaLkHDv7XSmN/0u6TBU/cvV9wWwvb0noyKbysLTrgWo=;
    b=tgYrqN6XD4iexCXa7JN9ZdmkDmFG0nFz/wbwzdbjamOThS0O9fcHKTfTXBQ08I3JlS
    L2LGJvy+vKj1nmNeGr0gzSFdE1DrLOdf+T2c7w05m4vQ16xzUjpFWuiBZbk2D1jVhmtg
    1C4MQgBFTUzGonL45Ruk3Muk1bgLkLATgoFDOhetZCy9wHrcY5BdTSO4knOXkJ1oiw6P
    ol1scspHqe4VcUVMad+SmYc/naz8nYqoaLckJYrWrbfZzGOJIhmF8tuQvVsvY+NNAR0f
    BzZcAjXKJ0q6MUaWtxzvdAXwnn0iFUB7HHAjRUmYKYKw7etcNlv/SmGz8Uu7dsG3G094
    Y76Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1727980742;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=zaLkHDv7XSmN/0u6TBU/cvV9wWwvb0noyKbysLTrgWo=;
    b=q8AuEU07F1fU2ur5XqxvcB8u3Vxr9An+NV8DqgxpNs4s8IhxF+ZkEnJbdJaw3c8kay
    SpWerwchDhjm+qLcmEY6xDyH7MYlMNAifqe920KMilJcIbcSK+wWp1z01s41+m5Iwokv
    2LZoAkNzAPVr3EKmdJi9+K3eilsLRcCY8gO3cdr7lVmuOlv/6yCyCeQJ5Q/t1XpahWUQ
    wsoE+AWI/Apw9B/aMMxRTxOaVqH2i7EopaRhXMtirJcgI6plidb1XWLVBC1msgqNApoR
    T0xhQvAQMjB9nTeWEKDefAb2uwFXyNJMICaAsgif9JkYBVNUlhsC+G8P+EP458Gqwxaz
    juHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1727980742;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=zaLkHDv7XSmN/0u6TBU/cvV9wWwvb0noyKbysLTrgWo=;
    b=GZfnsivOcdwKHbQtcKOKO3NA4zzz5GxBrZme3nVUsyNpwdzbORd6ZAPkHgAyZ19H78
    T8yxGVEftv5NwMtQSeCA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD06ISTu50pjmwgQ1wz9b7T+Mhx2Sk00RyG5Tc="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b0093Id2iLB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 3 Oct 2024 20:39:02 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	vfazio@xes-inc.com
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v2 5/5] mmc-utils: add FFU mode 5 for firmware download using CMD6 and repeated CMD24 command
Date: Thu,  3 Oct 2024 20:38:48 +0200
Message-Id: <20241003183848.58626-6-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003183848.58626-1-beanhuo@iokpp.de>
References: <20241003183848.58626-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Bean Huo <beanhuo@micron.com>

Add FFU mode 5 which enters FFU mode with CMD6, followed by repeated CMD24 commands to perform
single-block writes for the firmware download. After downloading all firmware data, CMD6 is issued
to exit FFU mode.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mmc.c     |  3 ++-
 mmc_ffu.c | 20 ++++++++++++++------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/mmc.c b/mmc.c
index 2fdfdce..8f71a51 100644
--- a/mmc.c
+++ b/mmc.c
@@ -236,7 +236,8 @@ static struct Command commands[] = {
 		" -m 1: Default mode (CMD6+CMD23+CMD25+CMD6 repeated), may exit FFU mode if the firmware size exceeds chunk size.\n"
 		" -m 2: FFU mode 2 (enter FFU mode, CMD23+CMD25 repeated, exit FFU mode), stays in FFU mode until firmware download completes.\n"
 		" -m 3: FFU mode 3 (enter FFU mode, CMD25+CMD12 repeated, exit FFU mode), stays in FFU mode until firmware download completes.\n"
-		" -m 4: FFU mode 4 (CMD6+CMD24+CMD6 repeated), exits FFU mode after each cycle.\n",
+		" -m 4: FFU mode 4 (CMD6+CMD24+CMD6 repeated), exits FFU mode after each cycle.\n"
+		" -m 5: FFU mode 5 (CMD6 enter FFU mode, CMD24 repeated,  CMD6 exit FFU mode) stays in FFU mode until firmware download completes.\n",
 	  NULL
 	},
 	{ do_erase, -4,
diff --git a/mmc_ffu.c b/mmc_ffu.c
index d342c7b..4b2f63b 100644
--- a/mmc_ffu.c
+++ b/mmc_ffu.c
@@ -60,6 +60,9 @@ static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd, __u8 *ext_
 		set_single_cmd(&multi_cmd->cmds[1], MMC_WRITE_BLOCK, 1, 1, arg);
 		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
 		fill_switch_cmd(&multi_cmd->cmds[2], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
+	} else {
+		set_single_cmd(&multi_cmd->cmds[0], MMC_WRITE_BLOCK, 1, 1, arg);
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[0], buf + offset);
 	}
 }
 
@@ -150,6 +153,8 @@ static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_si
 		num_of_cmds = 2;
 	else if (ffu_mode == 4)
 		num_of_cmds = 3;
+	else if (ffu_mode == 5)
+		num_of_cmds = 1;
 
 	/* allocate maximum required */
 	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) + num_of_cmds * sizeof(struct mmc_ioc_cmd));
@@ -171,11 +176,14 @@ do_retry:
 		/* prepare multi_cmd for FFU based on cmd to be used */
 		set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop, fw_buf, off, ffu_mode);
 
-		/* send ioctl with multi-cmd, download firmware bundle */
-		ret = ioctl(*dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+		if (num_of_cmds > 1)
+			/* send ioctl with multi-cmd, download firmware bundle */
+			ret = ioctl(*dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+		else
+			ret = ioctl(*dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[0]);
 
 		if (ret) {
-			perror("Multi-cmd ioctl");
+			perror("ioctl failed!");
 			/*
 			 * In case multi-cmd ioctl failed before exiting from
 			 * ffu mode
@@ -247,7 +255,7 @@ int do_ffu(int nargs, char **argv)
 			break;
 		case 'm':
 			ffu_mode = atoi(optarg);
-			if (ffu_mode > 4) {
+			if (ffu_mode > 5) {
 				fprintf(stderr, "Unsupported ffu mode `%d'.\n", ffu_mode);
 				abort();
 			}
@@ -262,8 +270,8 @@ int do_ffu(int nargs, char **argv)
 		}
 	}
 
-	if (ffu_mode ==4)
-		/* FFU mode 4 uses CMD24, the write is limited to single-block operations*/
+	if (ffu_mode ==4 || ffu_mode == 5)
+		/* FFU mode 4/5 uses CMD24, the write is limited to single-block operations*/
 		default_chunk = 512;
 
 	fprintf(stderr, "eMMC Devie: %s, fw %s, FFU mode %d, chunk size: %d\n",
-- 
2.34.1

