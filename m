Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705C017E472
	for <linux-mmc@vger.kernel.org>; Mon, 25 Nov 2024 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732537499; cv=none; b=t5OHPTxWc12Z1OVo1pk8NbxqIoxLXnjZfuE65G8/gjBtLcOUU3DiQXnQSgrY7czeryClW8XMcmQscu+4oys2Y6XlIL3f6hwPNh/uv+C/khqcH6f/EELvggSYze8ZcNADIPQBmsYCzqGolOAhfjb8jXCRvDbHGJ5TbXAUHcjJzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732537499; c=relaxed/simple;
	bh=1MIhac942bYqThQhO2fYakc1q0gsOhjIRGIpfC6gHDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dorrPn5yl60+LBx9rnOkic9K9dGraUB7yK2qGP4rvNl6/h8q/wX0TYW+C6wjArrA/+4S4p/p1xtXjhYiPJk9fGhGOEdGCMIRKThXu+15rok7B3Wrj4kjett6J8+/3Bptk8GLydBX/5LS0kRxIR8xaTlKluovyrpaWR2A0nu8/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MfjBV2tJ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfjBV2tJ"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53de6b7da14so379349e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 Nov 2024 04:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732537495; x=1733142295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPJcH/pZUFwQXY8dj6Du6OSGV2ZbBkDCGcyY6tthZEM=;
        b=MfjBV2tJCcZ/e5Om7TBlnrg/Od9lllBBinNNlTs1vgaYudCbwsqkK6UpY8iyzxgXY6
         R58Ci37+2jHeK4lxnF4NnFLJkKOSqoMM95VC2BZl1NPgrXcH3xhr5vQHGKLI2iwqffn6
         +PoeDavpDHnMjcIAMJKmTQ4XATrePHjElrRMKyCaaSlmUCkb6l95oU3oTm/GKvoUVGfh
         DIlloYRFGSaQm0O2C+tUHGPFCIW0j4gwwxGTMl5l7f1O2um1epGbh5/Tk/EgBNeXH6+s
         b8K1PWcFcA2hW/CBVV6fdsLyeqAwRrse8FwMZtjqIB4OVCLL7on4+A5URfHJKnsWNHLk
         W4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732537495; x=1733142295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPJcH/pZUFwQXY8dj6Du6OSGV2ZbBkDCGcyY6tthZEM=;
        b=AtphyKjVS3a/zvURQynNFnz+wSOPJa88pI/94KEMwiKw1bZi2diQjRGSxZYhl4S/NX
         tA3eF/0/hK+6yd7pdpnWdlAF241sazFZDxV9YBi6bbXLM3sa2VnVy+NI108RrUA/7gj9
         /8AhE3A3VHswaderZZb+gq2+GOZxZORsKrWP8I07pOUnaORc9npdJKNua6wwoU2x1AO0
         K/iyNrKL3dvrIbJ65YtUPKq1FJVQB4LPXNHsWGL0qZTYzpA9LFRGZ0aZW82egUPol0W+
         u6fOPs5XgUabAlRNKK3NWrzjsGJuabYUa4Ey9QsakupnYkenp8qM0QFdqa2u7kVYyhO9
         lgHw==
X-Gm-Message-State: AOJu0YyYZy02hJcN1iSFMVFZLM26JwVWqCVB7ZKyDb89iYZGAqoFuQIE
	CA4Hh16fz/RkIrFwIrZWV86gpfGKLkRn38vGzVW8IjNq7FZBSV3ZPebHXUQyyP+YB154yjjcwsr
	c
X-Gm-Gg: ASbGncs5gME9gySfoL2cSYM9kvLRnEUjHuN8KHqf8XIfZBfq7k9sduIjD9R3xYZ04lC
	MWJrVt32CCD+PgY1EroSryieVA0GEURk/5rUaW9XbY343VBhgXx20DbRAhZC9DqiKQxuGraMNu3
	3IeJPT2t7qrJPn/ROVVoceVZ0MvTHKggrOYipeXDEltKY7+2Uuglkjnxu6U+vHdwnkjtcEmSKyn
	jWWSgEP+3sj5vq085gpfnFmRSRjz5ddY0K1dUlW6H/JVXQQpQ70JcrYM/UbKZs8hWeEVFlqRro5
	S3TQ1zIg16zcNmXm+CutvZ4n
X-Google-Smtp-Source: AGHT+IFlVjwEQfSEHD92mmB7kec/o4wkAJx7J1K/QCuKDC+tc1kL8fPqTnY1+jYN1nta3srV5ZSvBw==
X-Received: by 2002:a05:6512:3e1b:b0:53d:a122:dd0f with SMTP id 2adb3069b0e04-53dd389e353mr5547727e87.28.1732537495333;
        Mon, 25 Nov 2024 04:24:55 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24457d4sm1655255e87.54.2024.11.25.04.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 04:24:53 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Anthony Pighin <anthony.pighin@nokia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mmc: core: Further prevent card detect during shutdown
Date: Mon, 25 Nov 2024 13:24:46 +0100
Message-ID: <20241125122446.18684-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disabling card detect from the host's ->shutdown_pre() callback turned out
to not be the complete solution. More precisely, beyond the point when the
mmc_bus->shutdown() has been called, to gracefully power off the card, we
need to prevent card detect. Otherwise the mmc_rescan work may poll for the
card with a CMD13, to see if it's still alive, which then will fail and
hang as the card has already been powered off.

To fix this problem, let's disable mmc_rescan prior to power off the card
during shutdown.

Reported-by: Anthony Pighin <anthony.pighin@nokia.com>
Fixes: 66c915d09b94 ("mmc: core: Disable card detect during shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c  | 2 ++
 drivers/mmc/core/core.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 9283b28bc69f..1cf64e0952fb 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -149,6 +149,8 @@ static void mmc_bus_shutdown(struct device *dev)
 	if (dev->driver && drv->shutdown)
 		drv->shutdown(card);
 
+	__mmc_stop_host(host);
+
 	if (host->bus_ops->shutdown) {
 		ret = host->bus_ops->shutdown(host);
 		if (ret)
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a499f3c59de5..d996d39c0d6f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2335,6 +2335,9 @@ void mmc_start_host(struct mmc_host *host)
 
 void __mmc_stop_host(struct mmc_host *host)
 {
+	if (host->rescan_disable)
+		return;
+
 	if (host->slot.cd_irq >= 0) {
 		mmc_gpio_set_cd_wake(host, false);
 		disable_irq(host->slot.cd_irq);
-- 
2.43.0

