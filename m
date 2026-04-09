Received: from mail-m49200.qiye.163.com (mail-m49200.qiye.163.com [45.254.49.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23A8375F6C;
	Thu,  9 Apr 2026 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720921; cv=none; b=gy3Ao54FhSJoe1POlGUMxkTYV+NLKeawSLkLLuGHi7NbNO/+owz1ToOHlaxiJPFlEu0eAp6sq95IHQO4g+MKbwPvTCxb45UHzUIziH5Aljbuc8QRxGEzds1ewfkEq2gW2z7m2BWj0YcQoLZb6dBMdLvekCHEwOWwIZLEgaoQjyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720921; c=relaxed/simple;
	bh=5BtLsm2SeGXCKtAKReThTc05GsQs8TxJV1AxCmxf7AM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=lUeXS7YR3cQhIEq7MMV25uX9rFTYFmmVQvoGq9Zm8ft0FgcinU+INOizvP46z8KQGNCvwqQLZy0SrzQMMwKQccCnZ/hr3aJ02qow841nLk8qIzszhLQTQcSEfNxRYIk7/Jga/3TWZ+rsfhITSKn4cdT7pDqvX1WBl5juRT3+Be4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DxRPee9J; arc=none smtp.client-ip=45.254.49.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DxRPee9J"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3a14149b6;
	Thu, 9 Apr 2026 15:48:34 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/4] Refactoring to support per-instance configurable max segments for dw_mmc
Date: Thu,  9 Apr 2026 15:48:10 +0800
Message-Id: <1775720894-97901-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9d7136ddc509cckunm41b60ef14ae4f1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0tIHVZLTRlOGElPT08dTExWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=DxRPee9JSI3e/i8+L4Z5OXsXKAIldFlxKVeCzlePLCUbmSqAoHtkl1KOEb3dASOnuD5pgiQsc5a3++y6sytX8hZMGFiWNBAwRVRGQtwfZXAC0tuDYRY1KHqpTRjlXjy+dCTRwiOjM2cdYAg3EalEnWnZqHRb1gqp1/qyqkZD8hc=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=IgYKuoj9Tr1E00o/T54TT4s8JMqQLuh+986G+H0VdFs=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>


The first patch is a defensive fix that addresses a crash caused by
incorrect max segment numbers provided by host drivers. Patches 2
through 4 then perform a step-by-step refactoring of the dw_mmc
code to support per-instance configurable max segments, which host
drivers can utilize in the future.



Shawn Lin (4):
  mmc: core: mmc: core: Add validation for host-provided max_segs
  mmc: dw_mmc: Move misplaced comment
  mmc: dw_mmc: Add desc_num field for clarity
  mmc: dw_mmc: Convert descriptor ring buffer to per-instance
    configurable

 drivers/mmc/core/queue.c  |  8 +++++++-
 drivers/mmc/host/dw_mmc.c | 27 +++++++++++++--------------
 drivers/mmc/host/dw_mmc.h |  4 +++-
 3 files changed, 23 insertions(+), 16 deletions(-)

-- 
2.7.4

