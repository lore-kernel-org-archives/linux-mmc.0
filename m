Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256D2B9A5
	for <linux-mmc@vger.kernel.org>; Tue,  1 Oct 2024 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815845; cv=pass; b=XnOvQYqtV1/ffBkcXKcKwNasE5iJkhseYbH0AiM2UQJiU0zCzfqo3f1Cspi4II8FfL0pRb/htuOnkuY3lTpx7MYGGnMcTILYEYu4fxQBQxah3mg5Bx2Kt8+BHeBfgs9um4/wrwwwO0nCDXpdkcM02BUtERi8JcUcsJ/sbYCNpTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815845; c=relaxed/simple;
	bh=XWoZ5M9IJgvG7TVKVlYl5y7VxImpaDUWws/n3Lju9o0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9bj4COG0q/cI9dSAafaoJ0WM4Y+nLowvOYToBNl6MXzW9loqnhwjtQEdttnosPOQPvSiVT8xrBWTiAIR6i3QoDA3n8RXVYEAY5+7dDx94M5/MJDKhMXwuZ8HNcZMat3E27+aH7h/MXWEWei7lZHmDIglh1dy2C6447zprZhHpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=oS1Qh0ei; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=96okupII; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="oS1Qh0ei";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="96okupII"
ARC-Seal: i=1; a=rsa-sha256; t=1727815120; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hyTAEG5R2WtkUjAAqOOYd1sL+TEzOE5Uaymw0SCMqXfT2aURYsZMkGafVm2pJERpj1
    lDDeiI4pcm9au7NYkATLdGzytcM+TaQfAp7lFjuwkQ/QBir8GZpIhusdYfdV91CmyaIP
    jvXl9WLsTX7ZXTTSKnUytp+PFs07mFxyGnA78CVRXH0Oar4flf3ACI6rAI0R5LRKCO2J
    DBIBJszAtVzpfATMq4zRiAo3s6p6QNjuN8M7rpiebPT5kWcPUQfjQjDDEGP9iCqiX9m2
    5bNqCMlLIjvLNZfBWL8CfMnuqB3nVS9IVEcl2f/jzHFqNrxYuWMC/H1271387lNA8XkR
    3trQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1727815120;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4txe+iD50pMDpThtrvaW5COT5g0xJ1mL6n/zbUfQoYQ=;
    b=FmeRDb1k6UdM8zF6z1ToDU5ep6qVBlguMqsTPgQiyWX6NNFy5P+64NqWGznRS/Iecu
    3UhnKAhSMttVFZa7VbkF1eJuwcJn841eXj/zGT9c4qaMk5nnGbr7TzkMz0fO5T42LivY
    xaV81Kqip65yfynYKh8BeUwUxExsPJjny7XeC/6E8esae0YwwcZ+5dMQBWU8gV0NbmPU
    BYKkTTznLMBQhp7ErusIL+o5Z2MyTM1BLKN+uhXs4kV4q6RGEJX8LuRW3ZEMJjngDBxF
    5tPU6dgLpgtTAG6+yLm8ioS2DlKElf6Xl3gTVEbdIGcYuAeUxei2yGmGlhZMOXjFEu89
    JFRw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1727815120;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4txe+iD50pMDpThtrvaW5COT5g0xJ1mL6n/zbUfQoYQ=;
    b=oS1Qh0eipSjs5gAdKJc+aIbmZyEBkBgVF6RKSAh5UYWa/EE8ZtRM8rMbROSAIZkP63
    mqKV6NpxStppKDijMA+xXi8mR8R3AoxEfG7VVwzX08dNe8V0fsdJI3ZXWp/ijWCIoOfx
    y3eoO76srsvJAdX2ouV3HeGPBeNXbytY2Jjlj7861iTxVUecP9NNjzsk1zb4+1g24x3s
    +Dc78JfvmX5J+fDmaWo+67AjlJeKPRIqOLv+3MhlnHHkBZVMR6gyPqcyKs89C5r1/02t
    4Ctrd1zNu1a0YEng6ph3fP7eP3d5g6l/kVoQeKNry6BrpVKzEPWG16pmGoQsCKUNiPyI
    DTpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1727815120;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4txe+iD50pMDpThtrvaW5COT5g0xJ1mL6n/zbUfQoYQ=;
    b=96okupIIVqqdCNWL6s10ZtTqJSnr9n/L6mkWruqPYi3arTuZ4slcDZQJaqUOOdHi5D
    UTo0j1tfp0CprHfgIMAw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RD06ISTv80p2D11QFwNypsTi9pEHpqtUzGQwQ=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0e6b0091Kcecdh
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 1 Oct 2024 22:38:40 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH v1 3/5] mmc-utils: Add new FFU mode using CMD25+CMD12 for Open-ended write download FW
Date: Tue,  1 Oct 2024 22:38:09 +0200
Message-Id: <20241001203811.26279-4-beanhuo@iokpp.de>
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

