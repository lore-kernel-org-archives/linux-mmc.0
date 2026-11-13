Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604310;
	b=XwPl/2JagZjpaft4hdRDWkrvZg266HGkxPhleW13HBRzx/qhEnvOkFKDUSMGpvA2A7qE
	 rp1vH2r5EURKbdw9Xf68jiu1ag2hqjMO8+Gf5qmNsGTj/pYlXBTD7VflerEXpQjRzP31P
	 hOaoHeJnIGIEz39qnWAmpNGFsYEXxLuV174f0m/lU3cqanuRfQify0tycVUlQsjayTDLy
	 kfVEP5GByNUfTjLJjk3QUeMFr9oKexOzLsYK2sdKG9pJvn5TLWF5141kB06ZXpPFKGiBu
	 E0z2owjrGUFDpaCRC8OHjvZJ9vL63eGylOvtFJpFPTyAFdrEUNrLTd8h1WKLDhVp8iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604310;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=AcnH/jTKTxIE1YZEERyqIuGuYPlGUR+IxISmRbzT7E0=;
	b=hbcPCsetkLfajx9tYFsS7Q/SWbtpMRxIjYjVDjx4lWaUhDaK5m9Iu8jTVpI2QmL+TMRw
	 tnb5OP8tJ1w8hr1o065xeQDk8/OCEiFhHjDGziwqHtl6WOCMCOgnJ3RB9+ZtIK7bBUmCK
	 VCnEAot3unnlD2sye0wU3NfUJ7MVm9wJEfiLTUPkaR1r7YXFeasc60oyWLX6qdcjy3525
	 ysu0ozV5sbFLdDA92s/WoLoKcDi/VAZP5VoVjwksUobhIT3SYjrhyhIk80v65Y5qhQ04w
	 qcT/H7LQAC3JxA+qr5HZj7rffjEYSq4IixWDh920/mM1gphae9Sl6VWL6x7vhJCUdPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=JmUmiFgo;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0026660A2621
	for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 21:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0026660A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=JmUmiFgo
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso721526a91.1
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 13:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604309; x=1795209109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AcnH/jTKTxIE1YZEERyqIuGuYPlGUR+IxISmRbzT7E0=;
        b=lxPfLiqqBn67a951xK3qS7rBtwkxxoCZpGDuOr9ZHRKDpLctYqNMqRtPnvQDb0Gfp9
         yErYZKU8jLlWAVGIF0akvtIucaEAYXK2CVKaye3iDk/caDfmY6DJRvEd15DvIXcjlG/Y
         iZq4j8fDeXgC0FcrIljPy2y9AraTbuIckwtyEtv2U1OGbPD3cO5zZcqraBoTcLabaT5e
         JS8QO35RO3K5DrA8uLXiKWbkzm7oA3Qw/MQ9Dq6LdHeiVNltCxyMTsujxxAAaSOBexUj
         gnRoJqP/LS/MP7vQCsr/izWtYXSEhGDqY5EvarBhEf9wRep/wVILH+XpWrl9pHcO31PB
         N0Cg==
X-Gm-Message-State: APuU4Z99HBmeMefr3cKJRwKeB11wJnt48xIDGI/OLG/ArUVziEguug8U
	PUlyCNMsmaAzQvmu8zWpV6s6h9w42fHaVpMSGSxk/Dg4S3YszjCG6rb7F8VBQZ/ytzXACC/NUwo
	cIOWPx7V1TBtGZMo5WT5TeJDomPQeis1l0rAdNLE8X6SxeKZh/TGNZnRPfcPmH9NEaLhImQTFr6
	aGQU4OMZ9Pw05cxDEr8x3LWIa+pHgIOrmtwRmvkg6MdqEue4XKXaZaNLSY8DbjfAhvhTyjDur/X
	zavvR9358C1
