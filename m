Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C89B6DCE1
	for <linux-mmc@vger.kernel.org>; Sat, 21 Feb 2026 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771681083; cv=none; b=slNqrGgoradbqFnX9sqg8FL6x0MIecox5cq9Fd5oxClzdruGsK4h30rnO5H8OMk+Zt93IWn7fSyhup2yTahfxuGCzXJYcoEn7EOWEMCf42NQoiWk4kQpcUkZLSPObGxznqOry3f8P9atUrJtU/qZSo8oih/QTmxma2NiA78rtyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771681083; c=relaxed/simple;
	bh=z6zf5bZnGhemRs/rm0HDlDXkI65kNH5qErAtFJBDB/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjBLUp72N5uPlxJsWlMwrh6H1Ho5N7ylG92wo7+YLfVlWKoDf70Nnc+M5EgMRdHz4Z0Nk7BkGk5kjDhkGRiYdqcyNxfl44nJzCU+3bWQpzNYxANh3HdFUQfegL0XFrMYpXKoqCn4CMjBy5aqBOMd09kp+aeWOFcPcLolSSrN+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzPXRB9r; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzPXRB9r"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c6f306faaffso1122207a12.0
        for <linux-mmc@vger.kernel.org>; Sat, 21 Feb 2026 05:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771681082; x=1772285882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pyk6Z+VoDuJMdL4eJZ3cKHVL9+OM0IxwS6L8hXr1m84=;
        b=GzPXRB9rERwgIdqyW3Oi6pYjmZP97qvhi/XB4tBntWOGaiDhQOfNxjiYxA5DMX4C2x
         tOmUVv8nWAA+Ik1zavjUJOg2Vrwq2zV0qehg2P5I8sM+t/vaL5dy3kN9j4Vct11o6xAq
         1F6RQ8KLz1txtEBa+x3VKO//otxxTbVKTbrE1cRvQDC/9a/M3mGxGAxFi8cLaWGm+vP5
         cU10CeOw0TJKnv7BapChIyO9VmM0m7CGgENJI5u/XFBvtb+00xR25CJZPQXaehZfF3lK
         XXceOuDMDJLcm9bEvlhV7W7eErNLOBAwJIc/U1ftIWAlNFmhI07oF8/w1rNz+yqZk2Eh
         fsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771681082; x=1772285882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pyk6Z+VoDuJMdL4eJZ3cKHVL9+OM0IxwS6L8hXr1m84=;
        b=Toy5dTpdbW10mRcRQ/C01YyRe9Nu+/DbmmZRFIPdEaStdLoFX2/hOmf93h8fy2jEhz
         kCSjgSm4RDV0yXh6mM7oZLi5W1U8hWXuFzl0gU/nMYX6RLVQm4WI/n9B0e8hN4tjnN6B
         1EgMqMWbnpA4NHCTKZ5zmuXiZ9pPmbTiHwkkFF3Q+vEznSMa9DPBQeAJ5hYTkTHV3w4S
         4ei18IUn6gkYIIVFK2IyiJqsQ5GPoG15R6+u0qGzFEk4Il8FgmUYVAOCVFK5SW/sStCf
         gL8K/PEkP3ZKal83egZ+Jtagpgm8pVgS/zGpMuT87qunF1r87e1N4JuGPY+Xxdbm7nB3
         129w==
X-Forwarded-Encrypted: i=1; AJvYcCUZg9XAs8BYcBhhQs8zeu2ILYRIwjH9GdglMoSMLG2/CoeTUV85X546WX/nIKrpGTxEmJTE0mzlVYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB6uNWAUzDWCDbstPXFKeTyKp8cH4FVRR9vb/qCgilUWXzERer
	ZAAx/6m96jmwAi6h5g0n+mu0sZyP8vhAyZrvxVY2fCY7cBeJl2aU2N/x
X-Gm-Gg: AZuq6aKFXPBd6JtccZzJf3Z4LgNs1Nztj1a4ve1ufSi3AGRiQJftRea2xrzMchA97Bb
	Y0IYLCRfyDmHoHbH1IK/KisBh+61J7Ha2njghSuzYFYTHVli9TbNCxzdL8HrOTFfz4RRkoEBcH/
	TNGra3h/nhwm+O2DkW+eqhqP0mW9+tSPhalS1aEbbUSzjmncmnChSMsYHRXeGZjIlUl2IHJ4uqW
	mTjozZ/elB7l8m28m30riTfE/0YC3do9NvNb87KNVyg+4awOQHQw9dT9Kk2hxpK02I1Z64LuJ4B
	brurX8TDdFbJwsUgveDPO1+hTBwU0stErSMtzFndpp2nuRSjhFC0s1SeDSUDEHIsBe7US7OqAt5
	yGSjel3VkudhvBxjoj27U7sbYjzybrPbdtE9wPkw9Ste/z5S5j9luN/pTvhXrzD7j1QB+/4VuiB
	2Cy5wIWqHhszY42Vt7HwCLm/8iZRDK8VXunT0++rU=
X-Received: by 2002:a17:903:11cc:b0:2ab:344e:1400 with SMTP id d9443c01a7336-2ad74515cccmr29318235ad.37.1771681081793;
        Sat, 21 Feb 2026 05:38:01 -0800 (PST)
Received: from kush-pc.lan ([2409:40d4:420d:708c:4402:953d:ce2d:1659])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e29asm21493075ad.44.2026.02.21.05.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 05:38:01 -0800 (PST)
From: OnlineLearningTutorials <kush.kulshrestha5@gmail.com>
X-Google-Original-From: OnlineLearningTutorials <kush.kulshrestha.5@gmail.com>
To: sean.wang@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	sean.wang@mediatek.com,
	ulf.hansson@linaro.org
Subject: Re: [PATCH 3/4] Bluetooth: btusb: Add new VID/PID 13d3/3579 for MT7902
Date: Sat, 21 Feb 2026 19:07:48 +0530
Message-ID: <20260221133748.309045-1-kush.kulshrestha.5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219231624.8226-3-sean.wang@kernel.org>
References: <20260219231624.8226-3-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sean,

Thanks for helping me to add driver for mt7902 chip.

I have checked the wifi driver for mt7902 and it is working correctly with new firmware,
earlier I have issue with old firmware, thanks.

For Bluetooth driver, you already added VID/PID 13d3/3579 for MT7902
There are some other VID/PID which are part of mt7902 bluetooth chip
	13d3/3580 - (my chip)
	13d3/3594 - https://github.com/OnlineLearningTutorials/mt7902_temp/commit/f94e0075ca04e50629852adbb567e130f8784873
	13d3/3596 - https://github.com/OnlineLearningTutorials/mt7902_temp/commit/2a3db89c7a87241846d166defa17ebd22d4be337
	
Please add these VID/PID or instruct me to add, 
below are device debug - cat /sys/kernel/debug/usb/devices


cat /sys/kernel/debug/usb/devices

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



cat /sys/kernel/debug/usb/devices

T: Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#= 3 Spd=480 MxCh= 0
D: Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=13d3 ProdID=3594 Rev= 1.00
S: Manufacturer=MediaTek Inc.
S: Product=Wireless_Device
S: SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A: FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=125us
E: Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
I: If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 63 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 63 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E: Ad=8a(I) Atr=03(Int.) MxPS= 64 Ivl=125us
E: Ad=0a(O) Atr=03(Int.) MxPS= 64 Ivl=125us
I: If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E: Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E: Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us


cat /sys/kernel/debug/usb/devices

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


Thanks

