Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FF728387;
	Sun,  1 Sep 2024 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725212000; cv=none; b=XJLXUs9LebSDK7S/Hk2EQ7VkvN20cz3bmIRe+g1RO7fJ33SfVCgJhmxWr4f0MAwd1kCzXkNNWCsxUwwpoY4cknmTekkrTMLkFqBOdRAmA23f0JbUNSJIlDQWvuNglM5pPBmibwdW4fPIA7G4GLHACf4gu93KR2l4ryqpJK/GthE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725212000; c=relaxed/simple;
	bh=N2AjIuHTcLBgR/IBzold+V312lKsHhv8qHXKrNzaaao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oXt8se1C/CwoSKbc1nGl1Z/+C4zSCfmQ92OXSsN5SJD4xB1jq+pTZUQgUhCYbcXPPJQqTFpR8fWdDSgQqs1WxqYQaONrweHbIvh7Eu2P48GFy+9q4rWeYU4F5swt2NwmFhPqeeaulQzPWIRYIgwmdRGxxupQKY9tCTDkZsrVGzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oi0XBwDZ; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi0XBwDZ"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5dfad5a9c21so1519553eaf.0;
        Sun, 01 Sep 2024 10:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725211998; x=1725816798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6bXJHG6lWckj73XUa4LXT2Ji7chAifQ0hvSuTg50kg=;
        b=Oi0XBwDZ+GliRjo0n7QYRo1Ip+KTMEKoV+v2YCq793b2UcNS3U9b4Kp1MANKQqaAfq
         eOLYA3lwpVuLvZRXPf8NiN0sLY8YAyvjgQ8dyKF2l9vkflgDc1LM1Q4sCTWtVROg9wxj
         Pzn3VmHj9KuwVb8/tmWdn9ypp9e8h4WOd+K4td+ZZl5wK9T0I0fEi8iWjbuYkXJs4n8m
         8/G0L3elpubCStiPyLM/PCGsE9w0SqJRM3XEHYZG3XQ4PGrwGgFpn+hc7U1mcj807nu2
         ixeoKmegm9PtReHXNn9moRB6JlB4/4KX6knh8+XWFr9LFa6K4UCVkOZzcXkZB06zC0YN
         wtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725211998; x=1725816798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6bXJHG6lWckj73XUa4LXT2Ji7chAifQ0hvSuTg50kg=;
        b=XypZLHlGed4AaQCTTs42qeBxmsMuGM+Ks4CfP6hgVy6041pJpKMyt5B5UCGazAP0Ql
         LHPjLBWw8Ge31XBtg2MrSTT3YaS80BpQjlszliTIfWJOHdRl/WcIhfK4gqciDHjDmJwc
         EZZAxxSaEJ9lqG6OnpKFMGSxyLZ7fh46yZMfJRrPybkBzff8PpaAfRqpOwwDrQQRnl4n
         F1yt4OLrdv2QQOgxrUMt9w3lYPcKOqBfm8QLrKtc1F2mtQ4VmQK3J9/AqLqYREIKVz+w
         c8rEVkqNwHMRcyKzXbhOCjWpJmEWLKkTDKfnsWYzMIezQ2c0eV/NrUdH1BcnsM6AvzYb
         HOrw==
X-Forwarded-Encrypted: i=1; AJvYcCUqZSmH0I3fhaTWAXBz+8gdQ1TnOYaKFVEdvdTpc5WRERF9NjfyJJZpLJCzKKDZp628Yiqw4aZibvnjbZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzH1W1k13Gb8diQjUKeXGRfWXIOufAnsMjOFl6E98NukAzzisH
	CX2sy/h3CUE8kIgzS1QAdLa8sPdf5lM78thBJgxUAQwJ4blDUpj38ljfi+4CKfk=
X-Google-Smtp-Source: AGHT+IG1nXzzkcfCirW606WgsV86rXonsxVrwoawWMRLRyDPHBMv3CjetlCpWfolzH/UFtwH9PKyMw==
X-Received: by 2002:a05:6358:9986:b0:1b3:93b8:8c1e with SMTP id e5c5f4694b2df-1b603bebef8mr1321169955d.2.1725211998435;
        Sun, 01 Sep 2024 10:33:18 -0700 (PDT)
Received: from fedora.. ([106.219.167.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a596csm5572029b3a.81.2024.09.01.10.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 10:33:17 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] mmc: core: Calculate size from pointer
Date: Sun,  1 Sep 2024 23:03:09 +0530
Message-ID: <20240901173309.7124-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calculate the size from pointer instead of
struct to adhere to linux kernel coding style.

Issue reported by checkpatch.

This commit has no functional changes.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2c9963248fcb..dfd495e86985 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2484,7 +2484,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 		return ERR_PTR(devidx);
 	}
 
-	md = kzalloc(sizeof(struct mmc_blk_data), GFP_KERNEL);
+	md = kzalloc(sizeof(*md), GFP_KERNEL);
 	if (!md) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.46.0

