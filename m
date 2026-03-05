Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F163CF662
	for <linux-mmc@vger.kernel.org>; Thu,  5 Mar 2026 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739666; cv=none; b=pE2+hrteK4FQ86JZdy8lqJQWYjwpd1G7SbuTTYFLYj2FOH2NjrU5pNIiwbSX8NhxvuxY1gjJ8+m8alRR9aOpIkuUWFf/9D8EkdydQZ4W07A3JkSjnYldPQ5qmylIGwRhnebJBdmr3QO8ilbPTbNqWUvE4b5PnW3XYQKbc0DAl9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739666; c=relaxed/simple;
	bh=QfcpGq77fLYNDCobaNjjIeOj2imphrNCAcezXXgBA2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+Ob0xf+wIHzrt0os51VFJSBKtrj96Pt2uHgQbZrcnS3PjEOt/UKTI+UnRasEcnBm7N5ycZIXJE0hLjLrStj0vWAwC1I3tiYOEUgDekHBZbDcXeY0YdafbDr5S3g1P6FMi3spHF5D9z2jaihPloGrkGAoKaVBm8bMMzdKvUX1IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=yY0GtH/B; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="yY0GtH/B"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4807068eacbso70852095e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2026 11:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1772739661; x=1773344461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdIy1fm/RRHFyWbC0yhnY1690tyzx/03AbGybTnU4TE=;
        b=yY0GtH/B0csIqZprwtA9RNssxYYXEpWLCERb4a3elQygSvahpMbauPpEKyksnlNSHM
         yhovoWw6MlmbJb01FgUIAkIFzGY3W7iErvYN5hUQl+T/tYvIf5kr34f2du4a4wh6YEwq
         epf9uTpLUzbQ9YAVYo3VHlU7EwjLCR5VSi59laySIGZjZEJ+OXuc14354GyGr1Y35ERd
         sBqBhdNhh0Kst2DkX7ipDXvnhcdfE+OGTfgd5HEoVQAdR1G5VMt/wufkoSgi5B6tYiqW
         Mpp458XVxcnA1FDlTNfeeV0iE0sy+Su4QFTZldr+yPCHe0UWgYFQ3Rf8n1hBh4UO5+Px
         +Cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772739661; x=1773344461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fdIy1fm/RRHFyWbC0yhnY1690tyzx/03AbGybTnU4TE=;
        b=A9ArC3AXdP65HXWB3oRgP0fIwbtc8/GJ75KWXfJLZOGKPZZAxmUGC64Ki2bd5a56tQ
         iJg5nh8HsLOpTh/7Ga5R1s1lGTOfq4o+bO2dBFOtKB2ncS8+Yu/SfbE1iKsSDC0u43OV
         EC7aiUihb5nku2hQiDumaUdEXLNXEu0HPzYXpYnsJy2zB3ZQI3nQ3e66OtsuTbYsOTig
         DzNJhjWsapW+LiS0PttLXav56uUKBoW13Kb/9Tzddwo6Ghjwgq2O4/x6NCBbVm1VNM/f
         D+eLVuQ4skfTXU6FmL//0KQ9rTxvbRwclhD7WQRfKQiAhf9bUb/nXNxSQ0UYVHDi9Fhw
         92WQ==
X-Gm-Message-State: AOJu0YzVWgzMLoB57BjpiBAZWcg7S6HximN7ieolRx23kfYI3EfSNQyV
	dniv8OsE1IwSypjJQTHniNFe3d+N+Yct9VfPulxMY7HlUbKhHFEBC4mGXqoqHrV3YSTRrUP8pfw
	BNnhdKg==
X-Gm-Gg: ATEYQzyCWnT30/l7WFVZdt7lWTS9ixfeahzh88cpMhEm56Iad2+RMasoVH3ESrfeEeY
	enEeVeaSlvgwyJ2NOA/T5iQx7r8HAhInKZEI2bithIJKehIqN0roLSwzYJ4qwkibMGvgzAe2r85
	5589CL48reRte6jduYoPRQ9hfpDb0xiT2O7O48dwwiHKWeAokllk6cG7hDkKgqGVTsYgYkaqlAK
	+Og5eNRZsD/Gw+JuCqm3FMXQnHbPtUy3HN5sqpc+X9oOrOBjJMHdBHsws/Iek4NzbVZpOhMluGS
	zRwdi2aBbLrYkAMnlejuoEc7ccJGPLXGx2ccRxRg3MsOktsv1gjyvzO0u8dbxEV4i1PvUTJw7Tk
	oqLna3cTvI6nYbDu9NHhjtNS5ZoJFRA+shxF+f1tRRGd2kmyxUm3ZMJBS6cqXblRx/AGjWoJYn9
	lxpgHMlb2e+ZGXuacCn2CUBWf8ebjs91sZ0lfGSsS1oQrk/ea6mDo=
X-Received: by 2002:a05:600c:1550:b0:47e:e970:b4e4 with SMTP id 5b1f17b1804b1-485235fb068mr10533765e9.29.1772739660509;
        Thu, 05 Mar 2026 11:41:00 -0800 (PST)
Received: from starbook ([217.155.46.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485246fd127sm3265e9.6.2026.03.05.11.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:41:00 -0800 (PST)
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
Subject: [PATCH v2 6/6] rtsx_usb: avoid USB I/O in runtime autosuspend
Date: Thu,  5 Mar 2026 19:40:52 +0000
Message-ID: <20260305194052.5120-7-sean@starlabs.systems>
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

The runtime autosuspend callback currently queries card status and clears
OCP via USB register accesses.

On some systems this can deadlock runtime PM and leave the USB device
stuck in the "suspending" state.

Avoid issuing USB commands from the runtime autosuspend callback.
Instead, use the last cached card status (updated on successful status
reads) and conservatively assume a card may be present until status is
known.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/misc/cardreader/rtsx_usb.c | 11 +++++++----
 include/linux/rtsx_usb.h           |  3 +++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index 5d818b632788..63751797ee2b 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -336,6 +336,9 @@ int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
 	if (ret < 0)
 		return ret;
 
+	ucr->card_status_cache = *status;
+	ucr->card_status_valid = true;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rtsx_usb_get_card_status);
@@ -743,16 +746,16 @@ static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
 
 	if (PMSG_IS_AUTO(message)) {
 		if (mutex_trylock(&ucr->dev_mutex)) {
-			rtsx_usb_get_card_status(ucr, &val);
+			if (ucr->card_status_valid)
+				val = ucr->card_status_cache;
+			else
+				val = SD_CD | MS_CD;
 			mutex_unlock(&ucr->dev_mutex);
 
 			/* Defer the autosuspend if card exists */
 			if (val & (SD_CD | MS_CD)) {
 				device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
 				return -EAGAIN;
-			} else {
-				/* if the card does not exists, clear OCP status */
-				rtsx_usb_write_register(ucr, OCPCTL, MS_OCP_CLEAR, MS_OCP_CLEAR);
 			}
 		} else {
 			/* There is an ongoing operation*/
diff --git a/include/linux/rtsx_usb.h b/include/linux/rtsx_usb.h
index 276b509c03e3..3188f6616729 100644
--- a/include/linux/rtsx_usb.h
+++ b/include/linux/rtsx_usb.h
@@ -59,6 +59,9 @@ struct rtsx_ucr {
 	struct usb_interface	*pusb_intf;
 	struct usb_sg_request	current_sg;
 
+	u16			card_status_cache;
+	bool			card_status_valid;
+
 	struct timer_list	sg_timer;
 	struct mutex		dev_mutex;
 };
-- 
2.51.0

