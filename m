Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604315;
	b=Zi5dNxwd+sbvh6zGzUqZHfe3SrT5Bul19sLCMkRjEsZRg1SZPjd/QHfzAW8IcR73UciO
	 yk/4m29Ph4o8wOOd/Zko5QnPcR2ah82NueC5irum4DZZI6cOHWpDuj5BCe+XDH0CmfyXY
	 yzxr4TDRcKr8g/wbtCcdNSCxgXFSSUor4JEhLnDX4GPbyq4j/hBjivQ+lbhKDn73qI440
	 R/VvM80KcwvSiBd5L+060Hgeck+wNCTSubqhB643/EOKclYeRkoqklqvVwhynxPvAM4JV
	 1wwGmPtDDyi5NgDjAI5BeUy7kAheSgC1YXyS1ACxgGqIgjUwqKR0ouF2gf4undyPZ5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604315;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=U89Ri6qe++/23rqNsp5hTmALdgYlvp+BVbZWrThohE4=;
	b=1M6a6R2iblEInrjlfLhvFyMgxWO7NZbGjrZfeOgxTGkq0mbF9NX/yoZ6+Eu+4vVDDEAZ
	 RzcElJpOfMGUBVf3BUB8WDo4sXfdPmgVP3MOpK5IopwJFR7S4vRLsx5H2VbfacFnTu2WG
	 s5kyv00WaDU1YU9kr/4H8usdtg228Cfd1pM3an34J3rK2JTAaSydR3NguOeJkSOZM1OTy
	 vkRF47LVgpdsv0VhU3N6lF3IfPTxyM4gkWtQZ+7XwQDlYTA5kDulEHVOMgKp0FDthtp9e
	 EYjTavuf+4DdWAdozOOoXLjqpfxc1JAvoU/ggDxeA6T/YjMsjhZZGWAzmaWyNq9R3+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="T8/zAGA4";
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D21A606A8AD
	for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 21:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D21A606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=T8/zAGA4
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so2656741a91.3
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 13:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604314; x=1795209114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U89Ri6qe++/23rqNsp5hTmALdgYlvp+BVbZWrThohE4=;
        b=IQzJZXdRdvTmSB/TWgpyY6Adn9Z8EcCjYd5FJs2jdGcW9a27d+JnmfARpbmPg7QHdf
         G/fuhoJ42F7RsNkfZzSbsuue6Fu9XfI0vKHVTWISbB/7D5WTCFMe1JTD3bkIs2IxOGgM
         iMeL6snM/gYrxdKBKYUQQgWFq4IPKR6eahPKGJ5M6HDoEnpj7dKMyFCyrzdkOWe28rb/
         cXpAnRGr9o/F367IDg9kRnPEzeb0PY22gj1qt065ZmlpSQut5clbWBdKbYqz+LcxXaW0
         BQ6tGUd19SZgLtpJwgziNs+UZe239HiEn0mdNDudF7a2guyvvopIeeHhABJJzdhGsA8E
         kW9A==
X-Gm-Message-State: APuU4Z+IZnzaQeN4Y0NEspWU78IrqVuVD1Pg8e27EWbTH/PMezb+41Sv
	Rn5penLZaP1/UcUrhu1TO0yPDsrdPzMULPyCU+QBInR3E6WL4Cus2SB22dN6bVSRAYrQAPowvv9
	bwEnhrimhmEMoaMRai1O+zo4KL4u6tPX/fg6OT5hOgLvv+nm+9KnGB8eQi6IDgFvifjmn6ajB5N
	5FvYqxMLcEfhUkZSKgGClKnTPNsZWG9AscWcrh4w6bQEcdJYAP5WGklZQU4vNnZJk5hhm/Iv3Vc
	N33PNzKPHrA
X-Gm-Gg: AYBFou3+m0JktY93OrvxuyVaiaSRRX8aHLizHEljnYNcbMrcrrtJuifi+eKa3pNtudJ
	c0R17RTqB9SZ91uIqNS7u9LQWdPu8UTTQZKajjo4Fo9/su2PvL0YvwPhP4+bMTuoPRvG7j+QSoi
	nXn2NxqVu8Blc/sGAimMlrfP6wDILELfZi/mA+2X+DqVKgaGAIYDsfTwNb5YCsp8VEjJu16al//
	RLYOBEEsuhCelZ2jyCNeVHupAOJYnqNJjvTEEeTSVh4hhPGYhHM8Zbv/s4rwdMiaB+N2ET4itPD
	tRohRocOjgr0nCfSahpU+qHsraDjM8D1uqc3yC6sEXhYRx19TsiSaf6XfaeqNOC5cgOZX6Ro786
	0dIiAEsuE9FH87N1wLKLrsNtth2P5rU39lMIAGy8XS8m9UFljLf5VG4tgwlp8o2TIE5T/kNOxp7
	q78iiLKxdMtjvA+G4UK84WhVaPHnhAeCL3y5Q=
X-Received: by 2002:a17:90a:f947:b0:3ad:ce24:acfa with SMTP id 98e67ed59e1d1-3b1b0b55384mr3571656a91.20.1794604313945;
        Fri, 13 Nov 2026 13:11:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1ae96f125sm5234722a91.4.2026.11.13.13.11.53
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2026 13:11:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91eee6fa56bso15785166d6.2
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 13:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794604312; x=1795209112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U89Ri6qe++/23rqNsp5hTmALdgYlvp+BVbZWrThohE4=;
        b=T8/zAGA44oFxm+nLGnEWFvUswo7MeabBPx75/wQGUllHQuDl2xDXOaioKEFt+S5qQU
         L5TmNFoftFfwmaDcIFFyyWqVMCQ/vS1iiBPl3jOwIn5UwasSVst3HM24sNTUVka00gs9
         pEep8ffXk7HWtVz573EHVMSP1jTf0NADQgObU=
