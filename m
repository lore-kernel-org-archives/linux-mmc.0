Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B1C1CB334
	for <linux-mmc@vger.kernel.org>; Tue,  1 Oct 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815843; cv=pass; b=gSc6zLKPd6lkGhEXcGxXqxDsgSLQRHqXTaKlpOVQnEXfgraiIMRoCvF9fp0SLYKVMzRy739p8kPoe6rrwVf3PKraOaHjCepM/gfeDEZRTYhTQzCEzweaUePhxWtn32IEr8c2lHw6pEvKAblwMRDeFFEPraME1HKBl+3Gk8CpSwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815843; c=relaxed/simple;
	bh=sRuG3TtNlkn/y8qwch2GpQp1dkIVC5APa/BDuC93j6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIMRxXNWJDJUeOzPWub0xXTrzE88CG2HxRqPKagNknwnzsD0+5B1EOshrCCft63QC2YpQ40X/eYeTrFeW+60ePcnHxFrGWUpzrg8x4vNDgyZAiCjvoo/T4u6HyHkO2Pu6TyCNxA0oZZfzOeE5/GaM2lKd3PmxZjXvzkDUUlcEK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=LtD2oHmI; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=FqDM8lmL; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="LtD2oHmI";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="FqDM8lmL"
ARC-Seal: i=1; a=rsa-sha256; t=1727815120; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sM7oytJN1DJIqaQHyIRm0Us/+s+fDiCv4KAQbk/XtIST2lVhfvSWD+YpfM927MJURr
    pTPHOAAz2XaHUOFau4V+ZUQ1dxv88B5CdmAGXtM3uc7eKkk2r6ti3qSDeM7tiLkD7AZy
    rLC9pcws3aVk2hl587nemUWhL+tZUT8OyvSO4/LB67QHD9R8uYR8CvVfJZ3mO6wEvFD8
    1UpbR4lHnnj7PwEYvUm7CgzCIBDn31qxJT2TlDJlulRjoyavYwdK13EyrP9Gdy1lbY3g
    0zPs2gybr8GwcDOh6G6jRKF5bL5iXDilDzk43CUdVAJUGs9aH+ttueRNvpiDVNqjYXKF
    iVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1727815120;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=UT8FxUtJ5s7Ga5tE7Zbjmhp9+ciwYY6lV/DLRVqS6bg=;
    b=F2oqMZBTQCVVW6OvtzaYNiEo7VwCvD3r54PtF3TY1JdXoU5o5XZ4c/ZNPrfaM4RHUc
    z492dhlEykhHxNBwDNnUb2SxRtZ0kRofQn0bTSAFX/7Hpw+SKkwYflEFxXQUddQeU8Mv
    DDOdEEY/VTdAOKgOmqfnxby1PQsSiM7UodfXSc7yLp4+RM7kt3mQpr4umW4we5yYUubN
    G5eeCKx96AmkovhcMpB3ggGYkviRkNccInS+csHc/gEX4U2lvwz04+z+l7YI1Bp2WOB3
    qmiJ0vn6rbQCmQmdGK5n8an9V0zzDamAWHGN+KPJmJB/naCcFqJOyECT1lIg7CiYeAm5
    fEHw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1727815120;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=UT8FxUtJ5s7Ga5tE7Zbjmhp9+ciwYY6lV/DLRVqS6bg=;
    b=LtD2oHmIx5LDTvwhOHq3Qg/O5D9TaXwJkouQ5+ujb3kqFibdd6W0QgddMtLA2MhM60
    l9oBJJ01X67LSWBSma2HyG7HRcdfBccZ5WoGByndSTqRrL2wYk2iLP5xYC7xm0ey/VhH
    BjKngCFOKuJgMXD72lZZKA+0p9NypL3RYNhDDaF18kQ6sl4/XRZ5FT7WfwN7T78ILhNH
    X0APSTzztRUz6N74GxHBXDPeihpPFYUmfQZvqZ5JRyg5km7pEELubN8FOesop8tJsFdb
    bd0f8P7lSFsANP7WMVd4xILYjtGjzjvCxK4bwjpHAcxLrjm7jpmJJfACEmMUFAZYRbc4
    7Iqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1727815120;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=UT8FxUtJ5s7Ga5tE7Zbjmhp9+ciwYY6lV/DLRVqS6bg=;
    b=FqDM8lmLq9XLeZ6mLCWFDBKfEkzpK2CAPZpBhab3PcfcNDh3mwX9p4imzNwb0GlQ0r
    10iYBiZzjQPoJjsi1dDg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD06ISTv80p2D11QFwNypsTi9pEHpqtUzGQwQ=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b0091Kcecdj
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 1 Oct 2024 22:38:40 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v1 5/5] mmc-utils: add FFU mode 5 for firmware download using CMD6 and repeated CMD24 commands
Date: Tue,  1 Oct 2024 22:38:11 +0200
Message-Id: <20241001203811.26279-6-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001203811.26279-1-beanhuo@iokpp.de>
References: <20241001203811.26279-1-beanhuo@iokpp.de>
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
 mmc_ffu.c | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

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
index fff7b11..5e3c59f 100644
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
 
@@ -148,6 +151,8 @@ static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_si
 		num_of_cmds = 2;
 	else if (ffu_mode == 4)
 		num_of_cmds = 3;
+	else if (ffu_mode == 5)
+		num_of_cmds = 1;
 
 	/* allocate maximum required */
 	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) + num_of_cmds * sizeof(struct mmc_ioc_cmd));
@@ -169,11 +174,14 @@ do_retry:
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
@@ -245,7 +253,7 @@ int do_ffu(int nargs, char **argv)
 			break;
 		case 'm':
 			ffu_mode = atoi(optarg);
-			if (ffu_mode > 4) {
+			if (ffu_mode > 5) {
 				fprintf(stderr, "Unsupported ffu mode `%d'.\n", ffu_mode);
 				abort();
 			}
-- 
2.34.1

