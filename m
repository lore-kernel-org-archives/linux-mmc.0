Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426293;
	b=dr8joOI+a/75v0fW5HP+ZjfPoChWCG4wJYlbpccDDGdZ7BbqvDeH7xBmxP6H2aX0/zya
	 aTomPb5E5Ml9ZutP7+UuwS3Xmm7jh4dMJDoUuOLcYP+lkID6e6meaJvFQVU3u+jDtYqXL
	 mO8a1FFndW1heUgPskZ68SBZwy3mLkUkI07uKShsNaTcmU45sdM3bLbAoaRrSHtCl8swg
	 h2yHoQko/4isMsDN0sts9i1/BWIRVKpbB47HIpeYit3/x/OG4p1rAuT139t3MV8bb4gmU
	 /szJbz1w5Ph+C+/K3dCBdo10Q2g6bBs24DY7VLJMLJ+w9yU603GN+g+j5IEiDiw0qkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426293;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=gw48uU5TuI97IZTqjbPClG+wxWg8KU+drJon/k2SkSQ=;
	b=vW3CDnRp72hndAg2FPvVTKRBT+XPm7oaa0wK4JZRv2ev8fsjij2snboY4wSI2vEklM/Z
	 1jbmjN7JOpxmHPOBLHL5wxg1ao1jOO3Oohe9T7bUEG+U60Pep7YRgtru60MHON65OtbHY
	 wTQBsp8QyKNYIzfaMrN04sE6fdymi+rmZTfJiygRf4K8srSnv5Bx9M9MvwZ5yyX6ao4uB
	 pIYxGxZ3S4nwCOxKvXUhTdi6TP3mg1oJeuuvNZ6im7mI/7RRoAY97HURy8XWBQpPXsQBh
	 +rZK1WH56zQ4LlmFkpp+MceCNdiTZm83+YiCLx4BfLhHxT5qsa6TZCSifhc359iwBIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KOTABQTy;
	arc=none smtp.remote-ip=209.85.214.228
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9960A260F
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 19:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAB9960A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KOTABQTy
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2e9d7791b00so29990575ad.0
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794426292; x=1795031092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gw48uU5TuI97IZTqjbPClG+wxWg8KU+drJon/k2SkSQ=;
        b=Vr80eGf/MXKT2FvPYcpPvLuu3XznumA2y+tCawJU/lT/fTn9PYKjrt/Nolg0ANbAN7
         CKBQhDXgD4DKKYK9EKBIs76NPsVdjxNPVZ7GI7MT6/IhYRfmskTXCAa18jfTYcQPjigs
         jvyQ2XWzVrQLW/HFjd5E16L8QKDmx3mYSjGlNseFf3ZgW9/ZvV0exIOZaawNIB5sPYjL
         fIqM3O+OMFu/jvy5E50TdC2pZd5iYqM2XIIxJfXMcRWvvCj/WLy/skeQywMNqicCaNcz
         MwcA75Qy/Ri/vRu0aX82i8YjYD2/V9QD3RtyX02gXXiC6q/FhYoazdshP5CqNWao88Pg
         DtWQ==
X-Gm-Message-State: APuU4Z9bE/5tHZsNsRsxc57huULiIATtrg4kycEZKamar11kFJB7DD2J
	6RUISti/osNqzOYToAUfFhMfMJaX6paZAyT73/wTbhyhMt94UAh3xbbcPGQ3RlBRhU6wX+IfqKj
	EFYMcgpUjluo2IhnpzQQSzREnhirsvLaI378DbMJSST5d2hYzBUkxFz3zjUHyz+amqzBos4s116
	RkP94eLqe0uOYXVqaCL9D3vqJJ+qq1jqH8HRv9qqGWhjTizGIBaUPozoarg+EpeJH7mQRVATfdw
	CyDdotMSzLs
X-Gm-Gg: AYBFou1rc0SpzXQCILfbPfTYZ+Abxh9LXMhCHChJ30KZFyW1xRlReMpMUof1FdjwdNz
	NUgkwgbdb55q+bU1yF8brOrivglBfn40FRhil3m6tvHsWYL9e62L8gXcrprKEQUAjn9cVIjWKlY
	sDtdvCi3rXhP+xt68dhEA8nY3g4DyV+NReG2wBRO+ya79A4yCtXydVaMTiGjzBdAU2z3u+yNr+U
	j6rzO9EMGNgbdynPV7MbXgEkqu6oT8vVguC1NctnoEefLxYqZvHFa+Kj4AtbnD26MZP+Fz9vKUJ
	6mKh9L5wrtLNCWnPuPTbAySoT0EtsF7EJjTRaIV5d0T7RwIlRbyjfSnJc8uZFftgHXWZGjdnwSy
	qub+2n6AEYGKmLdvTFopIT4dj/sbP8+M1SY4Z1o4oMLu4sA3W5wDeMgutTWxclAdEcAmtcKKJHD
	HPIhJ8CfN5RL00Xg4TBiSr3t5lSkWgnXec
X-Received: by 2002:a17:903:120d:b0:2dd:ad73:5b6c with SMTP id d9443c01a7336-2edd7b394d7mr35060375ad.28.1794426291855;
        Wed, 11 Nov 2026 11:44:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2edb65d6ce4sm1438685ad.54.2026.11.11.11.44.51
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 11:44:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-37628596fc9so580986eec.0
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794426290; x=1795031090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gw48uU5TuI97IZTqjbPClG+wxWg8KU+drJon/k2SkSQ=;
        b=KOTABQTyMmSotnDBqowcSSEsu2WGYMXB1N5ZVC96ERVJ6H4jgXrEuqOj1J5TMU0zqe
         NOqtCkW3n+1LMjoBIxceyQzR25kXBJGFZyuVXYdA6teWUjsVIO+3W9B10GK3oa99rxOx
         4+6gpq5X4gSxixbltiAwtclOUq6Dz8UKzQadY=
X-Received: by 2002:a05:693c:42d3:b0:36a:54a0:6b4c with SMTP id 5a478bee46e88-37686757ce7mr3184478eec.25.1794426289797;
        Wed, 11 Nov 2026 11:44:49 -0800 (PST)
X-Received: by 2002:a05:693c:42d3:b0:36a:54a0:6b4c with SMTP id 5a478bee46e88-37686757ce7mr3184439eec.25.1794426288973;
        Wed, 11 Nov 2026 11:44:48 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm17948013eec.11.2026.11.11.11.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:44:48 -0800 (PST)
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
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH v12 6/6] mmc: core: Add support for resetting an eMMC at system resume
Date: Wed, 11 Nov 2026 14:44:26 -0500
Message-Id: <20261111194426.1652644-7-kamal.dasu@broadcom.com>
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
index 026003ba507d..71c59cf1178f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2314,14 +2314,24 @@ static int mmc_hw_reset_recovery(struct mmc_host *host)
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
