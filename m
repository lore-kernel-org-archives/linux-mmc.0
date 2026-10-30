Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383878;
	b=MBoyTeTuVneg+bYU+FyMkNTBXpPt8J5QB2GTWe1Ln2jT93R0T8+ujbD0I5cgfPyBQKlF
	 bZ2oXKTYyK8nEOz2QnCeaAR3A8I506lCO/JiL585jaNQes+gqhpqcHA6SxrpASWEk2LkB
	 u/hW0W7PdMTnH00abERPcBXP7247C6YRKhMBQGCWYSFeSDEtlZXWwRXw+P9dHaeayhRmA
	 HyAUtp0t2F97FbZTdEy/7E1VS9HBPsBOLIN31w6sZx9Qs7JOb8AsEhFGY9M1BQj99MnSV
	 rh9zgja2BgL84u+yAfA4hFUCy+WUGZIkXCwSywVQmjTUKstGiogL/gzOtmd+pLVjRsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383878;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=KX9VsWiwW35a++SYtlTrxjs9sLoEMITslby8aUNfDtY=;
	b=Op+6AldXCqSvuQhYSe+joFLJHeRVyPWdUVSTvL/gUL4H0tOn9+J+hR/e/9lMjBKfrZGg
	 uUtsnqTkRdjlL2E8qbckPuQDV5uNz9yqchZ5vPSCKlx9HBozBg0CPQ5MqZqfFko3C7V6G
	 MXFY2a6fCkgzT4aZ8zvWqVNAFsCcY9TxDbZDJAsCquT8Ni2YvWbHw5gdJn2ce10ns3Je0
	 QE1B/HzVV803LerfZaMIHP5QxguQdWSwnm0NiPuf14qgHUahW0KXxytmAWGv9eKN4yaM1
	 1jfHNNQEYcTJ3WX6qhFUCTc7xYGUrwubBXqNblTY+Aa6BrEGEUgo7zofg7WiKcQjI6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Y+lUk9S5;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6BE606A323
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 18:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C6BE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Y+lUk9S5
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so1467358a91.2
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793383878; x=1793988678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KX9VsWiwW35a++SYtlTrxjs9sLoEMITslby8aUNfDtY=;
        b=PrE/NB877VJ1M9msMyCyJkcGSqyi+WBF0aMSuGti8W85QI+ZrcPvyy0VEDKzzgRjyJ
         qzj7xzOOD0UBnvy3J4IgMt93VA1rxz/DL8Zc05BxSuARfpH6AdHri8meda0UwZzhOqhA
         ZVroQqx+8KcRdH6jgb5jbu5amiSOUQMa0ZNEpkDFIoROn94o3EbLC0IyTMNElPJ6g9wq
         JONIQ8Asqnb/AX1cRI36c9JtDhacNI44hcdiZsgJ8d0et1XQaRdaPgHRdb+6MIpJdU4c
         ENgUXqmLzoRMZelv9wYFP07IZVZiV5zVJ9UMCpapLBo7KIe+BsFFRFAvwBkaKaQmF32q
         s63w==
X-Gm-Message-State: AFq9FYJuwr4uJta5YKGBtViy7aL0jjSHW5XygwEbexQhVIR1HqBBu8xm
	q8Yd46t2a2LEeHcSuW43dBlDUM894nb/5gvhj4a6/7RbePHz5tRIxkWwsKSWwUEAz76bI6rRvO5
	CPjK3y2nO+ZO6UPdYa082QHepigq9KRoY7c7YUQCcw4eF+BtnqD3tI62BzQmxO/526bcpa24Ece
	kYMJoLvzPB3EUN8lAYJAJ8nyP8BW2K3aiCjL+LXpCllyRBdH21XYC4afqRLmyxW09FSi4ZT5vTr
	dKAJbfMWEyL
X-Gm-Gg: AYBFou3Qkn6mhugzJGeAOqqG6meeYffFoTiX7WeR168IQjBdWxY5IFRpOvZWnhqt9d4
	rWHq6+y1h1iPq0BYILyFRfnkYAHn5mAGci/vZVxEHdtWGiStu4e7fUriBQ42TuCDYlTi9Ono4n+
	Wy+aGhqTg3RDoU44FlYENOlHxz5WzLFP2B+DcU6i6Xt+SDwtLPPu41Yix6/6Uf6lsgMJJm6Tnwc
	n+VMpsEDOzAjlCQxadwVnucvJMu5RbVYH+FBieiI0tl+R4nv41xFI+Zt9Sr5v4bqfI294UYeYcQ
	1bMLDf+3tbI9x6dlIK496F0YI1tgtDateZayxxE6rHR1bDvDirn+UBu1EcUehGpZ0IifNALyafV
	3k00yYJJZauU9KRzzULglfBthfKjT5uR+m1FEaIXXQSu9y3G+KE3yLpQ+5ULHzxj/kLCLglBses
	5PULDEifwLQClWn/7DhRmagqWZ08PA5X/R
X-Received: by 2002:a17:90a:c88c:b0:3ab:884b:65b4 with SMTP id 98e67ed59e1d1-3ae8984ceddmr2629838a91.59.1793383877805;
        Fri, 30 Oct 2026 11:11:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae85cc3344sm956000a91.0.2026.10.30.11.11.17
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 11:11:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-154e9d2d94fso1898558c88.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793383876; x=1793988676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KX9VsWiwW35a++SYtlTrxjs9sLoEMITslby8aUNfDtY=;
        b=Y+lUk9S52GpgSqkFxmpOfwNnhOpqBRdpXpu1/8vLyKaJGY07IortaOe0UY4bTFVUq5
         Bm3LbOqSgh+5UyjNsRbMx/sQIGHPm1rou/dSCabXxtaffBO2XI8WpeRc8e1720IiSvNP
         aFKWSqGxxcJrjWQ8gTm4FXYTQEf9/dsH6bAkY=
X-Received: by 2002:a05:701b:2910:b0:184:5f2e:aa52 with SMTP id a92af1059eb24-1ac5a0b4358mr3869608c88.16.1793383873763;
        Fri, 30 Oct 2026 11:11:13 -0700 (PDT)
X-Received: by 2002:a05:701b:2910:b0:184:5f2e:aa52 with SMTP id a92af1059eb24-1ac5a0b4358mr3869550c88.16.1793383872956;
        Fri, 30 Oct 2026 11:11:12 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac193b8179sm9974062c88.11.2026.10.30.11.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 11:11:12 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
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
Subject: [PATCH v11 3/6] mmc: core: Add option to keep an eMMC powered on at system suspend
Date: Fri, 30 Oct 2026 14:10:30 -0400
Message-Id: <20261030181034.3811225-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030181034.3811225-1-kamal.dasu@broadcom.com>
References: <20261030181034.3811225-1-kamal.dasu@broadcom.com>
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
 
-- 
2.34.1

