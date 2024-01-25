Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC86E2CE
	for <linux-mmc@vger.kernel.org>; Thu, 25 Jan 2024 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193436; cv=none; b=aT43uBXGL6EPSWv6PMhSjP7dPFkfGRzrLtYPbw4YnGOUWYjIyq4iuR4p2lGZcvHJ7+9a0hO2UmcHsNcVqhhMqNAKgDgoH7dEtqEWHCdSjtwV/cLsfQY9vb6mR8SNzELEq8kYP/hXT0Lhzmw/a2gX7ZojAKJYDb+N9XRT+jopDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193436; c=relaxed/simple;
	bh=Qs//UMnixr5IUp6jilmOnSE7i7QVfxi3SrizSBiLzF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JFt7UkzWX9UTICVinZvFl7pm/GQH42HKfuFc1nda/JU8KIsiEZhDd6QazYVIUJ0G0cIKA5IaKdJBW/ZUZYwMIdtFSKaY44XNXyDUoCoRD9Z4jrTr5LkQSZSlODxXowE+j0vWDGaLkTQ21s9SG9P6A7Ay7/qBRLqNCkfgEhgdYbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FgviSqIx; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FgviSqIx"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf338e1438so8396021fa.0
        for <linux-mmc@vger.kernel.org>; Thu, 25 Jan 2024 06:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706193432; x=1706798232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJBLYCKXFwySdbkU5jNVGgegDvui0xTSvQmfM70ZSEk=;
        b=FgviSqIxltqJDnUcgyL4fGiH6UPmwn1BrCqJpvncZd5lLNvubQcrzIjzJLoIsODfol
         /bqK9UYHLbRJyzJnMiP0kBtRnXvOEvLBvjhxkO48nqp4yWkznbUDwVdq4iRLwDikOO2O
         eSxO5zrRWd68rPJ3CfYiYX1Q8QHn6KY2Q/bE6sKLEBQOyxh5fFQ4/lO+nYN7mj+Hl5kp
         9eTwYvlgUJXEZEZGlLpB0RpJZ32AHBBN2kCYNzOvu4KBM5MoyjK8kq5EXpF0zjfFq2MT
         CZiyiFDPJk5pNCvUz6fkcJ0w+kS50ZpsM64xiFMCQejir7GVUsu74L62LWpu5awoamcu
         JfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706193432; x=1706798232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJBLYCKXFwySdbkU5jNVGgegDvui0xTSvQmfM70ZSEk=;
        b=KZLbMnP4W0l9YOGCKld0p/B/t9KCHdgbcMd1hiZFtMCnSexXpp443Ry2DvHO6NSiGP
         BiInhoTcCcLlWdw3Bv297UxwjYIU6gXpNWJa5NxOJs4CJ228vWRRt4m4vttdu75yZmFr
         vaaaUNKQifDF5ckjMfFFQqiynbA5K9IdpERLZrPiZ/T5F+xBEmefktXTdDzO1X3XAUnW
         Kvxkjx0LX6ErMaynp1f6QBFBDJMzsOdqmtk4MjZjZMqpDx2bpHFfBmtnsD6lul3xLeRh
         ex/0hnJldbTTfBwnqnT92QVGJoDLkfslKWYe8WAJ1hcZjcMJZHVdByrhoHh8MeYNk5Py
         dRWA==
X-Gm-Message-State: AOJu0YwKB66TDC5ZvuOwiQzoQlFaJJeWGXBBqx9b09nBvEq399R8cFJ6
	j3sdVnKrtcYqquyBnJn2E2+fVDOwsrkHPE1OpOaK4x31LFSQvEY17bP/vXWVoqY=
X-Google-Smtp-Source: AGHT+IHyoh6DqOZQxyE2KVxGS/rWXgxchalYubf3yeda14PSRbE8B6cvrgMcdIMq6MgeVioRNGja3Q==
X-Received: by 2002:a2e:90cb:0:b0:2cf:329c:31d3 with SMTP id o11-20020a2e90cb000000b002cf329c31d3mr596119ljg.25.1706193432776;
        Thu, 25 Jan 2024 06:37:12 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id y24-20020a2e3218000000b002ce098d3f0asm292644ljy.115.2024.01.25.06.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:37:12 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 25 Jan 2024 15:37:10 +0100
Subject: [PATCH 6/7] mmc: sdhci-esdhc-mcf: Map the virtual page for
 swapping
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-mmc-proper-kmap-v1-6-ba953c1ac3f9@linaro.org>
References: <20240125-mmc-proper-kmap-v1-0-ba953c1ac3f9@linaro.org>
In-Reply-To: <20240125-mmc-proper-kmap-v1-0-ba953c1ac3f9@linaro.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
 Ming Lei <ming.lei@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <angelo.dureghello@timesys.com>
Cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

Use kmap_local_page() instead of sg_virt() to obtain a page
from the scatterlist: sg_virt() will not perform bounce
buffering if the page happens to be located in high memory,
which the driver may or may not be using.

Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-mmc/20240122073423.GA25859@lst.de/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-mcf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
index a07f8333cd6b..ed851afbf9bc 100644
--- a/drivers/mmc/host/sdhci-esdhc-mcf.c
+++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
@@ -314,8 +314,9 @@ static void esdhc_mcf_request_done(struct sdhci_host *host,
 	 * transfer endiannes. A swap after the transfer is needed.
 	 */
 	for_each_sg(mrq->data->sg, sg, mrq->data->sg_len, i) {
-		buffer = (u32 *)sg_virt(sg);
+		buffer = kmap_local_page(sg_page(sg));
 		esdhc_mcf_buffer_swap32(buffer, sg->length);
+		kunmap_local(buffer);
 	}
 
 exit_done:

-- 
2.34.1

