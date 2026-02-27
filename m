Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0996636166A
	for <linux-mmc@vger.kernel.org>; Fri, 27 Feb 2026 04:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165718; cv=none; b=WP+PGBm286FjftNh+7ijhVZ3XoP+uYL+vHjwtHc/nKzt0S/+qjb/l2vTVSRr4rwfyULCXY7PnKVCqrLmbTXl/sDKm9JibUEysMlBMwpl8B7iwE8ujbdDeb8BXl0XJy0ESqylqiyP3pFbER1qU0M7Gat6bHPLpEs2Jf8gROE92+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165718; c=relaxed/simple;
	bh=umFqLkkCtEHhrB5xkU3rA0tKVMH9oBgD+CyFo4/y6oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJc4FYgeB8vPi2H72hCt2klSviz3Vhd8euChC1Wjc7AJmB6LOPoNIJ6LIdya8UYe+1ubASzcZPfd7iWSXLNesrYT7mFhb3BWsUKDNLuCtLpsIBXfrp2tzlhLwuVhbbw/L5Y81JQYabmiMQMgfNwXAOgWWfqFryBvFLHbHeXZUPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=Os0OB1N9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="Os0OB1N9"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ab232cc803so8546485ad.3
        for <linux-mmc@vger.kernel.org>; Thu, 26 Feb 2026 20:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165715; x=1772770515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGyuLcmqabu0coAnfLalHKdnzjl2iFV5tkrQRRcYS6g=;
        b=Os0OB1N9xiGjCkz+iwJR1ReXudQThNAcza3FFVRX2BA64X8Jxc401C9McRvmn2DWzB
         o+2LePPm9TbzD7s4CaxfZbdb7U97VEwpYGKxokUzPQ+6ZRx5qPxSF4QX592FKG376t75
         pmwI430oLluD2yXsIA9+U64l27gb55cL9ui0+QtjU6H1ASSwDjoLHXM6DajMCqVzoAaM
         RWMFBpWwL1131oQ3Q62fudSmhKmsEA+WKgN7GJ88xYmAUf3bH5Fc33oHfWfL5efUiVii
         FgMVugnncu7MYkOSKB4an6tMSgL8Tj0SjmvZL7eWiAVVW/43NVOWjbri6wHsFY1xHbgF
         O6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165715; x=1772770515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AGyuLcmqabu0coAnfLalHKdnzjl2iFV5tkrQRRcYS6g=;
        b=MrOjgoaTi88pUcra8mgMf5c8FZuadZs0Eih8IcQaCmIGSNWoQHHZ0inHz2YSadov8e
         AmC7vmpmzQjA2WxwxzgFbOEZjcNTI+OMqQS8BI6ZgmS3CKhhx4zTm6dZX3tThgg1c7/b
         uieE3TY8EZWcWlU3GUfVdT4IBcb8rEaSELGRIhXrvMq+2ts7JZwPN+u51pkKu12M8mbH
         bEJC+rgtgwXjqFOLPp4X+MxtNw1LRtFLbqMTwUjOZPlLk+tqxYixGy4CGCS6V4CEG+7n
         WgyBCZB7iBx3dPGaI7bqMFOFGS6StCTOd8QbcN6h0xdyP5sB3okolY/3kmS5Fm2G8Gyt
         j8gw==
X-Forwarded-Encrypted: i=1; AJvYcCXJYJRflMsvqFlzNQeogh8LH2v3Q8F2Ymx9bM3cg9b0wElxAXYcYsmcJtUVrNo74ILpPFw8n72RQWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3spivPlOVI/mXFGufonaSpn0d7qHE6zQlySx52EBC+YQGaqKJ
	TZ05KCAKGkHaZ5ih63Rz7DnziKYuu21hFqjbY1zxdj0VaUCDbqL+naO40Me1iT1YvhU=
X-Gm-Gg: ATEYQzzMYDYKV+ji/yMz1obIg4fvEws1mfQZXSRXAb3rho9oLu89bOF6F1X9PHtPRc0
	CnZwDu/0O9nDD7yL2JrF3xLlkHGctwmrqvBZqxkLuu7pmDVlZ9siRnq3n53zZDhqpoIs9MoNhRp
	m7H/IbDjHA4ZD+wykcbNwyf5LpLoaCmKgkHR3OW4HAFNU6hCYE4YKjw8z1eJIG21fFuUlJO9KHa
	ApA/ZYtjwuCU8vMRa/sMlIVUEj/DNlUGzZgHTTroZj+vJ73qzCiPndcKcH6zfAMhfDymQ6Z12+Z
	j+LYWuuzayqL0/AUOrJ/UhxsIGHEwK+SV6xbM3dlmR31JOUnm9bllqOYsQOrB9DTKhNnM5JRaCX
	CBsMdYhbia8MbK7sEigCbAEd8gqbgASidV3ouXXuvLORkXKKdm9+PbUKMOwjlH1NmbVmubYsNTn
	AKKC5j2rHfcNz+NRrL224SW8GfP8+wx5+5IoFoYpdcwaUUUAIocyIVPyPGuChFkDuCzmcY7dLxz
	Odh7oM9R5U3EtotHb57RBEEjOtDR7A=
X-Received: by 2002:a17:903:11d2:b0:2a0:a0cc:9994 with SMTP id d9443c01a7336-2ae2e4d6114mr15271685ad.47.1772165715457;
        Thu, 26 Feb 2026 20:15:15 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:15:15 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: arien.judge@morsemicro.com,
	dan.callaghan@morsemicro.com,
	ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 33/35] mmc: sdio: add Morse Micro vendor ids
Date: Fri, 27 Feb 2026 15:10:43 +1100
Message-ID: <20260227041108.66508-34-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Morse Micro mm81x series vendor ids.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 include/linux/mmc/sdio_ids.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 673cbdf43453..3ccfe3679c91 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -116,6 +116,10 @@
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
 
+#define SDIO_VENDOR_ID_MORSEMICRO		0x325B
+#define SDIO_VENDOR_ID_MORSEMICRO_MM81XB1	0x0709
+#define SDIO_VENDOR_ID_MORSEMICRO_MM81XB2	0x0809
+
 #define SDIO_VENDOR_ID_REALTEK			0x024c
 #define SDIO_DEVICE_ID_REALTEK_RTW8723BS	0xb723
 #define SDIO_DEVICE_ID_REALTEK_RTW8821BS	0xb821
-- 
2.43.0

