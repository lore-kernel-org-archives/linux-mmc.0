Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC4233ADA2
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080559; cv=none; b=M/4SBbrmFi/6wksbD601t2CXayvHBk2AhTCQxshAfZIy73q3dDZRv8uQFffyK+q3El0LqcvdRqUMJ2vv4nKgfUXTUcBqIbSMZdoCuTJKr8UXH9guM6fs/u68L+SNhGx77PWYGkAK2mAyHztKQ9aR0eVy2qrr/l+lct3MN86lwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080559; c=relaxed/simple;
	bh=PnNMMbjwcKzVWP+m7FD53JqeYKvEanJzlNiXzEuxsp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxRIomDbbtBV7JcT9nM8byQn2hpPvDrOiB/SI+ntKMzl//d43o7SEG9L8vuuiZYyP3ufq0BuZF4CCVP77CgFZ5mtqxtLyxt1zqrEnkcWb96ULXvMF18aNyztAwPkOcWBFrcwfrNS3U0D942lrWvZ2u0y4LL9GiE0na9v8qOpu+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=cAr3l21V; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="cAr3l21V"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso34939515e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 04:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1776080556; x=1776685356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbrAMVuoymvOc0pbOyeM4Q5RieftEOwF5FE/RDRgc9A=;
        b=cAr3l21VklToYwJNBQlMpmkHi/IkaKzFZNR3zfRMRHDHD8AeOwM03n9e/+Tk0TMyOp
         krpOgQ/otkHzuDNYhKQOonYyTEwGfqyl5FlP8tgxDQyr6GwpUPZf3yp2QkU/cSHDE0Jb
         euLnduKsneFyppNarzFmJhW9kFnY8qPUaRoE+FPaztQuPa3db8LLQIlQTIZHqMVZHGlR
         l2Z6XzeAO1e+7edNDXNPFca3q/atkjigMGFSMLmbwrF+zcrFpecNmnZzjEoMlmXvjPWW
         /cWa2D6ZuE48wdFKeZN7757uW5gc6V1nmJ+4DbZKKT1WFe47J/SsWkHC5qaCP/1lPtn9
         6auQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776080556; x=1776685356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BbrAMVuoymvOc0pbOyeM4Q5RieftEOwF5FE/RDRgc9A=;
        b=j1dgi72/YhvGUwyghCl18maCIVHfSKX8eelSE6s0mHnDdvtlGTSdplsCu2W9SXNhrp
         oMz7Eb/UX+0VKPg5KLPg07f01M9Rjf0MCfDs2i+Dsq4Kc6NGEzLv+a2f1VFxzKxDj98B
         31NbbFQsJozos7ae+hNESzk/0bv2pvKkTMUppG1b/ZGyUu9rsd0XqJXf909bs2kjZEqs
         5F/TR2Xut4G9uUQj+c/xA9H0AcctLuACmhK2seH2dOTb8K6CAafVrKivHeXGvVvSG9da
         jtEirSktX4Yl2+UpUWhDzrYvERZNL0WA9ZsGE5yrfSkDvFe3+Nx9Ni1aRUBMsEIwzd2B
         efMg==
X-Forwarded-Encrypted: i=1; AFNElJ+JQv0S0kVUBrzLIaUX5KG4f/ImdP6bzdr3ke8jVnJCFz3Erabj234RWxPEhP+NwKbmWa8SH13UuWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh6SzCvj0tm9OjN4/FT824CAsbeoZTdnH3cS5HICx1XiR9Vowg
	QIWYiOm/8Kf6N9TKsWzXePAj9pYT7ClaQX4yBJ9OZvluQjrpq+4e/IbAi6vuZzGlpg==
