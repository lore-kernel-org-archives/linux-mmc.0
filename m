Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344BC1B3F15
	for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761592; cv=none; b=NarhSxPSj4Ie4kM6C4QGdcmm2DFkG3jVW5ZDHXH26/MZ2/4QCSyEDViEdeOOhuRwwu9lSk4KcZ+vI6LZ4fTPjnP41Ck1+pf5mCGgWWc4Uh3sM3gGMshpTCJk4+/6gs8RFWrLje87Pt6KaxFU56fsNflFYsLynPgyY7LzB9NaPUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761592; c=relaxed/simple;
	bh=n4BvqYcyG5fJisECdT2jrsquwHyCgbpgYrJUh0vWBrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N78Gp5fMq1AJNl71gytFwFV7jFLG8VmD1Tq8JMczw7BZI8lcXMbj4zT/Sjzs5bE88QdPu11ueUgn3MbzEvz5hErR31R0nMaqfwWHPtjoEP7cwuhhcnQphvoeWBLEFIL5VjZchrjPnhx6+Szx9clhhfzJtOmc2HWQzCgw/ONAYEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IU91r7Ri; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IU91r7Ri"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724761590; x=1756297590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n4BvqYcyG5fJisECdT2jrsquwHyCgbpgYrJUh0vWBrw=;
  b=IU91r7Ri/KrDXE4NXEhZVb28mChDAmqsK/HvBW67ex6IJQUvP15gFM0h
   jQ0i3o6pDJRJ3I4VmeWQgBJ1KipvefUKj/Q62FoFv2TteMtYdLqUFWqNy
   xyXoUnSvTDCau3ercGFDT74mdwh+yLKW/SS1lKgLFLQLm6K8Qm+gkoh8e
   p41wHAhuYsrFlSFgTOF4Uzortc506f70AjWH1w0bK4IuMwrwQEeww4j7x
   E66jUK5W1AHsGwt1IiyaKU7+Y+iNf+org1kSeNYrDAM6BycSIFoCEhLga
   xbNJ9WVEqO5P2I1CMqfjaRMk9IVY4Fc4PU5vbPzJDOwpMZZzoeM/WYmr2
   w==;
X-CSE-ConnectionGUID: FcCv3K1kS0C+1wKtmWlVnw==
X-CSE-MsgGUID: r4/fMp7QRZGEW1QrEU9MeA==
X-IronPort-AV: E=Sophos;i="6.10,180,1719849600"; 
   d="scan'208";a="26277190"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2024 20:26:30 +0800
IronPort-SDR: 66cdb938_HSBnZMEBpAGenVDBvzAQmHboUu26E+DB+WOn5hEL+zBlVBq
 Qwqso7E91sTJ1P2NLVdCixcbajXvktf8SPuGFig==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 04:32:08 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 05:26:29 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v5 9/9] mmc: core: Enable SDUC
Date: Tue, 27 Aug 2024 15:23:42 +0300
Message-Id: <20240827122342.3314173-10-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240827122342.3314173-1-avri.altman@wdc.com>
References: <20240827122342.3314173-1-avri.altman@wdc.com>
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
index 3df084541e94..616bd7d5915d 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1461,7 +1461,10 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
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

