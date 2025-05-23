Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAAA2030A;
	Fri, 23 May 2025 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747996340; cv=none; b=TwCQSNBEH6xhog0wehQqNCGo9ogjyfwx6TcoGJ4y80ioVOysw0chBHWxaFMzhAlpH8cTOkjXQAEPJp+UVG4AjyakKgHvX/zwJMb28uJKAnwDp4KgqyiUF+o6yTnZbE8csbWH4zrj0QrPZbkhRojLTPUEOAJkj+bLVzXfjDVWUv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747996340; c=relaxed/simple;
	bh=sdUImjzjVy4p7BDx4hRMRTA3WkUJEPjx2WrucSq/Rhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qi1YcWq5EsQJkVrujh2t858sjQuGsjWpcjTL5sWO92uLl0JNBRjF191XUE5nIPMJACoLahxEAjGR9lNKRPqPwI1YxuTAf24EZfZtvV+9eWPn7oPlq9S4AwQ1BX5xWZXe+9DY35Yhxea5dp6Adjw6dYRm+ryH8I+mDnxkcnwIm58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RN+z9Tz9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN+z9Tz9"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7399838db7fso698551b3a.0;
        Fri, 23 May 2025 03:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747996336; x=1748601136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8iSHQXbhi/neDEe92uz7f1bQeL28XTLFAqRPlVNKA4=;
        b=RN+z9Tz9DxUSNScgzUnINk00rDHKVaxCiwvPY+0uLDdYsNyRHGdXRJq7cnuJlAP4Ev
         WYQByNhlaUSI26KPj4kHOQNAWINpBgo8bNVuhXnjCpd/z4JUmktJGc6t2j5Xt2QYr98a
         iaKJ02HBHZY6HVkodNQ7FzOGkZmzmhHmjaCg8ZbZgTGG3w0V27cDhBduad7Wyp/TIXRz
         P4LCVJ8+y1ZgTYZJg2D7HIa80hEFLQWaHNcAeo6yIEg/RiAS8sIcYCLqYXBGsB02id3k
         lwH1v3dbsCZ9s7nK1K1cZhLsuhSvYIQIm/Y/NndjSQ3J2giIWi/TWGrp/yr4ESBGPSTu
         cF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747996336; x=1748601136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8iSHQXbhi/neDEe92uz7f1bQeL28XTLFAqRPlVNKA4=;
        b=RFTprsEcF20zjI3HVj99/SUGas3/M5efGjJfdGqngt9eN6q8rOg9e2bU9jIsYDygdZ
         9zMLue8q8lte15P/sw7i8S+YT6RgfWQUsvpK0S3wg7zfLS4kwE+sy6EQkJsDz9niDnii
         K7fK4WEiNnwWbR0AtlTMSQCX8u4UywF4FmUnXmj3VXZrYYZtDkkMPc/6VGMCHXZCBNyy
         AgU3wEZUWQW2yZX6EK1tSZTIrviG3I70yDKcKDOjbKGWVs6r+wzI3uQns7Sm+YEqEC4N
         8lwynE6RUbfB2THUBaSAG+RhpPcX6gFEYIRhha8VpTodONpRtuAqPq2603XPnk+0BYVl
         aZaw==
X-Forwarded-Encrypted: i=1; AJvYcCX9jf33A2ZHlh0dIe+2PiiiJsZy1BYwhKN4x9S4yAUkPmcqFN53PKNT7NQLbzMY12Q/irz0PfUzzPzour0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydQBfZjXkFK70NrTLxCYINrY5XdYybIMRj3Dsji1NCanmIuby9
	oD+oL7dArklLLaHKEF7I+i6qdWieR6ac1gXKxYIXnZuga/MXGMgYQUOo
X-Gm-Gg: ASbGnctiJKrhVK7R5MDGzBsJyw4c2iPEbgyc4ynSRkwMKdYBpsCU8J3MsQlghr8awk+
	DWerllPVAyMbALG2sNGiBHjHLyhj2Ci4cZbysdT1ceI7qWJGWQ7bKRte+RtNofXmnhstZOfROab
	6HJyuIFJyr/3elqr8mFi22QGXbi7Ea+oAVhK2HxUpMm0d4ZP/2l/ImmLoos3CSZqiotOKHswRrD
	6joONXgJBUtU5a6vszvVItU4IhDBj0ib6jfWpPTvBd09mq+pVgLc/RaDv0y/Dx4vAV9YZCtIuuc
	4ypwOxrbtzEuVNXoorijpFm2P+hlhsLwqynjbmTXL0+QydF3lpzVNk8mdAU=
X-Google-Smtp-Source: AGHT+IHufaITHtJYcUn1e/g0m+GZ8BuemgNVkhxv2EVoe/tt7bkqtLb4EkoMrNt8q8k6E0QXEYgcFg==
X-Received: by 2002:a05:6a00:138d:b0:742:ccf9:317a with SMTP id d2e1a72fcca58-745ece8e29fmr4094017b3a.12.1747996335775;
        Fri, 23 May 2025 03:32:15 -0700 (PDT)
Received: from victorshih.. ([2402:7500:577:397a:c299:a1bd:2b60:56b8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970c882sm13066424b3a.55.2025.05.23.03.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:32:15 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	Ben.Chuang@genesyslogic.com.tw,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V2 1/2] mmc: core: Adjust some error messages for SD UHS-II cards
Date: Fri, 23 May 2025 18:31:51 +0800
Message-ID: <20250523103152.6210-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523103152.6210-1-victorshihgli@gmail.com>
References: <20250523103152.6210-1-victorshihgli@gmail.com>
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

