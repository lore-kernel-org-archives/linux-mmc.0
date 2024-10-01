Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F391925B8
	for <linux-mmc@vger.kernel.org>; Tue,  1 Oct 2024 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815482; cv=pass; b=FbCSTC3yyv8XKOkMWM2tpaSw/AadEyXzc0cDVMvCI0Nc7BD9RqoaqR2I/gbj84a9oTJJzyAII8AE4TNqyc3AnuLRnXYheTTn3TVMhlCZ710Vy/qYseNU/Qrwx5VOZnkEpYWV2G9JbVaiiR2V8dgODicfrdYmJNOxL4tYPH9JvVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815482; c=relaxed/simple;
	bh=yKvIT1JEmObxd+barjNg3/LrvihZvwKOQgKKVHA2BHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k52taEM27dTOD0/WbOp8wv4tbDJqJhQp4873JoCxBb7K4e3kDI1d3xihQws2QWlvTCBeKI1ovvotAS5RfkS/ZqrZLFAeYvxoNTFJo4aXs1ln8WnVb62lr8Xw3QzbHvRDQkqMqGqTYjmbKxAsGMhJg/RIzqhiJAnO7IcEgLEaTJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=pNFV9o00; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=Y55J9Sld; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="pNFV9o00";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="Y55J9Sld"
ARC-Seal: i=1; a=rsa-sha256; t=1727815120; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CK2Jv+iWIIykhYWij+rfMfyJtjpRCDMt4nhtvdUkNojQpLd89Wuq8Ut2PE5g8i+jle
    AXjNTix3LwY1B0Q/E2XjfgxR9hF+fpGJht9J9jd0AMjM/EDIVhLFm4MdicjFXMUZEbKV
    yl0W3GeEZKd96+kc0kZvcDkTO2VAoXM/DJDaIBnQM8kXPv73s02zdaazfPsU5811t7VB
    1Cw/DaLaEivPMVHkodNYSMgk4cWSGOcGe5+o9zwnt3ndIaEMH/N59pyZqlt+JefRRSoR
    fa3/s+NEZ1pFYJ4NXdcBzhPPCEf1jqEkcmrFcS6YjapXRgWbtszGnEOfTSrEqxPZInkn
    j59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1727815120;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vKTBXzM+PborSxwGXZE6/JsmEgq6H9BNtgDyEXIfEZQ=;
    b=IU33myOOMQqyuIdf49dzsIUaac/1oGtv+LW6UZVZG7W+tboRtgQVXFHy9EhkpKt5GL
    vKAmcwYcLLGV6Nfm1ls02OIR3rugpOwhcp7vLkH1kueP46ZWWdHkAvZu840v/fREJyQd
    b79e99+vkaqDqNv7cH2o+9F1l+q84LUvcSHI0zgMLv32pEVjfK4zkngy/6VNhd0+sE/R
    aOeGkRu5h3kxGYQ9H+ZlczWNMPvxwsnyH9HpIW+E7OlN4/u9xqsBlDGfaO+Fw+NObcIp
    tDUQAZ0aaGd46L5RepM4TinMYIzHAVSD196H5CrioX1+hqT9aQD0kBFtlI7NsSGd64Mw
    uBeg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1727815120;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vKTBXzM+PborSxwGXZE6/JsmEgq6H9BNtgDyEXIfEZQ=;
    b=pNFV9o00aVYxvOfJJ0iOaTFE95bKS0eNV8XADQicyNWr52s+8iaagqM9FMcyrQD4vW
    +yKhph3ZlnJ3rKf362bCXgyRJN8hN2pLuo7g4KnQNtXbNaFfFI9P0MHRxg27I5Uyo6kJ
    LesNt6BmzXrbEAbuNYInGIjts9S35OV/kBof2FjXp35g1mZXAimrZODRn8gWrNBcMeEw
    J6Xo71dtZybM1tcKIFiV1exIT2CmbrOS8Qm+PGsuU9GKXmwjXoqXdaBSkglz2svWRIn5
    0YwNI4Jq19BHuybCdEk5OeXRZxWbRmuQ4CGoVOY6+lYXW3vCxlv9BNcIG0SNjqXnqFct
    ErKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1727815120;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=vKTBXzM+PborSxwGXZE6/JsmEgq6H9BNtgDyEXIfEZQ=;
    b=Y55J9Sldu45w9JC/o1wa2bE2hmGLH4kJWAcYUEqpikYXSfjh0cw1+5wFgDA8tYVZVj
    tiR6HQBB2BZSmBy/BtAQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD06ISTv80p2D11QFwNypsTi9pEHpqtUzGQwQ=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b0091Kcecdi
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 1 Oct 2024 22:38:40 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v1 4/5] mmc-utils: Added FFU mode 4 that uses CMD6 and CMD24 for single-block firmware download
Date: Tue,  1 Oct 2024 22:38:10 +0200
Message-Id: <20241001203811.26279-5-beanhuo@iokpp.de>
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

