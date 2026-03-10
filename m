Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF84A2D948D
	for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2026 01:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773106593; cv=none; b=RoIa5YgkvXwborMAvecCw28ypteL6R7btQPVnN5WKB4CVvqRZoHyXNXmxI6NAdNlpb38BgTjyCoKR4a8b+48KXJ0BrjGgZL2ztwOvdpO+WhQO3ZvpZwD4bUTGY4PV2TMgZSqyqJiCd4yDd54O0QBnrsXEf/GcsgFV5VgVio6obc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773106593; c=relaxed/simple;
	bh=FMHpvhw3z+aVlV/yTIg2y6NGL8YRak1TVxbVj2iz5Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VBGg8SezQqM+rYciKiKpfmelX16g/XdPTUBZCHITXK3XxzwY8JEfZAbKV1AGl0gZh6YFizoFpl6rsHplrh7Rl1hnY/95PF6SWWrQ04s9rtdVZNjf0FPkBT9tbVvrUyKJE2g8Zzx0VxZWC5Llfjemk+nmqN7WXatpGdT4YrXm8n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jJRTFQo+; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jJRTFQo+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773106580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/nQZTOpz78ockLOK6zVS8FuQYU6A9K5EX0NaEqhBfT0=;
	b=jJRTFQo+VLLGOYJ8M6cwEgkYHbEwljp9XnwJ/HT+L8tntuD8yg6yhTH+XjJHZvs9J/qiZL
	jBgX5R8MDnX1FXBrRKYDO0XigdjQpeXrwl0LdYF8Ci4D57OIYfMDI0rsnPvM4TjM48jRJh
	Jnyxgk8u/lNrFzTEBgwbwRPOsqaxbwk=
From: Shawn Lin <shawn.lin@linux.dev>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 0/2] Validate and clean up UHS/DDR/HS200 timing checks
Date: Tue, 10 Mar 2026 09:35:51 +0800
Message-ID: <20260310013553.29332-1-shawn.lin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Shawn Lin <shawn.lin@rock-chips.com>


This series adds validation for UHS/DDR/HS200 timing modes when the host
only supports 1-bit bus width which also fixes a real performance drop issue
due to incorrect hs200 mode switch code. And then cleans up the check in
mmc_host_can_uhs().


Changes in v2:
- updating the temporary variables in the middle and update host's caps(2)
  in the final. (Ulf)

Luke Wang (1):
  mmc: core: Validate UHS/DDR/HS200 timing selection for 1-bit bus width

Shawn Lin (1):
  mmc: core: Remove checking MMC_CAP_4_BIT_DATA from mmc_host_can_uhs()

 drivers/mmc/core/host.c | 14 +++++++++++++-
 drivers/mmc/core/host.h |  6 +-----
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.7.4