X-Gm-Gg: AYBFou1Rl5pRz/RVyxE+Y9G4FRYhqfP8KuYVhG0ftW37S6FBmiUg3IrWPD7TJXkE4YX
	qG4kdkux1wAiXvM2HAITo9qS6N7cTq51i5QpZFjBFaI5G27SRQFG5BgNC6RhOA4TFgGb3jOLWAz
	0qGmqChOnMRbhuXro1JKv3j2W0PRrkgd4vkxHwFsqj9gFQJFUsWLgVB2u9PxMDZe+Aq4Jb46pLU
	ESqlVw13l6yiKQwxyi0A77dC9xhxYhwQV+3WONpeNsJwOq3xL9mnC7GEPPAwtElvIgU7lYEUvTD
	UqaPCPpzX3XUAPP4hjm6ty4Xrjsem87PhZEYcjb90kJIF2U6z5Cq/A73Po1E++AmdkcmmNCbHFA
	yT2zmQCwbqC1DPvY9fAcY6LNQr0+35XtnvM3jb9JsKBxKBFmzZ8i8qmAIa5/V4DKhE3i5rvc0z/
	dktBo5635XHCPume1Sr0mTn/cctSmlhgZ9
X-Received: by 2002:a17:90b:2e10:b0:3a4:acde:1e3b with SMTP id 98e67ed59e1d1-3b1b0a40386mr3486586a91.13.1794604309268;
        Fri, 13 Nov 2026 13:11:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1b24cf7ecsm2472944a91.2.2026.11.13.13.11.48
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2026 13:11:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91c046843f1so22530956d6.1
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 13:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794604308; x=1795209108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AcnH/jTKTxIE1YZEERyqIuGuYPlGUR+IxISmRbzT7E0=;
        b=JmUmiFgopnlvLG1cG13AqFS5u5rSAkANVXbzaMeifYcUFgULLslThOTmphoOTMhS6i
         lPKxKHeKIVMVYLWBMUpuayKMqrLkVJsM3E80QDLRqKI5DX8Stf1DAammXajzuP8J7sSC
         LfMTgcjpIrqKxlat6nMnNs0UG0BzBmeLrjabU=
X-Received: by 2002:a05:6214:2e4a:b0:91c:914c:897 with SMTP id 6a1803df08f44-91f24243daamr59079436d6.34.1794604307731;
        Fri, 13 Nov 2026 13:11:47 -0800 (PST)
X-Received: by 2002:a05:6214:2e4a:b0:91c:914c:897 with SMTP id 6a1803df08f44-91f24243daamr59079056d6.34.1794604307210;
        Fri, 13 Nov 2026 13:11:47 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d73206sm29027626d6.25.2026.11.13.13.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:11:46 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v13 3/6] mmc: core: Add option to keep an eMMC powered on at system suspend
Date: Fri, 13 Nov 2026 16:11:40 -0500
Message-Id: <20261113211143.3759154-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113211143.3759154-1-kamal.dasu@broadcom.com>
References: <20261113211143.3759154-1-kamal.dasu@broadcom.com>
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

As the card is neither powered off nor sent a command that would switch off
the command queue engine when the cache flush is skipped, turn CQE off
explicitly if it is active before leaving the card powered on.

Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/core/mmc.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a02b04938e1a..93bd9b44e7d9 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -38,6 +38,7 @@ enum mmc_poweroff_type {
 	MMC_POWEROFF_SHUTDOWN,
 	MMC_POWEROFF_UNDERVOLTAGE,
 	MMC_POWEROFF_UNBIND,
+	MMC_NO_POWEROFF_SUSPEND,
 };
 
 static const unsigned int tran_exp[] = {
@@ -2157,6 +2158,17 @@ static int _mmc_suspend(struct mmc_host *host, enum mmc_poweroff_type pm_type)
 			goto out;
 	}
 
+	if (pm_type == MMC_NO_POWEROFF_SUSPEND) {
+		if (host->cqe_on)
+			host->cqe_ops->cqe_off(host);
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
@@ -2193,9 +2205,15 @@ static void mmc_remove(struct mmc_host *host)
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
@@ -2260,7 +2278,13 @@ static int mmc_shutdown(struct mmc_host *host)
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
 
