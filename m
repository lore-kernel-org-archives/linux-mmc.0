Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D21036E48B
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311601; cv=none; b=EeAmyF4EHsijx0AwruPdY9XjYEvGsfilBeT1yCCc1JYJpXf0+gMEQqVosugxkye3peZEQM/tT+a2DkPrER9uYHrv6/UrUJRhDBR1i7I8/YcQ+/KIX1qpF8mCxG39nOSxNLeGM0cBig88TNv9J9IKoQf6+12lC3O3Vacy++Q1kb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311601; c=relaxed/simple;
	bh=C7iR5TL2sRKHhjZ+5i65XW4I0/9qKRfRfqWcp3ikyfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TDb+81EuYsryyjBMNy/Yz4819xc5OcbUtivcDhSL+59NCfi2AwHbQDMnocu6SKt6fFWPNrWVPbcrh6io9/6G0CHlGUnNpnvsSigddVqPqWXpDT+LFd05i+mmdez7SaeyumtEC4fkDL48ZKd/4ZsIYiNjuIjW0cPTzZX5hk5aLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JuqGfxS0; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JuqGfxS0"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-382ef647e20so7624359a91.1
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 11:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784311599; x=1784916399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qk8fOSTNKdpV10bE/M7xcnHMgAcvmP8Zk1rifIUjMZU=;
        b=PeYC2GRSYe+b/4OLYvF1VHYFatgFzM2XjLFJ192JFYwTqhBC7JqWoqYjbSm5YUIjtJ
         D9LpIKvMY2BBdfDwTkQyZtrwCd50VaDo2kKidLX1WoiIqHPRag9FBMUROOGLcwnFY6Zu
         3TFbmt0Xq1mNomUzmFB5p7rASWqdY+agrUTpcfqW2ldLhM3tHmpd8wY+js2yBtNJvPRV
         R8X+Jl5VkI7dH+3nS3wZUpEYN8aZoRmjJGU2d9HgAX2Wo5SdAeAsGBPnsOJlCHkkIZMU
         gpt795bKwyF3Zotq5Ox9zeuxPDv6zKKjtEwJ47psO5WQZoCwQnp3eA4ZauIau9gEN3lu
         t2CA==
X-Forwarded-Encrypted: i=1; AHgh+RoAS68s1kLdram0ZAZW6kG5w3WSHvVJi6IQTKeXOBXcB4vYdq9snbazj5Dnj7JFXXvu9DMXY9RjAC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiru79YHhNHYfNEdqtVW70ALBnxXX8wBHEhMjYhNpzuXpQGpMJ
	aqncixYXfVmbnwhv9hM5Y6MFW3jj6+IiRokG/NzmdrEVq23GTDDuYZSr+j5e4A6Ow28OP4TRdFG
	PGmpWsvhflKtQkJub5867MJObNCoNxUGPEgkKYdEg0qmBskm7UiKzmKEXh8ycOPaFt3pGN/BFMU
	pETiWnOQt/dqUKKBplsrNT4ZYQTrdC2gUajsQsgKL2b/2lUsLFNpaTPnwWhcc9cR7PoD5sbok0h
	72hZn1KyecS
X-Gm-Gg: AfdE7ckoDkU1R7mVQP2Gr46TDNnooREsdXTIU244zigXl8yZFU8kWMXLv3wC4JeZ8l8
	aNXcBQE1BpLmfaFexHhrpbZZXw2sCW2i08bcPxXsTHYtk+UXf7vG6FhnBQbQTdVBY/+wTpiunVR
	OYa5VpGZWvSYH/yByQvNZNEExPXsgB34qFUAII1Le781YaVTDzoFSgTT5WAFqAlpzM8GiY3VOH7
	r5fCaIrOIKE/bMzxtOMktx5BFPRwf5OFC/jTu1s3kGq2+0qkkDub4OlKVIaysYTcgO7TQVxTeQE
	nujIJ2cvOMAwQOR+0dRcktVh8n9nwrg9bCrCOrytEYgQUNJls545zRnCLXdmQtGN37wH7HaER/l
	MfZs9VHIKC/UKljF7QWCnyaL1N8hYQxWumgnK+mxm1QDaB+Ux3Pm+BeHrM5uJwxotc8t//DqLdD
	TKpGyNqj5R9eFnUVmVwJAkcsVGmNEXYSU87I0=
X-Received: by 2002:a17:90b:3805:b0:38d:eac8:2dbc with SMTP id 98e67ed59e1d1-38e4b422c03mr3915752a91.9.1784311599293;
        Fri, 17 Jul 2026 11:06:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-3142a022aa5sm145764eec.11.2026.07.17.11.06.39
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2026 11:06:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ec3314f65fso156731636d6.3
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784311598; x=1784916398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qk8fOSTNKdpV10bE/M7xcnHMgAcvmP8Zk1rifIUjMZU=;
        b=JuqGfxS0RhFVNSYPTKUWr5n07pmBY3YbAZv5tljME6hS51t8uBbiulWhya6XTjTHR/
         gcjOMjbRgJQ8FvwKt5V7sbjV5WKYvrX8GPDJBeu2SzBagE9Jj4QW6WDIfl2R6jFPWrk0
         tzEaBy2xSCzAFVPyCq0ZHU3wB3HonTQmwNKNs=
