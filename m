Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426285;
	b=2QuEeADnk0+SeYtcIj/H1MV23i8HggGvU59LbRO72PphRe8G+aijMIxvxea2XG4y8Nas
	 KOQ0V/LLBt5FbUBbVv4MinqoEyknLCqXQs90eTM3ItpTIv4D54EvGhe2um/olmQ9Ezu6W
	 7WBuKHBje2iGp/5F62MHT9PASCbrCu89QPJF5E6VjTqiggtktxM62NoiaKA4PALSoEGgA
	 wGscokww6DP13BiFo+iEkJMQf/0chLRztl0HlWpRMdrxTcrm2R3uRrzFcn+JkPFooJXV1
	 +TTUpwJY539tNTmzHCZ1pPJz660PgcDGZTTD08LCjy6xBy2sxAJn5UV1SF8lYv9+2OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426285;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=nfKZgcPVQuoQTMyJJaxHXbeJusNdz3UeR9BUP/GfHdU=;
	b=2TmmVmNR5rjZ8Awt4lVwhNEbRK2Nw5eSqLCZDFCJTIm3GWbhHXdyBQdrOThJIhqZqWp2
	 DEzxjHiwHi2AWjFFLBr9jTrKB8l7r6Vz/4sL0sbF3f8pL4+Bn1h2w0jkPhQDA8FchdWYT
	 b5zy9xbuNv6vt7pLlvuWprP0QTbBYk+6odEyE+JcJa9DKiM1YDVejo7Y2trlGBusgDeNR
	 by6mbH5RenkWZCVg3Ndgw4xl/pEDzSfKrkrYs3sjqN08zqLchzEpwHDmok5mjfqqJzX73
	 gSZWGOvz+HjuP1manpliPKs0yD1nvzEI9wVgqlTmcsdGxyBzbV2m85QzlPDSr6+Uf4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RiTRq0qO;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE6B606A89C
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 19:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CE6B606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RiTRq0qO
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cdb9f760337so100194a12.0
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794426284; x=1795031084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nfKZgcPVQuoQTMyJJaxHXbeJusNdz3UeR9BUP/GfHdU=;
        b=a5FhjbSx2419qAq31XOuenmHoWupmETmA3+onKYolDmxsfx6ry+Zwo/7V4QK9KJjBI
         S42yzub5mgsjT1f+7r+WQ9r4GCSZLJHpCfhZbHCCHrv3OGT/U/F8H/z9MT96EsoyTF4x
         e+kRxNzEA6GFCo5zVvL/9Cl7qFbj6al62XLwgRi3g70HMCwqhmCjdg7nQrU/zEBB58Np
         hCsQhZu18aSWbNhh+lV6IXjy7qAK7JaiU56vrwyL5eerUJcEPNAFPRmVX7J6bF4ugCB9
         GoOxLPV/iVF9Y7Hi5ettyhdv7T7GifiMofVjU0OMTpZX7yaGI+DLctNttcuF9I037483
         78Mw==
X-Gm-Message-State: APuU4Z8Gbc4oX7x/1CYrlakpMQX/UgfVibuPttix0NwRJZZdDUNnEuav
	QpjbCsAeaIh8Ka9r6f0ff/6fNe/ukxP2YEcxgzkLncpbNlpkPQLrXw15xTWqg7DPZLrCiDVxCNI
	L849jsosRSN//W/vAI4ACZnwMuel0TDskAMz8GgHlsL3cGeUhvEctEbsicvLuWsk0dLIJK17kH4
	d4xmCSL9LdhFhi4LGTFAsSfTv46K8dhpp9f783pkq3FpxzTQbHg7tdQW1HLO8TLLZrR4sGE397Z
	nMlOpUjD46D
X-Gm-Gg: AYBFou3laD3S4pT0sHx3RYP8nVX3GYTsT177EEpXCcNnkTR24HV5tgn84d2sYJmZUqg
	6vKP9BPeTfCx7gIeQZO98fRwAVtJ1hFPGjVcr+5bSclnNQhuDJc4fzOFEn2FLShv24/Cz7sZsTE
	A3Tw63QwSTd8RC27pMgVvs81sDuQ0IfZqh/Dmm/OiVUyvZ/rKpFeGZa5rrTDhG51ZTusZPmxakK
	Gbu9X839EDR6CQ9iy1CaJD0VMcRUQp5q6w3ZTtZ9TOuLpxY3vhkvV40I6LX4NdaHnVfiT1IUfym
	gf574p4nEFtJCENC5oMwQp8aM3T1iuhTh9eKXFsYznm4cX+svh4yqBhk1GXmKM4GlCLlN1iqd8C
	fgHnXFCO5ysx8RY/KSwBwj5yITyBuJWDzm5r2BLXFK07o7DKN1Oi0sBgbiWeCVSqD//tew12jrD
	vV7OHfGylsiRif0LpxDXqprHclKeMqZ5aY
