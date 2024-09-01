Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94F423776;
	Sun,  1 Sep 2024 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725214974; cv=none; b=NM8qHGltC+qnEplm5KnEBMvqaRiAyr4TE/6j349qqO1p6JG9ZAnXKn+Dq0o/zzflrf5Pm/SwyWLrFLj9X8/r5b3lOI2+AwKwdl/HETGU6NG5K3Ns3VfO1qKwEtYK/RJr87jAGPqLdg5Hp8Zo36vtr/YTr2TdPsSYFGuUoIas07o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725214974; c=relaxed/simple;
	bh=hpNlgQXfRElTb7PWWpMGDFhZuOJeOPJ0FvdsAa0XCXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YrdaeDKzE5npFueReUegI0FvFSlh+LWl8aqPnyiJSsNcGFumgCwH1ffal9XyUwa1HuH3Jmg5+cY5oxXBbeqdJTrci+mkCOoPopYrn7Pv47CgrT0oYEqYi4zoiN958mjvXjsDi46umSBUqTqjhnb5chn9mwylC+5hpT58ifSXPAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGDaC0iH; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGDaC0iH"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5df998d7a44so2099135eaf.2;
        Sun, 01 Sep 2024 11:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725214972; x=1725819772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=851F5ToijGXyBoO87pKyhwdeDUVtSlD/UcoryzTOI8k=;
        b=KGDaC0iHOtPbRBHzJq8pa2L9BoIsmrfieODkOlMVM9pZye+h5ncNHiMXv0SyFOedt5
         LrvWpmYzIGzUxgvLFeGUwDoyDBJxqkWrW1L9xrP9JfFTQe3wDUcaITt8jbbGcfy0xGoa
         s33KG/5z2oM851N/CziYSyU53myaeT+rw7jcxDE2vmBZKufFGHN8lJW8o2lVPZo38K6L
         UlDM2AyQV/qGFLZP/hBaOIiveOIjZDdnqUpnlY+y+IIpPqm3hiA4+JGm7Srtx+sDFHbP
         o/r7ccQDeAXHX2Bh5dvYZk4UvzjuTUIv38MqcGLaDrszFt3hYselM9QtfdbWqxTcHGgZ
         nL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725214972; x=1725819772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=851F5ToijGXyBoO87pKyhwdeDUVtSlD/UcoryzTOI8k=;
        b=u9Do9+7DqMzlJoNZDtZUaKV7EApx3oPZmpxeUb1km1nlMisYEX8/ZT6dgZvih3BARJ
         CKgATw9+KhxDdmt2N3c9r5qtv3jVOQs/w0lSG+39FmNlnySlBEQf04+N5hBwur5XISu2
         BQ/M74U7L7gL7HKOzBd9PjtGWLXgtx1UCdWY5AUOUxSCx/IHxzKXCDv8fZ054d/D4cAj
         94bp0X1MiXY6Zm8MOOyx9vBx1J5BfbfKUU+2jGLXZt92vdbPG6QfnhMlhMZRpPOWFrQZ
         YzKHY7cfd4aZc9hiqVvLheN7rK+Y/ORNUDm+M6JldG5bjHRvW0b8HKvS2Un0nONobWBW
         zSDw==
X-Forwarded-Encrypted: i=1; AJvYcCUvsu8qaID5nvhvM9NWhcfzVtst0pRWomvGS+zrCgJ2b+PyRhgF9y7P2Liwr5mSczyE0MwcC1Vj4EyjHXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX8tKz6bDPlYFrz2aCCfrup7HOGrqntmXg3I2eG+AKwGPzgf1g
	DNcyTaZuJ97EbCNMvEV0a3nZOImSP7esoHGl7VQoXQpleHmEVqI/
X-Google-Smtp-Source: AGHT+IFaPfs0CYZREB9J7MdmoiorlgXKo175W2quFCjrLgWkxWpNCaRGR3QLmTnAWVCe2onjHTXzJg==
X-Received: by 2002:a05:6871:29d:b0:277:ca2f:905 with SMTP id 586e51a60fabf-277ca2f0c33mr6079901fac.29.1725214971689;
        Sun, 01 Sep 2024 11:22:51 -0700 (PDT)
Received: from fedora.. ([106.219.167.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56e5439sm5601098b3a.180.2024.09.01.11.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 11:22:51 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] mmc: core: convert simple_stroul to kstroul
Date: Sun,  1 Sep 2024 23:52:44 +0530
Message-ID: <20240901182244.45543-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

simple_strtoul() is obsolete and lacks proper error handling, making it
unsafe for converting strings to unsigned long values. Replace it with
kstrtoul(), which provides robust error checking and better safety.

This change improves the reliability of the string-to-integer conversion
and aligns with current kernel coding standards. Error handling is added
to catch conversion failures, returning -EINVAL when input is invalid.

Issue reported by checkpatch:
- WARNING: simple_strtoul is obsolete, use kstrtoul instead

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/mmc/core/block.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2c9963248fcb..140d2b3504b3 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -307,10 +307,10 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
 	int ret;
-	char *end;
 	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
-	unsigned long set = simple_strtoul(buf, &end, 0);
-	if (end == buf) {
+	unsigned long set;
+
+	if (kstrtoul(buf, 0, &set)) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.46.0

