Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294038;
	b=OxpzQjtEX+9DYveZBVLnqgzxvBETA/0Lyu6W17H8lKDRanN2t6K1r7vP4CdY9pJNqCxb
	 XV82CSKONZ9hNUq1InDlkzVYxn9VzO5JCj7ljc488qZ0UN3W6lJVdwOfoXRwm8gFYbNeW
	 HvZgfV7jyhlXYbGS0iLTSs2ZsLF7X8ZQUv5IxTvRSLWbDl4CZYWpNpaSpTrD9NWCfmgci
	 c0LmpCIO16nu3jgXvkolZc9PHID90930/pRGTVrhHMt+REi1f+SDGHAUzlVfB258Xh4xE
	 twzjvHymYzIG7v2XgPjGdbvU51Ztm5OuMfAbO6Bm7k3LTVA2CoEuKdBN2rZ1kZZcV5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294038;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uIgIoqNUaNcHTCa8YxNJf9eSahU1vZuGDd3kO1Ne5XU=;
	b=lm9Odd2Yuce2Y2nX5F2iPuDpwT0cKSgL83eRnKgF3tazp5HdvninBezKxoonzMbxcxMI
	 +vjdqKx8+Bdn64S48GvH5edMSBLhDK2Q+2R+pCGlSfSLv8rL/MKmAStsMmSww9NhnVxkQ
	 MQ+kLVfA7yQns9/cslNMb9ibp1i3GBbCObMqAILBEkavBVwmf0zjJ9vCzxPElTKftyNxQ
	 2HOvOt1ofj52I4ogqSGwSwK8QxolsNJQVcy9gcsC7PJou+MkqkFAEHxeNcpLkYg940/3B
	 UWQuPn5fnCvP0mGbUS5CGPiy+JlNFvch36HTNbtvDBrPkyPTRcYsDjuH5dedzy7ticA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ZFnEL3cO;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095F9606A321;
	Tue, 10 Nov 2026 07:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 095F9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ZFnEL3cO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ZFnEL3cO3IbqlOJmmJt7FEsk8BicLWOkn+5bWrzzshISbvyKKefBsuJKrJHNuR8BVQVvT8AWXWqL2
	 IUhMpnOIPXf6yp8/fRgaRp7d1cF18Yk1a9A/tYTVLELbwU9z+UBBJFpVI45OPVYJyVocSHxsDyJDbU
	 pJc8kzTfxnEuOwKA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af2c111092-c9602;
	Tue, 10 Nov 2026 15:00:35 +0800 (CST)
X-RM-TRANSID:2ee56af2c111092-c9602
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af2c1102d5-ab182;
	Tue, 10 Nov 2026 15:00:35 +0800 (CST)
X-RM-TRANSID:2ee96af2c1102d5-ab182
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH] mmc: sdhci-acpi: Fix free_irq() of a never requested IRQ
Date: Tue, 10 Nov 2026 15:00:31 +0800
Message-ID: <20261110070032.1387-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qcom_probe_slot() stores the IRQ number from platform_get_irq() in
*irq and requests it afterwards.  When request_threaded_irq() fails,
sdhci_acpi_probe() already jumps to the error path that calls
qcom_free_slot(), but *irq still holds the positive IRQ number, so
the (*irq < 0) guard in qcom_free_slot() does not catch it and
free_irq() is called for an IRQ that was never requested, resulting
in a "Trying to free already-free IRQ" warning.

Reset *irq to the -EINVAL sentinel when the request fails, so
qcom_free_slot() skips the free_irq() as intended.

Fixes: 96ccb858093d ("sdhci: acpi: add qcom sdhci host reset quirk fix")
Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
---
 drivers/mmc/host/sdhci-acpi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 84c705460..85705d2eb 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -412,6 +412,7 @@ static int qcom_probe_slot(struct platform_device *pdev, struct acpi_device *ade
 	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
 	struct sdhci_host *host = c->host;
 	int *irq = sdhci_acpi_priv(c);
+	int ret;
 
 	*irq = -EINVAL;
 
@@ -422,9 +423,13 @@ static int qcom_probe_slot(struct platform_device *pdev, struct acpi_device *ade
 	if (*irq < 0)
 		return 0;
 
-	return request_threaded_irq(*irq, NULL, sdhci_acpi_qcom_handler,
+	ret = request_threaded_irq(*irq, NULL, sdhci_acpi_qcom_handler,
 				    IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
 				    "sdhci_qcom", host);
+	if (ret)
+		*irq = -EINVAL;
+
+	return ret;
 }
 
 static int qcom_free_slot(struct platform_device *pdev)


