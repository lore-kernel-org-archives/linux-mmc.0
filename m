Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A643B27C4
	for <linux-mmc@vger.kernel.org>; Tue,  7 Apr 2026 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563007; cv=none; b=U5lZ8tFYjvmK055G62SBMDf+dhcrITPvHaa36fdyVmWyIEvqMZ+szIgIG/wLuNG1n1UJEWC/yERlK7l05sgUytTGZ3OBPyvmfAsDmssq3XfOASCzKeM0IRl09V3Tr+9cZpqtNb++eUVMAgpWU2YKbfygBom5z8lBow/v1OyRk34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563007; c=relaxed/simple;
	bh=q36f3RLxu1TQVd3NN+p51ezMRv7VpdfvBQ4n2zcWzq0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QijGyFttKuNJGYNUiw+/8cnbigpNqD4HDFSTXqkALkj3ZqODrNRLDC+/qroo42GKu+dKytHmdArzcHjMBd8DRqM2HVK/+7bd8t+qG4wEv1HD23A1CSUSdNNswth4xR+egf+tHWv/j2CJDEZo7VmXc0+O7sUREw7zphLS4PKgLr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrcBNRsH; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrcBNRsH"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c6f21c2d81so439881985a.2
        for <linux-mmc@vger.kernel.org>; Tue, 07 Apr 2026 04:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775563005; x=1776167805; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHsPO7VkkkmF+LzDzouz7Fz5iyV2CQc/HSeILC33tdo=;
        b=VrcBNRsHgBUSNm9xQ1uVq7KAlQvKXxNuY3yEsZYVh09EUSL8AEDp4wdG33drJ60msr
         107O1tHxbU+jDOjyuEDBTMQDDLHLfajhC/YzohZc111bxAon8M3Lefqg7+PD/xV2EGt5
         PXtDegyD9BtNH6C1XZMKpcQ6Yc8dvSEzmLn9rGPf3uyyJvoOqY88xfnrP9d2WlDwawm7
         jAZPpbFcnFIxnTg5Aq9pdc2tbBGDzlnSw4akU6IwoIu1+LtQB6L6YrTxTtz0ZyjHHfEr
         WKPLyrTYt8CZiIj92HsBydvLEIhDOo3KC1SFdgsIbW2OPyTiqIFldtCrGJljUzXjSzSj
         3mrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775563005; x=1776167805;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHsPO7VkkkmF+LzDzouz7Fz5iyV2CQc/HSeILC33tdo=;
        b=Ly8GINANQkKhc3ch5S2SgQxkAw03VUWqgcImizvjMMvptbuBLjOR9jTkYLm0HgnTer
         CiVvF5YqFERTemqizFCS8o9kE0U6EmjbAPEZ/mQgPbLHNSKkycf8GpFWMOsYt0/n4q8Z
         Dhuo2ULFYjqmq89s4C7u/n+DLWfgrOeIQ3/tInrw3bHOwzYnpqoO/c8nzZIAr9AgGNdn
         1XCU5/KN+x7mNx3Ne+y027JjgsqLUWLVQqsWvMXUUxCLyyvHGVitGCGnDC3vvajyRHVZ
         oZdEzWq3O0O6kRIBztpf+ObAT27VFJswejhAhmSEVDV2KlDIudSYFhbz64f6F9v4PS27
         8Gyg==
X-Gm-Message-State: AOJu0YzG17KoaPMfE2BYLH9I8JSaw3Cy9TmxiEIRktlAt7reZOuzUOGq
	owtw/3R9DsZXhKPA8ltxOLh/QZGJY81Dt7dkalv6i9dix04Nx4YSqzxLMtfcxOnhl9c=
X-Gm-Gg: AeBDiesMpHy+R3U2wIAAfs+JXeFY+4ERIJkGVprrhVw1TsM/TYoxvo+ABw5ZWLX+hVV
	Zdbo6ul1WPvA6bmDn05IcdtKE1AWHNXWBJaGRJsq9t2VoVz9WzWrMCHVZwFe0IbdUeVRICwJ4s3
	6qmy0x98xvdjgc5bU5oziRvAavHqZJOwIcS5U3ZwyVwsMafVgMoi9k92QGkuwPv67O986iD/Kxq
	F7/rOqcwsxcjSyfV5wPbNFQEX8Scj7trOlpmIhbsWgGblCvKBK/Sx+gRNED/0V1qCCnwOEZ69cq
	T1mBTx7Pg/yOkXQ7oeU3VOYdhbZjA1QC3UHRjohLteg2bJgGcCAZWIBigRRYtx3627tOyTTVbxR
	udyKOYnYSzQK+AhyU97OuRxCCgB+S5tJFPNkznSCfM2eJHLVdMsS75tvs3vSshtop5spwxV1IlG
	0I+CwYWbn52rBOeZSkSCR7
X-Received: by 2002:a05:6214:1d07:b0:89c:d424:aceb with SMTP id 6a1803df08f44-8a7043ee093mr281400346d6.31.1775563005076;
        Tue, 07 Apr 2026 04:56:45 -0700 (PDT)
Received: from [10.10.10.1] ([157.245.8.14])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ab9acde805sm34223276d6.2.2026.04.07.04.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 04:56:44 -0700 (PDT)
Message-ID: <964d54a3-90ce-475e-952f-342bb383f878@gmail.com>
Date: Tue, 7 Apr 2026 14:56:39 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rogerable@realtek.com
From: Greg S <grigoryya@gmail.com>
Subject: [PATCH] misc: rtsx_usb: reset chip on resume to restore card
 detection
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

After S3 suspend the Realtek RTS5129 USB card reader loses its internal
state, but rtsx_usb_resume() does not reinitialize it — it only wakes up
child devices.  As a result, the first command sent to the chip after
resume times out with -ETIMEDOUT and the mmc subsystem never re-detects
the card.  The SD card (mmcblk0) disappears and does not come back until
the next full reboot.

rtsx_usb_reset_resume() already handles this correctly by calling
rtsx_usb_reset_chip() before waking children.  Apply the same logic to
the regular resume path.

Tested on a laptop with an RTS5129 (0x0bda:0x0129) built-in card reader
and a 128 GB SDXC card.  Before the patch, mmcblk0 was lost after every
S3 cycle; after the patch, the card is reliably re-detected on resume.

Signed-off-by: Greg S <grigoryya@gmail.com>
---
  drivers/misc/cardreader/rtsx_usb.c | 12 ++++++++++++
  1 file changed, 12 insertions(+)

diff --git a/drivers/misc/cardreader/rtsx_usb.c 
b/drivers/misc/cardreader/rtsx_usb.c
index 2b3ae2914ec8..f1a3b5c7e912 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -732,6 +732,18 @@ static int rtsx_usb_resume_child(struct device 
*dev, void *data)

  static int rtsx_usb_resume(struct usb_interface *intf)
  {
+    struct rtsx_ucr *ucr =
+        (struct rtsx_ucr *)usb_get_intfdata(intf);
+
+    /* After S3 suspend the chip loses its internal state and needs a full
+     * reset, identical to what reset_resume already does.  Without this
+     * the first command sent to the chip after resume times out
+     * (-ETIMEDOUT) and the mmc subsystem never re-detects the card
+     * (mmcblk0 disappears until the next reboot).
+     *
+     * Affected: at least RTS5129 on several laptop models.
+     */
+    rtsx_usb_reset_chip(ucr);
      device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
      return 0;
  }
--
2.43.0
