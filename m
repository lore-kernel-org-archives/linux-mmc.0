Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A79C2F5A29
	for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2026 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317776; cv=none; b=LZJY1cnYWW/SU+FuLVPHmxAKeOT9chOiWvCTgr4ioVqmb/8CWoeJXC5cGYb2wdsunT0ZkDhOYTeL4CqmHCHLJlryYbv8WENYRMjTgUIWKgv8IPzlOlLpW1V9rcjE7idXTCUssvDeBRMjUsxWz4NVr9ViJOGRt0Zh/Rqj6tuCSEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317776; c=relaxed/simple;
	bh=QfcpGq77fLYNDCobaNjjIeOj2imphrNCAcezXXgBA2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqO8pdvWTVXBIGnNLHEQXuzMQ8Ng+arH2yXupznijDDfOSCsP+J9aiD/9QntnORTE5mO1EOwKMtvsyM8lB3gu5zxVB4e12CQsjR+cq083/QkdsJ+mroKY7UHbfQYJHJRm/N5liC7WDkzq3UBHwzd57ot2cMYdliRljhIbFtPJNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=0iNdwIYV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="0iNdwIYV"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so816526f8f.3
        for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2026 05:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1773317770; x=1773922570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdIy1fm/RRHFyWbC0yhnY1690tyzx/03AbGybTnU4TE=;
        b=0iNdwIYVXvXfMxMJzQRUstDg5kFYHo1FwHmc+PVHPpPrfVprih9s2DIavYhGHAqnDi
         Wm37Kubvh5rAbD5g1EwKGQ/Dkxvomc2L0to7a6amviBk0yEk2aRuWi2BWx7kI6gATAwM
         KXswJrT0dkh/MYeHlmyfeZfJoWQkW1/cZ//BN3WsFrixvqSnmz945wpEQXER4Zvh3yZz
         gmYXHtymP8Jr/xq4AXviII8EYM26I3tZgtl7GSLbMTgc5h9b00GB8jliiq6SzFyFoxm5
         hYDiruFFLntm+07V1joYSH7UjQjhzu+XKxRHWVmgPWAxCczInolTKCFQcos/8pGR+Ri/
         ihLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317770; x=1773922570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fdIy1fm/RRHFyWbC0yhnY1690tyzx/03AbGybTnU4TE=;
        b=iRefkipKQgxGtJDnC4WTfMUR8d08RJ3vyEkN43djtLMYt0Ejy/P6HgwB/01v53x6+C
         FrSG4REQsMoWKqemhGOq6iGYJsOog+CaCHXO8XfIyi9LKB9gfyMFF0iaoO88KrfJ1qAy
         08z9j9+35D0Zaiw+7BYUX7hdSZyElx8xsDLwHCLqf8OCUUWN2iPtXr/UCZzF+PN8WQ+Z
         hTasOdR7uGsegZP+k2tW8i8jsXzEWKwniBQzuHexHKG/Sscxok5ptNbHQsFUZN/0Kk1O
         E1oY10aB/sk2gfRxvZFu7PciRFHK14H0GqBb8ddZyXPJiYMLSKhL625Wy/x6DYoNVTrL
         PaNA==
X-Gm-Message-State: AOJu0YxIm98LH/WuThv0IxxdBT2ngBARNIJNfLuMUDfqQvdZtopLblcc
	v8kYI49rsxmWv06OMQJ3dKWxyBG1w8l8Jcnx8EumcWhgHFUqlyc57SKI4qEWY+fX7sOy7ffsVK5
	3Nj2B3w==
X-Gm-Gg: ATEYQzznn9bHDylLaR0WD0Fqh1lHuH4V2wouzudknpI6ZuoTTRMxzg7c9sc9F0f7Jyn
	QbielE86tNntkzB4G3eTClmRVc/qSfC6wIyR/g6sN5IQ10Ljl/qQYLXlEoUn3H5dG5z8s7JR073
	67xLXWxEBQ6v/aKAFaku/k+wN7//5OY2wqKsvxH9qimvRc9Hw+SQugFe6d92bYRf8yxw8dErKug
	uq1yjSMtgQUXlfFX6mwJW9cwOGZHmb8VEIZUvFi4lWKjC7CPC8rKBgn/8oJAIF1bPKxlM7ATPbE
	o/KLhCzIpwQMWCODP2Yb5E6u9fEsu264cv0UaMD8x2H/w2bu6Dhjd1oDS1cS5smMBxvgYb/d32f
	XSqCp4L3sDo7O066p/a+gO5pTJ81BLV3++MsjsIdOcU+sbkS7DcxbYYNInPOQx6OE139jXOVM+w
	Kg/4qr7aEMP7H7bvHluZ+bw368gdGvtGOMAsVGAkqDOb4J0LhvMiZlAfn/yBsi4Ev+dnrlSw==
X-Received: by 2002:a05:6000:250a:b0:439:be3b:ddb6 with SMTP id ffacd0b85a97d-439f8441487mr11829204f8f.59.1773317770061;
        Thu, 12 Mar 2026 05:16:10 -0700 (PDT)
Received: from starbook.localdomain ([212.105.129.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c473sm8139874f8f.24.2026.03.12.05.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:16:09 -0700 (PDT)
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
Subject: [PATCH v2 RESEND 6/6] rtsx_usb: avoid USB I/O in runtime autosuspend
Date: Thu, 12 Mar 2026 12:15:59 +0000
Message-ID: <20260312121559.19197-7-sean@starlabs.systems>
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
