Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF617A2EB;
	Thu, 17 Apr 2025 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744882094; cv=none; b=KBYhl/lkcamyVJVPN00vrDmVtgVwCh68YtCLBBAlkrY2G+SyFxTreebPNNDIdfMJafYkdbtb4HkUsZdnZgIN9JXEnPxortJyRWE/fbvaROZNSJ9jUMWabeGVctwNKUaOxXZ04cHFjeb74Omy4iwPUxs/xNc9BAxKEbEgUK1zbNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744882094; c=relaxed/simple;
	bh=Ly1/i/AVY/FjcoDY40U5lshCFTeprih3AYlrmsJezMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IZvA/+YiJBtzwZlAiqWd0N2JOcRvikFfrxCvQ5q/5PQ6Cl23e1ZO3ZDGDB5wGuerSIt8a7c9AaXQq2KZ6bH9rKqmLJ0HQb/dFV8K97E7T6BTpbE5XwKbQ05KtcYIesuyAEegHl9wtRnMqmq0dCCloQG4e/0aTI+FeUwSRB6fSmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWR3F784; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWR3F784"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D87C4CEE4;
	Thu, 17 Apr 2025 09:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744882093;
	bh=Ly1/i/AVY/FjcoDY40U5lshCFTeprih3AYlrmsJezMU=;
	h=From:To:Cc:Subject:Date:From;
	b=eWR3F784Zh0Wlb7u0UbUyrRA9Rm3DP/VthjavsAWuH3R6qYz0rogMTgay3ZWt6boc
	 bqAnGb9GIC9m4RhPrv/rgwU6m6clq5uc98uofTxVp8Kiv/Yg5obEDF0w4nJ36YzUpr
	 1d/1GyWNN6VpOc/lx/sZUTFQRLljDHNsDDrgjWtAqUSp5zRDM4p4XyJolaXCSKPk+D
	 j4NKu3mRZZAg2gaf7a6kAnUne1EOfblrDsUMCKcRAh6uh8et4+ie+dP2v7PmPhVWpG
	 fKIbVPs3G8nrVlz1MOzygoQTzvx04N6ZnQ89DAkECtXLsVeQ6FeGVpve0M0Tq7l/NY
	 KpwQrJgELh/Ig==
From: Philipp Stanner <phasta@kernel.org>
To: Robert Richter <rric@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Philipp Stanner <phasta@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: cavium-thunderx: Use non-hybrid PCI devres API
Date: Thu, 17 Apr 2025 11:27:43 +0200
Message-ID: <20250417092742.27887-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cavium-thunderx enables its PCI device with pcim_enable_device(). This,
implicitly, switches the function pci_request_regions() into managed
mode, where it becomes a devres function.

The PCI subsystem wants to remove this hybrid nature from its
interfaces. To do so, users of the aforementioned combination of
functions must be ported to non-hybrid functions.

Moreover, since both functions are already managed in this driver, the
calls to pci_release_regions() are unnecessary.

Remove the calls to pci_release_regions().

Replace the call to sometimes-managed pci_request_regions() with one to
the always-managed pcim_request_all_regions().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/mmc/host/cavium-thunderx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
index 2e2ff984f0b3..1373deb3f531 100644
--- a/drivers/mmc/host/cavium-thunderx.c
+++ b/drivers/mmc/host/cavium-thunderx.c
@@ -72,7 +72,7 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	ret = pci_request_regions(pdev, KBUILD_MODNAME);
+	ret = pcim_request_all_regions(pdev, KBUILD_MODNAME);
 	if (ret)
 		return ret;
 
@@ -164,7 +164,6 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 		}
 	}
 	clk_disable_unprepare(host->clk);
-	pci_release_regions(pdev);
 	return ret;
 }
 
@@ -183,7 +182,6 @@ static void thunder_mmc_remove(struct pci_dev *pdev)
 	writeq(dma_cfg, host->dma_base + MIO_EMM_DMA_CFG(host));
 
 	clk_disable_unprepare(host->clk);
-	pci_release_regions(pdev);
 }
 
 static const struct pci_device_id thunder_mmc_id_table[] = {
-- 
2.48.1

