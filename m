Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248BF15445E
	for <linux-mmc@vger.kernel.org>; Sun,  6 Oct 2024 05:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728191645; cv=none; b=DKXwxuyDsB2Y4GduafX6OgmG66Ct9aBlZZrrFI9RqgX6k3yvACMu6dXa/VhOXp/PPY/5X8rNHIiHp92BbGFx8rTBS3iTBuqyLrs5Njz+wrfPOkMsPb2aYjCIPiEwZZ3j9E+wQL7yjK92m39JzXJNU43xdGiMjLqVB+4zcAKmziA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728191645; c=relaxed/simple;
	bh=Ddl+W4oMHa8wREPd+fErn50a1gEO4f0DVgR/mVsYYwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IA1RWw8EDl2RvcAWBp4ZLggvPA+LaqBr13B1xaVO+7prB4kvINqxyAhlOp4u+3AEqXkBnogmd6aT3o9qoy/w+T4fdyEKqzeWJF0rlJEKRW2yvZyioCuTF3uCjRxjOUH+NzC34OuvulDjT+7Uc7PgGAPB+H68kCXUZASl7FLHP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qXoQuL5z; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qXoQuL5z"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728191643; x=1759727643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ddl+W4oMHa8wREPd+fErn50a1gEO4f0DVgR/mVsYYwM=;
  b=qXoQuL5zOlF/P3tPO5YcMMTA0FaRwwxDhOI4SC4nQvSAbQT31cVKhBHR
   sTWtXD0/HlBoBSODbaPvSTgIRquwDy5P4erf572BefKLO+egIQdGHHukb
   44SKwVYY1his3O01a40wJKo99u5+jgLBZlY27xAJkRGXnylQdrHn3fRvx
   tH6RUDIx6Bs1kQSjdBdKrHHBuke2Yau03HQeCzdmQSBBwIg9+ndPWM3Lo
   DRt6mNcgL/HTOTjV2BEKizg07zlXXCwdcxTqh4YFUWgIqBWDRevFqRFMS
   aobunpaNecrS0/DnLNuCm5AGzZ2nol4jxP8/PbRMmEwRxgXEQDyKWt/hn
   w==;
X-CSE-ConnectionGUID: R3vEcRuxQ5uuoijPQP+PWA==
X-CSE-MsgGUID: O5DvCfKRRwmAJTpvtHGcvg==
X-IronPort-AV: E=Sophos;i="6.11,181,1725292800"; 
   d="scan'208";a="29406956"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2024 13:14:03 +0800
IronPort-SDR: 67020f9e_Pgcrw8NmZGStJVEe9JpBSx1kNYyAF7cvyJasej/7pjbpw7K
 xBqMiWeXu64hqH87sNudNy+kbXIILPqU1G9BGhg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 21:18:38 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2024 22:14:01 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ricky WU <ricky_wu@realtek.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v8 03/10] mmc: core: Don't use close-ended rw for SDUC
Date: Sun,  6 Oct 2024 08:11:41 +0300
Message-Id: <20241006051148.160278-4-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241006051148.160278-1-avri.altman@wdc.com>
References: <20241006051148.160278-1-avri.altman@wdc.com>
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

It also means that BLK_FEAT_FUA will not be used for I/O, but instead we
will rely on BLK_FEAT_WRITE_CACHE.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ef06a4d5d65b..f4817ea3017b 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2547,7 +2547,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
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

