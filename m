Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3C18C00;
	Thu,  5 Jun 2025 01:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749085665; cv=none; b=nTH+qajdniDoO3uT5yB31gBtZUm3cxfYwuq5ugZryp8L2AsSJflEV4oedHBT8nMTm3rqJySu0H0nRNuDp8NsGxVofJya+W8TLlnD1fF0HC0fTVnkfzuCdzkyUhOovBvyMQzfppLl5j2fGF/9xYrNCs4vDqi/kLb/A5YB1fmc4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749085665; c=relaxed/simple;
	bh=+aLpCNC8OzEHRmMRK/QFfVqV5g0o8xykjr6Q8++9rQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TdAx1mKBwTSDfkg0YxnM/EGU9XZMjgh3uyn8mTlimQ9tEWXWZGnvWT9aewZAQwdespUnVQu8ywoBqxR8sEvDyWa+ULqY1BZnMhN8gxo3e6dQwYiFWfKwnpSomB3vyUo/HWXHGF9cuhqyef7OQxQ+EsZb/a+wt2OxOQ9AUo0DNKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2IidH41; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2IidH41"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B2CC4CEE4;
	Thu,  5 Jun 2025 01:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749085662;
	bh=+aLpCNC8OzEHRmMRK/QFfVqV5g0o8xykjr6Q8++9rQk=;
	h=From:To:Cc:Subject:Date:From;
	b=t2IidH412MLiXpk9UtsT7bpSel0KM7VtkNCyhlNNKm1mRAFM9RI/5beDesqRExMIP
	 04M/3zlAjX5s9/k6qC9+zC8BUFIaSban2+JV84UyIrg3hw4z695JLAk2hrVvMydt79
	 f3OEx5LZ/pt2kd0IfYtHmA7R3mGG4diwciMqWBm8eMD1gySPvZeOQTdZD25zym8tN9
	 4hOb2Rz4RQqf9U5OiWSNMaryjGqrzkaTx1FL+M+qnhJQR8d5J9Cg5tAEYuHui+lI/i
	 WmmVK/Ef48KwqurGyeuC0QMCR1oFvH2ve/tjdVa3zd6mTusxD+2/oqhLL56aIfVpBD
	 pzid/Xoppprnw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mhiramat@kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] mtk-sd: Fix a pagefault in dma_unmap_sg() for not prepared data
Date: Thu,  5 Jun 2025 10:07:38 +0900
Message-ID:  <174908565814.4056588.769599127120955383.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.1266.g31b7d2e469-goog
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

mtk-msdc driver causes a kernel crash after swiotlb buffer is full.

---
mtk-msdc 11240000.mmc: swiotlb buffer is full (sz: 16384 bytes), total 32768 (slots), used 32732 (slots)
mtk-msdc 11240000.mmc: msdc_track_cmd_data: cmd=18 arg=0397A6F8; host->error=0x00000004
Unable to handle kernel paging request at virtual address ffffffffc0001fc0
---

When swiotlb buffer is full, the dma_map_sg() returns 0 to
msdc_prepare_data(), but it does not check it and sets the
MSDC_PREPARE_FLAG.

swiotlb_tbl_map_single() /* prints "swiotlb buffer is full" */
  <-swiotlb_map()
    <-dma_direct_map_page()
      <-dma_direct_map_sg()
        <-__dma_map_sg_attrs()
          <-dma_map_sg_attrs()
            <-dma_map_sg()  /* returns 0 (pages mapped) */
              <-msdc_prepare_data()

Then, the msdc_unprepare_data() checks MSDC_PREPARE_FLAG and calls
dma_unmap_sg() with unmapped pages. It causes a page fault.

To fix this problem, Do not set MSDC_PREPARE_FLAG if dma_map_sg()
fails because this is not prepared.

Fixes: 208489032bdd ("mmc: mediatek: Add Mediatek MMC driver")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 drivers/mmc/host/mtk-sd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 345ea91629e0..3594010bc229 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -827,9 +827,10 @@ static inline void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
 static void msdc_prepare_data(struct msdc_host *host, struct mmc_data *data)
 {
 	if (!(data->host_cookie & MSDC_PREPARE_FLAG)) {
-		data->host_cookie |= MSDC_PREPARE_FLAG;
 		data->sg_count = dma_map_sg(host->dev, data->sg, data->sg_len,
 					    mmc_get_dma_dir(data));
+		if (data->sg_count)
+			data->host_cookie |= MSDC_PREPARE_FLAG;
 	}
 }
 

