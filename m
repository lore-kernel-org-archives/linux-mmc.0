Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630872;
	b=0WoHpa6RGdHzIK8E70JzT/BkxcTw5ccQ1xJAp2rBfNiRgSqs+IMnHdRhobd4eQq3Kyot
	 WytrDN9V32OT5yGZMIVZAOQZOr5/3wdjY44gAERg+7e6oa2xZhq/laEDM8QKPXzrwCDjZ
	 DM3vn98d2p2UeCPnYhnG9BiOyI5Rv5QR+o2z6rUPKikC1rLKlQ4XeQwcmZhd4Ug7py3+m
	 Tl9/4hnLlMWHNzHqKowZchmPMlpPVo94Ujm9tCm1CTiuZ5isa+0Hjtu3S9GOKELnkvt6d
	 xP/KyO1UfOYRQMjqaVZlKl0vKFdLQXPR+lNHQwiVJStmBWT3DTS9paj4WbzLjcdb+Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630872;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=7ancN5tYiJUgiK5oPhN0zaXHe/997SRSIfB0LkRBNW4=;
	b=4rq2icmA4f02j76eahKwaK5AWFBIEaUBUa3TUhHQmkgYU836ynB7EwpOBRtX7xFl0PcZ
	 RkFfekpyjaFo1wzJwPr8Kmt5+RjMEzO+tkMRTmpx4RLss+eGZgXcFzQAQHG0IiRTsktTu
	 3gMllTIN3QOPozg4XNBbv6v84PxPrIZXTabWocJuY8JGXkmW/hgsn0VVkFmASd9cfw4Qs
	 CNJrRlYyIIwmDmKAdZPEpchEWclISm0Q9bTAXEravyDgZ6tHTmSAnROfe13cKHoarcG0O
	 +wipRw04Lyq/bh5XfCGm9wxWSNrGNtwQZNZGfIR2EGofVAAPIXO6byrzAhijvppoXgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Uj0GcKVj;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ED7606A68B
	for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 18:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47ED7606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Uj0GcKVj
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3b44bdcea8aso3422450a91.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 10:21:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795630872; x=1796235672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ancN5tYiJUgiK5oPhN0zaXHe/997SRSIfB0LkRBNW4=;
        b=BUoLmlUJV3gD4blwRekXg9NosseVdfYakEbJrladDeVaogJr65x+UFqZZCRF/HqV8w
         RbOp1e4ul1qe/LILivzbahWS2ZZnUr0TQlPmOo1Wdysq1Tz9IoFFnXPP9sLKRv9lunFf
         HF4H8snKOqfj8WXM7EuqgAw4K9MCLkywy6iFJI7Q3YgErLIHkkvUCRWjm0158kpx1/x2
         vAs9wZWOHG/0qxVjIvrawgQXkh7w+kRyaxvmnkz4QlrEZEUfIkhiaTuZ2Skf4nQrVaq4
         370G46AHKIAmCIWV8QvNaY59pRas8pXkLEmSwTxFmPSRJMT072JR/w/aJ+Cpt6OT3ET7
         ULiw==
X-Gm-Message-State: APuU4Z9iZTRL1/Zya6hWlgsJ3qUdXd4cKO9xep+jgNJecEwfySc+bt8N
	CQ66NHN6NqZ5mD17lDexMdJDEs/2SrmFXUSaheuKNi7+6P1KK7tZj8EavQkjf90SzsOAEuTjEAv
	KaEOTmSrHecDAfVtyZRW7s1bN09AOgxvGgX7Ixs0bEA5iKd5R3s176ns2M4do/U9Mvg0pfvGea8
	s89iaZWny00xXxFA8a4CjpwkoPWnZYAETx8rXy0tJR91wTINH00bQ0JRakk1HEF/dDPxd1+v4AL
	q8DcqXOTHEh
