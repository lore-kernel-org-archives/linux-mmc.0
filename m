Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36C2F363C
	for <linux-mmc@vger.kernel.org>; Thu, 19 Feb 2026 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771542998; cv=none; b=sMf5+yVcOoKlykHawGfkddEsWAIVO4qlDwVk+gTXEXt/7wpOqdfdFY3fIoL2Tg7T7Aqxsa7HTqqO525AFGIRYI0D9Ya1pUsJI2nKOHQ1kjcn+oFtxf/ukLIzFbvjq/tyBsJvmn/KIXavtr/jc41pxodMnv3AjHa2BBL5XPmMsOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771542998; c=relaxed/simple;
	bh=gXeQW26jTSQTiyXN17bmGgnqjm5kMoyGJlU5U2LO70w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2PGkLAaIoC9GVLDb2fevmfVD4FT3MNQtanBts9dOEbYAeq5rec9AATuJWL+a4j7B68loh3jx2P8O/mXexI92w2hxqH7kHw5XM3yRePM8DtmkFQa416WN8gf6YS2kMhHXIUYG9gHPKYYyFAoKwPpG8ZFjOvueB4DcZwzCDFyDh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-413d8b8e98aso675938fac.3
        for <linux-mmc@vger.kernel.org>; Thu, 19 Feb 2026 15:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771542996; x=1772147796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2FrHlSkp37yYjUZdmhoLkWWfswktOZSb++6lxqz9IBM=;
        b=LCfG5fDds25NnLiLEIRAnhcuAX3UzW3P5qIWGhPZCjmOgVUQm/Np+V3QCpI2cPmwvu
         hNRwmyxvyO3OcRntKftD3A3+01fOWT8QPe0EJW9We+Pc+YDLn70tKV3hbmZVL3fv5Dh/
         7bUgapUiR7dsDxUOd7zpRXjvLfZWgOfOlgO1jeI6fCMNr7ezIQHjz7WbPKquW0hevEvw
         XQaUQj80YI2FzVujpF8r6UXO6igR3jUXOaN0N+F2j65wpTTOCsrCd1jfQnH/tkNT12mJ
         hj1V4FoQVTHDcidUW6fqx6FyyAYItoIN0l1YmTjp8AjYX8J7jj9yDf5rLU9x86+28Alq
         F70A==
X-Forwarded-Encrypted: i=1; AJvYcCW3RPXvMFZtamFCQV6aEpYaUqvhPum+XBYxwOg2PWatZadiIvp9s4NyLqHVqolSJrN2eKhRcC2cmEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5H+i6sBZnIuEcJNoQEebSgLHhs2lwjipjaZ3syq8J+x9ipbbo
	9cc3yLoodfgz5taNp/+kL6HQjqLme08dbJJ1RwDti6nFzlXwRyb7PuQ9
X-Gm-Gg: AZuq6aJ0AmNQNTEKaYCx9L0GSxG2XCqXpyQZWlqxroOve0MjKyhjxonSnkI6Xeswd9e
	qhQpnPrZ8yYDM0j+GVneJHFTh1Ow7/aWe3neGOJCCSvsm/MsibJce432SixbkoMfvoz/ETu231T
	N/+zcnSKGJ4g8lZjhXSYZ852wFSbB4+7AiH3KlnL4WA/BEBSdgs1/ilsIKlG4BLEITifWUpFX4X
	QXssDBIeniDhZ4kw7ZhxH7y3zg7B/mWQYtwwZQWoITFONuRcWVAaHvYuYEmJsiBa6F3pUNrTpk7
	tsdNKPBUFQq1qN0T/SXMzb97ZQNxDqCCSJEs3z10EWqngaD1uIlZ1clrNcTTOLOlLe7N4+CfByL
	UbnB7lwb+u+oYNjY7/UiPfaeWcgNA1PhP6m7T6bICQR2SHol36Pz/K47sF1Kh9qyVT36ua+EBVi
	s9IB/GZiB/9su7prD0httrof3V1evleXZlpFAipSr26Lrww1E=
X-Received: by 2002:a05:6870:b529:b0:40b:77e0:7cb with SMTP id 586e51a60fabf-40ef3c10326mr11053198fac.19.1771542996041;
        Thu, 19 Feb 2026 15:16:36 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaee45d12sm26719644fac.1.2026.02.19.15.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 15:16:35 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 3/4] Bluetooth: btusb: Add new VID/PID 13d3/3579 for MT7902
Date: Thu, 19 Feb 2026 17:16:23 -0600
Message-ID: <20260219231624.8226-3-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219231624.8226-1-sean.wang@kernel.org>
References: <20260219231624.8226-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Add VID 13d3 & PID 3633 for MediaTek MT7922 USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=09 Cnt=04 Dev#=  7 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3579 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:* If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btusb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 247d6aff5e79..c8c50daec967 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -671,7 +671,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3606), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
-
+	{ USB_DEVICE(0x13d3, 0x3579), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	/* MediaTek MT7922 Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3585), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
-- 
2.43.0

