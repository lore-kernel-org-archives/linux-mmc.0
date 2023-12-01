Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZE3XClYr"
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1171994
	for <linux-mmc@vger.kernel.org>; Fri,  1 Dec 2023 02:27:54 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfc2d03b3aso3124935ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 01 Dec 2023 02:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701426473; x=1702031273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2RC9FzC7iwPwgtlDLuitx0S/ZDsUva1kaWzL6Ox9kqE=;
        b=ZE3XClYr4BVJiR8xQqnDgwK7N4dvewF74tM1Qr5e7+gqyhl19uzeEzj+88vKyD2EPe
         DegYpYafj7x/hWERI6vcHSsJoe0DGFvPtWUe61C4ztIe/Go3Qn/2YLs8WObS/CvLR7KV
         TJEFP6neF8m1eID2zUZ9Eu6LVJfXma/LhRP+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701426473; x=1702031273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RC9FzC7iwPwgtlDLuitx0S/ZDsUva1kaWzL6Ox9kqE=;
        b=AH66Uy9w8NjFcgaKvpcMWO5UBBJrX/oBNqAUKzDsw+xM5z5Iud4GUmN+S48A/8zCKl
         JJkcWeSQbSxpwCPDVNAHvbMfCX6Iqvp4XfbJwmwChnlPtsXI+8FwEPUEXX7kCcX9EMoF
         7cgKswpy2dwvJRel2Wqcsfc6FW2lirFbGcFkcHBgr5zoakEGgWjX8YzO+D1F/DW8CPdx
         dSceK+U31LVw91UqsmcE78LmabOwYmNzhAWhsBFT8gbdCNPpBRtC9rAuhbl6fQQIg3OC
         yfjDDqm4TM8T43rGp1PRHTOM5QTdMfrZbDk2R288xB3XevAN1DHQOM4SUadjgbSI6bBX
         Os7Q==
X-Gm-Message-State: AOJu0YwLkHZI2AW4Wi/pRyHM9ulXmjoQqKGS21wxALj/Ra7aqzXmXI/A
	rSdFXSCpc6CxIwz7oA4vWpBxew==
X-Google-Smtp-Source: AGHT+IGCERlKGLeruUPnK4GdOVfqBQiVNvewSDpyal6DJA9WLBLq4tt7LRL+mCnc99WbZOcPHmdH9w==
X-Received: by 2002:a17:902:ce8a:b0:1cf:df4f:30d9 with SMTP id f10-20020a170902ce8a00b001cfdf4f30d9mr18630789plg.29.1701426473520;
        Fri, 01 Dec 2023 02:27:53 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:39b5:c526:2f63:2eb4])
        by smtp.gmail.com with ESMTPSA id z21-20020a170902ee1500b001cfc9c926b7sm2999507plb.75.2023.12.01.02.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 02:27:53 -0800 (PST)
From: Pin-yen Lin <treapking@chromium.org>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ot_shunxi.zhang@mediatek.corp-partner.google.com,
	linux-mediatek@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-mmc@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v3] mmc: mtk-sd: Increase the verbosity of msdc_track_cmd_data
Date: Fri,  1 Dec 2023 18:26:51 +0800
Message-ID: <20231201102747.3854573-1-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This log message is necessary for debugging, so enable it by default to
debug issues that are hard to reproduce locally.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v3:
- Only print the warning when -ETIMEDOUT or not in tuning process

Changes in v2:
- Use dev_warn() instead of dev_err()

 drivers/mmc/host/mtk-sd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 97f7c3d4be6e..6ae5e0a9fca9 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1149,9 +1149,11 @@ static void msdc_recheck_sdio_irq(struct msdc_host *host)
 
 static void msdc_track_cmd_data(struct msdc_host *host, struct mmc_command *cmd)
 {
-	if (host->error)
-		dev_dbg(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
-			__func__, cmd->opcode, cmd->arg, host->error);
+	if (host->error &&
+	    ((!mmc_op_tuning(cmd->opcode) && !host->hs400_tuning) ||
+	     cmd->error == -ETIMEDOUT))
+		dev_warn(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
+			 __func__, cmd->opcode, cmd->arg, host->error);
 }
 
 static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
-- 
2.43.0.rc2.451.g8631bc7472-goog

