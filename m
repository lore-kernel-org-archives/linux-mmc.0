Received: from mail-m12796.qiye.163.com (mail-m12796.qiye.163.com [115.236.127.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E755226ED40;
	Wed, 30 Sep 2026 05:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744915; cv=none; b=a7u31euYvM0NfZB0WYQNIieEh0yBf/VkIrZO+nu9lzTf2pSC/OLGguq8ctnK9CO4Wk60o0jSvXgI4Epfa9m6Zvn4n0ObAUpf7pAigws9m5YhqKJgs9JUHCCt/UkAoNh1a3JRTDpPPZuGXGTPn+08orO54dJRv6jPkArGCj/jgyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744915; c=relaxed/simple;
	bh=hKqdd9fnY4n5Ik00IyOXW1ZqJA2ikc3UxMVhcyDaVqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LSeR2YFHSxJ4DLq7GYenR6A+C+gUG3ZcnRUF0xFXCp/JRTx83qWKI1kgEwMNAfdmMtPHOSvMpcYV7ZierGyb2kgEPB4ORI8XkEYzSExMgu+pAW3Gob2PrAw+NBEx8/Qeg6CGIpn5bUGtUxu7yhMDjpy3NW5PTKRvz7Pp0S2tRek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bScb3SVc; arc=none smtp.client-ip=115.236.127.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bScb3SVc"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f96815d9;
	Wed, 30 Sep 2026 12:32:49 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] mmc: core: Use the ios vdd when calculating vqmmc for 3.3V signaling
Date: Wed, 30 Sep 2026 12:32:31 +0800
Message-Id: <1790742751-245571-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1790742751-245571-1-git-send-email-shawn.lin@rock-chips.com>
References: <1790742751-245571-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0f09630a603a4kunm0766139d8bc9cd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQhpOGVZDQx9JH0NOT0
	MfHkNWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bScb3SVc5+/Xds562ZGFz7rUGp6HCMI2ylcY7JMeNRPhOP20mIbVZ5GOhMVnpikvXpFl09IApO3+nI+o9p0zTipgok84Ea/t493tXgBVv3MCQBrI1gW81kS/ZD8ycXZz+DHu3A/QK69Qwsr9j6E3UNT6DcgReXb1D0wDvv5fgao=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=WdvLlX4wAGRqS3FOyqc6cjb1armaG1S8zhbytmM92Xw=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

mmc_regulator_set_vqmmc() takes an ios pointer and switches on its
signal_voltage, but the MMC_SIGNAL_VOLTAGE_330 path looks up the VMMC
voltage range using mmc->ios.vdd instead of ios->vdd. That mixes the
ios passed by the caller with the global mmc->ios state, which do not
have to agree.

mmc_set_signal_voltage() only updates host->ios.signal_voltage before
invoking ->start_signal_voltage_switch(); host->ios.vdd is refreshed
when the power supply is (re)configured, e.g. in mmc_power_up() after a
new OCR has been selected. A host driver switching the signal voltage
for a vdd that has not been committed to mmc->ios yet, or passing its
own ios snapshot, would therefore get a vqmmc range computed for the
previous, stale vdd instead of the signaling voltage it is switching
to. With a stale vdd of the 1.65-1.95V range, the computed 3.3V window
ends up with min_uV > max_uV and the vqmmc regulator is never set, so
the signaling switch fails.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/core/regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index a85179f..c553356 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -197,7 +197,7 @@ int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
 		return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
 						1700000, 1800000, 1950000);
 	case MMC_SIGNAL_VOLTAGE_330:
-		ret = mmc_ocrbitnum_to_vdd(mmc->ios.vdd, &volt, &max_uV);
+		ret = mmc_ocrbitnum_to_vdd(ios->vdd, &volt, &max_uV);
 		if (ret < 0)
 			return ret;
 
-- 
2.7.4

