Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE82561B
	for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111253; cv=none; b=LvjGD5FC84HwWYzc/6loCElcLa1Ms9pOY69lcoXhrzce775EtSbUE2SSb2iHwfj64FUhEWlucHi3QfLP36VUyyUsBbZGxblE16KLUQx30Ow3pwL/ACOghwcndijmhKjVh5jfijFGwVHlfLW/rzWXzH8jM6Ag1+xD/jTolDPtXPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111253; c=relaxed/simple;
	bh=J2S0BRyRbKRn+WUW986W3q52NCjhupQKu5CurAy2dPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fw7AG9M44fCixk8ZbU9djJdSXHlKRuZf7kB9UggYSE0xona/kLdk5nemO6xjSOuGgsS3DZnDdO98hg56Nf+/IuOWnZt9vUqLYrdkpLzLlLUbePZcVPf97BDfyERMWBynwrWhnTzn8AvKAq6x/o7UP8H0G8r5XHHNy6SjnyE9Jww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=US2BBDCt; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="US2BBDCt"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3f829cde6dso626849466b.0
        for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 01:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709111249; x=1709716049; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SOL5/KSAm5GipN+EyD9pJt0B6C/UrVSYyzILKb9x5uI=;
        b=US2BBDCtEEIi5eDdO9P5e6I7fXDSqlcxhkzm+ZO/l1QnTTlW2SS+Fq1iKZyY/OqjYP
         aqeDrrjMeI/kzDyVsGwx5geByqqfwkhhOq7yPjoaT8srMNvxlqZWGYpm6NTmZsdtsH7J
         eHxIqkQXEV/6PgFT77llctZq4Mk3X3aHL32Nyq1+CirGC1OqgDD1oXjQvYwUlZzs9nyY
         tJBn4oYvleBW3YmazR7kx6Fc60CRFbJm/toYlD7YxzzkrjHuS4ANIkO2MZpXYnrl8njn
         ig1JmXf3Yf0Lvm+J7KfSOF0Z7dljw/glfHZlxqEVwLCIQDly22haorBEjbhTGDcRT7bJ
         KSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709111249; x=1709716049;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOL5/KSAm5GipN+EyD9pJt0B6C/UrVSYyzILKb9x5uI=;
        b=iGHjB3iDJ+EuVwp+IUYw3vqgVRJ8KeX5xTulOmgcByQBb6QNOA8NKA1+1rrou7mkUc
         TILCM878jmQeGLv8AtkX4oAEhXvRSy60XAZOt0VxB83O/TXTQuIeGl7juLTOiKusBtwM
         5VQPWyfESmMREj6FAO2DnClPmUF5ZfF+jX65DtPOuua/6XNV7vSJEPcoWUWKSwH6T7PL
         7mN/sP77jvEJvEJjIKBRfBIGHKzYO1OYaqyij7QbGwZi2rlihvNgGhkTVusmb1fXnWwh
         M7IDpEMyIPCY6LIGA2MsY/opWpOuI98lrK2VD3/jpq+r6wzudDb0GAI3/+crFXcrJF8t
         zs0w==
X-Gm-Message-State: AOJu0YxaKmn+hXZeCD+5tWH6kDWTEB2hIt2vmmYhCcxAQW8EbO3mnC/J
	nKNubwOm9yd6U6cUKV+NvRfXyO78lt2rsmLFDBDkMbk7wRy3wjr73WoABsEPbUM=
X-Google-Smtp-Source: AGHT+IEDTrBy2samxlfh6dnUI+gaoUq3zvGYIMYLeTS+7oLi36GUk/mC9w3oBtnsnJU/Zz5h7jeoxg==
X-Received: by 2002:a17:906:918:b0:a3e:e84a:ccfb with SMTP id i24-20020a170906091800b00a3ee84accfbmr7802318ejd.9.1709111248797;
        Wed, 28 Feb 2024 01:07:28 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id un8-20020a170907cb8800b00a43e573146asm704729ejc.100.2024.02.28.01.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:07:28 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 28 Feb 2024 10:07:27 +0100
Subject: [PATCH v2] mmc: sdhci-esdhc-mcf: Flag the sg_miter as atomic
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-fix-sdhci-esdhc-mcf-2-v2-1-4ebb3fd691ea@linaro.org>
X-B4-Tracking: v=1; b=H4sIAM733mUC/x2MQQqAMAwEvyI5G5BEofoV8SAx1Rys0oII0r9bP
 Q0Ds/tA0miaYKgeiHpZsiMUoboC2eawKtpSHKihtiFy6O3GtGxiqB9wF4+EHffimZ3wzFC2Z9Q
 S/r/jlPMLFYpXPWcAAAA=
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <angelo.dureghello@timesys.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The sg_miter used to loop over the returned sglist from a
transfer in the esdhc subdriver for SDHCI can be called
from atomic context so the miter needs to be atomic.

sdhci_request_done() is always called from process context,
either as a work or as part of the threaded interrupt handler,
but the one case when we are actually calling .request_done()
from an atomic context is in sdhci_irq().

Fix this by flaggig the miter atomic so we always use
kmap_atomic().

Fixes: e8a167b84886 ("mmc: sdhci-esdhc-mcf: Use sg_miter for swapping")
Reported-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Do the simpler fix and just use an atomic iterator, it
  will work fine since esdhc_mcf_buffer_swap32() doesn't sleep.
- Link to v1: https://lore.kernel.org/r/20240222-fix-sdhci-esdhc-mcf-v1-1-fb87e04ca575@linaro.org
---
 drivers/mmc/host/sdhci-esdhc-mcf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
index 1909a11fd065..c97363e2d86c 100644
--- a/drivers/mmc/host/sdhci-esdhc-mcf.c
+++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
@@ -313,7 +313,7 @@ static void esdhc_mcf_request_done(struct sdhci_host *host,
 	 * transfer endiannes. A swap after the transfer is needed.
 	 */
 	sg_miter_start(&sgm, mrq->data->sg, mrq->data->sg_len,
-		       SG_MITER_TO_SG | SG_MITER_FROM_SG);
+		       SG_MITER_ATOMIC | SG_MITER_TO_SG | SG_MITER_FROM_SG);
 	while (sg_miter_next(&sgm)) {
 		buffer = sgm.addr;
 		esdhc_mcf_buffer_swap32(buffer, sgm.length);

---
base-commit: 20af1ca418d2c0b11bc2a1fe8c0c88f67bcc2a7e
change-id: 20240228-fix-sdhci-esdhc-mcf-2-539cf338c3a3

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

