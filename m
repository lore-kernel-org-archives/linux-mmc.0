Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB635346E56
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352452; cv=none; b=M7ACSyLi1eKXY6tQXxQ6D6t7usF5eiG1ioOEncNmJIGc/OG8dJGry6rrgiBZOAbB8VNqYM6T1ltR9qTXFQ/j2adKDS821muhdg8W+VzYTi+c48+PT0gCZbvOHK80xEd1zawy3WReZ39Z9mlk4ljKFnAnu1iUNsnjxknZC1p8DGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352452; c=relaxed/simple;
	bh=ow0cV4MmBxvTKrfQTsmEnH6Z5tO5qQZ6l+9swmzVv6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUlSR94rqROB1OjaSv06JUd2/m2lExnUxu3VjBHS6v87GHKk+xT4fI/65Uu5Q3OEEG5Y8o4DNdmbEiuHfDhz0LXROMTZ0oITeiagJXZ29P/g6w+xbzhxSS2Hm5K1F054gFFFcMC6q64j+KNcH16+zz7Z9GbYblMGC7qLrd0emZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=FTcApmtA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="FTcApmtA"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493c19bad03so29785735e9.2
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1783352449; x=1783957249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/G5x6Hc52+S82+X8Nv0Q18+4/TU5RR37pctCSwMkdVA=;
        b=FTcApmtAFbz7+IiGgv5MQbTTB/DtieWD8gR2AAMlgsIN7rT0qALwW6cYB5EtvbxjVz
         HEtXgPIJj2ZVC7YWKdVwciJYATfmr5ZE7UCjzUfDqgI7pk0QsMkVjX2EmANBWGQNy17+
         PKPSD9WXL11PeF6zKvaFX1PWRfUa9/+G6OXvkrualnMBhZOb2Kt/9CGIfS+zdGB/etW9
         DtiHwJ4EoClM62d7Ak3ljqEAO05XpaL9HchcCypYzYibVNtj/l37rXqL92CNBZsgnmvl
         1jZVeY+jG3txJQJsaAmGUGu5TcJVTvM6P0Ga45XYgddxygmCWvM5vC9YyZicgVOTV1nX
         mhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352449; x=1783957249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/G5x6Hc52+S82+X8Nv0Q18+4/TU5RR37pctCSwMkdVA=;
        b=Yn5tKZBgOyVtck+NvTpbEabsZB+yo4A1njKh1XsIlbhs9Y5PzREk/CzeSREYeX3HVr
         XHJCtzzjG8jfzWe1EfiaBbcHYNTfzaMftAmgb99s23jA5+OdE7mpM1O0v5tff2g8/Vds
         9j7bios6kyWjJi0osAdeXAKoV9ReSPpq+Gsj+TCLfd1sdh+0gGfZlfHXRK5Qze+FHNMM
         Gu+AT7kBXPwSx9BdtGzCWyOyEDGDXNWyerjdda0wkpzVRYkD01x7KvZDdVysTuWxN5G9
         TFmmyU7kvmQ3HVv4S3nArbv9iom9yYDCyB3hM/DwREGoFtl1YmW6caT/TOazx5SAd+y6
         ztBA==
X-Forwarded-Encrypted: i=1; AHgh+Rpy6Lyo8UfWS7RSugs3J4hTVzs5esTvevNGWJMXUhAfdlf3OPioKRmZ3qf4+cQzFwwbRUTw6xVmPx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysCzR2skRaUrRu3lkf9KOnyQzQWrvwd3xaAqhXIpB62UxvILCz
	xv33qc+UJKoQmFDmlQEWd6qJgjwoyw2hWgbfeuwObZW2K9YVwszHJI+xexBFiyyxxQ==
X-Gm-Gg: AfdE7ckhPnV8KIMKjIR2ZPsl5Ji+m8ib6gIzrSfgGfE3uEgWEe5s6b9a7iN+V+9h2PI
	8dGglQvUbOKMfbJZS6z1oAjRsZznsGDBVdaCpyZ6ut8QbYzgiVJ1EaGwuBQqcODpwrMe9kbtMty
	mKCKR0dHQOwRaAAPtPnzGD0rRiLcmJCJrmldD/OFfxbkk1lFn6awmb8tZ7AcP3SIHig/rur+vs6
	h6m2buxW6kcxpbCJktSIB0/MRi08c3CYz5FKyUzryPK6itQtO8ftMHiGHZAyUiDKQQDlxfSxTX0
	mjxiXjaG57AcrTzhy5TNffWNlOy8dgwgprgYsUB+tvHKJB7pCp2xCC31DNQixhbYfHtRtXVokX8
	HESudshVUEQSvypMaxDV/411F3SN80IuYttrIMZ8vnms6TaQ+8zYlsngryMZA5pkBycksnvC7AE
	7NJM+RgSm62N/vEko8Kmtq7fQlWNRKUCVj0ueSnU6S0Av53rzn07Kt3Lo=
