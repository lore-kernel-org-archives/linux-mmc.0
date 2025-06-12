Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F19229B38;
	Thu, 12 Jun 2025 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749727575; cv=none; b=WFFvTV7eWFgL8avCLYf1fIapyxm8qj4mlvHNGZnJtMN+vvQxMKIOtYkheVvSZUHgVCZO3ExWsBb17Eui21M5CtbVSYy36HogagI4yoXoFnlypcauWrLPGWOM/C4YlYvr/vbrXLNUwF21+0xkAwVob5o8H3SNZsOB6w9QT8AbUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749727575; c=relaxed/simple;
	bh=Wr3zLVYuYfWGn+MSJ4fOyJXUCAJrNU6nB+Tbsj+k/iU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ujec7lxI3ggVHwcnx5ro5C/0zV5MrmQ/+Fdw8HDV3H0D95yyLSSnwGBDB/lXWWKhCR541U7dypM47ijP9zz/M1TLbBqkPxfkkmHgsmj9UBgJ5arnjk4P0JW99PZ7MBhUOrX4jE8XWKmZku+wG2exUTxa6B4IMlCirUEswNzAwFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suHdLQXP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suHdLQXP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BFEC4CEEA;
	Thu, 12 Jun 2025 11:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749727574;
	bh=Wr3zLVYuYfWGn+MSJ4fOyJXUCAJrNU6nB+Tbsj+k/iU=;
	h=From:To:Cc:Subject:Date:From;
	b=suHdLQXP65AqhZVXPaBfZJ5EJOGqG4tRoTejZ33KOs6rNHz/jZQ2DjOB1d4n6k8ac
	 vODQ10GDg36OJ1lTqsWE/Jo+ItxEdyB71INni/2nHKasIoFbNmRUQMM091SoDAZoAl
	 xOSwtsoGcmcB+ng0JK+fJGZCLFU/ixkrZBUds2/vpQs2baRKDAC5FLyqzFKnAhiMAV
	 PrWRNU/1wENhvT4D7bGh93F/oraWclj2JU1tphs0tyWLUcSChs+vmuJkLR50dQ0loA
	 Uoj0aw32ZptKrU4aNlDJNse2llCnkXH7SpvbQoiO6jlgpnAcDS0QtacOnA9DdEe718
	 T8BEvYTjfl+rQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mhiramat@kernel.org,
	Tomasz Figa <tfiga@chromium.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] mtk-sd: Prevent memory corruption from DMA map failure
Date: Thu, 12 Jun 2025 20:26:10 +0900
Message-ID:  <174972756982.3337526.6755001617701603082.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

If msdc_prepare_data() fails to map the DMA region, the request is
not prepared for data receiving, but msdc_start_data() proceeds
the DMA with previous setting.
Since this will lead a memory corruption, we have to stop the
request operation soon after the msdc_prepare_data() fails to
prepare it.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 drivers/mmc/host/mtk-sd.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 3594010bc229..56b4999fe58f 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -834,6 +834,11 @@ static void msdc_prepare_data(struct msdc_host *host, struct mmc_data *data)
 	}
 }
 
+static bool msdc_data_prepared(struct mmc_data *data)
+{
+	return data->host_cookie & MSDC_PREPARE_FLAG;
+}
+
 static void msdc_unprepare_data(struct msdc_host *host, struct mmc_data *data)
 {
 	if (data->host_cookie & MSDC_ASYNC_FLAG)
@@ -1466,8 +1471,18 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	WARN_ON(!host->hsq_en && host->mrq);
 	host->mrq = mrq;
 
-	if (mrq->data)
+	if (mrq->data) {
 		msdc_prepare_data(host, mrq->data);
+		if (!msdc_data_prepared(mrq->data)) {
+			/*
+			 * Failed to prepare DMA area, fail fast before
+			 * starting any commands.
+			 */
+			mrq->cmd->error = -ENOSPC;
+			mmc_request_done(mmc_from_priv(host), mrq);
+			return;
+		}
+	}
 
 	/* if SBC is required, we have HW option and SW option.
 	 * if HW option is enabled, and SBC does not have "special" flags,

