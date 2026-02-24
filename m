Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B644629BD95
	for <linux-mmc@vger.kernel.org>; Tue, 24 Feb 2026 06:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913671; cv=none; b=ikxuHMOOADohJdVayEmj+hHIqIFbg1G+GjLsDNhbAF7MQOGqrGZLvbWIjfGuBbh6UsdgfgBed8q6s5yRH3WZdb+r7cNejC1cnRw2t4BBcyOSirGeSeDXHukivrBlJdlhiZ9FB1nz0dpbTM2SIhBroAW3d29pIW8HItdGp5hYo1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913671; c=relaxed/simple;
	bh=z1IJOeSzMZAL1/xcLy8dG/0cKMLlMODvFu/RhDvuw/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T09xLSlXyQ6c8iB4xd0C93QMQ3l+9YHYeJh2eaoBic9BueptUr9w8HotRlR0PJhAZ43a+8xv/TmvSHOgtCIxxRvAKj5QfyJUL7COdnbtle9bptbaoSSvpBPIm2zZXBARgBcE5NNBzGNoYSorFXq8iqgJfCsDlQHoAi0++aeTOnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-679b072ed3aso2686235eaf.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 22:14:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771913670; x=1772518470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iff0nX3eVlq1aXN5uKCYb/BBxBzq+NNIR/1dGHBeD1Q=;
        b=jeF3JXU9IybOf/k0iGLnIahdP5ys34G+19jDqnybGFJH+bFxAf/3lTnu/BuyVkUDaV
         X/RctiiptKYFYLvmH4HTB3N7r/6jn/C4V3doiGEj52L9bD/mJ5dkRZ3VbkgltH5BgIT0
         BlcZu2sAEcPL056NzDlEceUhp4ZDgOiqMjW+O6JlZ3GujX9Le+OrnHJNKPLQSc3jjNoE
         LA+7BIToOmoElX4/cVwjQJGvnDauVEl63Hnl74i1QRXsVjNdz6hbJ9N3sCfobV+KA0Fj
         YyqpkPdbHraKp/QNkzxb2mcdxRDn3mvUC3T0U9W64fQmP7LW1QxnDJI2gWKRKrXuH+CB
         bnjg==
X-Forwarded-Encrypted: i=1; AJvYcCVcqmnT12IZ+dJ9AXY3Iexi9XNkq+TLD7gvS4+/GSumD1bDmRG77gT/+QnRhFtAYTAH8aebxLAQi7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOjhIErLwu2gSN/dV8bf2OPgrK8vhsIp+6b0YbwboAN52gKMf/
	/7jllwfcs7fVT7e2/dKvqPlwY/MZKEcGugtRR+qlTyzHt0lTjgyj8ZKC
X-Gm-Gg: AZuq6aINWB1uXGLfLPZmb/y+0I6ttPIIiulG6b7qNQuraL9eLAx6NpNsfGAvmEP5TRa
	P0YdoP1O8+gYimYj4MhcqXzrvKQjsgJWGcmwnxxuFO8GqGEHCgtjIZHAUYhCrWVLfi2/Ec0Dj5J
	uo4Mlya5DzkKuaigfBtcSUWbn+rKWlzFBYy1vKYFdwotSKhfOVzsPtCVhOp26pt/N3ff/qUHpxd
	Bk+oymahsubMX17hBEFWubFI4jRVMYGymDVtvhzfwfihqmM8JFyziMuB9cfE0IzKu//KOKLj8Mm
	SHi/WXeEfSUfEe5Sxju5iC7VsuNpfDrO0YqM0Pmd6tZfQqurlnMlGvWJKi/MxFhXgslKjglPC5M
	ZdtIyqkMbh5DwGhgQZaQDFa2FkR08RAnn4uuo/LeHBhXCpIA/RtSS+Odjzfh12kFxv49xXwqyA4
	sNgoz8nOYglsjzNdJz0Q4HTfRtUTRZZe0v3sJILqEJgNr8i62rgaw497Gps/HWlbg=
X-Received: by 2002:a05:6820:221e:b0:679:c369:9ef0 with SMTP id 006d021491bc7-679c4259c8amr6083665eaf.15.1771913669779;
        Mon, 23 Feb 2026 22:14:29 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:8ac2:4fdd:a742:61b8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c56dbde9sm7895306eaf.11.2026.02.23.22.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:14:28 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2 7/8] Bluetooth: btusb: Add new VID/PID 0e8d/1ede for MT7902
Date: Tue, 24 Feb 2026 00:13:24 -0600
Message-ID: <20260224061325.20189-7-sean.wang@kernel.org>
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

Add VID 0e8d & PID 1ede for MediaTek MT7902 USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=02 Dev#=  4 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0e8d ProdID=1ede Rev= 1.00
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

Co-developed-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: newly added
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4e8bf032d35e..a5e44887a5b5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -672,6 +672,8 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3606), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	/* MediaTek MT7902 Bluetooth devices */
+	{ USB_DEVICE(0x0e8d, 0x1ede), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3579), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3580), .driver_info = BTUSB_MEDIATEK |
-- 
2.43.0