X-Received: by 2002:ad4:5f0b:0:b0:91e:9db6:c324 with SMTP id 6a1803df08f44-91f2424856cmr64949346d6.40.1794604312368;
        Fri, 13 Nov 2026 13:11:52 -0800 (PST)
X-Received: by 2002:ad4:5f0b:0:b0:91e:9db6:c324 with SMTP id 6a1803df08f44-91f2424856cmr64948666d6.40.1794604311556;
        Fri, 13 Nov 2026 13:11:51 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d73206sm29027626d6.25.2026.11.13.13.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:11:51 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v13 6/6] mmc: core: Add support for resetting an eMMC at system resume
Date: Fri, 13 Nov 2026 16:11:43 -0500
Message-Id: <20261113211143.3759154-7-kamal.dasu@broadcom.com>
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

The DT property reset-card-at-resume specifies that we need to make a reset
of an eMMC card at system resume, assuming it also has stayed powered on
during system suspend.

To implement support for this, let's start by parsing for the new DT
property and set the new bit MMC_CAP2_RESET_AT_RESUME if it's found. Based
on the property, we must also set MMC_PM_KEEP_POWER in the pm_flags for the
host, to keep the eMMC powered on during system suspend.

Finally, to manage the actual reset during system resume, let's extend
mmc_resume() to support the needed behaviour.

The property only makes sense together with keep-power-in-suspend, as the
card would otherwise be powered off and system suspend is refused. Validate
that in mmc_validate_host_caps(), to make the host probe fail upfront on
such a misconfiguration.

While at it, claim the host around the reset in mmc_resume(), as it sends
commands to the card, and propagate any error from the reset so that a
failure to re-initialize the card is reported by the resume path.

Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Co-developed-by: Kamal Dasu <kamal.dasu@broadcom.com>
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/core/host.c  | 17 +++++++++++++++++
 drivers/mmc/core/mmc.c   | 12 +++++++++++-
 include/linux/mmc/host.h |  1 +
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 8e9e61839198..94c8ec81ee08 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -48,6 +48,14 @@ static int mmc_host_class_prepare(struct device *dev)
 	if (host->bus_ops->pre_suspend)
 		return host->bus_ops->pre_suspend(host);
 
+	/*
+	 * If it's required to make a reset of the card at system resume, this
+	 * indirectly also means that we must keep the card powered on during
+	 * system suspend.
+	 */
+	if (host->caps2 & MMC_CAP2_RESET_AT_RESUME)
+		return mmc_set_host_pm_flags(host, MMC_PM_KEEP_POWER);
+
 	return 0;
 }
 
@@ -375,6 +383,8 @@ int mmc_of_parse(struct mmc_host *host)
 		host->pm_caps |= MMC_PM_KEEP_POWER;
 	if (device_property_read_bool(dev, "wakeup-source"))
 		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+	if (device_property_read_bool(dev, "reset-card-at-resume"))
+		host->caps2 |= MMC_CAP2_RESET_AT_RESUME;
 	if (device_property_read_bool(dev, "mmc-ddr-3_3v"))
 		host->caps |= MMC_CAP_3_3V_DDR;
 	if (device_property_read_bool(dev, "mmc-ddr-1_8v"))
@@ -620,6 +630,13 @@ static int mmc_validate_host_caps(struct mmc_host *host)
 		return -EINVAL;
 	}
 
+	/* Resetting the card at resume requires that it stays powered on */
+	if (caps2 & MMC_CAP2_RESET_AT_RESUME &&
+	    !(host->pm_caps & MMC_PM_KEEP_POWER)) {
+		dev_warn(dev, "reset-card-at-resume requires keep-power-in-suspend\n");
+		return -EINVAL;
+	}
+
 	/* UHS/DDR/HS200 modes require at least 4-bit bus */
 	if (!(caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) &&
 	    ((caps & (MMC_CAP_UHS | MMC_CAP_DDR)) || (caps2 & MMC_CAP2_HS200))) {
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 122ac9ba0a4b..829947374dcc 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2316,14 +2316,24 @@ static int mmc_hw_reset_recovery(struct mmc_host *host)
  */
 static int mmc_resume(struct mmc_host *host)
 {
+	int err = 0;
+
 	if (mmc_card_keep_power(host)) {
 		pm_runtime_set_active(&host->card->dev);
 		mmc_card_clr_suspended(host->card);
 	}
 
 	pm_runtime_enable(&host->card->dev);
+
+	if (mmc_card_keep_power(host) &&
+	    host->caps2 & MMC_CAP2_RESET_AT_RESUME) {
+		mmc_claim_host(host);
+		err = _mmc_hw_reset(host);
+		mmc_release_host(host);
+	}
+
 	host->pm_flags &= ~MMC_PM_KEEP_POWER;
-	return 0;
+	return err;
 }
 
 /*
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 032c018650e0..3c0ea74e3e35 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -430,6 +430,7 @@ struct mmc_host {
 	u32			caps2;		/* More host capabilities */
 
 #define MMC_CAP2_BOOTPART_NOACC	(1 << 0)	/* Boot partition no access */
+#define MMC_CAP2_RESET_AT_RESUME BIT(1)	/* Reset the card at system resume */
 #define MMC_CAP2_FULL_PWR_CYCLE	(1 << 2)	/* Can do full power cycle */
 #define MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND (1 << 3) /* Can do full power cycle in suspend */
 #define MMC_CAP2_HS200_1_8V_SDR	(1 << 5)        /* can support */
