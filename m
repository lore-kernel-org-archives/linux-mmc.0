Received: from mail-m3272.qiye.163.com (mail-m3272.qiye.163.com [220.197.32.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAA339DBFF;
	Tue, 31 Mar 2026 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944008; cv=none; b=DeN8HM3SP+lMg902NNdGPkSZ6V/Tv8mF5aqatvTqwgcBJXlQpc9B9zFPwEU4VxhpIkReJGIbl+1ihu+/fkOFNnubgtmVGaBwQivLf2cpGJvI7O5F4SyI4IBuZvK0ydpRACGnUQE8Qam4fUYfAq4pQZd3O3m2hW3KlXOSsrnTHwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944008; c=relaxed/simple;
	bh=6EMYVWONJr2PXZlyXyULhoiEltB8K+QK6GrkyHA6TRA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=C9X6syYN/aeDLKMSxirAHgmyeygcR6DOXYTz9wXoydGRg8zIXWmMM0mpe9+Wp5jX0rNNO8+689bKmgJsHIYNPl9Q/81yymMnv+FCv90BheoPi2UqvR97TGInrZCQwKUSRgOE2gOEt/RTOlxrKfY6kknpXIOz1bu7wEcwODXjYiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=A+gtbKTJ; arc=none smtp.client-ip=220.197.32.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="A+gtbKTJ"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 38f5d4bed;
	Tue, 31 Mar 2026 15:54:54 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/2] Improve request handling code flow and clarify function naming for dw_mmc
Date: Tue, 31 Mar 2026 15:54:48 +0800
Message-Id: <1774943690-219754-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9d42e36cd709cckunmd4b3018ef13882
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0xJT1YeTB8dGR1JGktPHx1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=A+gtbKTJlh9jaYuf1WUxLd2FvlYGpOGX2zVppw+TwMe6hwjlz+i7rrQX3MgDkkDWglMno842VYBRM81v9Bthq0/ftAev0WHwu0uW4FCsARgRzmaDF2aj6XkFWMXa61e9YFDV75pSdRVxyIBQStx1ocxY0wTjb4uYnVfOAf+KLDY=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=gSnH4so2PSfGSdCv2SFzRIteYL3c5ClUqfvuMeQpeU4=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>


This patch series aims to simplify the request handling logic and enhance
code readability in the dw_mmc driver by addressing suboptimal function
naming and unnecessary abstraction layers.

The dw_mmc's request handling routines currently include multiple functions
with confusing names and redundant responsibilities:
- dw_mci_request() serves as the mmc_host_ops entry point.
- dw_mci_queue_request() was used for queuing requests, but with the removal of
  multi-slot support, it no longer performs any meaningful queuing operations.
- dw_mci_start_request() acts as a thin wrapper around __dw_mci_start_request(),
  adding unnecessary indirection.
- __dw_mci_start_request() contains the actual core implementation.

This naming hierarchy not only obscures the true function roles but also creates
a misleading impression of queuing behavior, which no longer exists. Simplifying
this flow and aligning names with actual functionality significantly improves
code clarity and maintainability.



Shawn Lin (2):
  mmc: dw_mmc: Inline dw_mci_queue_request() into dw_mci_request()
  mmc: dw_mmc: Remove dw_mci_start_request wrapper and rename core
    function

 drivers/mmc/host/dw_mmc.c | 58 +++++++++++++++++------------------------------
 1 file changed, 21 insertions(+), 37 deletions(-)

-- 
2.7.4