X-Received: by 2002:a05:600c:8b70:b0:493:b6e4:fb2b with SMTP id 5b1f17b1804b1-493df06e943mr11965665e9.25.1783352448552;
        Mon, 06 Jul 2026 08:40:48 -0700 (PDT)
Received: from horizon.localdomain ([150.228.6.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce03fa1sm283699005e9.11.2026.07.06.08.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:40:47 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ricky Wu <ricky_wu@realtek.com>,
	Sean Rhodes <sean@starlabs.systems>,
	Lee Jones <lee@kernel.org>,
	Roger Tseng <rogerable@realtek.com>,
	Dan Carpenter <error27@gmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] misc: rtsx_usb: avoid USB I/O in runtime autosuspend
Date: Mon,  6 Jul 2026 16:40:43 +0100
Message-ID: <7acac70a471452a6ccf23b7ccc557f3c3861e0ad.1783352430.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783352430.git.sean@starlabs.systems>
References: <cover.1783352430.git.sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The runtime autosuspend callback currently queries card status and
clears OCP by issuing USB register accesses. This can run from the
USB runtime-PM path itself, which is the wrong place to start more
device I/O.

Keep a cached copy of the card-status bits from normal status reads
instead. During runtime autosuspend, use that cached value only to
preserve the existing Memory Stick autosuspend deferral.

Do not treat raw SD_CD as an autosuspend blocker, because tray-based
SD readers can assert SD_CD with an empty tray. A real SD card is
protected by the SD/MMC child runtime-PM usage once powered.

Also stop clearing OCP from the runtime autosuspend callback, so the
callback does not issue USB commands.

Fixes: bb400d2120bd ("mfd: rtsx_usb: Defer autosuspend while card exists")

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/misc/cardreader/rtsx_usb.c | 26 ++++++++++++++++++++------
 include/linux/rtsx_usb.h           |  3 +++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index 1830e9ed2521..a127744918f4 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -312,6 +312,9 @@ int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
 	if (ret < 0)
 		return ret;
 
+	ucr->card_status_cache = *status;
+	ucr->card_status_valid = true;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rtsx_usb_get_card_status);
@@ -623,6 +626,7 @@ static int rtsx_usb_probe(struct usb_interface *intf,
 {
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	struct rtsx_ucr *ucr;
+	u16 status;
 	int ret;
 
 	dev_dbg(&intf->dev,
@@ -659,6 +663,9 @@ static int rtsx_usb_probe(struct usb_interface *intf,
 	if (ret)
 		goto out_init_fail;
 
+	/* Prime cached status for runtime autosuspend decisions. */
+	rtsx_usb_get_card_status(ucr, &status);
+
 	/* initialize USB SG transfer timer */
 	timer_setup(&ucr->sg_timer, rtsx_usb_sg_timed_out, 0);
 
@@ -713,22 +720,29 @@ static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
 	struct rtsx_ucr *ucr =
 		(struct rtsx_ucr *)usb_get_intfdata(intf);
 	u16 val = 0;
+	bool valid = false;
 
 	dev_dbg(&intf->dev, "%s called with pm message 0x%04x\n",
 			__func__, message.event);
 
 	if (PMSG_IS_AUTO(message)) {
 		if (mutex_trylock(&ucr->dev_mutex)) {
-			rtsx_usb_get_card_status(ucr, &val);
+			valid = ucr->card_status_valid;
+			if (valid)
+				val = ucr->card_status_cache;
 			mutex_unlock(&ucr->dev_mutex);
 
-			/* Defer the autosuspend if card exists */
-			if (val & (SD_CD | MS_CD)) {
+			/*
+			 * Do not issue USB commands from runtime autosuspend.
+			 * Raw SD_CD is not authoritative on tray-based readers,
+			 * while a real SD card is protected by the SD/MMC child
+			 * runtime-PM reference once the card is powered. Keep
+			 * the historical Memory Stick autosuspend deferral when
+			 * the cached status says MS media is present.
+			 */
+			if (valid && (val & MS_CD)) {
 				device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
 				return -EAGAIN;
-			} else {
-				/* if the card does not exists, clear OCP status */
-				rtsx_usb_write_register(ucr, OCPCTL, MS_OCP_CLEAR, MS_OCP_CLEAR);
 			}
 		} else {
 			/* There is an ongoing operation*/
diff --git a/include/linux/rtsx_usb.h b/include/linux/rtsx_usb.h
index 276b509c03e3..0fc5a74700a8 100644
--- a/include/linux/rtsx_usb.h
+++ b/include/linux/rtsx_usb.h
@@ -61,6 +61,9 @@ struct rtsx_ucr {
 
 	struct timer_list	sg_timer;
 	struct mutex		dev_mutex;
+
+	u16			card_status_cache;
+	bool			card_status_valid;
 };
 
 /* buffer size */
