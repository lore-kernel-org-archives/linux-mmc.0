Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19983223311
	for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479255; cv=none; b=kcKvhq8qxMySUmvBQ+GHZF4TO74XfLBkMzToC8HeAwkMF3V6ZWNPMb9t584R/Avw7IFAOc5JWDXlIVe7a6Q5lknAJ0Rc7U9biBwjKkwuRl715HUtkc0QH8fZ+T77PGZ23YtmYlycbuCVkRDsgPQtl3IP+NpJP6BKy7kW8FR4FaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479255; c=relaxed/simple;
	bh=VhD8Av3HSuJHTUiv2cdROzFQDA9TdxYn3udhBrPmLPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UswrhxKRjtwBuRsr8pzZaatx0QxPw5w5x9bywbuklOYPQPhJTmhPGT7d9kdr3OpPm2NsnDP0FEqkTzZN3a0TDgk8WXpui/hz+lNNxTRhI98kAnMVfh4NQwO+hkdxF0MZF2ioOn1wcRIhQ3BSfTU8EkN8jRJDBBcvQoXsK9uqhas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B1oLyqwG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B1oLyqwG"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54991d85f99so2141473e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742479251; x=1743084051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYAI2eqixUcWJERcq8+IYiHipQCgnbOCM34Jd7N+9HY=;
        b=B1oLyqwGqyT03rP0GFXC82s/cDUh4gdQlsUNZve/uzwAbLZJk2y/RLv6ITzPYDRx2M
         etIcDIxYMpHP57RLIZhziRzmc0pmXnh6xJxrEQ4wCJlOJWnuAOXjfRL8p/1D+XJZa07p
         jbhbMWdRoS3f085uzNlQ+MhdThzt76ct++dW81eKzTEJkSmvKIZ2CopIVy2M5RwgQUIM
         h3RHxuYwFMtB96hFhSI8hVSul1FnxSVF1LJLJP/K108g2vidlIeegvkzlKNBbiEqtybk
         1JDdZblJdqSeS8IDdOU7cI3JSSFlb6avt5L5dvO7wxgKc2a9xlqvZZI4dYuHDkiPVtOW
         nWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479251; x=1743084051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYAI2eqixUcWJERcq8+IYiHipQCgnbOCM34Jd7N+9HY=;
        b=cvGyaykcSPrL/SQKny0DTkly2HyoQNm+O0JglULyixquGsPjcu7Dhl4fOtcZP3jbO3
         nmMiSB0x3r6/r6oHLXz0p/FR1lLxLUD5icABsOT2w9rdYXOrBh9992EfMgvGcw2s3dSY
         EH9poUgrTyF/vXDDK1mE97ZfNxfzffszp8ivS6EG256s8Y7TZ5vTtU4MwI1rD1jw+q5j
         s4lho0PprZihdh52RRgeNd3eBHVm4XnyMSzJ2U6/LKds0prh9YLLcOZiZqvzwUhqtW0Z
         +INiW2ALH86OF9CuVarIRRvPIHAP0DRDq6VbqGWtdMHR3Z6R7GW2UjOi8ucL9aUQHzQx
         LUxg==
X-Gm-Message-State: AOJu0YzzOXck9pJ50qe9aWb+mb01D7wm7hqHeuHNZEtkNaG+kd3Hqd0Z
	+Sqcwuj8woAOoySKHsPgoLqv0b2gpVvhbJ0yMtau9d56kH68Hf9JoMxIoPnBQTpdGm7oU+fZEZg
	L
X-Gm-Gg: ASbGncskuBu7Q0zN06aBcAENxTIIMVmid3JfIJfa1oA9O1N6SkxELaPwxHgtOS2YPF2
	swddDA+4h+UB+Gb8v8dGwHACoKLXcSFxl1DTV+LvXfMpHnRX76QVLNSNpeBgsLT0QdRo5u471mj
	Tt1DoZmjomk4vsZjNQM3QW+whX1OgHnPE2/x4fu00yEP2h+D729TXt2VPQuFJceJuObYIWOZLOR
	agbU6XLGyBVVNMWIJN2cRXmn9vYa4s0nHv6RmgM/bShFp2ronFOc7fnQXvUsEsfKONNU+Rdkfti
	F7bkqfQxYB2z2G5gVSYJAowp2UpaEcIwExXVC5GF+FrzE+4LMHNNDhI1tQyhySXvO7jgVyGasE7
	FSPWm8mGQgQ+8utt0e8A=
X-Google-Smtp-Source: AGHT+IE6l4M0DQlQYZg4ALvU5yllXDeu5+WFY7sQJFtppyPs0t//66RIGxg0FcrWHeDey/P2LeUHtw==
X-Received: by 2002:a05:6512:39d6:b0:549:6309:2b9d with SMTP id 2adb3069b0e04-54acfaa1caamr1050147e87.13.1742479250703;
        Thu, 20 Mar 2025 07:00:50 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864dd9sm2295029e87.148.2025.03.20.07.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:00:50 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] mmc: core: Further avoid re-storing power to the eMMC before a shutdown
Date: Thu, 20 Mar 2025 15:00:33 +0100
Message-ID: <20250320140040.162416-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320140040.162416-1-ulf.hansson@linaro.org>
References: <20250320140040.162416-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To manage a graceful power-off of the eMMC card during platform shutdown,
the preferred option is to use the poweroff-notification command.

Due to an earlier suspend request the eMMC may already have been properly
powered-off, hence we are sometimes leaving the eMMC in its current state.
However, in one case when the host has MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND
set we may unnecessarily restore the power to the eMMC, let's avoid this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3424bc9e20c5..400dd0449fec 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2014,6 +2014,18 @@ static bool mmc_can_poweroff_notify(const struct mmc_card *card)
 		(card->ext_csd.power_off_notification == EXT_CSD_POWER_ON);
 }
 
+static bool mmc_may_poweroff_notify(const struct mmc_host *host,
+				    bool is_suspend)
+{
+	if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE)
+		return true;
+
+	if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND && is_suspend)
+		return true;
+
+	return !is_suspend;
+}
+
 static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
 {
 	unsigned int timeout = card->ext_csd.generic_cmd6_time;
@@ -2124,8 +2136,7 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 		goto out;
 
 	if (mmc_can_poweroff_notify(host->card) &&
-	    ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend ||
-	     (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND)))
+	    mmc_may_poweroff_notify(host, is_suspend))
 		err = mmc_poweroff_notify(host->card, notify_type);
 	else if (mmc_can_sleep(host->card))
 		err = mmc_sleep(host);
@@ -2191,7 +2202,7 @@ static int mmc_shutdown(struct mmc_host *host)
 	 * before we can shutdown it properly.
 	 */
 	if (mmc_can_poweroff_notify(host->card) &&
-		!(host->caps2 & MMC_CAP2_FULL_PWR_CYCLE))
+	    !mmc_may_poweroff_notify(host, true))
 		err = _mmc_resume(host);
 
 	if (!err)
-- 
2.43.0

