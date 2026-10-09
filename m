Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7221D1D5AC2
	for <linux-mmc@vger.kernel.org>; Fri,  9 Oct 2026 00:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791505938; cv=none; b=ltkiaX4OL+Hsvm3Lyq/ZqyNOPn+64OyIN+urKOMwz+S25gGMDMZSom4p/1Lw1oqbyKuy041h5EEz3SHqgjCEwGApVrJOfdmalYCez8T4GAG3DGj4OpTMrVHC1NGVfZGHGD91OZK+zBNOVeXhhBSRrQZuWs6cOvidms8LcjTy8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791505938; c=relaxed/simple;
	bh=gNLg6Qgamg7mjc3UkG6SuB4YvLH7gMzwvVuIS70oNsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HOTT/LVUSzsDmswBomR82rF+vEgGfoi0pEokKYUGDfffH3BmNdktjTGIcpLlweA9l5vIk0zPa4w/Da3ENC9UHstmv3+SAYvLYlk9uA/3QZ6AOGmtArU5m34GDo/b5nGAe1y4my/EbmG2qQgpAXTjVmO0BiCS1NKeOQVybJdodyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g187p4h6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g187p4h6"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so33097485e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 08 Oct 2026 17:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791505936; x=1792110736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kd9f6IzxLdOe+YXs15sHvBb+DnWpHr6FxR7UwEMv3EU=;
        b=g187p4h6vRTvEAN9SN1eHqKnvSL3K8myML0YpfTVkjnPaRau9gUL5cFxuxJTE7G+sp
         zniXPOfAcg2iSrYVj4lcoUjqwarsoe7zfY2AWeZelcsEDHBDVWNXkkypVtF/p6jK4Q5j
         3JmgAX0jwrEfbiuMUEANIi0118cETltnC80faHbUJSfV3FKVQYGU1qYux5Jt+DkfzgwT
         0a5W2h66tpXwUQa1txV13DzAf5tyNQ6veG4o84aepwG9DpaVLlTBAT9XEVXN0wYW+4j0
         GNG99KIWDld+MLpShvhzdBhXdr+miGHsb8ug8hz9VLNoCXUuc31qxRlPIX9FDf6E0dfq
         3hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791505936; x=1792110736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kd9f6IzxLdOe+YXs15sHvBb+DnWpHr6FxR7UwEMv3EU=;
        b=dmHXY93ycKbIJO9zn/KkBaFMdp8yMDWaIlMpg6D0EhSg+7rVB/Db5o8gXpcjz/hfxw
         GRiudORa43B26U9gnYaI2+zUeuHqDXZS44tBL9BAHQx9yMSknnNMsTIWLdQ4RF0WS3y4
         1I+Z7XY5hTimIqgAxlufEH13vMcUNQ+oPhLWGZABKTZgbeOxE86K0542EpFOdIkYGdLj
         JE1mH7nsfybUxQDxvr1iSuNBSWwfQJp+mYl2lPMHDmAl9RNlU+oVPprB5CHhEV9wfvnc
         sEZC3n3LUO9nGEefcGeqyDO2/3IaZcS1NbNuOj0Wo/zuFH1HD2O3dYcyxa2QAE0/AjYE
         afvg==
X-Forwarded-Encrypted: i=1; AKwUvByPcQBkium302vk21qjfd+x2iMvpSKjL7bHh7PbxihhCeTAUgnykfl3+SXshmWDPZKTozZI+cBj4pA=@vger.kernel.org
X-Gm-Message-State: AFuF++nZkoA03OQKVIN5N/Nxd2MP5wzDc0vEF7aKYGx/+UFHHeHTcym2
	P8zMimVy704UeD0OG458I9ll+tYQvHE5A2d3rX3dIWjaAr2FJfS3DyJOETdx3ijT
