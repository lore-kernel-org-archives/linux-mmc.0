Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68662E0B71
	for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2026 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317775; cv=none; b=bMrp0rAT0zg06l0BqPZh6VzJXzLmKKYvwC3frJ+dPy4D020nf0O+asWnCcjQFyn/+S1z3nIy+H4P9pVgZqefnOrGrbBZCgdH9fqCFIaS4DE2yvjDFDS5pui3oaFKjIuzQeTqNRz8cIx+weDnRGwdIFrgd8DKPbVVFceKS9neMdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317775; c=relaxed/simple;
	bh=L1iquWccV2yVTQCH11JwiafCcxb5GJJdUIRGsXkOSjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3WDlSzH8HYbbEeySCgTKz5kqh0+nZXjATVyP9gKNjnNALVBO9XAq47Y/1c0jCz/cCF9YRhX3iNQIpSY1sYeYE2EvKFb0USMdHmKiGo0m3CpL3qRVNdmM7U5Hs08ZNe+DmEhclgaGqcpdSPG1BTrSre6k7O6bKMw4/zLdWscuMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=vQBQGIWy; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="vQBQGIWy"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b7c2788dso654221f8f.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2026 05:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1773317769; x=1773922569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apEGcP2fvlwAgwLrCM8QRJtwowl3Oio23Mz89ebHt+8=;
        b=vQBQGIWyOtfgeiEyrIzPNDJvaNhKLa+mDPJYKfdyqsPLFUaV2MsgR1oEZHj1gMIrsa
         KnmUQ5f3jLgG0a+qYpEiTLFIMHjroy/hl8Quj47EBMvTcprx8MFUERe36a71NfzaZZCD
         OTidePuosxtzs41NmB9Fu3tPvzwZnAH+rWonpmKPc8hBhfH3MgkZG8QgGsKcn26hXYr/
         JNLfGQMcwx2kxdkmqp4tO4/hr0SOiY/OyLDGO4TDrfFHWGNE+DpNF+BwpN2CLfogxQP7
         cvhV/d6t78ftdX9QyqneM1mZuNxkVSF7gaoEFVD4vMkTVXwlf06WNQ4ekUfX1J1lykMH
         TidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317769; x=1773922569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=apEGcP2fvlwAgwLrCM8QRJtwowl3Oio23Mz89ebHt+8=;
        b=Uhu9rqtcECbqT0ngoqNfwqmyc+aNpAorLZKfjy7000AUJlBjfpfN1I1vkp2/pp8PGR
         cCVzYqzG5sbFcd8xQvK9OhYz6SoGfzriz7/m0ukBT/ooG+raHob+MimqQCK7342On+/F
         32BULzzi2Qe8DoYEdo7pDS/uPRpUels1hhkC+MvN/MGz8f0J3CJspcANaXZyqLXi5+dN
         56pCOZ9CsEVa1/67hiBJKmcnYOm9JzMffo1dXgd/BhQd+VBpK6cAuXHebEopIvp1I3sf
         djJEs9C7euL/3BqGdIskJiI+RNjCzLkoQAG4kkPjbUY94S0AfxKB65bgDIPtJv2lOO9+
         VFGw==
X-Gm-Message-State: AOJu0YzMFyEILSOFLHFsIpFru31SqCYMimk3tOCHUk8pvGdQ+Ti3Ik/C
	5mv7hXuamEOJOpXq9XCW/SYIRJorGwxpLVQ8h8RVHjYiNmcsdHqthoAkZT1NHd+KOrgbvTMmUox
	o7g6SsQ==
X-Gm-Gg: ATEYQzym2Ax/EiLNE1wpAuK8oxfwDGG4GIcBq4hRIbbWRCNV11Nx5nXiNvApSFxgDwO
	l6/PxibI5f3NRfYk9Uz8mlDfrv44yUyCdBOwgHfgN4ZLOfLGajPuTlaSXOPqpU2O/WhsKl4mC7P
	OKPIPzYY3i/kbJ8UMvrPULe0h5lN6FtO6egsolyL/uz9V0Qd7dm/khrGeq4IKw9AxzqBRF5SmNt
	hRzIuinPCYNWdlY2GFwF7lxygS9tiD8Zv9AgrbM+F3Epp+6XtrX4nN5cklJRsCC/Qi1a2qgWHCy
	WkGTd8eePV3m8jWbKNSchH/I5Fn44pfs/dofFokQYP1R4N9ONhWLgwnlrjwDA5bv+wQftC4mOwT
	PPhR5MfEd2uVg4yPBwxRSeBbY1EgTvc6zTOZbcV7ZqfbbPcoqt1xz0lKDnjD0mdjmw09NKlXNUl
	1mGGsL68XaW42aFq0j0oVTNkYjYjCeHoeqquykmiXgRxwFRGuRM4BZ+i0QQoaPM+T6SLKSGVGxV
	6oX4IYc
X-Received: by 2002:a05:6000:1aca:b0:439:ca9b:1f61 with SMTP id ffacd0b85a97d-439f81c74admr11574930f8f.17.1773317768726;
        Thu, 12 Mar 2026 05:16:08 -0700 (PDT)
Received: from starbook.localdomain ([212.105.129.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c473sm8139874f8f.24.2026.03.12.05.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:16:08 -0700 (PDT)
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
Subject: [PATCH v2 RESEND 5/6] rtsx_usb: hold runtime PM during transfers
Date: Thu, 12 Mar 2026 12:15:58 +0000
Message-ID: <20260312121559.19197-6-sean@starlabs.systems>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312121559.19197-1-sean@starlabs.systems>
References: <20260305194052.5120-1-sean@starlabs.systems>
 <20260312121559.19197-1-sean@starlabs.systems>
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
