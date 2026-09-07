Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BB5013A5
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794082; cv=none; b=IPpZz4yfDY0RebGv0fP43YN7lZbGe/A+Dg5E52KTstOxl9nNkpbyYNhLglHM6hkT5XzLYjYLtB/ziYb/bWzJDkc6AmxSN+65oJBDeZuDdG9BeotUkTdbrs6s8fgx00/dCRbx0n0mcCadV/qnGC0qOLYZcggyr1KJlJTAP+rzDA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794082; c=relaxed/simple;
	bh=mNjpd1tQwWKdzKUEeAZaOMlQ8clRHjCrzGoa5fQ5e0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZ11SiSh0lBlXdhZJU/6kVWIXH3Xkl1Sq/JBix9D6Zah1VTayYc6RCMPW4LwmvPtNEXifBDMLOzQBUrHlAErAEzDkXbPHxkqXqMkgxbh5eN+NRVLYwvrlcz3S9+zxl0ReGWhUoWJqpRTu0UaBYzEwxbzvKIA2mdtYt+3yH0uC0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV+b6MbT; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV+b6MbT"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-785073ad5ccso2513098137.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2026 08:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788794079; x=1789398879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W9HwXQlNGS9bLvO1Kv0B3vOGIHhTJMb9BOvcgiHRmOU=;
        b=YV+b6MbTdU9we3rDFifWyokV2UArQSoXeTUTrP/4pcbgkrBxwpkzTLrRsF9e9wIg0h
         T7pffIMDm1TEv2IzMTbzbzlORyx1OURjcLi9S/8gJ30XJ5uXDYBq6XzrU+9l+dVHPEfs
         LxwYnjxrUQ3WwLVu4T/lbYMnCfgST6DNXDLjNaYrLEhJZKET0tmOb1GtLJFHKmTGpPyA
         mO2JZPz29+ToEroXDaA95Y8MDcLoOYWgnIb01HVgG6MZeYVP30XVPnRa2HFzZTkFK5H4
         WheiyG8uhDXcifr2pcbv9blNGtwqVUXAT8nenpbF1V7TJPF27lfcmlZcGCIdAvM8eF6o
         KnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788794079; x=1789398879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W9HwXQlNGS9bLvO1Kv0B3vOGIHhTJMb9BOvcgiHRmOU=;
        b=KbkFAjTp+VL38aPzMvnNyYfkSVuNUZk6D17RYHPSF6gqks4uXg+Y7UkHClkDgFZVqr
         6jALuF3GJSX/ozbvCjJxO9GcuFAmlo9A6Tvr9XyL33Rd6HDEmhXaHP2OW/3JxRsUKyfv
         EvrXh4FZVA6SCeXYGUx5qRCrGYXFE5pFQOcH0WlKawmVuF4jbe/BWe6X26sbQhlvswiZ
         5JHSvGQbGakY+wkOysaXlrvRntMOOX4YR7EgWbYpS1l9ie8XP2b9X0VYq+Dod7zpWK2V
         /mpzHzOneIofP4hbZBOOO4JA3ONQJzGOsfSC/VXZT/DQOKMu9odk/Kt6U8E/nLwFDbnH
         Pkhg==
X-Forwarded-Encrypted: i=1; AKwUvBxPnvwXphzn0riF1uT/lE1DFguzDFGlHaFQ5MLZTds17y/Qqto0jN1+q8bzTyvNaK2pBG/uszwC8wc=@vger.kernel.org
X-Gm-Message-State: AFuF++nahpIoXXAWEiQ3wRmfmTUu+LnHgzxSEYQfCp+6PWF4nxhOohIX
	H87L4WCnJNakfB6UOyyfnlAQTTRSkoyY4Hac0dTbLCNliBIgybpqoCdYO0kWlSi77ws=
X-Gm-Gg: AYBFou2Fj7lKhrTCdkRflbBQmGWx4/KoerbXR3KoL7N2FnNg3MijE2x9lyWtkGNm9Vi
	dKn1QfxpUTT3anCrYurf++hXs382tHTasFWdJjeUnzTDQZsDGbQAZVkwvSb685iKda2Pr3Cgjcj
	ussXq/MJpIFIEEv1NyUfqaolmhJ+tFP5z+g7BtQE+VbI3hJ/LbL/ENJeEH7DB4uCljAuqX2psma
	Wj7DYr/5EwbThLJclRyAClRIQir13YGvh0iwEeVLIDMa1t9cWV0STYP4swRJ0uPmIDVa377r1G4
	+PszlgjIbfWaMV3BYOjq6eurCGmpYiDSjyW3r6lwWk6UaSLMvQ/kRip+QRuO4xwY8hkftCpNDAD
	Ncsx9hC/4oGRPRNf+TXmPNX+58xjaZmZGKwvn/tJ1tgjbSdK/dZu95b/OtExy1kVgozcTV/EyEV
	k4l7iEM5MMNpCGFsGqMnsgsy3asq8pqpMAqL8KXnMZwXwA8h7EkvCZzuwSk4Q8JLg=
X-Received: by 2002:a05:6102:80a9:b0:786:4822:308f with SMTP id ada2fe7eead31-78a4a9aea5fmr9223898137.13.1788794079271;
        Mon, 07 Sep 2026 08:14:39 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-980d774ad5dsm607088241.9.2026.09.07.08.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:14:38 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] mmc: vub300: fix use-after-free in vub300 teardown
Date: Mon,  7 Sep 2026 12:14:28 -0300
Message-ID: <20260907151428.643841-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not dereference mmc/vub300/udev after the final kref_put, because
it can release them via mmc_free_host()/usb_put_dev().

Fixes: 8f4d20a71022 ("mmc: vub300: fix use-after-free on disconnect")
Reported-by: syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f312381a95cc080992fd
Cc: stable@vger.kernel.org
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 drivers/mmc/host/vub300.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 2dae474dcd06..a1a6aa1aafdb 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -370,13 +370,14 @@ static void vub300_delete(struct kref *kref)
 {				/* kref callback - softirq */
 	struct vub300_mmc_host *vub300 = kref_to_vub300_mmc_host(kref);
 	struct mmc_host *mmc = vub300->mmc;
+	struct usb_device *udev = vub300->udev;
 
 	usb_free_urb(vub300->command_out_urb);
 	vub300->command_out_urb = NULL;
 	usb_free_urb(vub300->command_res_urb);
 	vub300->command_res_urb = NULL;
-	usb_put_dev(vub300->udev);
 	mmc_free_host(mmc);
+	usb_put_dev(udev);
 	/*
 	 * and hence also frees vub300
 	 * which is contained at the end of struct mmc
@@ -1794,8 +1795,8 @@ static void vub300_cmndwork_thread(struct work_struct *work)
 			construct_request_response(vub300, cmd);
 			vub300->resp_len = 0;
 			mutex_unlock(&vub300->cmd_mutex);
-			kref_put(&vub300->kref, vub300_delete);
 			mmc_request_done(vub300->mmc, req);
+			kref_put(&vub300->kref, vub300_delete);
 			return;
 		}
 	}
@@ -1946,8 +1947,8 @@ static void vub300_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 		    satisfy_request_from_offloaded_data(vub300, cmd)) {
 			cmd->error = 0;
 			mutex_unlock(&vub300->cmd_mutex);
-			kref_put(&vub300->kref, vub300_delete);
 			mmc_request_done(mmc, req);
+			kref_put(&vub300->kref, vub300_delete);
 			return;
 		} else {
 			vub300->cmd = cmd;
-- 
2.51.0

