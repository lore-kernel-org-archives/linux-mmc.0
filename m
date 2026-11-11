Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426288;
	b=2GyEY2G58JyST3S9Zs2rHS+/JS9/e3xgtbqnD4LPQmdLyDCopsDwNk5nuATQkuBN8Pil
	 HIUjZYVWA2OiVjc8cj4Pjcj+X4p4cvbKmmCiGa84Aoq4Rn7JarnFnJjE7d4/1MG2+gSFQ
	 uGOsE1GZqBNjIwWOYrlrHOE/pdRcXaR3sICE5eesv+NQ9+eYrsOtn4Qg1afhoAkN4BjHZ
	 aZw62VEYs3vnXbfw8Y+f/9xHVtoyTZ7MvqhARFXFWIzcZSklKh9ROfNc28wxPlFm6qJW6
	 1BD/TZpgQPQqm71IwtM7vS8h4JD4pg0cqeQfNlt5lvsshm8jl60gCqUbaDV8RE2Tpyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426288;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=7ancN5tYiJUgiK5oPhN0zaXHe/997SRSIfB0LkRBNW4=;
	b=FkLn1k1veYldqQrNwTv17e09bLX1A2Kw0lsymnsxunClPtxvx/rWNa0tGbzv6E11mz/g
	 kwuSUvc/K5AwBLyQvg8lRVR12NsjmKXh5LTqE1Bi1PoAqBCVFWCHg5HhVSYKc1YhpkiQK
	 aVu9dszXm770Oc5x0LfQLR8lzvSG0LZbOD0YHiibcX3EawHVuo4enzBhFppXhg8cj2ZGC
	 iJAAKsZiOnFRWwc4DCAn8oVNSLz1j9GQGEDD8iDuBgor7VmzwcM4AcI96YC6Lp0EJJ+nI
	 FjOkc3xVI/FPp0xGFJCwsB9i9C+O7FHt8ZG9wW17+jqvU3iDkcMfx9wYfehtJ132hhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=UZkPfKGu;
	arc=none smtp.remote-ip=209.85.160.97
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151B6606A8B6
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 19:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 151B6606A8B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=UZkPfKGu
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-48e94879f02so1238257fac.0
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794426287; x=1795031087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ancN5tYiJUgiK5oPhN0zaXHe/997SRSIfB0LkRBNW4=;
        b=jHiPiXKYfYcOz/sCH0Wfbl9dm5eDy9us/OFmnrNG1rdwNttjpbvuLtMJD1NwMjxZde
         DVfoHiVYU9BkLv36BiNUnLYpyuipk0VLnvs0mXwJyw+zADZbp3O+6F+l7tMYsQwmstyT
         iStvS8+WhsSVMlAvg13UGEab7VQA0C3ONGcPfoidiiMPqu9Kd9ammrjUJHYasF0OPTlj
         14Pxxm6uyn9DFJ7P9NYJTk5JUeE4xI+jaEHz3UHw78UBX0Je/5yjivIgrzhQbeHpc/ED
         TDBcC/2mpnbakhXwVvCIGwT1UXZC6xcATzqC5sdkZ5nfmJpqWIQHY4ThwW3OUDsIQKjM
         eNBg==
X-Gm-Message-State: APuU4Z+BGE5zZB6mnDpRPBbgAxARDkEeJxGypC8BpPbSJTKAvIvTQcI9
	B8pZyAirN7AZVp2bTqfubZPP+nCUiHh5PmV9rTH59TqYC/FlGf2cGfBTw3AH5+NxIcK1T80wK8J
	ufLVlrBe42FvQug4G3msTs7V2xMGdeld8HTs1b1hIqK0hU+r0gy1AKM5OwIfP1nrmsR0ta03T9k
	a94UBeEsH696Lyg1013/N570R9mxOwmTS1AyaxeoXslyg7XY3bUYPqOAHStLUXsTr7SalMeSG+3
	vTPpPPca1Ip
X-Gm-Gg: AYBFou2YNuV3pcmkzna8nYa5H4iD8yjBci+yh6P3K1taTLsQ0kqtPw6KZ/G1T7JX/aX
	KytyN+utaMyVrpI6CYLuhmV2gMaBk7r3zjy9z6sURfpu1NATFssQEDcDtCnbmXNrMn1uzyXHB5U
	eNoYjvwzcnw6l0c67Q4nMe5KSR1UYpNqFdRZJkUpWBZl8yc2gJ0eWh8FCGBXnG4ssSgLLJqlYv9
	C1Jr+M/PIAJZb6J3216iRPQqqjkqhta0VK246aMjZ1C/0oTqGXZ0jV6qq2OtrQegA77sjqeBLXr
	Pa5tkfgyAK/MsYm/mRe35s0qO5XtAGYl7OzEbceglwsOaMlh7nqa+BUgsf7/ArsKO+UHT8IN+na
	tN9SeZWrE7E6Y/zXNpmcqRyCzt6zETugjNcFfIR3obORw+AQGz4wlANTvjpg+VYLOS3WUGQph8E
	lY9Hy05XrHK5PgO6A+i2lsLx1UW5ZXwMH9
X-Received: by 2002:a05:6870:1cf:b0:4a7:20fa:b5da with SMTP id 586e51a60fabf-4ae46bb9326mr2925255fac.24.1794426286896;
        Wed, 11 Nov 2026 11:44:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4ae22fdff81sm70920fac.16.2026.11.11.11.44.46
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 11:44:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3763bd79663so1699072eec.0
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794426285; x=1795031085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ancN5tYiJUgiK5oPhN0zaXHe/997SRSIfB0LkRBNW4=;
        b=UZkPfKGuAF9BGRlxMTV+L6PI1sKR61LRtXcPSu8flR/Jvm3MDS568MH4MQPTcrJgd/
         /+ekArU0IDsRPF62EW2vrx7HwOKRT8Mi+CqcwUln5AoDiJwmKfG7IUZqJUAa4HL2S83G
         AYKkyfNkhHYNIrnaIU1me0nFrqgXQfzgQSu90=
X-Received: by 2002:a05:7300:51d3:b0:36c:a1ef:f8f7 with SMTP id 5a478bee46e88-3768385dbcemr4144914eec.4.1794426285125;
        Wed, 11 Nov 2026 11:44:45 -0800 (PST)
X-Received: by 2002:a05:7300:51d3:b0:36c:a1ef:f8f7 with SMTP id 5a478bee46e88-3768385dbcemr4144865eec.4.1794426284141;
        Wed, 11 Nov 2026 11:44:44 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm17948013eec.11.2026.11.11.11.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:44:43 -0800 (PST)
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
Subject: [PATCH v12 4/6] mmc: core: Split sdio_set_host_pm_flags()
Date: Wed, 11 Nov 2026 14:44:24 -0500
Message-Id: <20261111194426.1652644-5-kamal.dasu@broadcom.com>
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
 
