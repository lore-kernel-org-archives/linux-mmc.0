Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB7239A7F9
	for <linux-mmc@vger.kernel.org>; Thu, 21 May 2026 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348130; cv=none; b=Ou254M3l83FJWDQUW0Vqb4w/FIjprmRUSgc5Ds3cMEWli6Dub9sfvyumJE+8G7tzTgz2mUdwKdcyjsscyCCiW6a9cviJx8OkM5767BUe990p/g05r39/QvBtgpbqfKY/LS3vlE+cw+IFKw6pE5pt5vJg+MJ9vCWsajbc9P405zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348130; c=relaxed/simple;
	bh=Mw2AGjPcnmuHHZCQ0a+KC554jOJiVIjRahnR6xrADfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihtAN7qcvF6panXSlDuVmRXMzyGcXoQOsJBgp6FTUNAsqCf+LW7wYr6ZJeAg3hcM1FEULmFW1xF4Ynw2zsiZLt+QY2gbt2pSfuWetbGTZu2dOt+DGoC6WIH/CNtTCHVLw5g3f7FnrYImBoFOiV9pXkWp4HPUYZGlQKpwR3VuBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmK5ZyfN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmK5ZyfN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bc85eda6b6so28072465ad.1
        for <linux-mmc@vger.kernel.org>; Thu, 21 May 2026 00:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779348128; x=1779952928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTYqbJYJ9tS837Ijwhb4D+xEtAeHHmkjjGBTYP1lfQc=;
        b=EmK5ZyfNLnIGKeUeIZt2awabvzjF/bHHXaKH0f2T1cDOpruOuTRQ/aghW1y7mUbYn1
         8bIQc8fU1HvvpXvE8nVs5TmVxkULRY3pej/bt1DqYlku8rwdvVOWyXAi2u0EP+eUV6T6
         vIHWa1jQeVc9vYyIKFCt1Kpspn1drRZiJ4cK62DauW2sqjQCXNmoXJ8cKNTAwj4Kb7II
         VfZdGUm7tJcYVOY7xa/BFXlwJhpp7I+XVXyDpNa+9Xi8ehR8rzyEdmKeqofrMSauxJJ4
         C1LMeBWNMH0M8L1RDkawLAPPb5/p9snGAwPDR4/7jv7aX/+umpAVkj+iBTbpzej8T2qZ
         N22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779348128; x=1779952928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTYqbJYJ9tS837Ijwhb4D+xEtAeHHmkjjGBTYP1lfQc=;
        b=rPVGtXz4iElDWZXVlcGpSEgMZMV+fCy1RdugnVFWSQm4G+vbCer5ipcjcFUKVirkQK
         9xTNMkuOx9n2kddKAgRpiyK/2yjeHtI9UjxxmhJkzbYG9MBj8r+W2sAGkKTVKoNfgX1C
         YhJGg/J/5jG7KEnEJR4GMY5cZxTIJuennDU4nDMWt5Qd1BeMSeMnYC2RgsIeITKFL6Ux
         G32+oGiswOtBZ2mSemIBkmgiAYBu6GqIhs9g9/gbtjo2zwG/brPgu68AKyCpapMf2xDa
         +VnnDEzx61HX6qUHTNhvKE1W2NswarW5NA1fz/gouF337G0tXEJiS5nNJEGt+dxHieOL
         klhg==
X-Forwarded-Encrypted: i=1; AFNElJ8QnY8MN8yDs2TdSpDgORLFyoLdPin/aNEURkaW5xUaXwI0nMTA35hefhYEnf+ffmC+M10liaq0ytI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHOFoO5ozdML3d2nLV7rhRmDGfLz2z5v6RStE2KlUYgCiLGiqh
	0vp+3hhODuSQ0jpixxB2rx98TT7O3N5DMT5qCVKMwBE/JvxWyOgFWgil1Y/LmWpJ
X-Gm-Gg: Acq92OGU35zKxB1MiPP0lhIUh1wnAlw+kfCXERRDv/PvhMqe/3dUcDwX4Qu7fuFA9SY
	jUCNPBAwswHlPhLftngt+cKqBQbekwrJEpsIHOT8Qc6WNB/DPJexho7gNs2HutTO3jmbvhRUgGo
	rDaelIZLHhvKVxsBf6Gl0LIVNMnbJR1IuZjRwmSILFWJ9dKR+fHX4RfJlXMUEU3Wn+GHN2+yj9G
	697deYSDB24errMDz8+geRqrlsjAxJo86WKh2NrEP9LYc5Pf1ev8T6gVRd+ADI8t2bXw8R/g4Vt
	YCCHYXMGeKze4i4JsAIYu7QqQe7OS4PFw7nvo4s/dnexM/iG816yRU2VoivencWT3pORBkm212o
	ejQBsq9UVZJy6qLsXPxhYiC3Eg8cSrof8eBD/wa+Vh0oHLA/IqcUk0Bvu+cHcQemSpz6GghaTiI
	2m7SiYzbB3Z2e26XBZgDw2+i+a1paQeUW3Ew==
X-Received: by 2002:a17:903:1ad0:b0:2b2:ebed:7afc with SMTP id d9443c01a7336-2bea335a682mr16852035ad.27.1779348128077;
        Thu, 21 May 2026 00:22:08 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98eca87sm584735ad.54.2026.05.21.00.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 00:22:07 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Maciej Dudek <mdudek@internships.antmicro.com>,
	Paul Mackerras <paulus@ozlabs.org>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v5 2/2] mmc: litex_mmc: Set mandatory idle clocks before CMD0
Date: Thu, 21 May 2026 15:21:21 +0800
Message-ID: <20260521072122.1601215-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521072122.1601215-1-inochiama@gmail.com>
References: <20260521072122.1601215-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The litex_mmc driver assumes the card is already probed in the BIOS
and skip the phy initialization. This will cause the command fail
like the following when the old card is unplugged and then insert
a new card:

[   62.923593] litex-mmc f0004000.mmc: Command (cmd 8) error, status -110
[   62.949717] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
[   62.976606] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
[   63.002516] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
[   63.028442] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110

Add required clock settings and initialization for the CMD 0, so it can
probe the new card.

Fixes: 92e099104729 ("mmc: Add driver for LiteX's LiteSDCard interface")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/mmc/host/litex_mmc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index 52571bb17c61..3655542ca998 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -69,6 +69,9 @@
 #define SD_SLEEP_US       5
 #define SD_TIMEOUT_US 20000
 
+#define SD_INIT_DELAY_US  1000
+#define SD_INIT_CLK_HZ    400000
+
 #define SDIRQ_CARD_DETECT    1
 #define SDIRQ_SD_TO_MEM_DONE 2
 #define SDIRQ_MEM_TO_SD_DONE 4
@@ -449,6 +452,17 @@ static void litex_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct litex_mmc_host *host = mmc_priv(mmc);
 
+	/*
+	 * The SD specification requires at least 74 idle clocks before CMD0.
+	 * These dummy cycles is generated by writing LITEX_PHY_INITIALIZE.
+	 */
+	if (ios->chip_select == MMC_CS_HIGH) {
+		litex_mmc_setclk(host, SD_INIT_CLK_HZ);
+		litex_write8(host->sdphy + LITEX_PHY_INITIALIZE, 1);
+		fsleep(SD_INIT_DELAY_US);
+		return;
+	}
+
 	/*
 	 * NOTE: Ignore any ios->bus_width updates; they occur right after
 	 * the mmc core sends its own acmd6 bus-width change notification,
-- 
2.54.0

