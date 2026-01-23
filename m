Received: from mail-m49237.qiye.163.com (mail-m49237.qiye.163.com [45.254.49.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCF12FDC25;
	Fri, 23 Jan 2026 01:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132834; cv=none; b=LMuaHziVY4r/JUsLaF9ZlHgeti5bxX7sBeIrzvSVNoxPmfoYRnbF5XjGzmhZlUUpJROGAZvaQzRB5B929ft/T9EmrWNsomCSk+y1VtCkG7tIc+UPaMmbGYy/74djzMW/Wc1ZPE3jsTw2J7FmLILqO/DCZ8Rc69SamQAEwZs3DYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132834; c=relaxed/simple;
	bh=uFAZH6Q2qk2fX6HvLKYTNthtsJIvmfwg0RYw+ozAM1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RZtwJYDcDdOPHqWEm6KWqRYHF5w3JWjW4EY+rdHQdaroucGo161c1BWFf/VPy+AZKnHT12SMBscBjQiUFt6UCyanzTf0mV+9hJ6olOz0qdm5OIoXnQqo7ZbV5hqPfdyVqPS+CMdz0weYZIHyGqTEdXOrNJr8b8Iwgh6kk2pwmg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=VPM1Wwq4; arc=none smtp.client-ip=45.254.49.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="VPM1Wwq4"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31a9def13;
	Fri, 23 Jan 2026 09:41:45 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Wei Xu <xuwei5@hisilicon.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/3] arm64: dts: hisilicon: hikey960/970: Convert to use standard mmc alias
Date: Fri, 23 Jan 2026 09:41:22 +0800
Message-Id: <1769132482-177365-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1769132482-177365-1-git-send-email-shawn.lin@rock-chips.com>
References: <1769132482-177365-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9be883baa009cckunmb02720d3138818
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxgeHVZIGUofHk5CHUwdSUxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=VPM1Wwq4tE8D+ZSKDMXrXDtBj0Y6ZIPfUzLU0qfzjv+zxkGVNxr+HbZymW/qSC4s5tLDfdl/ClWV/PZK73/xA9OXN0GUPWG+j6qaJ0oBjnVouI0rY1L41alXUbV0T4k/Re/v581PTMY5wJ+cBrvqilDoLuYEo/KUewU2LavIJa0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=u5lFISpxQM5gBS3PHpmmitP2PZhVuWO2MnJkkarX19I=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Convert the long-deprecated mshc alias to standard mmc alias.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 4 ++--
 arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index ed84ab9..c6056a8 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -20,8 +20,8 @@
 	compatible = "hisilicon,hi3660-hikey960", "hisilicon,hi3660";
 
 	aliases {
-		mshc1 = &dwmmc1;
-		mshc2 = &dwmmc2;
+		mmc1 = &dwmmc1;
+		mmc2 = &dwmmc2;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index 7c32f5f..65764b3 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -19,8 +19,8 @@
 	compatible = "hisilicon,hi3670-hikey970", "hisilicon,hi3670";
 
 	aliases {
-		mshc1 = &dwmmc1;
-		mshc2 = &dwmmc2;
+		mmc1 = &dwmmc1;
+		mmc2 = &dwmmc2;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
-- 
2.7.4

