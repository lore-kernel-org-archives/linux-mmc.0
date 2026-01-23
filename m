Received: from mail-m21473.qiye.163.com (mail-m21473.qiye.163.com [117.135.214.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870E837F759;
	Fri, 23 Jan 2026 01:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132848; cv=none; b=GasEDAmrTWV4e2jeWvPIhGPmePobHbGhX8QqIljuu/CyWPB9YlzIyvZkOUiuFc9yFp9AMX9+/hyQmtdGq9EsCNCRbyO7Zp4G24f2hIO2N+1P4cM8xfD0knEcFebJKKSF8nY5lIwcaVUHDCuWO6DDLse8wcJ3fATo3uPeZhRLkfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132848; c=relaxed/simple;
	bh=FqLG2JCZBAMer8wKSOyAchTbabBe/VjQN7w6wLYxZXE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=auhmXOuFwsaE0kcXE/QcBhXXk4kZ+PxOpFWRAhCngd0CPUhmzGkqXwWD3M64RCVPbkJ3Tv3O53UeSpwkGJ7LaoxPCWMlotBKPsSwMnX0iMvBXRU3FyCKnzDW0LiY7e4oejtrGUglMAkcZ1qIxkGL2lwGbLLB6x53e5l6Voclc4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=NTi4ZpTi; arc=none smtp.client-ip=117.135.214.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="NTi4ZpTi"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31a9deeee;
	Fri, 23 Jan 2026 09:41:37 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Wei Xu <xuwei5@hisilicon.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/3] Remove deprecated mshc alias support from dw_mmc
Date: Fri, 23 Jan 2026 09:41:19 +0800
Message-Id: <1769132482-177365-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9be8839a5c09cckunmb02720d31387b4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlMSFYdGU4dSR1DHk5DSE5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=NTi4ZpTihGfIfaWGUUMs5hn9Q4w5oWm4oZabuYzl/FC4C4Q2HMgKuv9Klap/yRNx9IMIyMQ0BAElY9XU2chKVUxV8r0zPfnA9ZUxfYbTkbanNV0KELIEYlc6CirBDmNdRnYkCZudOlYINxLGCe/f4QEhDGuFW2v/65QT/H+eFPI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=wouslL8DF5AQTwxxssNeLvOsURFTo7wi5hiAkNEzhOs=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>


The support for the mshc alias has long been deprecated[1], as the mmc core
already provides standard alias support for obtaining the controller ID[2].
With mshc aliases removed from the last Rk3036 plaform[3], the only remaining
users are the HiSilicon hi3660-hikey960 and hi3670-hikey970 boards. This patch
series removes support for mshc from the dwmmc driver and updates the DTS files
for the hi3660-hikey960 and hi3670-hikey970 to use the standard mmc alias instead.
Considering that the hikey960 and hikey970 are open development boards, users are
expected to use newer kernels, and the need to adapt old DTBs to new kernels is
relatively low. Therefore, backward compatibility of DTBs is likely not a major
concern here.

[1] https://lore.kernel.org/linux-rockchip/20211124184603.3897245-1-john@metanate.com/
[2] Documentation/devicetree/bindings/mmc/mmc-controller.yaml
[3] https://lore.kernel.org/linux-rockchip/c6feab79-5b73-413b-a94f-9d1b2fa6df43@gmail.com/



Shawn Lin (3):
  mmc: dw_mmc-k3: Remove mshc alias support
  mmc: dw_mmc: Remove mshc alias support
  arm64: dts: hisilicon: hikey960/970: Convert to use standard mmc alias

 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts |  4 ++--
 arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts |  4 ++--
 drivers/mmc/host/dw_mmc-k3.c                      | 22 +++++++++-------------
 drivers/mmc/host/dw_mmc.c                         |  9 +++------
 4 files changed, 16 insertions(+), 23 deletions(-)

-- 
2.7.4

