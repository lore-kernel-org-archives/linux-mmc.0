Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08493A6EE6
	for <linux-mmc@vger.kernel.org>; Wed, 10 Jun 2026 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080878; cv=none; b=e9Dkcdv9OOP5YeZHPtahbBSwTwgTkiPVhiSEme27dULdPlKJJl9wvNXUfrwELRivmHrH1kWoIfFeGw3uvx3SuF8aQgp7KWy/OohuZcW62DjIJ5GCztCjpTu5CAl3orWJtNIngEIHROqDMCTR99TNFbbcS/YIyLQEyOko988EzLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080878; c=relaxed/simple;
	bh=hejhQgh9SjSMB2wUG675foLCLDteGWPVQ7rZwyGrnmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uod0di0YqKPQowWz/CdNlmuUIfgyDURw8rNO9zFCvA2D/NQPpihphp+nhyJa7mnGQzQdC9j1EuypRLx450Ikoy8oyFz2un50ZIWcNbWF17udKRQMqnE1rapsQtaWv/FqzVK6BYP+kfV6HtwHKPOTIJLFEKmHzNMy+S9PkWZELBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=O/gcrW0N; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="O/gcrW0N"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso55120575e9.1
        for <linux-mmc@vger.kernel.org>; Wed, 10 Jun 2026 01:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781080874; x=1781685674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rzWcaWV58v1ShQvqrIYlQUStPpHO8vHGq6YxhWtcmIs=;
        b=O/gcrW0N8kqwr3kGfIHM/XYHIpd/9WpYumHnLT8cCCUo9Xan7WHwUH/xIYWTrDcY5l
         dBmIVVtwM3v8xQB5DHotRalPONgchNkz9VeifJxlqtGBIVVhnN+32zT53zCEZDtI5MbV
         RGL5Abnhs1lcZMKavWjK4azZbyZQjxFguwfX+Es+1TVoeXQh1mBRzq8wOoCwGhAegfUp
         oKlYSeDzECQaSKLSfF0NWai6dkq4KWVMiRBkN3SIfdMkMlsV7TWZJCB1fhrfX3kXTN1G
         uxacpmqN6ddEA4NmD+mIW0HlwDaluolI50efVQI7kboo5tan3MWH11gu3g8+OC5SCryh
         uOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080874; x=1781685674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzWcaWV58v1ShQvqrIYlQUStPpHO8vHGq6YxhWtcmIs=;
        b=LYKrncg+sVHTDpymjqmwkmE1VZFss/wNg1PFwVWn2SYqXNHze7TJtq32ZijPbcURYh
         NRTu6iF5NErQt6tUzFnGdaR+83Df0TL4Du0qAd6h7rRSU3Xc1tdYFAvyw9L/lpSJspXD
         YKVz0D8Whbh/fbwcTxb1nInluN9eme0hTQHpggPHAOVaCtxFrxm6jUzLLbA8R6w0Ih+p
         WH3P9ap9b9Qm/k1BvW2id8evcAIclqY8iu6En9XElat6xP6ZFDLBa+spMWzNlVhUXB0Z
         j5Iene5kolSA1nDI6jK3prNwICZvv2JNzaRehKNuBi7qzyuOjHdu+rEGTqTg3wJrpp4J
         sOCA==
X-Gm-Message-State: AOJu0Yxc/4sBRYp8OQ8zdoH9xyck5PM2BP/FMXw+s3+YXRG5p//YHn6p
	+pXQZ/wQYprYSvFjBWzr0/lqyV5UTKecU4bJ69BS8+Kpt/GJNRZVWM4vQSj210vlPTg=
