Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515067;
	b=Zn1aCIq1tOSLqxcV+KhQnfPHzBnu1q3xvxb+Sc+LKiWJ0P42IO7W5c0NeNw3W/iJ+vtq
	 G7VvU2Rrbs0MNwwGRwgmZ6L8vlqkc3wzB7BGaMcCZsTVVKcLU6+UX168Ac3HEBKR7b65L
	 KZWqf3fHNtzd6YFqSRm0JXODnWOaLGVEX0fsZyyDUtwERHQAlnW1bowySfq/QiBcyPh4b
	 Didc6lxmNjU9CypMMW9z4aaCOANXzif6KE4gr+b7u6dOsfU5kkxiR5ezBuC6pOP6Ufdcp
	 q2AX4GlmYOOPBFkTbG/Kfi5urgh8rXNByjjvXBnDFVojldt3mQVewOY2i8yEl9VCOYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jk+Iv7E50Op3JEPwALwZ9u6FV2ftF6XFRcZ7NgdVWFo=;
	b=Oc4fWlvZroH8L3yIrix/Qoe24Sm3VnVyQWazRLrpLcDjecWlZYmLo+WWnYmxra4f2a6+
	 hBGnWe74sm0XpqQwCSPLeQFdx5VXxWUU90rktfK5gB/3254foP9DRMtpKKkYKUu16rVQO
	 7q1GhhjMlXlIgoKLVVAgg3AwAeME4RdeR60HMy4nJcWP/U2MqiJ3tOYaFpv0WbJCtrJw2
	 uZyn00Ta5ybbj1Q4yRbtUJ4WWQhNCw+lxr4l5Nk90aOpfbndHA5Z++VF/ZFFQF8JX736v
	 vAd/2Xx4/piZxWcSKE0aspunY4yz1ReDj8L0kV1VPq/21YF/YcVh2Kq2kelSh6OBoWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zhQPQbUU;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CB2606A327
	for <linux-mmc@vger.kernel.org>; Sun,  1 Nov 2026 06:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67CB2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zhQPQbUU
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ea7190aea1so9497055ad.1
        for <linux-mmc@vger.kernel.org>; Sat, 31 Oct 2026 23:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793515067; x=1794119867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jk+Iv7E50Op3JEPwALwZ9u6FV2ftF6XFRcZ7NgdVWFo=;
        b=zhQPQbUUhCYQFoTxvL8ZHBMO96oNrXROIr4p5ptS2/BMhHSy7+unGTDNoxZL7y+CpH
         aCUMkZFs7uwjg0LU+wIt3SSdjhm8qYaGqv0zLKFbrJGofDnBPFWyhuMUxc0FQUF3kuml
         xj8Sj1Fh6y/iEh2p+nPAHb3FwgaGz2tn28dSbOa6vpG5PO87zXCa49pBhgmZlCtPpA4f
         yrSliOz1yG+L5b7v1F4hCkn9eb266rcddg6ryjPhDkvjodoODsQXtNEVyHG9aOsVAXP7
         5a5VVJXFl5HRFanN5VzsV2jvfh1v7uJ4zF5DXFuGhUhpr9LjSxdNx5ALv+7TNOazvy4V
         ZX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793515067; x=1794119867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jk+Iv7E50Op3JEPwALwZ9u6FV2ftF6XFRcZ7NgdVWFo=;
        b=cNzPISOaXP0BL2Z/E+9DrQ1uNtNL07phC4Ww0bu00Jx4LWmNaqdBefQP2yAulUKChA
         YAMU+uq09lKTDnPZ/foR0dhzqO51LuSrWsNkufAV5pO/L++Suf/JgvPaGf27OSuncApU
         xlr7Ow3oi2ADsrjmH2VkQVpVHsiUKhWRpYjau/lbO99FwWzoJzXkGzVGVw4UxtIE6E6I
         wgc411OtZPmEuroe+0j8uxDM7Al0XmtGZyCiHWkUB5uCtw7vPNS1VvHTHgY3bfAZ/SOK
         z1g6bZEDOZiKJrucu7B3CUZFsVnXBEr50iuTDi9Hrd1L7FbxYtcIuRTGj+TrqVPM306p
         IBUw==
X-Gm-Message-State: APuU4Z/RbNEL/BNKIwJFVjTGSucnQjMHJdgXS6kImJ53grn9Rp7FGv7N
	uhvEWviLW3OjreHzzCzQ+pW+yx8poaJcdYOzLhj0ztEWT2hIAQNc1gLX
