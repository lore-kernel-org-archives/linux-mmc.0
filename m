Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03D318E342
	for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143455; cv=none; b=S/DZ7fGYOXmmx6Ny05H1e7AGkWYnCDLApEiSbqipx8KLa4iGHwB8ZIKph7RX145dhYacFxDMsR/uGF+uTWvUUPoQGw+0qtc5yhQWG2nbdYIYbHK5HzLv6gypmgn1aWvPDxIjkC582isYTz6zbYAwdiiiFtQHwLU9vSLgOfRcLzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143455; c=relaxed/simple;
	bh=3HY5A4mBT4lcDgE79BnGp8q3zg7WEhsKws3g9VNoPKc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rxkDjWnBTGWB1HDo60OA6oH7XRIfegwKluHdJH8bsqz4KWZLBkv/5o4pJNm7qQw7nJLIkkbF3Q0jK9T3Cuqrnawis5eyFLcOnyGztqYTolmlWKG2aYBRHNtKE0ZmrwgM8l+oeHOLV/rr+jWiyzz+kNrK7SaNcr91TutbyZgEJGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iCgpFzGC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCgpFzGC"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bebd3b7c22so7177462a12.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Aug 2024 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724143452; x=1724748252; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8gt5QHwzh5IDznDoPANZQT7end38k7a/M7L1Zdp8Es=;
        b=iCgpFzGCpagz3iG6wxXaWspQ+jK6fp17R9rIxxupo/EWduXhHCdWXisLy+96/qCetc
         1pV7YF39dv5oaPcZO6z8i3hdhthukR/Jbw4XmG+szQMxKumKGZrAb+IS+4tHVulrpm5p
         xA1Ct7FrlO8A7dpnMAoKpEhHvGnkNItcPBGT3j1XFqKUI3FS4PEM4JJQfghhG+6UNWhV
         IkEUdwuFt0jbo7/n3DFhmEYWeCNLhdhYzN/UCiqgYB6QAeGkWfGHB4nWVfoW/80pTggN
         bh2cAcPoCD7FTtIdQbdlK6wdBY3Wz2Too0v8MfyNaY9OquOtDwcXi9NWw4PU7G6l8xfg
         sUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724143452; x=1724748252;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8gt5QHwzh5IDznDoPANZQT7end38k7a/M7L1Zdp8Es=;
        b=X+gKirj0xVxtIeGKRqP9uiff9JcxXJkwDOTM/sKy47ajxEDPNpOfk1ph5hIjt6fJ3+
         eDp7bosdNOrz8NKKmHGjxRItqJZcUlhep6HqP2oftGaC37qfa7uFfsAyRgazuq2jmSzB
         pmcczVf4MvRc/dcm3ioqHa1qiV3f3mgeYzVoSBqfzWvQBepFTCCL8oYbNll3UzLMZRdz
         29ilEa07GIp9xVI0N+Y4IZvOLsrTgDF0AcQbXVX298xvGQKvbklwMr+kDRcSzPp5rgAV
         qP9lOJ0hhnNbd69NbefnlEY6BR/Jr7Km06zoczOEQxHa8DieKPaAsfVcelLVeUVt3ufE
         qcBw==
X-Forwarded-Encrypted: i=1; AJvYcCV3+Pj3Ya+azE9BP1ZTCvG/frGFcly+T+CdPNxADHHcOHrPfFUyFbr4NOX+pFJoFxCRHm0mYwt0usU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoxHRPmeeuA1RJm0CHGOwBRnR/cHLaeeH7qqgqOxWzkuTWNPj+
	PJ9fs3LaWYEY31XgZ/gTVSawFtGA0u1NQLct2Zqa6U4Qy98VaiZnii9H6i+xJ9V+/zzFpBePSEY
	Nx5g=
X-Google-Smtp-Source: AGHT+IHXBQUe4OAAniXOKMeQ4CSeHZIMmFC9sBk0Tiyh3i+5IhY3tULZEGkvSWW4yb/23VdkMbOuYw==
X-Received: by 2002:a05:6402:34c4:b0:5b8:eb1d:7fec with SMTP id 4fb4d7f45d1cf-5bf0ac1caabmr2057368a12.6.1724143452210;
        Tue, 20 Aug 2024 01:44:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc080277sm6520511a12.80.2024.08.20.01.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 01:44:11 -0700 (PDT)
Date: Tue, 20 Aug 2024 11:44:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mmc: mmc_test: Fix NULL dereference on allocation failure
Message-ID: <8c90be28-67b4-4b0d-a105-034dc72a0b31@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If the "test->highmem = alloc_pages()" allocation fails then calling
__free_pages(test->highmem) will result in a NULL dereference.  Also
change the error code to -ENOMEM instead of returning success.

Fixes: 2661081f5ab9 ("mmc_test: highmem tests")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This code is from 2008 so it must not be that much of an issue in real
life.

 drivers/mmc/core/mmc_test.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 8f7f587a0025..b7f627a9fdea 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -3125,13 +3125,13 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
 	test->buffer = kzalloc(BUFFER_SIZE, GFP_KERNEL);
 #ifdef CONFIG_HIGHMEM
 	test->highmem = alloc_pages(GFP_KERNEL | __GFP_HIGHMEM, BUFFER_ORDER);
+	if (!test->highmem) {
+		count = -ENOMEM;
+		goto free_test_buffer;
+	}
 #endif
 
-#ifdef CONFIG_HIGHMEM
-	if (test->buffer && test->highmem) {
-#else
 	if (test->buffer) {
-#endif
 		mutex_lock(&mmc_test_lock);
 		mmc_test_run(test, testcase);
 		mutex_unlock(&mmc_test_lock);
@@ -3139,6 +3139,7 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
 
 #ifdef CONFIG_HIGHMEM
 	__free_pages(test->highmem, BUFFER_ORDER);
+free_test_buffer:
 #endif
 	kfree(test->buffer);
 	kfree(test);
-- 
2.43.0

