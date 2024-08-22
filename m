Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F81D27AC;
	Thu, 22 Aug 2024 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724361900; cv=pass; b=fF7dR1tAsZ+U4ncuWeELNr2QB7v+wdkebji+lq1OiU++/lo3jBg++6skastpjGUVerU/judoT6uEKlsCRzy18UrkooVGhFNNcONpjKhw115G4JzNw3I8lwOlCO1ppZL0FnG1EFU+LJqlH2wUt50kG46hWCfaU0KmuUcOUMSU88M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724361900; c=relaxed/simple;
	bh=POQi917ROR/aImwBAvuhdQT4wsdd1ZBwAPh991+RcRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6KGQEFHZlmNREkKxSB7KGg/z0Uwe0gfXSMMA5X/G0zfMRaO+XgiYpCnFh/fRqQWvhIXtw6dXTzxVFRJ5RJx6cXt/p2WfbAlLJzWaI0IWwB6j/HVtJuRUc9WJYFGcLASmrn0kgvabyNOL3Abykp49lZynokNr+cjsLxJZsdHpdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=WiV99nXB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="WiV99nXB"
ARC-Seal: i=1; a=rsa-sha256; t=1724361878; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SKAst/GSUDdpDsFfaCCUvjT+DpgUBLoA3iDBj9JSQZBj4iy0/gbaEyPSfv7j2d454jUWgsnpLbF+3dHNhUPRq0rRsHTan1cJuEaX3TIVM/KXJIr4/5WLAJ92IkJUvDEHYDs0xT5EjqQZPOr9Z9s1ad9ffEUwK64y2/czSoA6smI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724361878; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=U9XVsD5fvKJmyv7C72+pHv7QCs88k6hh5p5gXJ49Tv0=; 
	b=kGee4qNF1CjouS8zw1FNBVRBixtWD5JpvifX62Oxa/Pj+n+eSfSmU1bJhs9SjWGStYts+oIB3aoYphB/qkvDwcGMtZ8JNhQEVCFJF1kEW/6OSpaYPjXC9VB9GlyF7rQ4BSPlMJXDDpgf98iXwL1VOEFqmBfb4hBUs0m7Ww+FYoc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724361878;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=U9XVsD5fvKJmyv7C72+pHv7QCs88k6hh5p5gXJ49Tv0=;
	b=WiV99nXBDLXF0B4t61a61Fz3kBa5BuTFn8hnpVE+d+7bxFSRViQehu7Xobr7WvsP
	gv+JgsSXAVG6CPFtajw8dFO8X0dQBclymCoWhWczRVUS1HI7qMLgrYtF0P/C3rJTX3o
	DhIgx7HlgU8lFfHIGVY3b1Vt6SS3lK0pSWaZdVE4=
Received: by mx.zohomail.com with SMTPS id 1724361877557950.7494035533349;
	Thu, 22 Aug 2024 14:24:37 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v4 3/4] mmc: dw_mmc-rockchip: Skip all phases bigger than 270 degrees
Date: Thu, 22 Aug 2024 17:15:33 -0400
Message-ID: <20240822212418.982927-4-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822212418.982927-1-detlev.casanova@collabora.com>
References: <20240822212418.982927-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Shawn Lin <shawn.lin@rock-chips.com>

Per design recommendation, it'd better not try to use any phase
which is bigger than 270. Let's officially follow this.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
(cherry picked from commit 2a53aab5cfa43065b2e979959d727332a8a03c03)
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 2748f9bf2691..1458cb5fd5c7 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -310,6 +310,9 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 
 	/* Try each phase and extract good ranges */
 	for (i = 0; i < priv->num_phases; ) {
+		/* Cannot guarantee any phases larger than 270 would work well */
+		if (TUNING_ITERATION_TO_PHASE(i, priv->num_phases) > 270)
+			break;
 		rockchip_mmc_set_phase(host, true,
 				       TUNING_ITERATION_TO_PHASE(
 						i,
-- 
2.46.0

