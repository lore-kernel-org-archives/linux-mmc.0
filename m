Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85F29BD95
	for <linux-mmc@vger.kernel.org>; Tue, 24 Feb 2026 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913655; cv=none; b=Ymh17lBBWdp2rLF8/VAC6vXncdxyM6NTBCdl1uU+GAIxBqKkrWrxPk87TzGpY9Vqw7q0YwDcYLz0NJUhm6Kdlr+G9oehiDkBCPDmCeEIp7Bi76PzAkTxWS1H78fsjI9+x0dXmPq8KgzeFvkR2gkie3BIxQmFDUVCYHV59BMYCk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913655; c=relaxed/simple;
	bh=/Z4MB5ElOyi+55Sr044CxcrpBM5KDUbk+zjFSrjyJpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+yRW0jY2wR4rIN7QnTewDhhJGKoZ1m+clO6Qe3bYcIOoscCkAnerzqROS4pTmNYPG1Qz9Dh1ja5jBcdFXzswLzjfh5qK8P9SJfUZMelzOIxN/tNjQDoruC8TYtDgtivfUVvQrk7XTfX6Q61DR8bBpRJJkRxNNoaMSVMCzZBpB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d4b9c839b1so2092625a34.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 22:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771913654; x=1772518454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yF9BrzHSjOCb61spjQQsg4By9fXphtW27Do+4p/DLZc=;
        b=GVCTK+V3uj5p2/S1cwQZEK484f3CY8A0WEuLG6wRJ/Hxqg9TMuqFTYQG2cMcMxfU8X
         ++JMi0IwaDJOav9IjZOL0xoLnnTm/APIQe7eifoKvzvhq2chy+089+9NjqwEfpiOmkfQ
         t+2xN0aH63CQhx5+T3uMeG0JptFjejqOhYLLmT2sNQ7ZRCwEBGys8NCtA/k/F5FM96xP
         xdsSFwP0VgVHW9K2XgCfC5YBvcFQ/QbXSbQ19JnTvhiy7PDktRvyBdOyld5xEvBDSIPH
         LnmkFLBf/HL9KfbQHT99q0WyvLYxg6n27krpwAwCdztIK/wD6RC0F+vVySr/UOEIerFd
         bABw==
X-Forwarded-Encrypted: i=1; AJvYcCWXWMsgY89sOP/q1jYQowK8d19D739uzZaU5AEWZ6t2JQtPBcNpM7IxLB8Cm6oWTki3xU73CoSYOpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAJ/zRsJLJJjygKM6Q/3sHJhm/zsD8fKKDulikRcO+lo7CBP1E
	JSDwipchnqXdfD4TsNbCDRQ4YcsvzHk5QoHzRTVI1JHKRNvk0Aj5WhcvYEbgCg==
X-Gm-Gg: AZuq6aJR3SnWk2LY+Vn2tadU8U5lFqay+J8z4ynFoK6Mnc4sX88BFyMLHDmZ7g+hGx0
	frPAQkQLBjbTfhM+xutswpDof9lytR8Brfba+fOPT0vpUU/BE3m+/z0uRh1xGtU/mdSVaR5CBd8
	DCIIpjyOF0Y0Mop5BsqcaauLpK4LWNqQhwzfHRAtDJrcqRUeJZtvqNfjdjrANDGrmnNdpDZ2qhT
	CXcuGcMVxluzCWYGodUZgKTXJ1i5LRzNza7OEaSTwUoNv3I8KKmzqEMtMlCrl0SkO6MitSnaZTf
	c271cPrPvkt3zLA2K/1EQWC76riYi+ni91E7uT+skD6uc/ZRE2gMHtqB5TsmFQba98+inOshx5K
	reJ3siedvHLtuPMmB83KgperNad291YZ9aw+MMva+oibiaUUYgbEKjjyGwcvKi92F1jqEj6M2vl
	F9ijZB4vMk3xQnaiv0l6kGHpiwuJXaqppTqlRtsGNkPvBO3qUm1sgNNeA2AX7W6yE=
X-Received: by 2002:a05:6820:162b:b0:676:7c9d:29ca with SMTP id 006d021491bc7-679c470ed7fmr5824085eaf.56.1771913653634;
        Mon, 23 Feb 2026 22:14:13 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:8ac2:4fdd:a742:61b8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c56dbde9sm7895306eaf.11.2026.02.23.22.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:14:13 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Kush Kulshrestha <kush.kulshrestha.5@gmail.com>
Subject: [PATCH v2 4/8] Bluetooth: btusb: Add new VID/PID 13d3/3580 for MT7902
Date: Tue, 24 Feb 2026 00:13:21 -0600
Message-ID: <20260224061325.20189-4-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224061325.20189-1-sean.wang@kernel.org>
References: <20260224061325.20189-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Add VID 13d3 & PID 3580 for MediaTek MT7902 USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3580 Rev= 1.00
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

Co-developed-by: Kush Kulshrestha <kush.kulshrestha.5@gmail.com>
Signed-off-by: Kush Kulshrestha <kush.kulshrestha.5@gmail.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: newly added
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 94554097191d..3a45b16c6b08 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -674,6 +674,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* MediaTek MT7902 Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3579), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3580), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	/* MediaTek MT7922 Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3585), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
-- 
2.43.0