X-Gm-Gg: Acq92OHGqQ58d43JxRqUCRgNQZ1lIgofMfkM2t2bfzX5dF+auyZvLNumvnK26kwG8ys
	388J8cgvUuhTwqdNirMgAP6lLpAfqGXS7HdSEIozLMTxCwJGJzIYx9JYhgEESgF2Eben5BhfhCs
	dIgFxB18r8MsmdKr1E2G6Pnm8rW0JdCjj23aLLGE4amw+mJzoSZKskbgB0sOfK/frM0HeNGzcAn
	09ekEukc8OEWPezglfCtzczpZY/lhT4nldTLTDhz8+ldPTePGfKDQ+nVhAurAaEIB9rfkiCFKWx
	MFc53v+l6ARJ/ZCL7QFWhvWUV4ER9AbLvj89aCX426Ux+jpF2r82/QVYe/w4SNaxKfhMkvB0KXQ
	DQGQkOW3KtWLx1JaU7e579tv5WQQSMYaAXrSpEBhJJQ/GK9HYavccxzoJftXq0gAmbFnnegQXRO
	5zPxwmopICeVvd2BF0Rb5DgCMz+7GZDIUzFYNltVs=
X-Received: by 2002:a05:600c:5248:b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-490c2522657mr382081105e9.0.1781080874190;
        Wed, 10 Jun 2026 01:41:14 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:559d:eec2:887f:c200])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490dcaa924bsm78623205e9.1.2026.06.10.01.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:41:13 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Pierre Ossman <pierre@ossman.eu>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] mmc: wbsd: Drop unused assignment of pnp_device_id driver data
Date: Wed, 10 Jun 2026 10:41:04 +0200
Message-ID:  <0a4749ab9ac7ae0db0a0e651267358e947a1826f.1781080709.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1634; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=hejhQgh9SjSMB2wUG675foLCLDteGWPVQ7rZwyGrnmY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqKSMh6FfZYByVNXe2h9KscIBrc/9JPTDowAppQ 1JiwFnCpPOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaikjIQAKCRCPgPtYfRL+ Tm3hB/9sUNw6oH6WOhw5jaLaYDWksy1P2NBZtBxAhJFkgUQA9S8vxpb4PwVnXQs5g4tJP6s1Lam iNjLB+eIy2XtZW8FCLaQPlCSyelseZyWfmyYCnYPiC0/hj86GudOPDciNjdldNJI8ibaVS5nuM4 vAkoBXuEwff69ZXM1RQSifgDBUkof/YGimhVMdHazueSZ+fXQh+Th20JDy7dfsW/vQCWcFgJk4m 5uD5NqyY1O5ZT4OUd4GkEr5d2a2HdQaWa2r2sUyfVVFvV743+11ETcydxp64uqNH8IBPHtPnWrk noYVwF/53t3/m+hCM7SfDLTciWjUSLbiZUeJacySbxuuSril
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The driver explicitly sets the .driver_data member of struct
pnp_device_id to zero without relying on that value. Drop these unused
assignments.

While touching this array use a named initializer for .id and simplify
the list terminator.

This patch doesn't modify the compiled array, only its representation in
source form benefits. The former was confirmed with an x86 build.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

I intend to change struct pnp_device_id and for that it's required that
.driver_data is not assigned using a list initializer. Instead of
converting it to a named initializer, drop the assignment as the value
is unused. So this is both a cleanup and a preparation for a later patch
series.

See
https://lore.kernel.org/all/cover.1779878004.git.u.kleine-koenig@baylibre.com/
for a more verbose description on the mentioned change to struct
pnp_device_id (though this is about platform_device_id, but the idea
here is the same).

Best regards
Uwe

 drivers/mmc/host/wbsd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index c33a0223ce7f..51706898239e 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -52,9 +52,9 @@
 #ifdef CONFIG_PNP
 
 static const struct pnp_device_id pnp_dev_table[] = {
-	{ "WEC0517", 0 },
-	{ "WEC0518", 0 },
-	{ "", 0 },
+	{ .id = "WEC0517" },
+	{ .id = "WEC0518" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pnp, pnp_dev_table);

base-commit: 49e02880ec0a8c378e811bc9d85da188d7c6204c
-- 
2.47.3