X-Forwarded-Encrypted: i=1; AHgh+RqH5zXFLec3XFJAiyvzVamGq6XVqB3ytUTClrurMt9aiOmarNGn00n7q+0gsBYSN8X9f6k5n/vKDYU=@vger.kernel.org
X-Received: by 2002:a05:6214:2027:b0:904:2e70:78f with SMTP id 6a1803df08f44-90778353d4cmr43902066d6.9.1784311597731;
        Fri, 17 Jul 2026 11:06:37 -0700 (PDT)
X-Received: by 2002:a05:6214:2027:b0:904:2e70:78f with SMTP id 6a1803df08f44-90778353d4cmr43901616d6.9.1784311597175;
        Fri, 17 Jul 2026 11:06:37 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077856002esm23175896d6.11.2026.07.17.11.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:06:36 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Kamal Dasu <kamal.dasu@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Avri Altman <avri.altman@sandisk.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mmc: core: Add MMC_CAP2_NO_SLEEP_CMD host capability
Date: Fri, 17 Jul 2026 14:05:36 -0400
Message-Id: <20260717180536.1757204-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717180536.1757204-1-kamal.dasu@broadcom.com>
References: <20260717180536.1757204-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Some (e)MMC devices take longer to exit the SLEEP (CMD5) state than
their advertised S_A_TIMEOUT allows for. On platforms where a boot
ROM sends CMD0 and reads boot code from the card immediately on
resume, a card still asleep at that point causes the ROM to treat
it as fatal and reset.

Add MMC_CAP2_NO_SLEEP_CMD, settable via the new "no-mmc-sleep" DT
property, so affected hosts can tell mmc_card_can_sleep() to never
put the card to sleep, regardless of ext_csd revision. This is a
host-level capability rather than a card quirk so it also covers
cards whose bug can't be identified by CID/ext_csd matching alone,
and it is resolved before the card even exists, avoiding any
ordering dependency on when a card-quirk table would be applied.

Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
Closes: https://lore.kernel.org/r/20260413180551.3683969-1-florian.fainelli@broadcom.com/
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
Changes in v2:
  - Replaced the card-level MMC_QUIRK_BROKEN_SLEEP quirk (keyed off
    CID) with a host capability, MMC_CAP2_NO_SLEEP_CMD, set from the
    new "no-mmc-sleep" DT property, per Ulf's suggestion that this
    generalize beyond one device's CID.
  - Resolving the capability in mmc_of_parse(), before any card
    exists, also addresses Oleksij's concern that a quirk registered
    in mmc_blk_fixups[] (applied at mmc_block probe time) could lose
    a race against an earlier SLEEP/poweroff on an under-voltage
    path.
  - Added Reported-by/Closes tags crediting Florian for the original
    bug report.

 drivers/mmc/core/host.c  | 2 ++
 drivers/mmc/core/mmc.c   | 3 +++
 include/linux/mmc/host.h | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b7ce3137d452..3bc19645ea96 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -400,6 +400,8 @@ int mmc_of_parse(struct mmc_host *host)
 	if (device_property_read_bool(dev, "no-mmc-hs400"))
 		host->caps2 &= ~(MMC_CAP2_HS400_1_8V | MMC_CAP2_HS400_1_2V |
 				 MMC_CAP2_HS400_ES);
+	if (device_property_read_bool(dev, "no-mmc-sleep"))
+		host->caps2 |= MMC_CAP2_NO_SLEEP_CMD;
 
 	/* Must be after "non-removable" check */
 	if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 05444ecf3909..5e80fa5c1a28 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1972,6 +1972,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 
 static bool mmc_card_can_sleep(struct mmc_card *card)
 {
+	if (card->host->caps2 & MMC_CAP2_NO_SLEEP_CMD)
+		return false;
+
 	return card->ext_csd.rev >= 3;
 }
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba84f02c2a10..0447a8efed50 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -463,6 +463,7 @@ struct mmc_host {
 #define MMC_CAP2_CRYPTO		0
 #endif
 #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
+#define MMC_CAP2_NO_SLEEP_CMD	(1 << 29)	/* Card can't reliably wake from CMD5 SLEEP */
 
 	bool			uhs2_sd_tran;	/* UHS-II flag for SD_TRAN state */
 	bool			uhs2_app_cmd;	/* UHS-II flag for APP command */
-- 
2.34.1

