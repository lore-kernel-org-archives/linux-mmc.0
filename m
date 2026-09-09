Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42359531AE8
	for <linux-mmc@vger.kernel.org>; Wed,  9 Sep 2026 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951554; cv=none; b=eA73ltZJRs5FZkI51uoXIzH8mivh+4Fluf2TNvN+ZCLItJD0yRa3cpCP/TxsuOTYZy3Yn/s1YcxuDPq7lIsPw9k6yLqLnqAqSXP2EVDHHb06Fk5EHh7kiJIgeVLbkuq2lmtfLVWJM3BCidHkPtgKAahMoyYlEqVM0wfcs9ISXLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951554; c=relaxed/simple;
	bh=RUO35p/hYiz3qwtxTqHtL1pfFhUUTjGTSPmbomopvYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTQS/PUhIc1+N/YPwdPhTySG52Bzu0VWc5R+Of/Q45pHW2Int9JyOqzdtL8trKe2aacy2Yy0XU6enggVjDER5CJW4RIB6g62TAknEi7y6ABuqOX0KFN4wYSODhxtHOVQzL1znAcyNWSHN6ckfwR/4p4C5yiPRNTRwxy6EqnINzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pAL2d1U7; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAL2d1U7"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d90ba1d807so701475ad.3
        for <linux-mmc@vger.kernel.org>; Wed, 09 Sep 2026 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788951546; x=1789556346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xc+Wze03aW10ioVYI+L7Um/7DBQSw6qOvq0My2EOj7U=;
        b=pAL2d1U7NU7o638SSBc1SQN94sq2D6jVKwm5Erqoeu5qN0jftc6svVQgdfICIZLXSr
         3ZVPEik/4pbJhzBvsMH+8kIHabOVLGA4KE6h0M2HUr/dGbjq0aLRAjlO0kTmn3PiBGGX
         u23JgQcH7Ji6azaaZ0rsYq2TUdI6odmt4fxVsqDXMHR5LVCAIvJeaV7uwZk6vOFrvbcG
         INfe6xaMhtqf+tH4745oRbCjrkjq5ZaScZ7GaFTFK2Q2rFwS9ZE0+4MWjGS1l1rOWH/m
         qpSNEQDafwUq71mChxqEZqVU6X/y17VDnTCv38bv5/00ZVDmQ5rRB36x45bmPv4lEn11
         aJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788951546; x=1789556346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xc+Wze03aW10ioVYI+L7Um/7DBQSw6qOvq0My2EOj7U=;
        b=aiPya7WJi352rMtOdo3/zm9UtR8mkbHpRDmJFcdiZymtaXYimKNjMGRsTZd+w95k8Y
         5GnqX4CGzhTvCqGs+E/dX5rnsfsq1H9xn4vwMgArC+Fi3AQ+m4vBLY2NeZI951ivma4w
         mNEoqcuNIb6g8q7pAL8pmsVOU1KlJt6gT6ALzVncrebYNQl1ZHf0CgRmLJHcPNGn934G
         XseiJYTB/s2FR1yHgwdhWoK13aCpxy4Sjyq3ChJujuy7Sda+CUXnPgHpMf3MA6SkVj0t
         0+37Feu6PksBWk6f06Pck4wsSo2j8/OdXaHETEKHE/bL7WC86Xvg9N7SFda32zcnQ4g4
         LWzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdPgLSrP4CuuRTwt7UXjZg35OaH3kYu8GWQxjCf5bN/VYYiBmLXK9ml6ZzVFBCgoiNolc2WFraavs=@vger.kernel.org
X-Gm-Message-State: AFuF++m2gM6U003LsxB9ooTTIG0c6+/D0Fu34c9L0PaQT6AcppHIBEVA
	GDnwfa00nXuAIAIwNfd3OGObsS8l3sbM2sHo3w7Sdm0A8g6cr2oZKy26
