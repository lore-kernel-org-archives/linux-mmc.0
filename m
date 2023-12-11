Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="EjLLYJw5"
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505C2B3
	for <linux-mmc@vger.kernel.org>; Mon, 11 Dec 2023 08:55:06 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so44457665e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 Dec 2023 08:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1702313705; x=1702918505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/aQB4e679gg004POwfDoV2M+ylGjdoOtKaUmuhlaWT0=;
        b=EjLLYJw5XlWyzBT+kpo7j21MJw739hZc81Lm5NGFyrqjQERXKhu555UiuMw9xUvj/7
         2VJ+RuAJR9rnZYFHFjDnnEpwoYZRhqswDxfn2r2K5pDmuin3J+ehOLZk6s98K9bKenQI
         Qksa+UGI9+KuSQjSbkv0XmkiMgN1VGWrPoUNyhf1oP+j3wlk+NC4TX2zOU+r9lkA6hRp
         bPId+zIfwjJ1pZJDOJ7IuV9xf7FjRjcXOYGkcWVlpJPhBnDIpkVgipsFH0KwKuCx5X/+
         //6ufxCc2C4Sc/V8eOiY840qOhhuwDFBOvQ6kJ67tHmNF1QIHuWhDeaAN9lCJUrwPzt1
         sATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702313705; x=1702918505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aQB4e679gg004POwfDoV2M+ylGjdoOtKaUmuhlaWT0=;
        b=cwHqt2J6+yMCUgvcI5QW3iRstJHnkckyl97x40AsnztGL9smtoS4Brp0TXUHfQP1k9
         yrIY+Qt/tPVhHv6xkhXLpGoxLqDBCx1RetZC96gA6OB+EQLw1snySiBcaKMRovX/lctZ
         idGh6Ieu8jbr6uvZJBJKZQu1ZqZpdNrw1d651yrm/QS599bydZe/lZQyraCB932tP80u
         hqR87+nNXwXrTG80VG7JYVFTeSO6eL1Dy7pg36o5xeap0F4onNCYnyPqIgJeuNj9ih9W
         9i8aKDl+NEuJQ3+8Kpefj7TuBET4x7tEUMVInn7UkedUAvIO1xZ+wY7AqD/Lc8VpTfvU
         2paQ==
X-Gm-Message-State: AOJu0YzG3VwY86mqk4V9CxMYKfkCDGON+IXEkmO2VxAZwJ9T/sPqfr6e
	qOMlRmKvX5lONj9mCkXUf2u3krKq64xOopuQhYG3Ow==
X-Google-Smtp-Source: AGHT+IErwDWQj6vbRb9WM5dwKMENhbE9O5oHBCsCa5WlJd/1Ls68OegcT8VxTfUkgkad9quChVl8CA==
X-Received: by 2002:a05:600c:4285:b0:40c:1df2:c9a2 with SMTP id v5-20020a05600c428500b0040c1df2c9a2mr2430291wmc.126.1702313704714;
        Mon, 11 Dec 2023 08:55:04 -0800 (PST)
Received: from trax.. (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c4eca00b0040c11fbe581sm13374370wmq.27.2023.12.11.08.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:55:04 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge@foundries.io>
To: jorge@foundries.io,
	adrian.hunter@intel.com,
	Avri.Altman@wdc.com,
	ulf.hansson@linaro.org,
	christian.loehle@arm.com,
	ricardo@foundries.io
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Date: Mon, 11 Dec 2023 17:55:00 +0100
Message-Id: <20231211165500.310097-1-jorge@foundries.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Requesting a retune before switching to the RPMB partition has been
observed to cause CRC errors on the RPMB reads (-EILSEQ).

Since RPMB reads can not be retried, the clients would be directly
affected by the errors.

This commit disables the retune request prior to switching to the RPMB
partition: mmc_retune_pause() no longer triggers a retune before the
pause period begins.

This was verified with the sdhci-of-arasan driver (ZynqMP) configured
for HS200 using two separate eMMC cards (DG4064 and 064GB2). In both
cases, the error was easy to reproduce triggering every few tenths of
reads.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
Acked-by: Avri Altman <avri.altman@wdc.com>
---
 v2:
    mmc_retune_pause() no longer can trigger a retune.
    Keeping Avri Altman Acked-by since they are functionally equivalent.
 v1:
    modify mmc_retune_pause to optionally trigger a retune.

 drivers/mmc/core/host.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 096093f7be00..ed44920e92df 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -119,13 +119,12 @@ void mmc_retune_enable(struct mmc_host *host)

 /*
  * Pause re-tuning for a small set of operations.  The pause begins after the
- * next command and after first doing re-tuning.
+ * next command.
  */
 void mmc_retune_pause(struct mmc_host *host)
 {
 	if (!host->retune_paused) {
 		host->retune_paused = 1;
-		mmc_retune_needed(host);
 		mmc_retune_hold(host);
 	}
 }
--
2.34.1
