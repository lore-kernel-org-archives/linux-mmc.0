Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719AF29BD95
	for <linux-mmc@vger.kernel.org>; Tue, 24 Feb 2026 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913668; cv=none; b=TPowzoJnDtL5c31U3CIjAkG+Qg7IH30N67784srkqqTCQKTuBoJBPK0uT+HufiboHuFZlmDD2CSTcP0aF6YTpl4zOTYYBqtGiTtTNwBwup/6Xel2p05QSBy7eZ2Y2+wDRFrQ1bhaI54DQhO+/amOWmEHd3XwBM5LxWK6K5dRh0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913668; c=relaxed/simple;
	bh=vDPWlV5gtxuO5oJKhYB4XQH9mg3cnQ2FJ3iMv7tlfBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4j5ME6DvOK6HyfRvfMcz/CKHK7vmjSVjACo/wqr4rAGri7Fe/pTU3t55jIsE9zAyl03QmgwBoLn/1KNIlC8ZU38HxaGidSo/+biCr1+aAYSTb/vrR3KSkWmqPXBHP+mpy1nJOBbKOoBSaKCCjsU/gx/uy4fiQHoyiioDmO8REM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-662f9aeb782so3271127eaf.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 22:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771913666; x=1772518466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jc+Zbpdps3NV1O+TlQTpIhdV1pVsPxYo95sUPq5BXkI=;
        b=sjQiKRLi9mikF5u7QwGYvDmO7Y1jRrqlXSm99mR8RYDg4V820wG0DmmlEQVuI5sev6
         fF0zPucqNw0b0eNkyfLu6ghtU1wumkEHdONvbaQVFrhduBgrQLKaq4NtZK8bOvOYh5I6
         tQAVXIaAI9hDyrX/Kz6ZsDHIrr0dBQpYzytuQH7rKc6VmhuRqY7LN9mnSJDUe6FdM1Fb
         p46Dxj+Sp8vXbbQ6YpJd/ZL4rpuz6zycf7NW2+DjSrfTk0/Fdtf3XTVH2jGKGwsBufAD
         Ekcb6bl/O4AnjKNjjfDBZFJz4oXl7hkCwiPXp5y3OaeYL4oOGu7mbOYaXZsTRnZKEfMw
         1mxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxvXefMlK1SXn3rGvFAuRjBP2AVNnfK6pXdKnZu+4fSm0RN2N3C7mW0q30phvxEtNeGNc2E75Kkto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkuh1M8WfqGmx2VEigW09e8leVs2AWifbItFgBvyhnepJAOdd
	Gh2z8YNgpsK/2snJTNlWo3W31E/HlLoibZzDY5EKpZnvRKVx3v77sJHZ
X-Gm-Gg: AZuq6aJeEON+JfWGhVzi26UmIUCusIZUk5SPcqFAcx5vkEpLEVhDKNCnkulrFVhTvPe
	BjtR8w8xsye8xAfRPW08TW9XCcYIIXzShxzfiGrIAfl6tMKPocAyDpyGicS8DzrO+zTbtP0+ckQ
	wLF2uDf+Onfb/4Xz+lqD9r5eqgAdViNlGIhOue+cbGTBOPkJ9AW/RsDqppRYt/9GuzOmpwDKA+n
	htsH/7BrMZsvhR9GMyIp0ABnPncQW6/Y3HsxtIGS9Rnzj5YX8AqKG+1NTdsBur4NF29J9vaa1yM
	Loo8WLZMH1IZGRowl8H47AjdBgG/13fnlMGQN3/aAXvydTYOlTdFascoKnQULgUrjIgkFUjAo7N
	tqv6e+LBqkxfTiMjsv3LhaNuKmuxrFi4NgYwGGysUDtRgSi90FtNhb1IXf+Ji35MPvqfyKH3NWI
	kpNh7UNlPptAPHcF7ydbMsjRp3ufIIKVc/8MklQ9uYX9m9C4CVA8fH/oreKVaOXa1IMtpjZcj5a
	A==
X-Received: by 2002:a4a:ee88:0:b0:679:9844:698a with SMTP id 006d021491bc7-679c46e947fmr5857920eaf.55.1771913666519;
        Mon, 23 Feb 2026 22:14:26 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:8ac2:4fdd:a742:61b8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c56dbde9sm7895306eaf.11.2026.02.23.22.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:14:26 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Kush Kulshrestha <kush.kulshrestha.5@gmail.com>
Subject: [PATCH v2 6/8] Bluetooth: btusb: Add new VID/PID 13d3/3596 for MT7902
Date: Tue, 24 Feb 2026 00:13:23 -0600
Message-ID: <20260224061325.20189-6-sean.wang@kernel.org>
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

Add VID 13d3 & PID 3596 for MediaTek MT7902 USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=07 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3596 Rev= 1.00
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
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
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
index 0f1bd9b5d296..4e8bf032d35e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -678,6 +678,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3594), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3596), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	/* MediaTek MT7922 Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3585), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
-- 
2.43.0