Introduced a new FFU mode leveraging CMD25+CMD12 for Open-ended Multiple-block write to
download the firmware bundle.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 mmc.c     | 3 ++-
 mmc.h     | 1 +
 mmc_ffu.c | 9 ++++++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/mmc.c b/mmc.c
index 0a22f2e..73b694d 100644
--- a/mmc.c
+++ b/mmc.c
@@ -234,7 +234,8 @@ static struct Command commands[] = {
 		"should be in decimal bytes and sector aligned.\n"
 		"[-m <ffu_mode>] Optional, provides five firmware bundle download command modes:\n"
 		" -m 1: Default mode (CMD6+CMD23+CMD25+CMD6 repeated), may exit FFU mode if the firmware size exceeds chunk size.\n"
-		" -m 2: FFU mode 2 (enter FFU mode, CMD23+CMD25 repeated, exit FFU mode), stays in FFU mode until firmware download completes.\n",
+		" -m 2: FFU mode 2 (enter FFU mode, CMD23+CMD25 repeated, exit FFU mode), stays in FFU mode until firmware download completes.\n"
+		" -m 3: FFU mode 3 (enter FFU mode, CMD25+CMD12 repeated, exit FFU mode), stays in FFU mode until firmware download completes.\n",
 	  NULL
 	},
 	{ do_erase, -4,
diff --git a/mmc.h b/mmc.h
index 6f1bf3e..78cc140 100644
--- a/mmc.h
+++ b/mmc.h
@@ -27,6 +27,7 @@
 #define MMC_BOOT_INITIATION_ARG		0xFFFFFFFA
 #define MMC_SWITCH		6	/* ac	[31:0] See below	R1b */
 #define MMC_SEND_EXT_CSD	8	/* adtc				R1  */
+#define MMC_STOP_TRANSMISSION	12	/* ac				R1b */
 #define MMC_SEND_STATUS		13	/* ac   [31:16] RCA        R1  */
 #define R1_SWITCH_ERROR   (1 << 7)  /* sx, c */
 #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
diff --git a/mmc_ffu.c b/mmc_ffu.c
index ac65130..239d3b0 100644
--- a/mmc_ffu.c
+++ b/mmc_ffu.c
@@ -48,6 +48,13 @@ static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd, __u8 *ext_
 		multi_cmd->cmds[0].flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 		set_single_cmd(&multi_cmd->cmds[1], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
 		mmc_ioc_cmd_set_data(multi_cmd->cmds[1], buf + offset);
+	} else if (ffu_mode == 3) {
+		set_single_cmd(&multi_cmd->cmds[0], MMC_WRITE_MULTIPLE_BLOCK, 1, bytes / 512, arg);
+		multi_cmd->cmds[0].flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+		mmc_ioc_cmd_set_data(multi_cmd->cmds[0], buf + offset);
+		set_single_cmd(&multi_cmd->cmds[1], MMC_STOP_TRANSMISSION, 0, 0, 0);
+		multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+
 	}
 }
 
@@ -231,7 +238,7 @@ int do_ffu(int nargs, char **argv)
 			break;
 		case 'm':
 			ffu_mode = atoi(optarg);
-			if (ffu_mode > 2) {
+			if (ffu_mode > 3) {
 				fprintf(stderr, "Unsupported ffu mode `%d'.\n", ffu_mode);
 				abort();
 			}
-- 
2.34.1