X-Gm-Gg: AYBFou0jvHLTP4F9kZvc+Wgu+MWHNW+y2FesVYLOiTfm/wndhcPk47xlEyhtE1fVx1+
	8GL+d+GTLqjMS3CNTY/3EB8trSgC//EwAlUdzKu/lvn6wjr7tz+PeTGHtg9diQj+BS3unmrA0mR
	T1sN6UJy6CA1Hu9qxAuoIMyjf3HWx5PjK42vZntfGMRbvlr5s2y1J2GU9pifxb77vZ1uoWicKCH
	cu8+TkBJ51JgYq88g3AfrgIJBd7Cc7o+jo/8kBXpAa+9s5+DIB+qoGfXgAX2VIgvzqwHZB6fO9p
	UhZjgK+BrUxHJZFWmuCu80k0qiayIHxQh2nUvgxJJqm6hM8LDh33uEVm8ADk8/eP9GMMeZ/cHe3
	EKZAc4PCsgyxchm5akNG6S/NdUy26GmOTPSkXA1GG297RkAJZTYZOt37Jgco27xIWhRmBlMT3ts
	2BnwzFzYfd24kv1ObZTADGLIemYJHCEb1111+0kUJ3kfeyIxCapt1D2VpqFmc944y6sgFeVG+4y
	jyz3txwaSsm
X-Received: by 2002:a17:903:2ac5:b0:2d8:d4d1:3139 with SMTP id d9443c01a7336-2dd07a911f8mr7078825ad.16.1788951546098;
        Wed, 09 Sep 2026 03:59:06 -0700 (PDT)
Received: from adriano.lan ([2803:9810:3d22:1608:e46d:9e65:1b2a:35eb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm68395973eec.16.2026.09.09.03.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:59:05 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Stephen Boyd <swboyd@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] mmc: core: don't dereference parent when releasing host index
Date: Wed,  9 Sep 2026 07:58:56 -0300
Message-ID: <20260909105856.129733-2-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260909105856.129733-1-adrianox@gmail.com>
References: <20260909105856.129733-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmc_host_classdev_release() reads host->parent->of_node to decide
whether to free the IDA slot, but mmc_alloc_host() does not guarantee
that the parent outlives the host (only devm_mmc_alloc_host() does).
So the vub300 driver can release its parent usb_device before
the host, resulting in a use-after-free.

Put the alias decision in host->index_is_alias at allocation time,
while the parent is still valid, and use it at release time.

Fixes: 10252bae863d ("mmc: core: Don't allocate IDA for OF aliases")
Reported-by: syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f312381a95cc080992fd
Assisted-by: opencode: deepseek v4 flash
Cc: stable@vger.kernel.org
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
Changes since v1:
  - Added Assisted-by tag
  - put alias decision in host->index_is_alias
Changes since v2:
  - Split patch into two logical patches
  - Corrected the Fixes: tag

 drivers/mmc/core/host.c | 3 ++-
 include/linux/mmc/host.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b7ce3137d452..542bb033c6da 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -67,7 +67,7 @@ static void mmc_host_classdev_release(struct device *dev)
 {
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
 	wakeup_source_unregister(host->ws);
-	if (of_alias_get_id(host->parent->of_node, "mmc") < 0)
+	if (!host->index_is_alias)
 		ida_free(&mmc_host_ida, host->index);
 	kfree(host);
 }
@@ -538,6 +538,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	}
 
 	host->index = index;
+	host->index_is_alias = (alias_id >= 0);
 
 	dev_set_name(&host->class_dev, "mmc%d", host->index);
 	host->ws = wakeup_source_register(NULL, dev_name(&host->class_dev));
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba84f02c2a10..165d24104d3c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -356,6 +356,7 @@ struct mmc_host {
 	struct device		*parent;
 	struct device		class_dev;
 	int			index;
+	bool			index_is_alias;
 	const struct mmc_host_ops *ops;
 	struct mmc_pwrseq	*pwrseq;
 	unsigned int		f_min;
-- 
2.51.0

