Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eYpPo+cB"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D75E19B6
	for <linux-mmc@vger.kernel.org>; Tue, 28 Nov 2023 18:59:58 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ce3084c2d1so51910875ad.3
        for <linux-mmc@vger.kernel.org>; Tue, 28 Nov 2023 18:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701226798; x=1701831598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k9Ui2NwwGrhvccOt4uEhvW+bd99ZDt3pI3ujTBGkCJ0=;
        b=eYpPo+cBBpCGhOPWYfpWdW4bPqJ8uKfZjn+qv72B9Z7/VG+rRCXw/MEMdTxsXtyXeC
         +VJwZMMsLAsgpitCEa8+CkWbPKsd/FUy531jz4SHR0/3srUly+gBJN3dw+in6OZCAVYU
         fBdGZlIIAqzxdfyRv92TnpVPzOi5Qo/aUrqy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701226798; x=1701831598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9Ui2NwwGrhvccOt4uEhvW+bd99ZDt3pI3ujTBGkCJ0=;
        b=cGSrK0oLqD2vXQCqpbIxthnWRW9C7j8f5HIlfI1QooIiq/nB//HT2mW7QNtLd7+M24
         bhdRmQIa9RNfF+UIGhJtkegBXQmmMyKxfg9K2Y95g/zlUir7xqEDtv7MJ8y8M7AOyQUu
         lsTNy4f/LJG9bdOMobWd+8bw975cjgjgGHfCQuLF4AFsqajiN9JJmRiWzG3y5P1fzHxm
         Ztey5EocxV435nQryGjf88ypVVtx96Icwv4U5mkwn8/ltWcm7qbb3RYZcL87wUZgMJ7o
         NcF7xwMVSF0o0VFFb3J+8b7fzA/D6Vely+bttujczA1WwxjWlGfBjmwVD/MsHf1ana8u
         96Cg==
X-Gm-Message-State: AOJu0YxCMLUYJICevX9/bVioheyGpEj5Pb8wTtB/zGwv2ITMEZNjP1V6
	Qo0utKbLpYJWaCJOI1Ih4cRe6Q==
X-Google-Smtp-Source: AGHT+IG6dFGqtk4fZYge5QsDOksX0ByB2i5897VnFENUeZrCkriv/jmF9N0rsBrUdnOw+cS3d0Ze4A==
X-Received: by 2002:a17:903:41d1:b0:1d0:5be:7816 with SMTP id u17-20020a17090341d100b001d005be7816mr3133476ple.10.1701226797568;
        Tue, 28 Nov 2023 18:59:57 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:db5a:6bdb:74af:e72a])
        by smtp.gmail.com with ESMTPSA id jh15-20020a170903328f00b001cfcd3a764esm4866623plb.77.2023.11.28.18.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 18:59:57 -0800 (PST)
From: Pin-yen Lin <treapking@chromium.org>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ot_shunxi.zhang@mediatek.corp-partner.google.com,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-mmc@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2] mmc: mtk-sd: Increase the verbosity of msdc_track_cmd_data
Date: Wed, 29 Nov 2023 10:59:18 +0800
Message-ID: <20231129025950.1579981-1-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
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

Changes in v2:
- Use dev_warn() instead of dev_err()

 drivers/mmc/host/mtk-sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 97f7c3d4be6e..907c13d746c1 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1150,8 +1150,8 @@ static void msdc_recheck_sdio_irq(struct msdc_host *host)
 static void msdc_track_cmd_data(struct msdc_host *host, struct mmc_command *cmd)
 {
 	if (host->error)
-		dev_dbg(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
-			__func__, cmd->opcode, cmd->arg, host->error);
+		dev_warn(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
+			 __func__, cmd->opcode, cmd->arg, host->error);
 }
 
 static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
-- 
2.43.0.rc1.413.gea7ed67945-goog

