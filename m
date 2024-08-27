Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1831B3F15
	for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2024 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761555; cv=none; b=rbxwY7WJauR1tna7QitEO5US2pKLe/abzSZSMDCKz66kiHGtRwYZ/JWsg/W2judKqiryP1NoqF48/+q84TgG1bAP+2s+JiMsP5Ee8iH5+ZbjTGW8uVKuNEtBOjlPMoqvYmW+yfW+FkfCxpx2Jg7qUKct/McQRtU4ZFnB8NYw1MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761555; c=relaxed/simple;
	bh=2w3lXFsm8iyuCgRvGOVoP2GOXWlNzN5mGRAn5vXNM0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oDqWUfPaZILPTycl+n5P3HavO2S8Sl2Peu8OicwQ5B3T9w8kiohLB0OIjbazvgWghp0gC9PagjTzK8xeU15ckGREKLDS4B/1YHlV4XJEuPTylmBNoeXvubHHH8iAQHnOLS8R1wfpW9X77MO9hWtPdYml6d4Rx+OqZas0mjlk0Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Eutn0rNd; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Eutn0rNd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724761553; x=1756297553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2w3lXFsm8iyuCgRvGOVoP2GOXWlNzN5mGRAn5vXNM0M=;
  b=Eutn0rNdb24BpUIeC0+k8SvX2rZip28NrB0pecCk9iJ3RFbsAk0m616B
   k+fIJKAA7TRYWz3Y6wbj9iYt4t250TlAUNRI8AO+OYn4HiLa+NHylSsdj
   GCPGs+XKnqSvGMfxV17X4Z+OiSj+CoZ/EgmnUTwvRwJzHcGFoYu16uwIj
   eHrg/lEiEAEf/VzXdGS/tlmCJiId+XdQp4BTL78hUAb8zD2joSkgS6MTI
   H7nMUxxp6Qv4Gz/AsfOJrfSQ8oTSlT/7zTe3ZhbTPxUzzIIkHPAaf5RK/
   4lHLZQG7JmVb6FaEhQ8QoQAT88RgHKcNZfk7+hM8EJhpETyUZuU008Hwt
   Q==;
X-CSE-ConnectionGUID: 5RwoswySR+OoPbZ2hPX5Fw==
X-CSE-MsgGUID: qqpO/mhBQsueJe1XED9y6Q==
X-IronPort-AV: E=Sophos;i="6.10,180,1719849600"; 
   d="scan'208";a="25318704"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2024 20:25:53 +0800
IronPort-SDR: 66cdb912_xYUxuqihdigG5BIBR9wqHaS7meopef/MQ0mT1LYpcfv+bx/
 3U0lrgf8S9DK57/hHeG2VK41tGrloIQpKVo6rWw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 04:31:31 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 05:25:51 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v5 4/9] mmc: core: Don't use close-ended rw for SDUC
Date: Tue, 27 Aug 2024 15:23:37 +0300
Message-Id: <20240827122342.3314173-5-avri.altman@wdc.com>
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

The SDUC spec expects CMD22 to get squeezed between CMD23 and the
read/write command, e.g. CMD23->CMD22->CMD18 and CMD23->CMD22->CMD25.
At this early stage of adoption, we want to avoid an amid stream of
fixes & quirks of bogus hw, that tends to apply extra logic specifically
around auto-cmd12 & auto-cmd23.

Let's leave close-ended out for now, and re-consider this should those
cards become ubiquitous, if any.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8816b3f0a312..713b22eced72 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2505,7 +2505,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	if (mmc_host_cmd23(card->host)) {
 		if ((mmc_card_mmc(card) &&
 		     card->csd.mmca_vsn >= CSD_SPEC_VER_3) ||
-		    (mmc_card_sd(card) &&
+		    (mmc_card_sd(card) && !mmc_card_ult_capacity(card) &&
 		     card->scr.cmds & SD_SCR_CMD23_SUPPORT))
 			md->flags |= MMC_BLK_CMD23;
 	}
-- 
2.25.1

