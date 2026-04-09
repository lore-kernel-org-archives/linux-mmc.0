Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB1D2FD1D0
	for <linux-mmc@vger.kernel.org>; Thu,  9 Apr 2026 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775763726; cv=none; b=dR8AXFldvQgmbdizWjT/5L8JZlfpsjxrqIasLORL47wOj72KKxe/ps42SXZNDbNS7d/nwwQ4Mf3Z/3MmK6l6+7IR8uGT7jobbp+IiMjF5E6qyO4mt0TRkPtH8sfdC+TqJRDcBmAfpWo3EstBUHZcNYcKSiUJ3GSyL10d+Z9cR3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775763726; c=relaxed/simple;
	bh=qOoW4aRym6b3AX+bWSrl2d084ZPhq8jJErEaGtwMluo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liqb8hZLmeoMm+5bACLCJ1TpNzXdYq2RMXf3xWyskrDN2NLGoVy0Ksk0NoQCi2EM9PmrkFTp206YK6bwAFus7CMcPx1KIAWbU7Xqc6Ba87yzTuwiQLTz/A/ALnrJ3hgrobHgQ4lcLpWvZZdzWtiR5ONAuCxeDDlb+IKq9mVnQNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUSHZZ6j; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUSHZZ6j"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-89fc349b5ceso19953046d6.3
        for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2026 12:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775763723; x=1776368523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GjKxBtkjDt3We9EjyJ1v8TRnifRaBnbhRAoyO7TLFsQ=;
        b=bUSHZZ6jptNH9uBja6J/nTdn4tQjknpvQ1p4DvUfayssHGXXD3v4ZYZM/lKRf/0+wE
         BacUqcjGP9jDOmXuefKNaZbcwZWRMfYewsDe/KXAQHMtIwAKzGJTmS+35gXHKnkTKp1l
         dF0uDHPrVuIHbolMmiG/EkYmJjq2+t374gq8wPJKwfrlD3l/Vcpwi7YMSPt0ZPyaWyx3
         4iSfvuJfBRj7BW9DL3uxmjqvOeQTTFH4YEsU60K+wnxCqsDnIbW/Qu1yv2GCDRmombwx
         UJF3txuVadNvWC+lzmTYAilWWvuQ/P0fm1wWj6AL0HMF+PoDirkZ1/i4Rl5+LvL1aXBT
         ppow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775763723; x=1776368523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjKxBtkjDt3We9EjyJ1v8TRnifRaBnbhRAoyO7TLFsQ=;
        b=DhlR/kInpG0ww8DUCTKTtrs1g2dg8Itpr71Z7FdKEM6ITOTlwhv7cBzbFoq5nR5WAQ
         Sp3qWHllEEXGni/um0XB9PLYrjPHSeehwwsJMysPxbTqpivr6u5I9HnsLAdAKQyGtnn9
         Xco1JKeAN5fdgjveeCVkwTZUO/ku8YI20QwpRJ2DSAg22E7W8RhFX1ROfzuNj6Jswmh6
         AQVn6O8fRqFCYBhM8gwzg0QfLuRaOT8dFXIm8wcdTADwwYbq7JUfrOAfhyMjcivtfKxE
         luggNNNjtX71Pv94zPXLVijQkWQVrtCh7tpIIxRmTTjnKX+dU53aSi/hm9dfNTve7bry
         BNrg==
X-Gm-Message-State: AOJu0YzmwyaAhTWvXsLFCEax4GiGSmqshRT6slTF7dhFV9albrnE+Z+O
	+SiQYvvZxr63jW+s6BUh3+G+LBsybtvAQbLBVH0DSGZAkUWemDxQEIai
X-Gm-Gg: AeBDiesMenJXJROuf2IB6kfFZG6wSKm7GNkMghf7Cknvuq5g41s6WgkYReTixjELfx9
	wnq4fBEPkDp0+oJ2awV34jAJbDQcUmfxJ5c5RyojkcG2k/Rei6MxLdnhHtgSVke8dNynnieE4nq
	ahgqwEa6B89I8RTe6SV9Nvc4oyhviARBdV4VHLGd/lk/RxHqbjjcAGD2R+iI+VM5Qn2Ia0aNlGs
	/O/+/q7BCE8WkmUrOoCU8AabKtdCfBfCNdhLB64lWceH23ayodARrLPLqJ/NDPdsx7S2HEq/Dxd
	xd37l66IsTwDaG7ZKY9Go1k8qN0JpI1iwkZemqI+suh+1l39VSNawbiKht/2ShU8G5Sjo4BnCsw
	QhCB6A5haCol9qE2zhkIVruqcJxHHchBXfO9c4RtWExRqmy56O87ohUZ8INHWR7pmNDZb81BYt+
	kuJsKxCawJ8UUrzEkKc9Qe
X-Received: by 2002:ad4:5f88:0:b0:89a:1069:d229 with SMTP id 6a1803df08f44-8ac86322208mr1316236d6.55.1775763723142;
        Thu, 09 Apr 2026 12:42:03 -0700 (PDT)
Received: from [10.10.10.1] ([157.245.8.14])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac8449e664sm4160336d6.0.2026.04.09.12.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 12:42:02 -0700 (PDT)
Message-ID: <9e52c51d-c358-47ad-a2b1-763a348f6c7d@gmail.com>
Date: Thu, 9 Apr 2026 22:41:58 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] misc: rtsx_usb: reset chip on resume to re-detect card
 after S3
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rogerable@realtek.com, Ricky Wu <ricky_wu@realtek.com>,
 Sean Rhodes <sean@starlabs.systems>
References: <964d54a3-90ce-475e-952f-342bb383f878@gmail.com>
 <CAPDyKFoPjwBeaQKMDf7zrW8hQDZjD89=ChJ_TPf51BG4yonz6w@mail.gmail.com>
Content-Language: en-US
From: Greg S <grigoryya@gmail.com>
In-Reply-To: <CAPDyKFoPjwBeaQKMDf7zrW8hQDZjD89=ChJ_TPf51BG4yonz6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 7 Apr 2026 at XX:XX, Ulf Hansson <ulf.hansson@linaro.org> wrote:
 > The patch looks reasonable to me, but perhaps we also need a fixes tag?

Good point, thanks. Here is v2 with the Fixes tag added.

---

[PATCH v2] misc: rtsx_usb: reset chip on resume to re-detect card after S3

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

Fixes: 730876be2566 ("mfd: Add realtek USB card reader driver")
Signed-off-by: Greg S <grigoryya@gmail.com>
---
Changes in v2:
  - Added Fixes tag (Ulf Hansson)

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
+     * reset, identical to what reset_resume already does. Without this
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

