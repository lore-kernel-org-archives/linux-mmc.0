Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756034E01EB
	for <linux-mmc@vger.kernel.org>; Fri, 16 Oct 2026 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168639; cv=none; b=p42zBJWRT6JCKCvpXCFeMnONY/X8hc+YFfhPNcSWxKTOH/bqo0miCj4JZZkn0QvpZT8r03W60JSP/Q+M9PPfiND6I4RysRkfFazK9XRzVpI4ZqXhWlPcL39a7UGgEeDBokXZHhAFwATNzRRzsviB8A3hgetR+r83fkqzkf428Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168639; c=relaxed/simple;
	bh=ay0QhUIxWGqQW7tkXs2XfwnADTvpm/OD3c2MGP4/vpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMa5RkFQUyZ80VOXVxsbz2Jj4YKVhq92HonllV53z7mYgHWKcku8wuJbKCtfk48A70ID2BhbIuP02RwNaiDKv5/2ZciQLjWR9McFN2wn/phoYnQawck9hWziZQsf0xZlY4FKsXFqB04gXpDnZvNb3N9FRcqzN9+H+6gUKUUsv74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwrPIoeG; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwrPIoeG"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbe437a530dso13355a12.1
        for <linux-mmc@vger.kernel.org>; Fri, 16 Oct 2026 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792168636; x=1792773436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fE/8k1v1er6yt8K5zlufTxmneZEuI8I3OJXU6lY3dxA=;
        b=MwrPIoeGFOy7FkZdsQzeZ/DRbDwSpkRA1Fo375X/TH7U/C69ozfBKrSWeWLBWRM5kv
         XmL47UpYlAT0bHRJ3IZjYI5XeEU6o1nIaG5mYYxHhTdaOm5LHhvsLiYy07kNcNrNE+tI
         m7Qjsft+9CTn3oAlN2EfTylW5hvGRJMP/JxcZA9d21eUzy7f+z+96vz0VKa5uZgDl8MW
         nHYRev/u5MCfqGcH4E7UHfRgQ4gE6ZkBr4jSmY/xSBfkauW4x6hLaEGslWdy+3LrqDSw
         5o0OpRDqoN2icKP/PYu4njLyaxmcCmHaXpjUJ88dAlIW81QfjWi5ft0MVKmeBJ9PsS3E
         CUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792168636; x=1792773436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fE/8k1v1er6yt8K5zlufTxmneZEuI8I3OJXU6lY3dxA=;
        b=ArkynDH2CKbYdXXcae0NWOa9ufbCbSXmti6czN5CoRtIWYncQEyj7l5a9KrRo6FQ8A
         BL3O7bfUtDL7Akc3mJJGocDW4inbBAgRaSBinBMdf9AzxFca7rFXycyvi7DfGQIqDEFR
         NLxt3WVw3i6qCEz1RsbufyoB8qHnnRvUDQn5n37oTRM6Qi6lwk7HmXZU0ucV2W1+lHva
         iJ8tGNigav0UeztFzqUYeAadGbY0zGyZ16nXionxHYzIoK70ZhxZ6aRhWXiKltFESyZ9
         pvI9QUjFlBBwI4ABPEzsXOxHwOnicy1R7HbPvpIpfYYIjZk3BDNiuQJsM0W+KoOhndwC
         xXbw==
X-Gm-Message-State: AFq9FYKZEpsy50PY1MGwEvJXALxreVemXTMOCtCjeJxe4xa9nZqmC/Xd
	lvitpmXrELK448hf8ubAvUdIkyuhfGissz3K1h0Kk3HSEkNXu6PfAX44
X-Gm-Gg: AYBFou1F9HxnNnDlKHdyyXc2+5nSu2ZcTSgLWQr2vphovNUyumUdWNhDV56C4O/Xlu8
	D5ZLShHN/vkUXeX8/fdQvYzdffCDs7wH2/RK6hqUTdWJXlnEz1vgs9gF98vWY/sV6gY+aR8TlpU
	l1WkOWHBrS+uD/pvUi0YMVBHGPCHAB0gFoDoRc6KfsFSCVtJIkBhx4vpRMmqPekQ9qyhfFGtAJX
	b8zivIXhbEWEDn5wvVdbm//cv9N+gHQDcl1WS4BdH8ElQ20erMOUQmipomQR8nwQI4N3KU2JSr7
	3KDitB2Qpr5w+rg+x8Q61kWxU9h0Ya7pMD1FPQKiV16N0Me2k1MLmPf6BcUnK1nwLxEOuWFGh6T
	Eb18ue0JuTg2JW3hD3pgDwlvybC3qmfUwyuoAxU1+aEPFbJiNmGU8BA/77TC6fAKtkaIWH8dTuA
	nqnQJAWmjRx1dT896Zv1dcr6q5qOy5XeCTkSxQfqqxCLvkCDTkMIdWmo2UkyZLBvQd0QYEGOnFM
	jgmIbEYr9yekiu+lXlWoQI=
X-Received: by 2002:a17:90b:4cc6:b0:3ac:9e76:aa96 with SMTP id 98e67ed59e1d1-3aceebea420mr590463a91.3.1792168635662;
        Fri, 16 Oct 2026 09:37:15 -0700 (PDT)
Received: from MELOKC-LAPTOP ([61.171.228.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9474b52fsm11154255a91.9.2026.10.16.09.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:37:15 -0700 (PDT)
From: Anfernee Cao <anferneemelokc5@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Anfernee Cao <anferneemelokc5@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: mmci: fix DMA channel leak when mmc_add_host() fails
Date: Sat, 17 Oct 2026 00:37:07 +0800
Message-ID: <20261016163707.3508-1-anferneemelokc5@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmci_probe() calls mmci_dma_setup(), which acquires the RX and TX DMA
channels via dma_request_chan(). These channels are not managed by
devres, and are released only by mmci_dma_release().

If the following mmc_add_host() fails, probe jumps to the clk_disable
label, which only disables the clock. As probe then fails,
mmci_remove() is never called, so both DMA channels are leaked.

Release them by adding a dedicated unwind label, reached only after
mmci_dma_setup().

This issue was found by manual code inspection.

Fixes: b38a20f29a49 ("mmc: mmci: fix return value check of mmc_add_host()")
Cc: stable@vger.kernel.org # v6.2+
Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>
---
 drivers/mmc/host/mmci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 416bdb184ed4..4db5c55b2700 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2477,11 +2477,13 @@ static int mmci_probe(struct amba_device *dev,
 
 	ret = mmc_add_host(mmc);
 	if (ret)
-		goto clk_disable;
+		goto dma_release;
 
 	pm_runtime_put(&dev->dev);
 	return 0;
 
+dma_release:
+	mmci_dma_release(host);
  clk_disable:
 	clk_disable_unprepare(host->clk);
 	return ret;
-- 
2.54.0.windows.1

