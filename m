Received: from mail-m49205.qiye.163.com (mail-m49205.qiye.163.com [45.254.49.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8D33CB8EB;
	Thu, 17 Sep 2026 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635855; cv=none; b=BWKaNhA4ep9cLHpwLVOA5jjS8Mm5pQrSylbwG4aZzAqDLYu93y2N3Tz/Hr4TX49gswjeWQn3y93Wu2a7c8n2KLrmn6iTru9ictdQnsGt+u2Iae4nwwqE3F7nnppIWxaDwF87391IPbsSF5eAJAFIDlpMzcomLWJZiForUF6X8KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635855; c=relaxed/simple;
	bh=NPKUt4CnVrmMs9uyt2nHM1vlDAw5As+qZj/2+325nCE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=nC3MI+ZTr1l1khiJyWJuJ/xOWN/orNlqNfAtZNMBqFHyM3zLQcIeQHeF4qnOUD6u/3JmAt+P9cRfDz2lbNCPdW11QGAc3d3dhh5IjRBBcJau0gvTyF7afOyjPp0+x2/PmksZLzTT/EaW9UoCuRllU9aYDUhNoZGl2Orn4RmKBRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=IrYqHshI; arc=none smtp.client-ip=45.254.49.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="IrYqHshI"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e20347da;
	Thu, 17 Sep 2026 16:48:41 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@linux.dev>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/3] Small improvement about mmc documentation
Date: Thu, 17 Sep 2026 16:48:34 +0800
Message-Id: <1789634917-143165-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa0ae8dc11203a4kunm476cf0c8982ee
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGR9NHlZJSBhJQh1IGk
	MaSEtWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=IrYqHshIXn6h7LdTwiGo0JpTIqqkBk7wlHL6W11rTwG8/+Ba6Y++wKsrgBF4Y0rwGSxTtL0aRR1/I7+FPkYNIuXMjGvLG8vQCQXpQEmcIXtg8L7wC8z9na3e3KjwWpyyiI35weCrt2JvJQD7lVEz78wnPor7L4+2sdsZB5AkH7Q=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Zj814F54bsRHFkOhZo0yugsb1e4YPxBp0KhSDNSGpQg=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>


The first patch adds a line about eMMC health status in mmc-tools for
reference. And the last two patches amend the stale comment and link
for both of mmc-async-req.rst and the code.



Shawn Lin (3):
  docs: mmc: document eMMC health status support in mmc-tools
  docs: mmc: fix stale async request documentation
  mmc: core: fix stale mmc_start_req() references in comments

 Documentation/driver-api/mmc/mmc-async-req.rst | 64 ++++++--------------------
 Documentation/driver-api/mmc/mmc-tools.rst     |  1 +
 drivers/mmc/core/core.c                        |  4 +-
 drivers/mmc/core/core.h                        |  2 +-
 4 files changed, 17 insertions(+), 54 deletions(-)

-- 
2.7.4

