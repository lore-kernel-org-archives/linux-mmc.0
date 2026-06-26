Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468633DB992
	for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2026 06:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455570; cv=none; b=KAe0XBDMQk8pR4ZQpihZfkir6trrFshf7LlI75DIqao6nVM3mhAzVU9OrbZFwof28WYobkVqF6bwDJLZxXJ0yuKl2vdDPRhwt7/1LQpvcRVcYN9sKv1Ys8cnUqHQqLhh/c1OuZOchmasC962dUiQvuR8BE9TDDHsbTgiT/NG0s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455570; c=relaxed/simple;
	bh=jh7nryGEKabYgpd+PfRGwc0d27nBce12mposWAI1iFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USl3W4Q40BAHy0eHU7Q6XWb3K0aVggqiP+KMK56oIfS9cI6w6QIbHCLaAd2GZCtXn61144/UrGeJJiJtIGTctEG/tusx7qHf16EB12MAOQmSOWqHN96hTJRIO77yw4De0jpB88S7E+f3E9h+jlNCgx7AwRHXplwEyL7CxOeeMzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=lGkUUP1v; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="lGkUUP1v"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1363fe80fe8so1422342c88.0
        for <linux-mmc@vger.kernel.org>; Thu, 25 Jun 2026 23:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455568; x=1783060368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xcgbUEbRV//HZf8rnCos9XTT1qb4oAzB+LdSj1teGwU=;
        b=lGkUUP1veDQG3tCyZ5bWIHEe2s9348Ne51cTTaAer6NRmDRVY4C/WxRKnm2zXWfjy2
         PqNKECxZjeZfw0Gp06o5Uf5hsXJKog6XKuYHK4Ufv85dTsTYVs/9FbzSdmL9clpD+FnY
         p3FcLa+v6DoSLSXBIA50RthO76mbHShdQPNomwYdmVmNFz1OjRA6lq0f5mloDxC2MOgO
         ewns0VKUDz7JTlOtLreIRO51yEdSleLnuwY78PfBCaOHZZpv+r3tP9S+Iywt9LRq2sHg
         S/LetjaI3tu5YXpAJXS8pwAsgU1aFwsLUdQ4ejHaaulvNSm7026wrGMnr2t4O/a3vfWz
         6UKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455568; x=1783060368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xcgbUEbRV//HZf8rnCos9XTT1qb4oAzB+LdSj1teGwU=;
        b=Xw3xplTGFiqk3yotJu4PH13iA9Nx6H7sYiOwl0jpQpC9n4sE6qzx8pT5xsq8nKbQJl
         6f0KpMDT7cSfvG5l+ymFC6hzaxfdQXwH8KdTRQXXIqIjY5yfaUBn/jZyv3Q3YYoABE1d
         D/hZCl+Y48hekb6oeQNNXkC7Cv0PCeQyKp6/fCu0WmJmJEamv+B5I7xfHYwzFdl3YMy4
         LcgdN0y24XSvkz37fCyi0FurW0maRiEjMaONchF2Yus/saraitC+GxiG2A3BLZg6t0Ty
         BmcHJkmR3gm5zAG41wiifJq3TLOWBW1XYyLq/XkKG15MNdirwvNpAHeQN5iEW2vQcNcV
         Ps9g==
X-Forwarded-Encrypted: i=1; AFNElJ/g4PksYTbc/cADhnpEaSy5Qku5JJGE0ra4pQw/1QbKTCLaV8r6no0WcuxqltFoJkOscdl/40yZ6s0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+TelzAtYmIKFeDPcx6H4X4gGxFuQwi34YzqnkaIsfqaiFEEuD
	BMjvuPqjcnys/h/fFp5Herp3/XLRb1/x42pjdLHzzmuxl0J32yZR74ayLmLbtqqC2j4=
X-Gm-Gg: AfdE7cm0KognDnrZQIv4l8xWSZa7Ztjtr5ko/Ov6n4bl4xMfKqhTb8+KP7AcSFgVLui
	/zu3ltkxrkbHAegE+VFpjE/YZYgKrBPGpL9k1cFK3FJyjAjFODS7PvYxIXjwlKJSgnZTjrMx851
	aQLU/nwYIGn5b/tcWTRgmRvCBNDDYlqjS+2PB0CiGtywwyxCxV3saZIUFQy7gs1qV7tYabW4KMw
	Uxo3pG5aGBhTtsK8ywzPirGfrBQ6VLNPDD750A8AnIAcKihK//j+CVYdlXRukPxK27db3eGhqr5
	EeY/03JgEUZfKA93bI0mhu3Rah16fVjzJknmFZ5zJOszzjSKiAaGR4zFQSNKBVYCqandNY76drQ
	MI+Z5LjSGt/AT0GPJvgHg9Kz+XxU4ihWhMQKgzCAvHRJu0leynl6cWmTCozXIN0z6t8J0EBXTed
	qV1Lqr8b/EUo9aZvXAW96+WDcmalpPVRtWs52hM+Nej++XBSO2clmmn7oU/wPKddH1jvhdkbtyJ
	iCprWRhsRMoPG3BYAtr7QSXlBIq5Gk=
X-Received: by 2002:a05:7022:6727:b0:137:5b9d:cf87 with SMTP id a92af1059eb24-139db93a89fmr4012264c88.0.1782455568353;
        Thu, 25 Jun 2026 23:32:48 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:32:48 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Ulf Hansson <ulfh@kernel.org>
Cc: arien.judge@morsemicro.com,
	dan.callaghan@morsemicro.com,
	ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 23/33] mmc: sdio: add Morse Micro vendor ids
Date: Fri, 26 Jun 2026 16:29:19 +1000
Message-ID: <20260626063014.1275235-24-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
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
Hi Ulf, since v2 we've made another slight change to the name removing
a "B2" suffix so even though you acked v2, I suppose it's best to
recollect again - sorry about that. As last time, the patchset is
split once per file following wireless driver submission guidelines,
but will be a pull request with a single patch adding the driver +
sdio ID once review is complete through the wireless tree.
---
 include/linux/mmc/sdio_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 0685dd717e85..bbffad9ae88e 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -117,6 +117,9 @@
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
 
+#define SDIO_VENDOR_ID_MORSEMICRO		0x325b
+#define SDIO_DEVICE_ID_MORSEMICRO_MM8108	0x0809
+
 #define SDIO_VENDOR_ID_NXP			0x0471
 #define SDIO_DEVICE_ID_NXP_IW61X		0x0205
 
-- 
2.43.0

