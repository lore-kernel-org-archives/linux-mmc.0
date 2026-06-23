Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085A38D3F3;
	Tue, 23 Jun 2026 06:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195122; cv=none; b=paWmlEdEXpVUic5tevpzriLNLQenjBS8rPwb8TJ+I5QA+lQKxU9vizpv8X25/duTj4N0NCM52TmLgGpgOFxWfHLD9G1uq+IPzQ7vN1YSW91zYBTswii+yksx//dkbvXiYwGXL/xT27xb0xo0gjldqE7SZ249ajuV25p5f9ZYAlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195122; c=relaxed/simple;
	bh=GCzb07KXPeKcoS9Qoy5ev8gzIP/o4YUB/Ab599yAjOQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pgD3rJdovDz7/G6Vz++FkgtOTD2KR+Elo6e4904+CYzbhbn2Xtooh9sLCmd2aypd6T86YpCD8WsmrbO5n6ynFoFdmFS0Lx6sQO5gnjHjxAxwcvFxHCv26kuORt4kC0WtHik3d2t0tznpPuIPWVtU/Jt6nt9ex1CkocfAJdeQRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAC3Gt6qIzpq7RPKFA--.5618S2;
	Tue, 23 Jun 2026 14:11:55 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Ulf Hansson <ulfh@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: moxart: report DMA completion timeout
Date: Tue, 23 Jun 2026 14:11:12 +0800
Message-ID: <20260623061117.35280-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3Gt6qIzpq7RPKFA--.5618S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trW3JFWfur1xtFyDJrW5Jrb_yoW8Ww1UpF
	Wjg3s8KrWUtrs09rW8GF4qgr1Ygan3JFZrKr1kJ393urZ8tr9rZr4kKa4vvF1rAryDta4S
	vF1qqa45uw1DJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUxcT
	PUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

moxart_transfer_dma() waits for the DMA completion but ignores
wait_for_completion_interruptible_timeout(). It then unconditionally
reports the full transfer length in data->bytes_xfered.

Terminate the DMA channel and set data->error when the wait is
interrupted or times out. Only report host->data_len as transferred
after the completion is observed.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/mmc/host/moxart-mmc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 3dd8f232052f..4a4d8b19b18c 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -264,6 +264,7 @@ static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 	u32 len, dir_slave;
 	struct dma_async_tx_descriptor *desc = NULL;
 	struct dma_chan *dma_chan;
+	long timeout;
 
 	if (host->data_len == data->bytes_xfered)
 		return;
@@ -296,11 +297,17 @@ static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 		dma_async_issue_pending(dma_chan);
 	}
 
-	wait_for_completion_interruptible_timeout(&host->dma_complete,
-						  host->timeout);
+	timeout = wait_for_completion_interruptible_timeout(&host->dma_complete,
+							    host->timeout);
+	if (timeout <= 0) {
+		dmaengine_terminate_sync(dma_chan);
+		data->error = timeout ?: -ETIMEDOUT;
+		goto unmap;
+	}
 
 	data->bytes_xfered = host->data_len;
 
+unmap:
 	dma_unmap_sg(dma_chan->device->dev,
 		     data->sg, data->sg_len,
 		     mmc_get_dma_dir(data));
-- 
2.50.1 (Apple Git-155)