X-Received: by 2002:a17:90b:1642:b0:3b0:9409:6969 with SMTP id 98e67ed59e1d1-3b197caa45dmr250232a91.19.1794426284421;
        Wed, 11 Nov 2026 11:44:44 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b197c12526sm281836a91.2.2026.11.11.11.44.44
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 11:44:44 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3724667bc16so96594eec.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794426283; x=1795031083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nfKZgcPVQuoQTMyJJaxHXbeJusNdz3UeR9BUP/GfHdU=;
        b=RiTRq0qOuv7i2ilFPrLjD4LOFBfI2fgrcF47WnK3oWD1LPGEiOWDPvNwV6VKRgyF9Q
         PqJMAlQ+E8KwaYfnAFOFlJEQmSFagCcGnowIlMaUFhgdJmL5ncbwyLQ0d3GlUimoyipd
         uz0Vlx1eJjQ0rZm0qPbczXro2aU4Sx5fuFliw=
X-Received: by 2002:a05:7301:d183:b0:371:32df:5ee2 with SMTP id 5a478bee46e88-377e15f0744mr486483eec.16.1794426282254;
        Wed, 11 Nov 2026 11:44:42 -0800 (PST)
X-Received: by 2002:a05:7301:d183:b0:371:32df:5ee2 with SMTP id 5a478bee46e88-377e15f0744mr486429eec.16.1794426281449;
        Wed, 11 Nov 2026 11:44:41 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm17948013eec.11.2026.11.11.11.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:44:40 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Shawn Lin <shawn.lin@linux.dev>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v12 3/6] mmc: core: Add option to keep an eMMC powered on at system suspend
Date: Wed, 11 Nov 2026 14:44:23 -0500
Message-Id: <20261111194426.1652644-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111194426.1652644-1-kamal.dasu@broadcom.com>
References: <20261111194426.1652644-1-kamal.dasu@broadcom.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>

The DT property keep-power-in-suspend, allows us to specify whether the
platform is capable of keeping the power to the card during system suspend.
Up until now, this has been restricted to be used for SDIO cards only, but
let's add the initial support to allow this for eMMC too.

Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/core/mmc.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a02b04938e1a..c936272bcd81 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -38,6 +38,7 @@ enum mmc_poweroff_type {
 	MMC_POWEROFF_SHUTDOWN,
 	MMC_POWEROFF_UNDERVOLTAGE,
 	MMC_POWEROFF_UNBIND,
+	MMC_NO_POWEROFF_SUSPEND,
 };
 
 static const unsigned int tran_exp[] = {
@@ -2157,6 +2158,15 @@ static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
 			goto out;
 	}
 
+	if (pm_type == MMC_NO_POWEROFF_SUSPEND) {
+		if (host->retune_period) {
+			mmc_retune_timer_stop(host);
+			mmc_retune_needed(host);
+		}
+		mmc_card_set_suspended(host->card);
+		goto out;
+	}
+
 	if (mmc_card_can_poweroff_notify(host->card) &&
 	    mmc_host_can_poweroff_notify(host, pm_type))
 		err = mmc_poweroff_notify(host->card, notify_type);
@@ -2193,9 +2203,15 @@ static void mmc_remove(struct mmc_host *host)
  */
 static int mmc_suspend(struct mmc_host *host)
 {
+	enum mmc_poweroff_type pm_type = MMC_POWEROFF_SUSPEND;
 	int err;
 
-	err = _mmc_suspend(host, MMC_POWEROFF_SUSPEND);
+	if (mmc_card_keep_power(host)) {
+		pm_runtime_resume(&host->card->dev);
+		pm_type = MMC_NO_POWEROFF_SUSPEND;
+	}
+
+	err = _mmc_suspend(host, pm_type);
 	if (!err) {
 		pm_runtime_disable(&host->card->dev);
 		pm_runtime_set_suspended(&host->card->dev);
@@ -2260,7 +2276,13 @@ static int mmc_shutdown(struct mmc_host *host)
  */
 static int mmc_resume(struct mmc_host *host)
 {
+	if (mmc_card_keep_power(host)) {
+		pm_runtime_set_active(&host->card->dev);
+		mmc_card_clr_suspended(host->card);
+	}
+
 	pm_runtime_enable(&host->card->dev);
+	host->pm_flags &= ~MMC_PM_KEEP_POWER;
 	return 0;
 }
 
