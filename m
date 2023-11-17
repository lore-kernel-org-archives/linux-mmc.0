Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HvjmH9YB"
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D61B0
	for <linux-mmc@vger.kernel.org>; Fri, 17 Nov 2023 01:55:40 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b2e72fe47fso1140252b6e.1
        for <linux-mmc@vger.kernel.org>; Fri, 17 Nov 2023 01:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700214940; x=1700819740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TVxZf23b1Ct7o+eXshFFzhsxx/lGHOCTi79IGHMkXx0=;
        b=HvjmH9YB1flnKNNecqmYkeKh651TGhD//rnTlS33lbAhZyK4T4v+9l/VHHCYsPLAzp
         wtKD836fo+IHMCMbCb5zAhgnUPpvfHYouplNL373KZycjPg2Nk3KOFI7+M9l/EwJloz0
         mQO6nkRGJ5C2wyvoM2INoijB0ZVWnUCUgx5m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700214940; x=1700819740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVxZf23b1Ct7o+eXshFFzhsxx/lGHOCTi79IGHMkXx0=;
        b=MUac63V7nB8JKmCmgWhstynM0xMYat9rvhfNgc+8N85OrnpAx/dBbXzDQDu9cNI2+1
         MrS1rF5YucQt/1n32eu6N8ZxYhvXDci6rD/RyWTHtIn+WE4cZMVJwM3K0iQG91eQ14Gg
         YSuWbFnsAJakRPeEc+Tq5ECaPiQQqS6isUC2VU8YG8386hmULKWKV0DACFsf98Nk9qKV
         ObTyn6yGd8j7qI1RnFMuHI5qd9Ofywdh+R9ICRURMeCzjcMlwvAzliHEIFx4r4GYW52G
         Fd5dUCrJoX4M74zFKMh5h/u5Pfklxwc9IWa5IMICMBkmjUkQyrt5Jfjy5KWU6sNGi41+
         TwHw==
X-Gm-Message-State: AOJu0YznzrSoWojMufiSKSvu32KmJnoiisSspLywevX7tFpjRly82khr
	qr70h9VR3P74/rf5zUU0ZhPlPg==
X-Google-Smtp-Source: AGHT+IGOoFsqpjvXqjYKjizRulc4FsjuAYO96rTyTzI2mMyXw6i0NLkFJfJqGRhBvGABhCMn+fGMVg==
X-Received: by 2002:a05:6808:1388:b0:3ad:fdfb:d384 with SMTP id c8-20020a056808138800b003adfdfbd384mr23689636oiw.53.1700214939883;
        Fri, 17 Nov 2023 01:55:39 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:900:4eaa:9148:bc32])
        by smtp.gmail.com with ESMTPSA id d18-20020a63ed12000000b005b458aa0541sm1038673pgi.15.2023.11.17.01.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 01:55:39 -0800 (PST)
From: Pin-yen Lin <treapking@chromium.org>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	ot_shunxi.zhang@mediatek.corp-partner.google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] mmc: mtk-sd: Increase the verbosity of msdc_track_cmd_data
Date: Fri, 17 Nov 2023 17:55:04 +0800
Message-ID: <20231117095531.1693753-1-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
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

 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 97f7c3d4be6e..4469003f571e 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1150,7 +1150,7 @@ static void msdc_recheck_sdio_irq(struct msdc_host *host)
 static void msdc_track_cmd_data(struct msdc_host *host, struct mmc_command *cmd)
 {
 	if (host->error)
-		dev_dbg(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
+		dev_err(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
 			__func__, cmd->opcode, cmd->arg, host->error);
 }
 
-- 
2.43.0.rc0.421.g78406f8d94-goog