X-Gm-Gg: AYBFou2hJr5Juuy9K/ooNlhuc4aIcMnzR2uoKEzCJxiaczP7fxJwZyuN5GDJofIkj+W
	2BFNlP8Ha5IQUhb+PaDS3itbzxy6Do4aSZlaMEfGOTMqMxyZPBEy1gL2AA098GJERguvVgXiqV6
	XwdHI7iXFYs83i/F/q8IxulZRYG4TH3gVQD71fBToIXM5541+B+xKEoARzdi3YYzXTnA7Uf7w+x
	6to/NQJGSMaZsXy/oMAxwOIB9RTwX5EUER7Rt4H7+gtSmGaVvXxaZydAwJgnW54///CiDhdootX
	h6dCxOxuzq4uLvdCDU1Ra4vQMbXIYSxmxCb4+zFMbGrWiyegHr6I6+3OwlCTqnQ+sPW27F82DAG
	vHqFs+Xzft/mXXGgUIgXTdDG+VvYq7gXzn/XsSdhNJfGACfh+kZzqNOJfGlcPdewVjzaQuaZ2Nd
	1G7dO1f4E4UUYTK/cJUE8NwWCSKLsg5NVWjV3HxLwtliW1bxN8cP29e3k6Wg0X6soQrIqIhxnBn
	KETjpcYAJIGcMmFsWMRlwVfcc9L3bbpdXel3op8vxj8+iXl6SIT0DItJkLgOQm1UytRyUl8Zpuk
	+ZVnOpvVt5axDDITK/7/UKH/sfdaQSctmpjHc/XqM6y//ksELGwKQmQEy0+Jy/u70BKM
X-Received: by 2002:a17:90b:5807:b0:3ab:be66:ddbf with SMTP id 98e67ed59e1d1-3ae8981dd4dmr5417304a91.54.1793515066743;
        Sat, 31 Oct 2026 23:37:46 -0700 (PDT)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e2a703esm14120742a91.0.2026.10.31.23.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 23:37:46 -0700 (PDT)
From: BeaCox <0xbeac@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RFC PATCH] mmc: tmio: disable dma_issue work before releasing DMA
Date: Sun,  1 Nov 2026 14:37:39 +0800
Message-ID: <20261101063739.89331-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tmio_mmc_host_remove() drains done and delayed_reset_work, but leaves
dma_issue pending or running when it releases the DMA resources. Its
backend callback accesses the host, controller registers and DMA state.

Disable dma_issue synchronously before releasing DMA. This also rejects
late queue attempts from an interrupt handler that is still running;
cancel_work_sync() alone does not provide that guarantee.

Some DMA backends fall back to PIO before initializing dma_issue. Move
their work initialization ahead of the fallible setup so the work is
always initialized when a DMA backend is present. Skip the disable call
when no DMA backend is configured.

The analysis, patch and validation were assisted by OpenAI Codex.

Fixes: 85683fb39d9b ("mmc: sdhi: Convert from tasklet to BH workqueue")
Cc: stable@vger.kernel.org
Signed-off-by: BeaCox <0xbeac@gmail.com>
---
Testing: x86_64 COMPILE_TEST object builds with gcc 13.3 and W=1 for
tmio_mmc_core, renesas_sdhi_core, both Renesas DMA backends and
uniphier-sd. A userspace model of the extracted remove function checks
the no-DMA case and modeled late queue attempts before DMA release.
It does not simulate real IRQ/DMA concurrency or backend hardware.

No matching hardware, kernel crash trace or demonstrated unprivileged
trigger is available. Please review DMA-to-PIO fallback, probe failure
and teardown on Renesas and UniPhier. The initialization changes cover
backends that can return before setting up DMA. Other work items and
the wider IRQ teardown remain outside this patch.

 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 4 ++--
 drivers/mmc/host/tmio_mmc_core.c         | 2 ++
 drivers/mmc/host/uniphier-sd.c           | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 426308b73b..45e34d57ab 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -340,6 +340,8 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
 
+	INIT_WORK(&host->dma_issue, renesas_sdhi_sys_dmac_issue_work_fn);
+
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
 	if (!host->pdev->dev.of_node &&
 	    (!pdata->chan_priv_tx || !pdata->chan_priv_rx))
@@ -402,8 +404,6 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 			goto ebouncebuf;
 
 		init_completion(&priv->dma_priv.dma_dataend);
-		INIT_WORK(&host->dma_issue,
-			  renesas_sdhi_sys_dmac_issue_work_fn);
 	}
 
 	renesas_sdhi_sys_dmac_enable_dma(host, true);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 775e0d9353..d0d3dd05a0 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1272,6 +1272,8 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 	dev_pm_qos_hide_latency_limit(&pdev->dev);
 
 	mmc_remove_host(mmc);
+	if (host->dma_ops)
+		disable_work_sync(&host->dma_issue);
 	cancel_work_sync(&host->done);
 	cancel_delayed_work_sync(&host->delayed_reset_work);
 	tmio_mmc_release_dma(host);
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 1eae2f4b6c..cd0fdffa30 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -187,6 +187,8 @@ static void uniphier_sd_external_dma_request(struct tmio_mmc_host *host,
 	struct uniphier_sd_priv *priv = uniphier_sd_priv(host);
 	struct dma_chan *chan;
 
+	INIT_WORK(&host->dma_issue, uniphier_sd_external_dma_issue);
+
 	chan = dma_request_chan(mmc_dev(host->mmc), "rx-tx");
 	if (IS_ERR(chan)) {
 		dev_warn(mmc_dev(host->mmc),
@@ -198,8 +200,6 @@ static void uniphier_sd_external_dma_request(struct tmio_mmc_host *host,
 	priv->chan = chan;
 	host->chan_rx = chan;
 	host->chan_tx = chan;
-
-	INIT_WORK(&host->dma_issue, uniphier_sd_external_dma_issue);
 }
 
 static void uniphier_sd_external_dma_release(struct tmio_mmc_host *host)

base-commit: cbbddb6b08cc9900a87cccaa9b22bbe06aa4f50a
-- 
2.43.0

