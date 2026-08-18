Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF5A346FA1
	for <linux-mmc@vger.kernel.org>; Tue, 18 Aug 2026 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087026; cv=none; b=fKsNi7w2rJoVU9vHHgv55Kbw2nfZ1r52NHU2mdDfxpysiny2YhMG+Zf7HrKPtfw42zIiB3xWbtB3a5oRB4QOSmz7p9AVVjQi5YvukLycEYbxmB17vKw+kyDYa8VGjxHpwJF5Pi+hzBB//Rv0q9tGc6EuX0vu+FzHjaCKbhFeRGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087026; c=relaxed/simple;
	bh=Ciga8fyK2UWC2s/b5cGw55pFzypHL9tfi1jBgKUzLFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jh3LSHfDuICf0oYQYMb1JIF7fJLRDrEvF8b5TOnUkooXFGxDvEE2tKYlgWPBi/s2B4Ww/QSRUG2wn+P3hUMUnSXUytJBfFE/yn36pSbJCyNpPcb2+8SWL44d2VF7ObBx3BRCRlMpAn+wJHMkVebw8IKNA7PtjivCM+vAscv0N7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+4VXr4l; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+4VXr4l"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a144c8eea2so560654a12.0
        for <linux-mmc@vger.kernel.org>; Tue, 18 Aug 2026 14:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787087023; x=1787691823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Su7JG/xj7C0P3Xla66ic7tZrV6Rekk1QPQ97x1ZodVQ=;
        b=G+4VXr4laiwUjYBDJc1iSH3kniDzehfdw8uOAascpIjCWHa/5Q3DLrc4CljbiLLp/1
         AOS0wo4PWI756fIIMyECsXi4op87rwUevyawJ/XMIRNaC8ySurmze16B50WizNunSDsI
         +4Tc0A1nkRu69OAJZLqn+yikDxJqegqSr4Lbw4lo6zo3MZYTMtWMvoCM+orkMHRq8j1z
         vj1DxnMvFRLfOHmzcm1m2B+pTEcrvBS3nQCnLQ0zPwWshfp7DRemSKNBD71e9zB/M656
         7wvOrLETx5dmQR2pmDUTLVp3e8iPmEVTP7ARwbPzoiabZlvaPAmM8jmGkA46CkmWyfzX
         TRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787087023; x=1787691823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Su7JG/xj7C0P3Xla66ic7tZrV6Rekk1QPQ97x1ZodVQ=;
        b=TJDqnBKYUV4u7hGFnQHhXz5MU/80ec8Smuf6dhFzytUmZTQG0z/O0+u3pP2tEzf2QZ
         MEM1hiaPdly+941KzHUpc0zRmUW05rJLbsScv8vXgFuy3fJdcxZBnPhfgKZi/dkXP1Wp
         fR0mNUXgHMygi+pMmmLYm6ZzbqD2X7J5u7Z/Ddpo8qAHXa8uQQIJ1dtredj5MmTxuV3z
         SyXS4YLqrhVBZSg8/lZ3Ab6mpAWrF02TD1V8/oGQu6Syn0pZffwGIopVBJl+12NVO+78
         V2podhoK9yxeFDdSc+4mbgrl7ASMv/DjkSIcDP26/e3eB4EgOz6qR0kfakdkaHTi032S
         +DgA==
X-Forwarded-Encrypted: i=1; AHgh+RrbLq2ExA3ZHkvaZYBlgBnqFV7uclMTq2PWH/FX80qL9dlfdrQ6+biVxBo9e2QyYoGkEh1EI2uk3DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYPD9aeur58ns7hdm6WOssuVZ/1uFUv/g5bY5YwgSHsR2OFeX
	UiN4nEyIAwvtpkDjKVzcNsh6ykFUhqa2KmCF3fsKXMcQC3KncOj6WCMx
X-Gm-Gg: AR+sD12bpdp5zZ4wlZK9NMZPccJcaEXZa3+OINd0Z9DIVEiavZsU9TW+oTEf5cg55HJ
	56Ry7pHSBFBHq8KuQi2ciMd621q3dDd1alFNNgjNxRNF2/y39hQdPEdSimULcVRDF/JXaNJgioj
	YASQZf3mTCZhdEmBNWKtALCQ+l/tGKPIEFbEzWwrkXiza/ZVl8Vno0w4RXVbOws+mREEvH/l9mx
	ZS3X4KrMzdQyMGdzsToRfgl4SHdeJwu14DlwASePIeX+pKHVFhriJqOC/0lQe4AWeYqxbTbA8zJ
	1JFDupyGgdxuRQ46V33hKsDJEn7DOPK9d9TOeAHBMNRErr766ZHyMSjqcJnHTlbQrDFDfNj+dxX
	u6M8Fhht3oKv9N5FHZQ/c5q80dBkVp8UlHREwf6utXU4Pa96JhKqyQyojpPNDh1JqF1IlBacWLw
	rYjz18Fq+weSbuEeJWBrPPUjlYY8PwN46HW+DVdU80BgdoFyXLiM4cOD+AdALPb5bmpv5794MPo
	stUAC4pk3TbyAYxbiRzq1UW
X-Received: by 2002:a17:907:94c7:b0:c21:f41:e192 with SMTP id a640c23a62f3a-c222a0ee20bmr66226666b.26.1787087022655;
        Tue, 18 Aug 2026 14:03:42 -0700 (PDT)
Received: from fedora ([2a02:6ea0:5601:6307::13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c219e3f64d6sm51888466b.32.2026.08.18.14.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 14:03:40 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] mmc: vub300: fix Use-After-Free of inactivity_timer on disconnect and probe failure
Date: Wed, 19 Aug 2026 02:03:22 +0500
Message-ID: <20260818210322.53266-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vub300 driver arms inactivity_timer during probe and acquires a kref
reference for the running timer. However, vub300_disconnect() sets
vub300->interface = NULL and drops the driver's kref without shutting down
the timer via timer_shutdown_sync().

If the timer expires after the host is removed and vub300 is freed,
or if concurrent work items re-arm the timer,
vub300_inactivity_timer_expired() accesses the already freed vub300
structure, causing a Use-After-Free.

Fix this by explicitly shutting down inactivity_timer via
timer_shutdown_sync() and releasing the timer's kref reference in
vub300_disconnect() and probe error cleanup paths.

Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/mmc/host/vub300.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 8e45dc1a4a12..9f84bd1531e2 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2350,6 +2350,8 @@ static int vub300_probe(struct usb_interface *interface,
 
 err_stop_io:
 	vub300->interface = NULL;
+	timer_shutdown_sync(&vub300->inactivity_timer);
+	kref_put(&vub300->kref, vub300_delete);
 	kref_put(&vub300->kref, vub300_delete);
 
 	return retval;
@@ -2385,6 +2387,8 @@ static void vub300_disconnect(struct usb_interface *interface)
 			usb_set_intfdata(interface, NULL);
 			/* prevent more I/O from starting */
 			vub300->interface = NULL;
+			timer_shutdown_sync(&vub300->inactivity_timer);
+			kref_put(&vub300->kref, vub300_delete);
 			mmc_remove_host(mmc);
 			kref_put(&vub300->kref, vub300_delete);
 			pr_info("USB vub300 remote SDIO host controller[%d]"
-- 
2.43.0
