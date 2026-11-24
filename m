Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795494699;
	b=m1eSlMFBw9U0nGg7nRCtis/6bQdCoVbAdwpAkytUtKr2qmi2mqgqm5W/Yb8Fm4TuP/M0
	 ed6ao9CFYkleCcWoTqIT9hYkBsgh6OIPkosRj3QGesZt5urdFXG3WNDqikGvbyO96qECD
	 EINHTpmjz6Fs2RIWFwb2EbaFoKJq5TP72FeD5JZfkCckiFAJ0GsLzOV8P0GooGhEASSCo
	 RWSgCAK2Q89iHwWFvdektdVY74+LQJ9saNaPbuebCWeJf3WMxpG9haBCdokJE8yUwOFq5
	 FCvEOTmzASXUM1AScXVS7j4n7o21oejs5hGXzUpud9BLjghEXXnr4mZNtLe/1or9flg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494699;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=L+PRhEcNTy0KhOlMyVxlg2Et+eJxBkw//tmrokfRvTE=;
	b=oePl+CCyy84jqfiOGspzVoA7bPxgG3QDcPLoKSqcX7JW9YpLnCwCCF5R+iCtg71DaoLu
	 SWSu6nKBlIkUFgCQXhl2wRdFu+18s36NWMbQnw4bBC0oqXJlDJfAQPXVhWxMXMZ3m0LS2
	 Pq7lEqlY8VCbhBJhfie7vr9mzMt5Ch/I147zQx03q59+T4H4DCQbPDevW0FQBLDOv/K6j
	 xH6iwkw6WUbr7NEJniD5sdX5WIc78gglH+dTiNRjdZCqvfFQUhiEpSRyxIltlfjvtA8ao
	 t/jAzrlZL6kRdbIXOAZEe0GKKfqhf2xy4Bg23zYRzIL9wMq8Q5E07Mg0pamUgpH0hnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KRqs8dSA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E5606A31E;
	Tue, 24 Nov 2026 04:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KRqs8dSA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795494699;
	b=1TmaQoXB8IbNbWPjNVEyf/oQT7BU7g9D9g7aRWOSLFiU6T9Vr2JmpVWN5acpUckNFohD
	 aVx8SPJaUIQfcQIB/rNncX9XZZ2QIUMcMgDArKf5IlbAk1Borg0T9s7IxythVDAseEoL7
	 YQg0MtaZgyLVngJvjtByrEc/rue/zp53DKBGbetq0jmtocSe2UQEmZJqLe0sbBYb1vPlM
	 1+RgdEpMH1r7Z3qOaEbugctr7mDVXL1bSmnKyUWAg7zO8of4pNb2YE205cgrvRAIaOiIu
	 2lHsAjzcXx85V2SxomfVzlisNvuSOprrYUr4woJeBsw/jwsQ/9D8VOymqVeIb9EsygQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795494699;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=L+PRhEcNTy0KhOlMyVxlg2Et+eJxBkw//tmrokfRvTE=;
	b=YplXg3DbHddR87aK+MuxkZ5/0CzIq1D5sYX1Ow8nM9yd73yFtM3zpNKfYZlu+uhGLlkU
	 UCmtCd7FNIhx3g6yVXeqHGnuE95fOMaEnkilfZRQPxCK8HbZTncCzMkOOE8NZ2iGNLpSJ
	 mYkPl6tt3A3dhgM0qfxOKq/NWH/MhwOr7hofm6K0xEmYG9CDWo99m02IdkT85ZIZyIQ6Z
	 aiRs/vJeyBGAe62HemevslKDjFIJcVXcid9L8DaA6aK/6vlh2z5uvFpCoXD4iaYhWUIvD
	 2iO2G4xsSEB509rCKcBLWNf350YVY+CaTPntFxTgQfENwmMKR+YOAV+ICOSJXn/SMrA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A2FE61F000C4;
	Tue, 24 Nov 2026 04:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795494699;
	bh=L+PRhEcNTy0KhOlMyVxlg2Et+eJxBkw//tmrokfRvTE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=KRqs8dSAlBgKfeHFGPq0YO/AcZi4UkH3DKoNZ8ulEDIa6BCibY9RQm212Y00ek+/c
	 nc9cXKuBjkXDvhk9hjI/7eCI/WwrLddMAbWijBtu6FpMm4CLKKKvx5fzwZ2GOw2g4f
	 +t5ChAWn7jtkUGGPqP5cVvm/Vx3K3XKIDHq/ETH2YJc22kNGcaLComWWxp7D9kAIxI
	 sTr/om+y4vC4O/B4hzrzW/IdUCTijkd8y8F+mIAO//UdMCrFp06nm/hxNlGYP9i3aR
	 nC5/V8gb+MViyW4Z4lKAdF+0fB5QFGricOaST6Kk36WjDgYwqMIA6KSIRRquSHxYeX
	 VMoijqa0fAMXg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 02DC24C895;
	Tue, 24 Nov 2026 04:31:34 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Tue, 24 Nov 2026 04:31:33 +0000
