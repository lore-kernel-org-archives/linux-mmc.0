Received: from mail-m3299.qiye.163.com (mail-m3299.qiye.163.com [220.197.32.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B373149B459;
	Thu, 17 Sep 2026 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635865; cv=none; b=btBlOISGo+lVJUdXCaiDH/vnsVoxMw6GCfQG3GVENEquwPFu7ZVr7YfiZ7YoIMWt850FvA04NXx4iyjbY0HqoRom73XhO7vbbzdZ9vNQYrAF/tf+u8gXhFVy9Q0yiMARijxFuck6o8FBcsZ6ZxyMO0lnOd/kbupM9CQ/28GB7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635865; c=relaxed/simple;
	bh=Rcrd5CQuFqJV2HtJdDxzBX0cfsc/fuUn4FclhcQuH2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=a3XhZCL9cF/R+VgC9i+lQ4FYsLtC+7LX0a5vEczS6VnWwgBvWeMWQE0M9DOkm0SgB8La8yT6eSbmzgtml7BgbgS67DfmPu0ErXwd4fgE3OXUwd51F4kAbLrM2wJL1s7N2MQczsUQlcbF3ElGlDE0+i5HpO+qS6dxOS8W9uwdmdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=T4CJ/OvA; arc=none smtp.client-ip=220.197.32.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="T4CJ/OvA"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e2034817;
	Thu, 17 Sep 2026 16:48:51 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH 1/3] docs: mmc: document eMMC health status support in mmc-tools
Date: Thu, 17 Sep 2026 16:48:35 +0800
Message-Id: <1789634917-143165-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789634917-143165-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789634917-143165-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0ae8de9a203a4kunm476cf0c89835e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQ0hCTlYdSUlIGR0aTB
	0ZGUNWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=T4CJ/OvARSknN0031K/AL9dG3zC5BKOMQKbBTUJ2HjibxEeibsv6jZtWhq+34k2OUa+m7XAduiuf82Me91/UB+Qcq4AKdBziNRpNR373m6i6H7IRYIj4XLiR6CbKCZtElhxSb/E2bQaro1OrAIUXR5qPqjbH4h6R7gNaC5QkSI0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=x9nw84dgY4KGqpe+l4fzVDV8jyMGMJi6ktFWuzjfqSw=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

mmc-utils added eMMC health status support, add a line for
reference.

Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---

 Documentation/driver-api/mmc/mmc-tools.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/driver-api/mmc/mmc-tools.rst b/Documentation/driver-api/mmc/mmc-tools.rst
index eee1c2c..728d3aa 100644
--- a/Documentation/driver-api/mmc/mmc-tools.rst
+++ b/Documentation/driver-api/mmc/mmc-tools.rst
@@ -32,6 +32,7 @@ The mmc-utils tools can do the following:
  - Write to rpmb device from data file.
  - Enable the eMMC cache feature.
  - Disable the eMMC cache feature.
+ - Print the eMMC health status.
  - Print and parse CID data.
  - Print and parse CSD data.
  - Print and parse SCR data.
-- 
2.7.4