FFU mode 4 initiates firmware download with CMD6 to enter FFU mode, followed by CMD24 for
single-block write. After each block is written, CMD6 is used to exit FFU mode.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mmc.c     |  3 ++-
 mmc_ffu.c | 11 +++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/mmc.c b/mmc.c
index 73b694d..2fdfdce 100644
--- a/mmc.c
+++ b/mmc.c
@@ -235,7 +235,8 @@ static struct Command commands[] = {
 		"[-m <ffu_mode>] Optional, provides five firmware bundle download command modes:\n"
 		" -m 1: Default mode (CMD6+CMD23+CMD25+CMD6 repeated), may exit FFU mode if the firmware size exceeds chunk size.\n"
 		" -m 2: FFU mode 2 (enter FFU mode, CMD23+CMD25 repeated, exit FFU mode), stays in FFU mode until firmware download completes.\n"
-		" -m 3: FFU mode 3 (enter FFU mode, CMD25+CMD12 repeated, exit FFU mode), stays in FFU mode until firmware download completes.\n",
+		" -m 3: FFU mode 3 (enter FFU mode, CMD25+CMD12 repeated, exit FFU mode), stays in FFU mode until firmware download completes.\n"
+		" -m 4: FFU mode 4 (CMD6+CMD24+CMD6 repeated), exits FFU mode after each cycle.\n",
 	  NULL
 	},
 	{ do_erase, -4,
diff --git a/mmc_ffu.c b/mmc_ffu.c
index 239d3b0..fff7b11 100644
--- a/mmc_ffu.c
+++ b/mmc_ffu.c
@@ -55,6 +55,11 @@ static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd, __u8 *ext_
 		set_single_cmd(&multi_cmd->cmds[1], MMC_STOP_TRANSMISSION, 0, 0, 0);
 		multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 
+	} else if (ffu_mode == 4) {
+		fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG, EXT_CSD_FFU_MODE);
+		set_single_cmd(&multi_cmd->cmds[1], MMC_WRITE_BLOCK, 1, 1, arg);
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
+		fill_switch_cmd(&multi_cmd->cmds[2], EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
 	}
 }
 
@@ -139,8 +144,10 @@ static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off_t fw_si
 		return -EINVAL;
 	}
 
-	if (ffu_mode != 1) /* only in FFU mode 1, mmc_ioc_multi_cmd contains 4 commands */
+	if (ffu_mode == 2 || ffu_mode == 3) /* only in FFU mode 1, mmc_ioc_multi_cmd contains 4 commands */
 		num_of_cmds = 2;
+	else if (ffu_mode == 4)
+		num_of_cmds = 3;
 
 	/* allocate maximum required */
 	multi_cmd = calloc(1, sizeof(struct mmc_ioc_multi_cmd) + num_of_cmds * sizeof(struct mmc_ioc_cmd));
@@ -238,7 +245,7 @@ int do_ffu(int nargs, char **argv)
 			break;
 		case 'm':
 			ffu_mode = atoi(optarg);
-			if (ffu_mode > 3) {
+			if (ffu_mode > 4) {
 				fprintf(stderr, "Unsupported ffu mode `%d'.\n", ffu_mode);
 				abort();
 			}
-- 
2.34.1

