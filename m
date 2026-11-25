Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630872;
	b=0cmFxK5jBRq2gWDEBP8gQO5Es3PzIQmGK+suei68Hc6KAu7N+A3BpZUHmf87soRRqI1N
	 EBdBPrw9fflxSbAyxvC0cX1XFA1sBfoufJP+Hd1Hi593Vt1f4QkO0HC9AIZl7YOcd5IEH
	 zKTltUxxlLDyWr+QdRnY0yA74AikPWhRVI8nAr81Q4zGskaMe1yz2xawaO5ZHmBqmaz4X
	 XPgXDGKyQ+m5GZYjQLMCH7Rrl0dsAbHjZtt+FfrLdBpUXhVXuu8+Nr6cXALAVsUdKxavb
	 9aGJewGPpKBMOWyrIwlwWpqwYZBDFLpYNKKP+xHJgNCA2hVk1ADvEYxL0bCL/K1ap0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630872;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=iXbDQFpiroJFmezz6SHFX01MfYfrrfJaNoc6qsYHSMM=;
	b=ipTlUvfp8xB+pPYAc/vSNW3EbA74D096WjgfM6VVg7X6/3uc3w6kgJgxkivkCmudg+CE
	 lCxvbMwAdPm8eiPjRjdw1vM6Iqd9UJu/t2BBQ1tJgUHLbAr5sOlLB/wY3k+b4TYftwzL/
	 /Skoy1Whz46Yv+eMzB4Ig3jaWWjVqEu3+Wq0yOk2z41/7QEXObEAb+RXOqPj7ykIfcTIO
	 0gQTiSmAHfsx4NbCWml6WM0PnUQFFj1Nu8/MPATdVD3cADxMz2NSX3mabdrJi5zchvEy/
	 R6u6oR7QtRHEAby3OwaY1TtVJvFvIPPNBloL7y0CtAhwsmgJCGxnR4sYZamWqNvxkUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Tm1svFrH;
	arc=none smtp.remote-ip=209.85.214.228
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307BF606A323
	for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 18:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 307BF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Tm1svFrH
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2f04fab527eso47030205ad.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 10:21:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795630871; x=1796235671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iXbDQFpiroJFmezz6SHFX01MfYfrrfJaNoc6qsYHSMM=;
        b=GXmBJsMKucZTaGtO7eB6LIamhiKghxqEyf0OcAz8exnViNK+j26K7zhD2zYoZTcUZg
         cfv9DfpWMf6fAMcCf4TDAxPQO7L0x4YLRAIiodAQ4SQ0BzfrG96j3BUhozkCFpMgkQL6
         X8unMRM6lP7sNudcAQYEXXPKepQLGOq4UIkARSL534od1wTtnirHXzrPgfpeO50dewHZ
         TVqpMktDmEORsILqxoR7SM0o7IqcVAqBbJCLbYfL9CNfcHrQKxlnJYonmheSZgcOlmIN
         exzB3BuJDGWg3bzeL62oyXLBTgmoaMrHH3irRE+rpef8Q5X9fjHQApcdOSaFOA+t7SkJ
         R9rw==
X-Gm-Message-State: APuU4Z8pFxz+GRz8mqaiZpl8bfBJ8PHvf7Yxz4By9+3yxqiKc2ZGuQfZ
	OgnHNid/jTbzu3ftZNPbzQhuw12o6pSw8JNiyR3ApeeHkfoZUrWU6U9F6+0BOqPIj7/V4uiRYg2
	Qf8Vyzgd24eUKN/mkGpFZcBPIcwYbuDYU/sFugeZ0TfO2W0gymGf10oyKgVeP67Ic9srpFDmiM/
	1P2BSSZeAwx/IlQlQCPfMQ4FWxwe9NskEmZGbywHfUch/Es5nWBx4j2u6I1BDPRd1PGqG0uVVWW
	I4qUujEPPp8