X-Gm-Gg: AeBDievMOWT0Cry1SE1aEss80ME12r7k+l0fhfJ+mB5VAUznKpJIh3+dQ8anp19KFo1
	2+uj1Lb2CP8fKn76/MJAJkHPvk68N1wgMgyl4umXphac5nJyj8meAqkNXHaY1A/d4Y/1BiFnZzJ
	AkbqXV9s7Se2rFN3AAnCLcNfEeM3N1dlzzoa35KmjN7BSg/YXYaocLyRWuS1PgylvNvjQbphCwB
	cLcGStk2rTYY6CJzpxxm/1GWzpf6UgXgsD5OcyzewIZ30zLn7MGRAQU3UzNw13RkHcCevdLHoB8
	JoGqH87KDF/wrFjmn9flyfHVavjpzAGS55wKqC1Yy3mf3cEVl6mf95DAQwAHNOKzKVQ1qy8Tp0o
	HdsWrwHcbr2GjkI/ZniOfgGH/s2OWhqxbYPdevb6nK0Uegy/mLaMcxBVBaB2AU5tM9NnLwZI9JN
	u+8zkgea4A6LPqm1niCkHwd9OTQ9OAXyZ6VgW6SDCm7TAlm4bzNp/DoAAeU4v528A1WZDA
X-Received: by 2002:a05:600c:3f0e:b0:485:3f72:323f with SMTP id 5b1f17b1804b1-488d67e6973mr177577725e9.11.1776080555721;
        Mon, 13 Apr 2026 04:42:35 -0700 (PDT)
Received: from horizon.localdomain ([212.105.128.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b46ffsm126301165e9.6.2026.04.13.04.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:42:34 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Rhodes <sean@starlabs.systems>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Ricky Wu <ricky_wu@realtek.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-usb@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [RFC PATCH 1/2] rtsx_usb: hold runtime PM during transfers
Date: Mon, 13 Apr 2026 12:42:30 +0100
Message-ID: <95a293902585bd43c6857b79bdcdb8be692ff687.1776080528.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776080528.git.sean@starlabs.systems>
References: <cover.1776080528.git.sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hold a runtime-PM reference across bulk transfers, and mark the device
busy afterwards.

When runtime PM is already in progress (e.g. from rtsx_usb_suspend()),
avoid forcing a runtime resume from within the PM path by using
usb_autopm_get_interface_no_resume() unless the interface is already
runtime-suspended.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/misc/cardreader/rtsx_usb.c | 38 ++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index f65acf4d1164..c8badd0db87b 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -12,6 +12,7 @@
 #include <linux/usb.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/core.h>
+#include <linux/pm_runtime.h>
 #include <linux/rtsx_usb.h>
 
 static int polling_pipe = 1;
@@ -65,19 +66,42 @@ static int rtsx_usb_bulk_transfer_sglist(struct rtsx_ucr *ucr,
 }
 
 int rtsx_usb_transfer_data(struct rtsx_ucr *ucr, unsigned int pipe,
-			      void *buf, unsigned int len, int num_sg,
-			      unsigned int *act_len, int timeout)
+				      void *buf, unsigned int len, int num_sg,
+				      unsigned int *act_len, int timeout)
 {
+	int ret;
+	struct device *dev = &ucr->pusb_intf->dev;
+
 	if (timeout < 600)
 		timeout = 600;
 
+	/*
+	 * During runtime suspend/resume callbacks, avoid forcing a runtime resume
+	 * from within the PM path. The device is still active when
+	 * rtsx_usb_suspend() runs, but usb_autopm_get_interface() can block when
+	 * runtime PM is already in progress.
+	 */
+	if (pm_runtime_status_suspended(dev)) {
+		ret = usb_autopm_get_interface(ucr->pusb_intf);
+	} else {
+		usb_autopm_get_interface_no_resume(ucr->pusb_intf);
+		ret = 0;
+	}
+	if (ret)
+		return ret;
+
 	if (num_sg)
-		return rtsx_usb_bulk_transfer_sglist(ucr, pipe,
-				(struct scatterlist *)buf, num_sg, len, act_len,
-				timeout);
+		ret = rtsx_usb_bulk_transfer_sglist(ucr, pipe,
+						    (struct scatterlist *)buf,
+						    num_sg, len, act_len,
+						    timeout);
 	else
-		return usb_bulk_msg(ucr->pusb_dev, pipe, buf, len, act_len,
-				timeout);
+		ret = usb_bulk_msg(ucr->pusb_dev, pipe, buf, len, act_len,
+				   timeout);
+
+	usb_mark_last_busy(ucr->pusb_dev);
+	usb_autopm_put_interface(ucr->pusb_intf);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(rtsx_usb_transfer_data);
 