Subject: [PATCH] mmc: sdhci-msm: Disable clocks when runtime resume fails
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-sdhci-msm-v1-1-75c70ed6569f@gmail.com>
X-B4-Tracking: v=1; b=H4sIACQTBWsC/yXMywqAIBBA0V+JWSeoiD1+JVqUTjVBD5yKIPr3r
 JYHLvcCxkDIUCYXBDyIaZkjVJqAG5q5R0E+GrTUViltBPvBkZh4EqYwymTS+txnEPs1YEfn96r
 q37y3I7rtHcB9P5jxzABtAAAA
X-Change-ID: 20261124-sdhci-msm-49414706d8d7
To: ulfh@kernel.org, adrian.hunter@intel.com
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795494693; l=2096;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=HhFjClmYElnD2cFzd7zNNwY54YGQOkXaSr+aFnOcHKc=;
 b=zQ6Ixg/O3d6/6EBenIwna/syzB/rptUS20olIOt4SZIX7tXf+a1VQZT5aipjVTOBY2eeYy/hC
 xE3DTWawSwjDQEzg2Q7a5pmI9AKPwhO+Y3xCveevI/3ihOkv+EvKlrn
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

From: Suyuan Wang <stevewong@hust.edu.cn>

sdhci_msm_runtime_resume() enables the bulk clocks first. If restoring
the SDR DLL config or resuming the ICE fails after the clocks have been
enabled, the callback returns the error without undoing the clock
enable. On the ICE error path the OPP performance vote also stays in
place.

The PM core then keeps the device in the suspended state, so
sdhci_msm_runtime_suspend() does not run and nothing drops the vote or
disables the clocks.

Undo these steps on the error paths, in the same order that
sdhci_msm_runtime_suspend() uses.

Found with a static analysis tool and checked by hand.

Fixes: 21f1e2d457ce ("mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically")
Fixes: c93767cf64eb ("mmc: sdhci-msm: add Inline Crypto Engine support")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Compile tested on arm64 (W=1). I don't have the hardware.
---
 drivers/mmc/host/sdhci-msm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 32b1bcba47d6..39db20ce5bb7 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2978,20 +2978,27 @@ static int sdhci_msm_runtime_resume(struct device *dev)
 	if (msm_host->restore_dll_config && msm_host->clk_rate) {
 		ret = sdhci_msm_restore_sdr_dll_config(host);
 		if (ret)
-			return ret;
+			goto err_disable_clks;
 	}
 
 	dev_pm_opp_set_rate(dev, msm_host->clk_rate);
 
 	ret = sdhci_msm_ice_resume(msm_host);
 	if (ret)
-		return ret;
+		goto err_drop_vote;
 
 	spin_lock_irqsave(&host->lock, flags);
 	host->runtime_suspended = false;
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	return ret;
+
+err_drop_vote:
+	dev_pm_opp_set_rate(dev, 0);
+err_disable_clks:
+	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
+				   msm_host->bulk_clks);
+	return ret;
 }
 
 static int sdhci_msm_restore(struct device *dev)