X-Gm-Gg: AZFdTZdfV8RrISpT8g7gowpO7IyQLoe/Qv7yxeLsUwEoiMFBP9FO1/6iEbt5z6Mlor0
	I7xGeSLCr2+j6YSyMFroyU4cDPQi5i8URQ6uWLR2VrUp0I7vbWSDAFCHvdU4i6m1q70Om28Weae
	EQViU+cmtDndxFHleXhnLwfWfzEnj/LKZ3Mt0iHONfYi80DBOavw9Y+wSWSpUHEc8hsvKMZ/agh
	DzYqHftKmExGX2C7gy5DrkuDPYVu79c41Gls8TIXwWNKBld9sC2/LA4E/MMTMeidHesx08D9Ugv
	P1r6pDR4cYNgQgNWkmighLlUU1G48K3LgFaXxrUkfzn88Kk+iiCRX0aNpot/fz7aaAAIWi32xJd
	Q2NCLX3DiflXFMY4g1fV64C6Ut3veSQTOl/ebrd87rHnZErwSeelQ4SFRpu5wQghJmLLwWjE8y4
	J8WCK4Up1XNoegsHh+JFIbocxny3qF3lL3M3o=
X-Received: by 2002:a17:90b:57c6:b0:3a8:786a:cfed with SMTP id 98e67ed59e1d1-3b41c9617ffmr13031919a91.37.1795630871444;
        Wed, 25 Nov 2026 10:21:11 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b4062eb7cdsm13810826a91.8.2026.11.25.10.21.11
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Nov 2026 10:21:11 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-94961ed97d6so1037897885a.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 10:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795630870; x=1796235670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ancN5tYiJUgiK5oPhN0zaXHe/997SRSIfB0LkRBNW4=;
        b=Uj0GcKVj1kydRE6V9xgAcU/WoRE9v88Us8RI3YRc6Lx/Et1tD5IuUkMcAqf4ufOdmL
         OZV5nEldxLGUdU7LdlKKOC4fmv8KXXXM40KV68i2EgpQJlI0KjIPvNMy3cYBb3vnWWMM
         aitJaap3SMZm/Jvm0inIbBgEQ7HfQziCAkKnM=
X-Received: by 2002:a05:620a:4625:b0:949:5c18:5347 with SMTP id af79cd13be357-949b340227dmr3447623285a.6.1795630869541;
        Wed, 25 Nov 2026 10:21:09 -0800 (PST)
X-Received: by 2002:a05:620a:4625:b0:949:5c18:5347 with SMTP id af79cd13be357-949b340227dmr3447581885a.6.1795630865589;
        Wed, 25 Nov 2026 10:21:05 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38322csm1375419285a.17.2026.11.25.10.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:21:04 -0800 (PST)
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
Subject: [PATCH v14 4/6] mmc: core: Split sdio_set_host_pm_flags()
Date: Wed, 25 Nov 2026 13:20:51 -0500
Message-Id: <20261125182053.3915833-5-kamal.dasu@broadcom.com>
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

To prepare for a subsequent change, let's split up sdio_set_host_pm_flags()
allowing the second part of it to be used as an internal function for the
core.

Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/core/core.c    | 10 ++++++++++
 drivers/mmc/core/core.h    |  1 +
 drivers/mmc/core/sdio_io.c |  7 +------
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 677e445dc48c..6cbb5ee6200c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1422,6 +1422,16 @@ int mmc_handle_undervoltage(struct mmc_host *host)
 	return host->bus_ops->handle_undervoltage(host);
 }
 
+int mmc_set_host_pm_flags(struct mmc_host *host, mmc_pm_flag_t flags)
+{
+	if (flags & ~host->pm_caps)
+		return -EINVAL;
+
+	/* function suspend methods are serialized, hence no lock needed */
+	host->pm_flags |= flags;
+	return 0;
+}
+
 /*
  * Assign a mmc bus handler to a host. Only one bus handler may control a
  * host at any given time.
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 9be2875608ce..d3a2ff00b18f 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -64,6 +64,7 @@ int mmc_handle_undervoltage(struct mmc_host *host);
 void mmc_regulator_register_undervoltage_notifier(struct mmc_host *host);
 void mmc_regulator_unregister_undervoltage_notifier(struct mmc_host *host);
 void mmc_undervoltage_workfn(struct work_struct *work);
+int mmc_set_host_pm_flags(struct mmc_host *host, mmc_pm_flag_t flags);
 
 static inline void mmc_delay(unsigned int ms)
 {
diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 12716ec0e35d..99f857514b63 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -726,12 +726,7 @@ int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags)
 
 	host = func->card->host;
 
-	if (flags & ~host->pm_caps)
-		return -EINVAL;
-
-	/* function suspend methods are serialized, hence no lock needed */
-	host->pm_flags |= flags;
-	return 0;
+	return mmc_set_host_pm_flags(host, flags);
 }
 EXPORT_SYMBOL_GPL(sdio_set_host_pm_flags);
 
