Received: from mail-m24107.xmail.ntesmail.com (mail-m24107.xmail.ntesmail.com [45.195.24.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DE018FC75;
	Thu, 12 Sep 2024 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.24.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126388; cv=none; b=TrVlXa6tDZb5CtZJG/s3lg2gVWbcKtXXApLePlr4mXBLOIq+f1BAKWjHzBpSXyy/QGAqmn+cbt3XT+nV4fygPMoNYVYXO/7bB6IjOMej12u+W70QI+OqnlV2EDZe5soSGXMH5pksh61QUEf9NczCbWR3EwvUSvIn8+1wxscycd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126388; c=relaxed/simple;
	bh=mqe34keLZhnEqLJoA0/8NHxHuhscgpbFFloCdx2avjc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uy8F4W+fw3dMKB9AkZtWwdMXInB5FuYhbuaWDKJ90ACj0/KUZ9mWEkraFFzeinTGtfi1uYXEIhtDoE7L7x+4yDWbzWnb2CRhCDBgTSj/+RlYChkQ+Su49IOQQpOLtIQ6KAZaqfyOg3gsvkTRF6mVc5L79vHkk3J/A+Pw+I3LgQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=emeihT/A; arc=none smtp.client-ip=45.195.24.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="emeihT/A"
DKIM-Signature: a=rsa-sha256;
	b=emeihT/A1S3qEp2p88WokDWPh3qpTY20t0wwpIypbwJb9ZX3DZuSfN14eKoaWE2ji0FCZUhPQrreWv29xzqBmu4j4XYCfRPcGo/jU1Uw3ePlDWOVcAYvUh4DuK59Y0Ktotu6HyOIPetE79uoRw/PMVU93OQZ37EGBA0pBORqd6E=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=3A7Xdz2lLn+EifRk1ghow9aL8DdOLauW53N67ioG3Hg=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 271FB900D34;
	Thu, 12 Sep 2024 15:26:23 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: dw_mmc: rockchip: Keep controller working for card detect
Date: Thu, 12 Sep 2024 15:26:14 +0800
Message-Id: <20240912152538.1.I858c2a0bf83606c8b59ba1ab6944978a398d2ac5@changeid>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkkeTVYYTBoaGE9DSEsfHhpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a91e520475303a3kunm271fb900d34
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ogw6Nyo6ITI1PywJTjUvNBMx
	Ai9PCSpVSlVKTElNSklOQkNPS0tPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISkNCNwY+

In order to make the SD card hotplug working we need the card detect
function logic inside the controller always working. The runtime PM will
gate the clock and the power domain, which stops controller working when
no data transfer happen.

So lets skip enable runtime PM when the card needs to detected by the
controller and the card is removable.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-rockchip.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index b07190ba4b7a..df91205f9cd3 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -345,28 +345,39 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
 	const struct dw_mci_drv_data *drv_data;
 	const struct of_device_id *match;
 	int ret;
+	bool use_rpm = true;
 
 	if (!pdev->dev.of_node)
 		return -ENODEV;
 
+	if (!device_property_read_bool(&pdev->dev, "non-removable") &&
+	     !device_property_read_bool(&pdev->dev, "cd-gpios"))
+		use_rpm = false;
+
 	match = of_match_node(dw_mci_rockchip_match, pdev->dev.of_node);
 	drv_data = match->data;
 
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
-	pm_runtime_use_autosuspend(&pdev->dev);
+
+	if (use_rpm) {
+		pm_runtime_enable(&pdev->dev);
+		pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
+		pm_runtime_use_autosuspend(&pdev->dev);
+	}
 
 	ret = dw_mci_pltfm_register(pdev, drv_data);
 	if (ret) {
-		pm_runtime_disable(&pdev->dev);
-		pm_runtime_set_suspended(&pdev->dev);
+		if (use_rpm) {
+			pm_runtime_disable(&pdev->dev);
+			pm_runtime_set_suspended(&pdev->dev);
+		}
 		pm_runtime_put_noidle(&pdev->dev);
 		return ret;
 	}
 
-	pm_runtime_put_autosuspend(&pdev->dev);
+	if (use_rpm)
+		pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 }
-- 
2.25.1

