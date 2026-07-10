Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA5443800A;
	Fri, 10 Jul 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700000; cv=none; b=rxoigQlsHTaW7zhIF2W51jxXShsqlB7igMChiV6561X2EcpbYygTPjT382fNdU3W7I0ioNnn3PDE+p0F9tWwvLBADx4cQWAo9BlyUR8TwjfbH0SaaiixeEPXLBYYmT/pWvAoco8FTAhWlIA1yt3I2sunmxJRAonw1p+OmDaNKRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700000; c=relaxed/simple;
	bh=ucXI49U/Plmb003QvLQRcChStFws7HwkeKF49Jut3V0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pjwEaqRIBn8xFqym9XsbEKTuWu0Ef27dOa0LeuUvog0lmkvNhgCTKn3U4TpIL/MHWw6REctXdowMvJdgF6pmIeoCUR/GoZPMlEzNr5zF0UsEwKQphMQvwoCLR8av+rNLm1txSoBxP+699TBIfd5UGML6MaiBrhUHldYjtM15rMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=UgosjGaB; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="UgosjGaB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=TC/UGrgWHjBp92DAPM0VNybod7BKYXnvEVYlfeyMgow=; b=UgosjGaBl/3qtH
	WAzu98Z21TGx4fta0hDZQBpkz0o6GgH/SP1xT4kcI8zdvaZkiXl2kXznsLgyYZTgAjlpgjSBk/XNZ
	PqakMUowakRcpg8rZRzb0EUr3+VnNFdRHfx0uYEPmVE27BOn86bFxNH+IsHPor0z4o6mNfro5P55p
	CMM0lCtHuku10IOJ+YU77Za/hyLrXr8ykwbggxwmzknk5jxhbiG0kEON2Jcmj0CM9DrKumBBhU8+E
	T7FkQjrq/+oJBiLD+BczJy8YCSKCo1JE/A4jtd1f+NKkqwBaBlqOzlyv8+qL89/S/qrFZsQ1WbzX8
	Ny0+9GJo+UsXt1zI/R3w==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wiDqV-0036mO-8Y; Fri, 10 Jul 2026 17:12:59 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
	(envelope-from <ben@rainbowdash>)
	id 1wiDqU-00000002OHv-3WTm;
	Fri, 10 Jul 2026 17:12:58 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v2] mmc: dw_mmc: move declaration of dw_mci_pmops
Date: Fri, 10 Jul 2026 17:12:54 +0100
Message-Id: <20260710161254.569883-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The dw_mci_pmops is exported out of dw_mmc.c so move the declaration of
ton dw_mmc.h from dw_mmc-pltfm.h to fix the following sparse warning:

drivers/mmc/host/dw_mmc.c:3512:25: warning: symbol 'dw_mci_pmops' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
v2:
  - changed to moving the definition and re-worded commit
---
 drivers/mmc/host/dw_mmc-pltfm.h | 1 -
 drivers/mmc/host/dw_mmc.h       | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.h b/drivers/mmc/host/dw_mmc-pltfm.h
index ef1b05d484c3..f3193662abf1 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.h
+++ b/drivers/mmc/host/dw_mmc-pltfm.h
@@ -11,6 +11,5 @@
 extern int dw_mci_pltfm_register(struct platform_device *pdev,
 				const struct dw_mci_drv_data *drv_data);
 extern void dw_mci_pltfm_remove(struct platform_device *pdev);
-extern const struct dev_pm_ops dw_mci_pmops;
 
 #endif /* _DW_MMC_PLTFM_H_ */
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 9ffcd3946cff..38610c89d54a 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -19,6 +19,8 @@
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
 
+extern const struct dev_pm_ops dw_mci_pmops;
+
 enum dw_mci_state {
 	STATE_IDLE = 0,
 	STATE_SENDING_CMD,
-- 
2.37.2.352.g3c44437643

