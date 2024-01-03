Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8983C18E20
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jan 2024 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foundries.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="mkA1cIYq"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so54851635e9.0
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jan 2024 03:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1704281357; x=1704886157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uonm83saY7VBk1RNLrVWufQJZVuuKsJnIJ61x/jSfWM=;
        b=mkA1cIYq8mdO7YNfl3dF2y81az2v5Uo0OJgNcl0idgZJlaw4MmE2qLAPbOMB1Khjjg
         b7vjAPEnJmWyVKOLRi0QO8IcJ4cYq0yIRVro7SSJS+hRguFY/t4Rud0PkvOTZeFntghZ
         2Z/9qPf8tk3cUgRfnMzhP0f93E2Zkv6D2wNSzjIJsOOuA3ZYJQjdmRTy8cvcNk8pn1Zx
         60B+6YTT7nIvheDywSTyvl0o5ciRMPCyTqkfExVnguCkdK1vdkEeCAMLExqQTuxGOi+C
         F4CDx8HJwFnBeffMpFhWjUoMQRLN0iqXOEGXqL5qQg47HYCi+m6ijdy+0Ow+VU9AUSfj
         3uBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704281357; x=1704886157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uonm83saY7VBk1RNLrVWufQJZVuuKsJnIJ61x/jSfWM=;
        b=KrMmxJ283kAAuuQo6UcyqDiD+g1kn4pKgtkIV+5U5923Nw7Ey7VElKIPf/x7PHv1pr
         aXh/LOGG82NoiNLl5iiD1dZhTyTKd2xsedoXeA+CuB7wWII9ZzdJGu4uVPF63v75o3dl
         TdHRy8fXsNOPlK8Ljyr1fvSPBNFpgV25vX2aRF7NppufBkuZHonUM8sST/nbdUID6anz
         pgfshTQIs5FZ5KqB0t4EvEi1rT27qyYoYa7rHEgQ2JFjJ+drRnaNE1qTNjmVYxyCJvlq
         qoAeFXt8m6b59NtX1xHHBE8iGlxlSP76OCUglQthJ8zPjgJc4OEOFXznOjYNF5fJCv6U
         Nkaw==
X-Gm-Message-State: AOJu0Yx6Uex/vBKMOQJcSZspNEc8R94/cRbMYi60HX6EQNGQRYhJLybm
	Gvy3QgRi1nKzNrY16hAfD+66XQDV90D51w==
X-Google-Smtp-Source: AGHT+IEC+hprC1XD+29xo+6JDXtpHJkshKG3WDHJW6XayhZvzoUEfoHZBqjP139IJtRL+0r2qG/ITQ==
X-Received: by 2002:a05:600c:314d:b0:40d:6e2f:da7b with SMTP id h13-20020a05600c314d00b0040d6e2fda7bmr4455448wmo.13.1704281356698;
        Wed, 03 Jan 2024 03:29:16 -0800 (PST)
Received: from trax.. (96.red-79-144-190.dynamicip.rima-tde.net. [79.144.190.96])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b0040d5f3ef2a2sm2040128wmn.16.2024.01.03.03.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 03:29:16 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge@foundries.io>
To: jorge@foundries.io,
	adrian.hunter@intel.com,
	Avri.Altman@wdc.com,
	ulf.hansson@linaro.org,
	christian.loehle@arm.com,
	ricardo@foundries.io
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCHv3] mmc: rpmb: do not force a retune before RPMB switch
Date: Wed,  3 Jan 2024 12:29:11 +0100
Message-Id: <20240103112911.2954632-1-jorge@foundries.io>
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

With this commit, systems that were utilizing OP-TEE to access RPMB
variables will experience an enhanced performance. Specifically, when
OP-TEE is configured to employ RPMB as a secure storage solution, it not
only writes the data but also the secure filesystem within the
partition. As a result, retrieving any variable involves multiple RPMB
reads, typically around five.

For context, on ZynqMP, each retune request consumed approximately
8ms. Consequently, reading any RPMB variable used to take at the very
minimum 40ms.

After droping the need to retune before switching to the RPMB partition,
this is no longer the case.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
Acked-by: Avri Altman <avri.altman@wdc.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 v3:
    Added some performance information to the commit message
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
