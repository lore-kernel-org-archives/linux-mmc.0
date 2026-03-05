Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1223E3DBA
	for <linux-mmc@vger.kernel.org>; Thu,  5 Mar 2026 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739666; cv=none; b=PZh4lEI3/rCVasa0g537ElcUFY6GZ5jOxZsgbxSUYIy3fybFiA0Wd160qV9HOHODMHkqTySyIf1J0pt22bSI+GL2VT0neWC8m8bOagTQC50+bs2/FXv7Jdn4FhugIv/nzXu8Krzr0gRcjl6vB0I7aZmQZ1RvlXYPUPwrsFnOmrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739666; c=relaxed/simple;
	bh=L1iquWccV2yVTQCH11JwiafCcxb5GJJdUIRGsXkOSjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqOQQmLwF+lblRmNf5kewu+llM9a+41wZXDPp6VNLerZHxcp92pf/+2Ocbl31ihlViDMA05Fo5RWjWwhMKR+J0+t7JJ+A1WH8hMgpGayQeHTe9fNHiulffhcImcuIfDYWguEwAhNoO9bW2QGmCmUX2Jkn/oD2Ahce0G/tQ7+AJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=jXYtEPPe; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="jXYtEPPe"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483703e4b08so82199725e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2026 11:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1772739659; x=1773344459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apEGcP2fvlwAgwLrCM8QRJtwowl3Oio23Mz89ebHt+8=;
        b=jXYtEPPez1gPVsGzjsX99d9bL0WntryP+8R/jbVHsPajMBiV6qWfB3XXPkUaUAC1YB
         R32XRbK1LzbTOQtWFlU44b6Sb7i2I+AEChL/uWzI4w7Bmx8vifP0KwOqNVnNZ7TIpnJL
         0HkkLkApWCOS+LO6zGlbouMEmAt5Usp6oST4xxSjG85bF0HdODwuQg2HcXiCpLmq0tOq
         Y1H9GJ2U89YKzicNPOjlLUebtymdhfN02sgfJWsPE/jGdtMhJs4P7BtRgZaQOHOWWWFa
         Tprsi2p/CIQSt/Louiti2ctIcwLlrAjWkLBmbitCrWklpAb4JTHvf0zGXgP8etfL2G+7
         4avA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772739659; x=1773344459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=apEGcP2fvlwAgwLrCM8QRJtwowl3Oio23Mz89ebHt+8=;
        b=FvtFav03bSTMpvg6Q0GOs3WmtDF9imRykI2h6V+2UAKbixIGSlFmCmt2+u07Lobzdy
         5duLg91DdYxrVojbk7n2hV4/5KicKDRRACE9mJ+WSlgbaIxl0n4FJztUycytD6oRn7Vi
         /JHsudeufflLDU/cbNCjVKODt1iwjtPagmURK4Y6/7875u9gL3uXcZoZXImSGvuhWyk9
         ylitPboaRyIw0Cxc03veQpSuhRPwkGYBdNjQ6fr8uTUWe9NxGplLA4kzTd7oULTNwDcc
         QWBwUaOeFzEMZSGCmoLUZy5I0oTEgTgDQTOEapsrDxc9Q+YWAeUq7o9nnZiVKQ+UCdPt
         3ukA==
X-Gm-Message-State: AOJu0YxI7j4g64woQWGOM5dWoqB7T4TyPYOwe/iP7I38Z//rMf8l405q
	jtHMC/5Y3lsmMQdQOvzxpSUbWLtC/zeW0Ebf/IDTX8n7JKxi/dsYVVQCdSohEKG3mVgTICEUB1H
	do6J5IQ==
