Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630867;
	b=hYSL1ui9D3McTtFImqJL88IT/fCL0JsuQWS0GUUzxTdJ27dYS0NLR8/4A8dH1V5ahGfH
	 YSTMYENof+HaRiPDI4cGLo0F62s7Kl4zmx6uZ8J7rhGCyeYfC7KZH2Q0+ZOQBAoHjPdrA
	 dlqKu5rPUGm91VeGCgSQ9BLyrximktrCiWd61wVBvyr2OIu712uMJtcwNDpEcqd/sRNio
	 bW4YN8GqQyzSRDCzajQaExkUTw5tTkameMfc59CjsTUDrzOowGf0YcvsGgpdO1OoFutYp
	 rjO/IOoH0ldpe1SPl87bHPYLgover/Y4i1zQ7yUEd2JR68hwj6B3IXj7u3+Q4qVK5qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630867;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=AcnH/jTKTxIE1YZEERyqIuGuYPlGUR+IxISmRbzT7E0=;
	b=IIusF2Cl3ImzI6SrCeoMwLqRUEegDv587sAf3rggBdViQZcxSdSVcd4R79QRUYyPOCFo
	 MjFr585SMKzTAmqtH9Vr7I8uJD9kSew72YCsUkos91GIWky5sTXMA6zyZ2HPdBPYj8/4h
	 h/9jcEKzM6IRl+w6La7mQwLauDt6UvoXk1kIbXeED49lctpCZ35Gv1eQ4+0I7R8/jLwBX
	 zRiwPUE4KjBtIV1T7s420owSkqB/pDDYnu5vYLGdKnmgj6YBmkNuUWefZPDb7wGwUGPca
	 O2jEUkxBy8WxztuzDr7aywutDVPr/76maTUt0PXmPI2Iwr78gEuqsZOPZvo9tfA+k+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=awJUvtQG;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973C7606A68F
	for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 18:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 973C7606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=awJUvtQG
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cdb2893531bso3240442a12.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 10:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795630866; x=1796235666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AcnH/jTKTxIE1YZEERyqIuGuYPlGUR+IxISmRbzT7E0=;
        b=WSazVu3GQOONxB+s3ZQVtdk77aOSjiTQHL7bgvl1dgiu4rOB3JhsfUdKgGNV0Ukll+
         EOg+pfYyrnGqSbkS3pijnS1nnZh1VhrgnC+B1ncxg7H/BW7JDHqWwfMlCWPynX1Rz325
         pYRWC5pyjmjSp7VOkFxbZ7uVCX2kCmGWXNYgGQzUuWkqla/DaqDgWnlrNTubC7jPil7U
         aMGOGUi87waaCZI2TiVBB3d6PO3W3158V3iWqHUZ7Op4vy7erczH3nQJMy92NnTYy0bq
         TQC5HnzZcsgA6AbjclBpKqE6lsLkuAug84fKn5FxiZhPFDdJnZwu9XjtpH8KT5PS5a3w
         TxLw==
X-Gm-Message-State: APuU4Z/8oDcbPhlzarXyYL7Qa0xbpVsJpH8edZwDcPIeHQARXfXSvVUD
	8D9zNSdLu9EpwqSb++RgM1SNUf0wxqHwNoXhsrNSF6q6LZ9HVSWsSe9bcH9cyJeCn2HbzeP2+9H
	Zmynxi+7qlrwdL0xjjLma2GgHhgUDaKq7OyeT48A4Fc+7SIiPfAPhKIpq3v6vjRyMxo4UE6su7v
	rj8p/uxo1W2lHt/fwqpYlG7oRzy3oE9Bf6z0oIlflnFnKv6hOFRHmFuxEyshdPE02Rj0kxxR1f7
	YTaogh9f+St
X-Gm-Gg: AZFdTZdsLVUy+ejX0Jo4lT+5rQk90o9ySfC5n4EVi6A8LkAIqWS3a62r0sSyMu4q93u
	EFn8h5f1tuJmEQ4zn4Ctqk9+PTKVeIhRjqBLMNBjFcAj7JdLbbxOudGKCtwKsruh2CVd0RfYsfL
	KsH5HvBKd38bKboY10AAAt5gsK9grozUk5+u/79FNeClDQSknDfPGOZF1A0RJuzyoFfwElUMK8+
	SzLTV9RI/vjjXR34JpfHDNoXzBlagfs3BJ7HpAs+4ljhlXHig8n1v1GEUuS2rRsKVLKzUctb5lJ
	1SJhmOhY9KPePObClYJI+SeT8XZd1Q1CC+h3KP0qQ96hexY3Ows/pzJ9G7C2nj5/MdCGBG0eW3n
	LoTLRH1gsLh2goLvPpGV0HI3FLIxHgiv1CYD/10/1sVFQk+nnyrzdMGN5S9iDhz7WOJi9ZNxw6q
	0Xy1Ec/o2B4uKrYExlIbh9T4fLJiZ9KkRpDPc=
X-Received: by 2002:a17:90b:50:b0:3b4:139d:33ba with SMTP id 98e67ed59e1d1-3b41c7e166amr18653760a91.4.1795630865834;
        Wed, 25 Nov 2026 10:21:05 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b41ac86baasm12840020a91.1.2026.11.25.10.21.05
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Nov 2026 10:21:05 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-92109408212so123621206d6.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 10:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795630864; x=1796235664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AcnH/jTKTxIE1YZEERyqIuGuYPlGUR+IxISmRbzT7E0=;
        b=awJUvtQGM0c6pL5l/AJeTAnzl2OmqLpFnMz6QVrAUj3HX9VgdbzoOvyHCmyWD+QSba
         qiQCC8eml2y/NpTjpqHUido0lruzvk99oshMhf/eG6cxl29gu+to0qGUxE6cHehkR20O
         raAS0mvOL6VgCSacux5IGjBKNvi8U1tdGXvpo=
X-Received: by 2002:a05:620a:838a:b0:93e:f0b9:505a with SMTP id af79cd13be357-949ba9fe6d8mr3155419685a.58.1795630864299;
        Wed, 25 Nov 2026 10:21:04 -0800 (PST)
X-Received: by 2002:a05:620a:838a:b0:93e:f0b9:505a with SMTP id af79cd13be357-949ba9fe6d8mr3155409985a.58.1795630863580;
        Wed, 25 Nov 2026 10:21:03 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38322csm1375419285a.17.2026.11.25.10.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:21:02 -0800 (PST)
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
Subject: [PATCH v14 3/6] mmc: core: Add option to keep an eMMC powered on at system suspend
Date: Wed, 25 Nov 2026 13:20:50 -0500
Message-Id: <20261125182053.3915833-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125182053.3915833-1-kamal.dasu@broadcom.com>
References: <20261125182053.3915833-1-kamal.dasu@broadcom.com>
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
 
