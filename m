Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF76815442A
	for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 05:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750828886; cv=none; b=SSJSBMo4Ypfgb6kVOKwOxdZz+BL/qtGsJ6xsxRUNF0ThjYMSyM4f+TcJtqbEPcqiy+ee5ejCtUnyPWd69l9aN9ZzteKCvtYtAiJQgDDjaDlo85Uk5W+2QT5T7bCJ+WhTYARrMrdoWIC/j7MAHVIk2CmNM33co/ezTbBLsOxVo7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750828886; c=relaxed/simple;
	bh=xTCQ5Co7j4ZX7l03fJkRNZOE8GD7nb6sEADXr0HP+Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4pOrIEhUsJdwvEhsNt3Zo5doNVemwb4E7BbafNVMa1tcDbtKtCBwyvoTsvhKANGTFEaSdhoIcroj3ebiBmQE5+QEXBfVdLOiEqiO18KzYGeNMGJLs3sQUVbL1ParRFJlTyQN0X0khV3BoRPAhw7WbFrAHoAiXHGm1njtr4k1zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dQimpEvD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dQimpEvD"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747fba9f962so407700b3a.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jun 2025 22:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750828884; x=1751433684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdewN+OqwPnfjHa4kNqJuR+GOLJuDMWb9fhOCDaUpO4=;
        b=dQimpEvDKErL8a7WGESUmAgtdMZ14xL4pOHHsK+Gs8MEgXvoItHHddcBJRK/32t2uB
         NLycxL7AM5bJcXLapcD/EXJENXZNsSFH34hKdCZnncNHoqO+L0Zu8vKN+38ET+cmWqin
         FSa/IJdttL/fWsE958dVXAkBOmhJIe26DVS+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750828884; x=1751433684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdewN+OqwPnfjHa4kNqJuR+GOLJuDMWb9fhOCDaUpO4=;
        b=uuxWCieMwl+AxDu+BRH+em5DOegDtzHHidH5dIeoCNrUZJ3K/3CT1LelxH0vRCvkUF
         0I+O1biFhQnVaNojXmdwtbpPej4fnOhevxR+U+Pdx92DJPmFHmK1lRtYRKZlXeV9aS3O
         Y+EUKtnuseQW+2brSza9figVGq/Kn/X2THD1v361ALmvTVWIyWwG9WPFY0oQVLURQnjQ
         3p7Kjt8ejB2zweybWm+MHcf0q1fXwGKrFEBJJCpM5gdh5ObbW8VXR9ZijBDn5D5vI5JC
         Z5S0zoXkpqwFjUiC6PG6luHTzoIwLLl30eaewro7agCOAudgMchUxxJsTFi5RnwIsCrl
         muwA==
X-Forwarded-Encrypted: i=1; AJvYcCUQn0qhs7dI115tpZBCBU6ZGMH/sYLw9bdDsfu8kbftOogxD8GLXBBLJwKWEbmfbKRhMwKFzMIYDbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNP0ll+W/yrPuXeatMHV4P7fIivCb5gRTWlLtvpUSXrdOYKR1o
	0HlQDuXeYBuMVQ8hgeZGSKjqOpfL2/imeEJlqNVZ7bpCcbhi64SI+MvpffjTfLJkiA==
X-Gm-Gg: ASbGncsu/03iwc6Ot0Tefsxx7E/2N3JClsJ4CHZRers6fixo2aypktHXtNLPdgRcoTG
	H6veP8O0b4Nrp5gO6lAx7mzzJwO6tCesBV1XkhZxytQAGAGq+pZCwGQNYuMdAz5bPKD66ZVJoPt
	jv22zyLVOYC7eMjHBqWGrBmEbdLsGonvgv9ev9u2KI9LFTwTf4Tn9702Vmwxz4ON6x90eOK1Qjt
	2Hbm5oYVt2EAu4rhUf8WsHU5qq37D4q7DQDBUJ6P/2EJWWu66CRAV9dOD4mBcH9+AK54dWy9+Jj
	dsI9W8SvZWuK3vYzcA1lK40XnXcXcXUOC7kpQ7LaEG6FMNORfScPioRjtjxBWW203oDXE72I9t5
	b+W2fhpfkhbos
X-Google-Smtp-Source: AGHT+IHtRUvI4BFjONg8E4iCJF2EoVUYaYsRjRtF6W4pN3FGjeweBp2iZqpmntUDbugSl88Vu2pCtA==
X-Received: by 2002:a05:6a00:464f:b0:749:1e60:bdd with SMTP id d2e1a72fcca58-74ad4ad593emr2674902b3a.2.1750828884013;
        Tue, 24 Jun 2025 22:21:24 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:301e:ee9a:3fb5:c761])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c882cda6sm3536393b3a.96.2025.06.24.22.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 22:21:23 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Tomasz Figa <tfiga@chromium.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] mtk-sd: reset host->mrq on prepare_data() error
Date: Wed, 25 Jun 2025 14:20:37 +0900
Message-ID: <20250625052106.584905-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
In-Reply-To: <174972756982.3337526.6755001617701603082.stgit@mhiramat.tok.corp.google.com>
References: <174972756982.3337526.6755001617701603082.stgit@mhiramat.tok.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not leave host with dangling ->mrq pointer if we hit
the msdc_prepare_data() error out path.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/mmc/host/mtk-sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index b12cfb9a5e5f..d7020e06dd55 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1492,6 +1492,7 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (mrq->data) {
 		msdc_prepare_data(host, mrq->data);
 		if (!msdc_data_prepared(mrq->data)) {
+			host->mrq = NULL;
 			/*
 			 * Failed to prepare DMA area, fail fast before
 			 * starting any commands.
-- 
2.50.0.714.g196bf9f422-goog

