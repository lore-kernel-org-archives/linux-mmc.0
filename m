Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795570857;
	b=GLX5s2+V4no1ufJHNw7jWRyee2XAa3mx+6P6uSwX5YO1UUOGHiTv7dcddbhMMqVygdVo
	 EWMMd3W3lZcIbLd2zAOzi65GMYehHfKllMtccbuDX9WNCoxmZr9Skun0JUNvxqLZwq37Z
	 qwDpmj+Ist4221NK2SnXI0B95OZkdcN6vhqkqyAg38hDsew/NeQBOscasZhu5Xjwe6WwC
	 0ke2igTdqZI/n2AWdueH86ZFPmrAYhL5MR1b2NE7yOdAbKPkHXRhtMzL0ZMrYvcKdVsDR
	 WJbpJjqm1KjL3hbEyUgRjz75czoWZeYyQadaedF9AO4o+zJhR8Rpym8R4iu+uByit7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795570857;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2k30GY8w8sIQsAWoDKXFJYTpD8SvpUR5692TePf907w=;
	b=Xp3c+EgrH0z2t11qn8A5yddjbuXztGvfB5y/S+EbIEy/VB3nLukfRYN39Pw1KreQ1UAx
	 wlcfivnXWyQpXXyCfN6b+r2FiJ1NDSZWOeBdwrNVTeD8TDaiu6EdwDcnhG7taW5ByRoGg
	 G3fE6JKowLgtgNkCIdImsCxCqyRPQULvWTgQSnBHqu6JjTsfl4U68XzlXP4Wlh0azv6mJ
	 gC5YVcL4iG2uyYh9Uxh6PvCM8g+EE8tz0Kv5wZ0AElt1c7luoegNok0FoxjnuMCM8aYLv
	 rfvx8zt0dDB3lqamRS0oze/cZa1cuJNxocU+nbH265mfFuCSsVubC2God2GCWPRu18A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=QIUPozd9;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A12606A321;
	Wed, 25 Nov 2026 01:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45A12606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=QIUPozd9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=QIUPozd9wvqQg8t0XWYzF8JACoiHkePj9QwMsL/Eigtz+iZ0m9sL9/U6JUbq8pMo9yANyXVdmtH88
	 wcLA6cVMDqpcVZeXMiKbjv+enEnPI97+avgBNeqTiJESX1sa2v0I9+IEoWo7mnED+C5qk54QdjVGlc
	 QoZbDJcf9UrPd6fE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66b063c9a360-18904;
	Wed, 25 Nov 2026 09:40:46 +0800 (CST)
X-RM-TRANSID:2ee66b063c9a360-18904
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76b063c9c755-33b71;
	Wed, 25 Nov 2026 09:40:46 +0800 (CST)
X-RM-TRANSID:2ee76b063c9c755-33b71
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: adrian.hunter@intel.com,
	ulfh@kernel.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH v2] mmc: sdhci-acpi: Fix free_irq() of a never requested IRQ
Date: Wed, 25 Nov 2026 09:40:43 +0800
Message-ID: <20261125014043.258-1-laixiangwu@cmss.chinamobile.com>
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
---
Changes in v2:

- Fix the Signed-off-by line to match the sender name. The SoB text
  was left over from an older commit and was not regenerated when the
  author name was updated. No functional change.

Link: https://lore.kernel.org/r/20261110070032.1387-1-laixiangwu@cmss.chinamobile.com/

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
-- 
2.50.1.windows.1