X-Gm-Gg: AZFdTZdvrFs3kXtJmLQn2pwIGaGjq7lQeOslNtGOGQgwXRotVu7HIP2rgaF3NfQUigk
	mTO2U7PSRORwjTs9xCxQhJfS95BaZ77XHkgotrE/E8cbC2UNSs1kz/r0vL8ERkFiF1Eo/b/n1vo
	U6ap9AlMyHzbGyBpqVB90rutPxFT6emqCvr/ExkrnomepwNEdWfpm6HxhIAPFRmhCB518QtN1+9
	tqqtqsY7OZSnnysEYaOE3Yn9j40zJWiNHZ+3+M/lRxnTSNJ+x97okzZ1FJnnYbkGpORsbmQIGlU
	DHEhmnXF6FLfYJJRS3PH/bCK47boeZII3Ni1V9G4a/8xYh7ZBQyCZxzUmg/jTM++cfvPUvf7fHk
	h1ATEqcuY00nFhZIUW0JIywusdJEyNvX8a3zEFWFrUm4hgn0UFRR3mAtOvF3yc+5VUrlgurUj80
	Heu10lblX3jxgXXHPsZHL6bwSC6HjhMA1L
X-Received: by 2002:a17:902:f54c:b0:2f0:25ea:8fbe with SMTP id d9443c01a7336-2f03efb104cmr197668695ad.7.1795630871528;
        Wed, 25 Nov 2026 10:21:11 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2f03f0c47dcsm2718575ad.19.2026.11.25.10.21.11
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Nov 2026 10:21:11 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-94967c6d4f4so670884185a.2
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 10:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795630870; x=1796235670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iXbDQFpiroJFmezz6SHFX01MfYfrrfJaNoc6qsYHSMM=;
        b=Tm1svFrHeAQ5l7w31QJpPA/mU+cg7r8G3LJ/ycz+998st6HwKg595XvflOADQ+U1sk
         bgyMYr+oX59/lRdGwsfVewXB/ssaVwNpNdw15T8bqJgspf6i+5UGCpg9Shn+7KgJgqQU
         /e7PWM/XTHQatTz8KfS2sYVQn9ilITsXyKcA0=
X-Received: by 2002:a05:620a:2403:20b0:945:e46b:15a2 with SMTP id af79cd13be357-949cb821e7fmr2119547085a.49.1795630870086;
        Wed, 25 Nov 2026 10:21:10 -0800 (PST)
X-Received: by 2002:a05:620a:2403:20b0:945:e46b:15a2 with SMTP id af79cd13be357-949cb821e7fmr2119537885a.49.1795630869236;
        Wed, 25 Nov 2026 10:21:09 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38322csm1375419285a.17.2026.11.25.10.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:21:08 -0800 (PST)
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
Subject: [PATCH v14 6/6] mmc: core: Add support for resetting an eMMC at system resume
Date: Wed, 25 Nov 2026 13:20:53 -0500
Message-Id: <20261125182053.3915833-7-kamal.dasu@broadcom.com>
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

Also clear MMC_PM_KEEP_POWER in mmc_host_class_complete(), as mmc_resume()
isn't invoked if system suspend is aborted after mmc_host_class_prepare()
has set the flag.

Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Co-developed-by: Kamal Dasu <kamal.dasu@broadcom.com>
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/core/host.c  | 26 ++++++++++++++++++++++++++
 drivers/mmc/core/mmc.c   | 12 +++++++++++-
 include/linux/mmc/host.h |  1 +
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 8e9e61839198..9cb456a153ae 100644
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
 
@@ -55,6 +63,15 @@ static void mmc_host_class_complete(struct device *dev)
 {
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
 
+	/*
+	 * MMC_PM_KEEP_POWER is set in ->prepare() and normally cleared by the
+	 * bus ->resume() callback. If system suspend is aborted after
+	 * ->prepare(), ->resume() isn't invoked, so clear the flag here to not
+	 * leave it set at runtime.
+	 */
+	if (host->caps2 & MMC_CAP2_RESET_AT_RESUME)
+		host->pm_flags &= ~MMC_PM_KEEP_POWER;
+
 	_mmc_detect_change(host, 0, false);
 }
 
@@ -375,6 +392,8 @@ int mmc_of_parse(struct mmc_host *host)
 		host->pm_caps |= MMC_PM_KEEP_POWER;
 	if (device_property_read_bool(dev, "wakeup-source"))
 		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+	if (device_property_read_bool(dev, "reset-card-at-resume"))
+		host->caps2 |= MMC_CAP2_RESET_AT_RESUME;
 	if (device_property_read_bool(dev, "mmc-ddr-3_3v"))
 		host->caps |= MMC_CAP_3_3V_DDR;
 	if (device_property_read_bool(dev, "mmc-ddr-1_8v"))
@@ -620,6 +639,13 @@ static int mmc_validate_host_caps(struct mmc_host *host)
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
