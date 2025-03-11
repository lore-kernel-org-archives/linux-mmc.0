Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F1249F9
	for <linux-mmc@vger.kernel.org>; Tue, 11 Mar 2025 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705310; cv=none; b=K3Xt51voUhKobkKSVZJNV9teqq3h+mGoOcNNiJPh80AFBrbvQwVl1GMUxrjBlkcp+/MNyKrvEX0YAhcCsGheawZTuVP33xnge7zEiaXLW/r80HyUFl52ks8RkP9UaWz2KZ2K8quGxc9zncBIRMJYRiY8JCAWbwYBYpYy6RDF1zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705310; c=relaxed/simple;
	bh=Es7Jq+xaUItmnmFx3FliQRRwKbWCSA0oO4kxOs+0tR0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=HikR/TUwLTW0qvB07DRJ7gQ1VP3A5BkJwf/5GQAVIbkb1m9LQdKrRZwzUaiJ3QdmzwLUaA0VfUIA0MddYMUCXqnbnyUAkAlFoDpBNJQ2SbbNLoVruffZJ7hfIwCdR33ZDg8wuhsNvMGTlq2JlDW/YfdTAoZOVrYnmRed9E7EMo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eMAY1ZF0; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eMAY1ZF0"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7272a839f3dso1259732a34.3
        for <linux-mmc@vger.kernel.org>; Tue, 11 Mar 2025 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741705307; x=1742310107; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4b/KdywCYMFDDq1/kWvENPSoLkrsBJwlXAOtPzvf0I=;
        b=eMAY1ZF0lLHPg0dOW/tX9X/on+2/+H3t0pn1rFeX7hOnh11h3we9Zc0jPHORxvcT+i
         VnV/tLSWF2po4TZLDDzSkROkC0gSmE2KuVC4yBvwTT8sVcpe4MUwNuMfkfJPj5/lb3Q8
         JHnd9FFHK1bGv1rpHyrghcmK068GzRqIBUVlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705307; x=1742310107;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4b/KdywCYMFDDq1/kWvENPSoLkrsBJwlXAOtPzvf0I=;
        b=ex0vPsp2aWpTFtW5QtNLBExVhk/ccN95gvEghWbNkAa3ZPTQBd2MQypOfS/fyWA4Bh
         xs9jJ47InbdH4/79c5b7xapqMrRg286VBNcR7vswTvGmiSQtAhTg5YK9M7brbnlwBL9X
         Ed+3nud9GJxkhGRNtENfQXD19ORcGcORRwKOKQJ8FvEKIGPyQ3aisLwM2Tk7nIeq3tsy
         5W3BAB/ZAs0nBWdnoNBBJnsUmhFErDcM+mrSfvQ0Sqz+gfyXFqqvDZ5M8a9pJCY0sF8e
         KhCh9+DSsfdq0bdv4eHmqwZMr09s476UhQA5Q2qVNnaaKiP7f2Vo524pjvwA02PGmvqU
         suZw==
X-Forwarded-Encrypted: i=1; AJvYcCVUT3fJifAUWM3gAwgjiF2WVEob8L9V8TT44i1rtuxUWl/fnY/3CBoXRraP3ea7znoq2irUvhVDtsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1SorhSteOgXi8DuepRNFScMR1P4vi1ZPa7od3yy21oAwW68T
	EuwuVfINEsiExcqdSBEspc70phNbwEDzeL38SP4oNi4VC//l6K7js1Slzq8DMg==
X-Gm-Gg: ASbGncu2ESiX9zwFgW7dIDAvKt/Rx9P1XgbP4Z2qGNbHuaRsbsTIgBzCiWsRf44esim
	L7DOVbJp65uBNedTp6D378C8Ev+3WULcyaQoabxLyDtIzvf+HUMjAVAPgW6o5hCe3n2Awemcxmr
	jDpQruLdMZhCapbTYgfQKVo92BQU/Z7wIUDpN2UXHsxIO20cWmv6D4NozMe8nVIr+cXK5hBFJuu
	VLC2w1dWFvpuorRyWDbmHDN2XBDFpITD0CcZPAV+F5JTKn1QFb37kolCuwg+525DNq5QhK5DtsD
	UVqtLi0mAoXhtDlM02PhCQWyL3hgQwQORmL30Ldz91lplvViRMUeq8oP3VthFFj+spxn4tqquJC
	5IMcA
X-Google-Smtp-Source: AGHT+IFdbjAPLkBcT/PdO6aUZ/LPk9p9TaaPPNTQhmFPj4MU5+L0g0wPVorRUgYDuoVha/IN/Ce0Hw==
X-Received: by 2002:a05:6808:151f:b0:3f6:d59c:6a40 with SMTP id 5614622812f47-3fa2b30bb82mr2312809b6e.28.1741705305315;
        Tue, 11 Mar 2025 08:01:45 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f9513f1f88sm646247b6e.0.2025.03.11.08.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:01:44 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops
Date: Tue, 11 Mar 2025 11:01:28 -0400
Message-Id: <20250311150136.46938-1-kamal.dasu@broadcom.com>
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
 drivers/mmc/host/sdhci-brcmstb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 0ef4d578ade8..bf55a9185eb6 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -505,6 +505,12 @@ static int sdhci_brcmstb_suspend(struct device *dev)
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
 
 	clk_disable_unprepare(priv->base_clk);
+	if (host->mmc->caps2 & MMC_CAP2_CQE) {
+		ret = cqhci_suspend(host->mmc);
+		if (ret)
+			return ret;
+	}
+
 	return sdhci_pltfm_suspend(dev);
 }
 
@@ -529,6 +535,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
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