X-Gm-Gg: ATEYQzyfCpzfRxqan/JF2O+48BraJaR6pFlIUbmq5Nsvj9SgqdBvHxTMXteSG/kLcIN
	u8X3uqthsvHoeDyp4w16srhLfcNSJUm4MLonKBVit2NuoDGbU/oNAlEwXzg0egK+FM9mKXqRF7w
	VZafrb4u3ECUmqqyhH8g87p4LNHo/xOyhbif0LBqmwcgwud3bMrNVEaLfoixma+JTNz6/TEJ6mj
	Xx4UOPF5DCLSN4Mmr40bATzYokug/Qdwej3NQyF2T3k172UD6AO13Nng8nUY6uWhjMdsxAQZKPX
	kGvFtp/4s22tPUkp8hpa0q0FrFcXXQVy7xpTdqPoF7KjZ6hgho2163Pi9NwrbVhuDBypCQtpk9A
	gzfkWCOeSPczeHJ+NMJ9CjiDPtnop7CLlu6ayXQ4w1tC3gC7GhpE8DOhT8fCIlUOQ5M45qF0/4y
	tLcdOCKHJe7zLQQAAQE09jWy3pHQkueR3fEVdL5d93hICcKpFbR0s=
X-Received: by 2002:a05:600c:870c:b0:483:a352:b4e4 with SMTP id 5b1f17b1804b1-4851ee81a6amr60300225e9.6.1772739659513;
        Thu, 05 Mar 2026 11:40:59 -0800 (PST)
Received: from starbook ([217.155.46.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485246fd127sm3265e9.6.2026.03.05.11.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:40:58 -0800 (PST)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ricky Wu <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] rtsx_usb: hold runtime PM during transfers
Date: Thu,  5 Mar 2026 19:40:51 +0000
Message-ID: <20260305194052.5120-6-sean@starlabs.systems>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305194052.5120-1-sean@starlabs.systems>
References: <1ca7b488a11e03b3f107f1829a40cf2c92c7d5fd.1771533586.git.sean@starlabs.systems>
 <20260305194052.5120-1-sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hold a runtime-PM reference across bulk transfers, and mark the device
busy afterwards.

When runtime PM is already in progress (e.g. from rtsx_usb_suspend()),
avoid forcing a runtime resume from within the PM path by using
usb_autopm_get_interface_no_resume() unless the interface is already
runtime-suspended.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/misc/cardreader/rtsx_usb.c | 38 ++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index 1830e9ed2521..5d818b632788 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -12,6 +12,7 @@
 #include <linux/usb.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/core.h>
+#include <linux/pm_runtime.h>
 #include <linux/rtsx_usb.h>
 
 static int polling_pipe = 1;
@@ -65,19 +66,42 @@ static int rtsx_usb_bulk_transfer_sglist(struct rtsx_ucr *ucr,
 }
 
 int rtsx_usb_transfer_data(struct rtsx_ucr *ucr, unsigned int pipe,
-			      void *buf, unsigned int len, int num_sg,
-			      unsigned int *act_len, int timeout)
+				      void *buf, unsigned int len, int num_sg,
+				      unsigned int *act_len, int timeout)
 {
+	int ret;
+	struct device *dev = &ucr->pusb_intf->dev;
+
 	if (timeout < 600)
 		timeout = 600;
 
+	/*
+	 * During runtime suspend/resume callbacks, avoid forcing a runtime resume
+	 * from within the PM path. The device is still active when
+	 * rtsx_usb_suspend() runs, but usb_autopm_get_interface() can block when
+	 * runtime PM is already in progress.
+	 */
+	if (pm_runtime_status_suspended(dev)) {
+		ret = usb_autopm_get_interface(ucr->pusb_intf);
+	} else {
+		usb_autopm_get_interface_no_resume(ucr->pusb_intf);
+		ret = 0;
+	}
+	if (ret)
+		return ret;
+
 	if (num_sg)
-		return rtsx_usb_bulk_transfer_sglist(ucr, pipe,
-				(struct scatterlist *)buf, num_sg, len, act_len,
-				timeout);
+		ret = rtsx_usb_bulk_transfer_sglist(ucr, pipe,
+						    (struct scatterlist *)buf,
+						    num_sg, len, act_len,
+						    timeout);
 	else
-		return usb_bulk_msg(ucr->pusb_dev, pipe, buf, len, act_len,
-				timeout);
+		ret = usb_bulk_msg(ucr->pusb_dev, pipe, buf, len, act_len,
+				   timeout);
+
+	usb_mark_last_busy(ucr->pusb_dev);
+	usb_autopm_put_interface(ucr->pusb_intf);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(rtsx_usb_transfer_data);
 
-- 
2.51.0