X-Gm-Gg: AYBFou2Ngcs89mGfVq6OHP9G1lRDfJg3A5EZHdSPYayeETp8Fb+hrc4589/lB/T+YmM
	g9nO841D4hKUPF+2WwsGQD1l9RBj2SguQem0zOjKEPkLUiqs972elN1t+70zcypUq+cGrgFAkNf
	iTQLcBSKrJzaMIK7IFn2jrFXTQYHfOFWVh0ruyGI8d00bbC9ESjkMpmjxuj6c5E5J5cL2B4hXih
	Fa/mynA/iLySyV1mgJae6HzO1l4a2J9a4rHt5RkAJf4pnpwWIy9eHqQSQo/vIhvYgNyKMO4vIyY
	eoQMePILq4TOQlZN6lYux43AMXgdZVtEEDVIFsaYPqspMxMOfqqdCKV7hoBKoewhZfOtHbzumzp
	Ujh5VXDknKClJfzdcnfPmm1UARJZ2l0L31a9TUnAPnFwut1kHwwJW6h5kzlISrtygcdZ0ExU5CJ
	5V7tlI26mUv3slBwjH1Ivc5Aqm9exFNBjf2QVsnQJGfVE8m3E6SM3KvGLtF6/nYmlwvXjyzXbuO
	c7r5lFN7p9AGOvcINcTE8+uInEyLjFB1bDQyMlMrH6B6Q66YXcqGHds8yUwc1tJOx6LEaCRU8+V
	V9HDVawXOZC4EEH3GVijUrgUcU4MEf1IgllNUQzbbRfEH7mjDOXfLhYdVXZLFOWkEFNumRhXGut
	abRDYKjk=
X-Received: by 2002:a05:600c:3510:b0:4a1:7033:5b55 with SMTP id 5b1f17b1804b1-4a18e4cc437mr2753135e9.21.1791505935518;
        Thu, 08 Oct 2026 17:32:15 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad61-5a01-743c-891f-b33c-cae7.310.pool.telefonica.de. [2a02:3100:ad61:5a01:743c:891f:b33c:cae7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db94e33d2sm1133434f8f.9.2026.10.08.17.32.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 17:32:14 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-brcmstb: don't log an error for missing BOOT registers
Date: Fri,  9 Oct 2026 02:32:01 +0200
Message-Id: <20261009003201.68288-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BOOT register range is optional: the probe function ignores a
failure to map it and the suspend/resume code checks for NULL. It is
mapped with devm_platform_get_and_ioremap_resource(), though, which
calls dev_err_probe() when the resource does not exist. Every
non-removable host without a third reg entry therefore logs an error
at probe time and then works normally.

The binding only describes the "host" and "cfg" ranges, so this is the
case for the in-tree users. On the Raspberry Pi 5 family (BCM2712),
where the SDIO host of the Wi-Fi module is non-removable, each boot
prints:

  sdhci-brcmstb 1001100000.mmc: error -EINVAL: invalid resource (null)

Look the resource up with platform_get_resource() first and map it only
when it is present. Hosts that do have the range are mapped by the same
two calls as before.

Fixes: b7e614802e3f ("mmc: sdhci-brcmstb: save and restore registers during PM")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested on a Raspberry Pi 500+ with v7.3-rc4: the message is gone, the
SDIO card is detected as before and Wi-Fi works. Suspend/resume, the
only user of these registers, was not tested.

 drivers/mmc/host/sdhci-brcmstb.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 1de2f05..7c17a3c 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -491,6 +491,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	struct sdhci_brcmstb_priv *priv;
 	u32 actual_clock_mhz;
 	struct sdhci_host *host;
+	struct resource *boot_res;
 	struct clk *clk;
 	struct clk *base_clk = NULL;
 	int res;
@@ -534,9 +535,13 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 
 	/* map non-standard BOOT registers if present */
 	if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
-		priv->boot_regs = devm_platform_get_and_ioremap_resource(pdev, 2, NULL);
-		if (IS_ERR(priv->boot_regs))
-			priv->boot_regs = NULL;
+		boot_res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+		if (boot_res) {
+			priv->boot_regs = devm_ioremap_resource(&pdev->dev,
+								boot_res);
+			if (IS_ERR(priv->boot_regs))
+				priv->boot_regs = NULL;
+		}
 	}
 
 	/*

base-commit: 6c377d19d4a5116d9bec5203aa3c6c11523e7898
