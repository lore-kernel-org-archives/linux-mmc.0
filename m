Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19333230996;
	Fri, 16 May 2025 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387665; cv=none; b=WBcyv7P75t9TIpaffG2LM6BxOOMuoCKrRXpZFw7gjbhezdCIOpTVkNELksQ4GY6S4eh4sx5ujDfRAg2i0BxkddIJkNJwV0oHNmo4IvHZzAOJiLGZ1Qh6DbYbhJ/xCMpT/c9neYdiOIdtMNwwgxrrLfsKPq5NMWY8bSRP98pKbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387665; c=relaxed/simple;
	bh=sdUImjzjVy4p7BDx4hRMRTA3WkUJEPjx2WrucSq/Rhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0tC8HnJfmzmzvZ74qIbOzx0hrIWCbgTb77OcqeHT/zJkZEVu9V2uj6I19oX7OjMjpyfYu6IPgwx2BZ7+zYuUAN8Eja4vwOYpwqLWOOz7iJb9I05HgwVFp+FYGd6tkKix2mQqEKMPkOFOVCeJvqoYDU0GzNjmmAgGITaytvShSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3ymyftK; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3ymyftK"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d8020ba858so18596995ab.0;
        Fri, 16 May 2025 02:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747387663; x=1747992463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8iSHQXbhi/neDEe92uz7f1bQeL28XTLFAqRPlVNKA4=;
        b=a3ymyftKFtGceLyoFovGXAIu3vy9vWpOi4BjEgrxRSUxZ8T4paZXKRlvbcMJ1lUIRY
         41E523UNkPAPBETqLFzDhY2OBfSYfNBcedkaqjnlj1A4kcOmDoapMLjd/7p6qanIlahA
         mpJHNzM8x5cjIp2u7xq9z4miaLjHNDT+mSQ+parUoVLufgjTvd+jQku8VrNzySNKnN6K
         LK6G5/t925qCSeImuVxrrakXIvzLuPfvh/5VAoDQ0MN/Pkz067wvL5Lz9Mcy1XkqFdem
         tLot3YErXu9cDi7U4yiPUzyfC1Jyd9Ln2KGRpVdgdCozChfoEAWPy7ZkQrdvGW3DclZE
         /qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747387663; x=1747992463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8iSHQXbhi/neDEe92uz7f1bQeL28XTLFAqRPlVNKA4=;
        b=bpFu7rv6ul6SpxbETMb6ZijldEAnOBZvERnybeSm92pO2xRqOkaDvRbMO73FBeMR1A
         Lge9cdSnql2eIXzhMeB+/ltK+eAQJbyJlRQiIjK9wIEkh+U2zw4MIGDoEUrgC/h3L9UJ
         kLNNEONfiFWHlkNipuy35MytrG17PrBafB1jc1qsiAp3rz+0j/fbutNscbU4/zGhCQVa
         gopKpbvSkUfPMSLtCyx162NK/aMCR0sdbZgOLcUZNISrLG9m6s2k1Yk2SBQwd7Lar2yj
         YAG2yr7Ty4O5vIqotFlrICOw24VB0snanksvoN9O/fRh8PB8WeC/bAtIjGvHuXUhSFJ8
         SZPA==
X-Forwarded-Encrypted: i=1; AJvYcCVkXnfCLNUZ5uCwauGw4hFg39298hrYh8AL/BDCIqDB9YKDgWunm/gp6eUYn4neV+MuVRcqkfH0PUgJ3bY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd9FCJtq/Yvfik1vH7k2GcBOVx2uRDXWMEKeFRZNvtboM/9nsR
	y+29fe6vcMnn8oiXmXFVr5VeFTTQL7maUJ3Ob56t/ktw/9pJGKI7IBioyqAV08Om
X-Gm-Gg: ASbGncvaWSN8hgSxH8f4103gv/phP6QjXLs9H+saL4WW9//4z7Az0ZarGJdbg+hgEtd
	J4beAagl0ksCrkYOZZlo8UyQJvxxkt2IQAZ6V8KkGrdnr3oGrMoTRFKDB9s6f/ERDPkPHITj6jr
	gdre1QxFAvecmt5niAQUwxw2+hbOG/tiT/s3kgrxLNwDb8non7CoiMBYDdPi0JZ3d+a/1apDe7l
	cu/mQLTpAvW3Jj27HY5H6PD25LxPnn8UYjMTzMTKgjFL3NmZ6KkowjIJxF2OOqf87QDPA8BVloA
	SPHxJ066Awf0v1v2ne/+Y0z3pnxemqIkV4dnYN5lPQxXX/J9Q+YVwVGJ3kUYKqgsFEzYbQ==
X-Google-Smtp-Source: AGHT+IE1XJ5Z5xCiFKErRNaoPDqXr9FhYolWOGpyckFKjyLcbSwBeSW7W8gtMDB25EvygpXbWVdU5A==
X-Received: by 2002:a05:6a00:2da5:b0:73f:f816:dd78 with SMTP id d2e1a72fcca58-742a98b2e69mr3131007b3a.15.1747387651912;
        Fri, 16 May 2025 02:27:31 -0700 (PDT)
Received: from victorshih.. ([2402:7500:577:397a:896b:66ce:fdf5:6801])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a229esm1097876b3a.161.2025.05.16.02.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 02:27:31 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V1 1/2] mmc: core: Adjust some error messages for SD UHS-II cards
Date: Fri, 16 May 2025 17:27:15 +0800
Message-ID: <20250516092716.3918-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250516092716.3918-1-victorshihgli@gmail.com>
References: <20250516092716.3918-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Adjust some error messages to debug mode to avoid causing
misunderstanding it is an error.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/core/sd_uhs2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
index 1c31d0dfa961..58c4cef37f7c 100644
--- a/drivers/mmc/core/sd_uhs2.c
+++ b/drivers/mmc/core/sd_uhs2.c
@@ -36,6 +36,10 @@
 #include "sd_ops.h"
 #include "mmc_ops.h"
 
+#define DRIVER_NAME "sd_uhs2"
+#define DBG(f, x...) \
+	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
+
 #define UHS2_WAIT_CFG_COMPLETE_PERIOD_US  (1 * 1000)
 #define UHS2_WAIT_CFG_COMPLETE_TIMEOUT_MS 100
 
@@ -91,8 +95,8 @@ static int sd_uhs2_phy_init(struct mmc_host *host)
 
 	err = host->ops->uhs2_control(host, UHS2_PHY_INIT);
 	if (err) {
-		pr_err("%s: failed to initial phy for UHS-II!\n",
-		       mmc_hostname(host));
+		DBG("%s: failed to initial phy for UHS-II!\n",
+		    mmc_hostname(host));
 	}
 
 	return err;
-- 
2.43.0

