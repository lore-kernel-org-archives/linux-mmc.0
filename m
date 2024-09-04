Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A811DC1A1
	for <linux-mmc@vger.kernel.org>; Wed,  4 Sep 2024 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461732; cv=none; b=JbOmYvB2Q8VhMk2f01FCXSNc4Ttve8B0/wRIcWHKc0+uMr9xpTvR09QuY6T1+nTPINajjocYEYm9sFRlfjJvPgTjLlOC4+a3PfHlGqJU7Q+e+B7Brs+QSaiTWIDdRRTCEe6nj+nVWBfmF/RmpUCFjG6QGTdu/46xGu6sPLM284Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461732; c=relaxed/simple;
	bh=5vXwqAn3Jkjo0mlxNTKkILiOqE+jnj/zRJ6IrCryjDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VtBPMJrtC2M8mJ4yVhDlaBle1a2z+B2D1pbDAO8Wm8RZV+c7F9/vBVSzovquMG+4/+scurUK+z9aek2Q7onsGe+Arfyq3I49skE8Xi0b4P7rrllNU6yopTlYJrh74z0RaFeRQKw+zVelGWkg1gNXfp8KpLTAkSTCDYzmHkL0io0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XJyt2FZ8; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XJyt2FZ8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725461730; x=1756997730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5vXwqAn3Jkjo0mlxNTKkILiOqE+jnj/zRJ6IrCryjDg=;
  b=XJyt2FZ8Q4WL7I9sy9BgLFke+me0r9XukBQ9v1IYMImxR9TDd+fZK9iW
   SLH1s86SdRe4RM4OBrC9HfPs3zmURp1ZVhbVJSwk7VXl2VZj5EnkqOs/e
   ib1oDoSfJnnqaXHKukzfWWEXG8wSitBw6ypDr9ij7uTWb2+VRkBrkJCbl
   8JVUyq+AjPT79Av8iswr8O4zX8M0pWBf4Yh4SDeJ2xHKe7YHStpnmyccl
   +AYptCUgk0h3eqzWWoypOYILQetrhHnaDV+ZkjertN5pY1rpHurX3fYgX
   jE1cnAmeUFb/aKLK9C1Mk5tpyQv9ibuZbt9BQ3WS2baaFgAClz+WXy6/3
   g==;
X-CSE-ConnectionGUID: 8wXiRTBPRbebjZKQXUUi2Q==
X-CSE-MsgGUID: JuVzRAMURz+/tnJE3OBIdQ==
X-IronPort-AV: E=Sophos;i="6.10,202,1719849600"; 
   d="scan'208";a="25940556"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2024 22:55:29 +0800
IronPort-SDR: 66d866c4_lLy+ZERhU+bxqhT/n8Qc897BUp7H5eOcGhn/+dA5n3jal39
 LWHSsFgCTornAxEb9QlG48k28sUujalQ/LVnyyw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 06:55:16 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 07:55:26 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v6 9/9] mmc: core: Enable SDUC
Date: Wed,  4 Sep 2024 17:52:56 +0300
Message-Id: <20240904145256.3670679-10-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240904145256.3670679-1-avri.altman@wdc.com>
References: <20240904145256.3670679-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable SDUC if the card responded to ACMD41 with HCS & HO2T bits set.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/sd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index eb9990d9db56..4261d3ae31ef 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1462,7 +1462,10 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	if (!oldcard) {
-		err = mmc_sd_get_csd(card, false);
+		u32 sduc_arg = SD_OCR_CCS | SD_OCR_2T;
+		bool is_sduc = (rocr & sduc_arg) == sduc_arg;
+
+		err = mmc_sd_get_csd(card, is_sduc);
 		if (err)
 			goto free_card;
 
-- 
2.25.1

