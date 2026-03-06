Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDD3369960
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801325; cv=none; b=RrUiVcW0146BF1xHi7+iGKY82zeMOZ/ET1RY5hOxYJrNxzkT5oICrieZI6CMg27LqwvikpSKwfzrqRWwLK4QtFVpQqtdHOBUFlfDZRCcWGVMCgFgJb4uxomWoPjAMvwQGi4ajN5DrNBvJYurUXBaU8/8gvqtchBkGjWEVbuKL7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801325; c=relaxed/simple;
	bh=RhjhItShQmA4PB9x29AC0pD31I8aw8/RrGGJ/iAOhWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CjA9ugGPD1Lu8SGWdzpd3CX6x9ZrrNsj+yz7aUxPhcYHfjtfb3rnIuwSH6rqSLpCOHTljUGzjQM9/aRn6TqgONPIm53S+p0UEJAYGQzdi8XgSxE6SHxhgCDhIR2bZI2BrAVCnanQuK1w73SngGPxSt4OjFwynYVuz5w7UcC8x5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m97hEnGQ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m97hEnGQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772801311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wQ8cgLGAdaT9DFp+mXWrydxUg79fT6xPQFKjqSs2RZ0=;
	b=m97hEnGQNY2xcp7pxzCWkfPiSp2w4tNO9Mpiy0d6uWotyudUfdaHm7L5yIc3TBRHGycjh+
	eeWU5NdyMiILZaigxLJfNJ6QqlZRQ4VXWdVqr3/1e2PU+J6bCc/aozK8WzTQ4lTIQt5DOA
	fvDeI7qsZWqRUfEHnFK50Ct3OBs9U7A=
From: Shawn Lin <shawn.lin@linux.dev>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH 0/2] Validate and clean up UHS/DDR/HS200 timing checks
Date: Fri,  6 Mar 2026 20:48:10 +0800
Message-ID: <20260306124812.332098-1-shawn.lin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


This series adds validation for UHS/DDR/HS200 timing modes when the host
only supports 1-bit bus width which also fixes a real performance drop issue
due to incorrect hs200 mode switch code. And then cleans up the check in
mmc_host_can_uhs().


Luke Wang (1):
  mmc: core: Validate UHS/DDR/HS200 timing selection for 1-bit bus width

Shawn Lin (1):
  mmc: core: Remove checking MMC_CAP_4_BIT_DATA from mmc_host_can_uhs()

 drivers/mmc/core/host.c | 9 +++++++++
 drivers/mmc/core/host.h | 6 +-----
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.7.4

