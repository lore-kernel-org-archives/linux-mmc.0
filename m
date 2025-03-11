Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EEE261370
	for <linux-mmc@vger.kernel.org>; Tue, 11 Mar 2025 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712398; cv=none; b=nDGawVTJ0TMUP+Ryo3/XkEKAZJbnWVPdeo97aQn9zD94w/0z+/hxm6Dkbg9zysxvPfOWFYqaNyZ3dLtkb5tLy9jxl9kmXfcG8oPg4EQpvZfDOJpol24HRelva0sujGslTU9y0IhdoKIQlNyDCv+mVyqoBwJLCotFge8MVhdnakE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712398; c=relaxed/simple;
	bh=152+JhKdJURsyIW035cU5ZqaX/06tU57xV2M5Cjl64Q=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pi6H/MP87ju+8m/pnK5X0z7AwJf4t5vcndesBSfVpOqbafZ1JRAJVYMrFxGHoik+/zBhMvomVsXLDcPFct+zt75woOrsALfMJturO4CN+TN/tLyNzrTZSjJlHKWpFvZ+BKNuYGxeXnr7P/wL8Z7q08NYIVB8x6gmzIJDWuhCKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A2rmn93w; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A2rmn93w"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5fc6cd89f85so2131008eaf.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Mar 2025 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741712395; x=1742317195; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mXZ5saot0RNfXEwNRIKD6v3oYeaF3NNGEULkoMtNjs=;
        b=A2rmn93wxtQJ43UgkZxaODw/TyPkwsKhDBJVK+WN76dU++7buB/cLc3ALDtF6TdrEp
         6vNI+WHkYNziFOoEqyrRnulc6wWspx9XRAL2UBdKk1i4s2DoTDLD+HvSKMIrz8q1GpJU
         nuSE5+hxNDdzEiTnRTreYPmEq8UxWPeS7/8+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741712395; x=1742317195;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mXZ5saot0RNfXEwNRIKD6v3oYeaF3NNGEULkoMtNjs=;
        b=bzyYxU+rdrOWAT9uGjYgj6KT99f79zy/HtbK7QRWLhvXQHAFJ6LKyIeB8REGGbpBWk
         pFdE2MnGH0OOsVd8oCNrc9fbHAHOUBfQbS6nX6L/mL4zvCRSmumDe00bmfMW571YY94D
         3SplH38S8Vo31NMk6Z5wta642UXE6Fdg48LfW8n9R8edTbqEGUVodAya1uBG75F2mnHL
         +2eI7g+IrnMBKoVTjqlur9ct06KfI86wVK1DbR3HCmJlY/4IXocCxDH8FcjQ1qGwWbc5
         MGOy1CHjl5VHcY+/mHP7J/tU1QtCVvpJJBXuH9mahAQe6w3MYp6FSXlTCYqgZchWaOF8
         xgXw==
X-Forwarded-Encrypted: i=1; AJvYcCVVZbIKxNZ0HECxrVSxVLYsJyhkhtfQWM3n2tcG5Q1Lewo6gqI3eanqQDtRqnFWwrL7ED95aZ7BzYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwW+zdWgltAzckGd229S1ntXAv8qwGxBksRdVb3W/sqCja7UDK
	ibyRyFwrmt8drj9yv53J/Tf1yo4QqbBUuD7/W6hv9ngJ3LTVUS2utLaqmiV2ZA==
X-Gm-Gg: ASbGncscuRXdKY9PHPIWaZ5YSAzi6XAWLg/CYDUDaO+Ah5kAm9jMror11VjKHcHNzjI
	inBTPdyPWZBJMjHhj94yqzt0Dagi7PAtmJaCNh5/HNZOCXbgtVj0fITJhgfgyVfB3Jm0YhzPukX
	dx4yZmgwf3YcH9IKwAxlWzs3LzwbFwekZhg5sywBJ87woFZkKo9f9/q9bmRHoB4Kzg+0E+A3IUG
	ixSQjtgWxhevEZ5lKAVhkGTUAvysiEgw1AbhyfevIuJqZnOKMHPabtzFDPuLyCy1DIiJ3++cBwf
	PnwqA8m1nPFoMkD3NRfAV8Z0rhpRFkUzHWbkx1l+1WbFGpE/wHg3061okCfz98n0k4dIdwgUcwx
	sO/xns5g+otGElw8=
X-Google-Smtp-Source: AGHT+IEo2y1B2P4YlspZf6ieZjf8/Wmas/53NMabqNUKfjrw4XnZraf15n9gzLSdbh8zE4W/K5VXSw==
X-Received: by 2002:a05:6808:1b13:b0:3f7:28ac:8068 with SMTP id 5614622812f47-3f728ac86fcmr6097289b6e.13.1741712395590;
        Tue, 11 Mar 2025 09:59:55 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f9513f1f88sm682492b6e.0.2025.03.11.09.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:59:54 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops
Date: Tue, 11 Mar 2025 12:59:35 -0400
Message-Id: <20250311165946.28190-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

cqhci timeouts observed on brcmstb platforms during suspend:
  ...
  [  164.832853] mmc0: cqhci: timeout for tag 18
  ...

Adding cqhci_suspend()/resume() calls to disable cqe
in sdhci_brcmstb_suspend()/resume() respectively to fix
CQE timeouts seen on PM suspend.

Fixes: d46ba2d17f90 ("mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)")
Cc: stable@vger.kernel.org
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 0ef4d578ade8..48cdcba0f39c 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -503,8 +503,15 @@ static int sdhci_brcmstb_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	int ret;
 
 	clk_disable_unprepare(priv->base_clk);
+	if (host->mmc->caps2 & MMC_CAP2_CQE) {
+		ret = cqhci_suspend(host->mmc);
+		if (ret)
+			return ret;
+	}
+
 	return sdhci_pltfm_suspend(dev);
 }
 
@@ -529,6 +536,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
 			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
 	}
 
+	if (host->mmc->caps2 & MMC_CAP2_CQE)
+		ret = cqhci_resume(host->mmc);
+
 	return ret;
 }
 #endif
-- 
2.17.1

