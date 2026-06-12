Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9557E3148A7
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781234895; cv=none; b=CzHOtvKfZ1BARUmS+JqFus4zoy5l+BxKOnR09POBuzIqGkSS/rlrcTLzZiOa6q3hw+9iMG6FQ/pSA4yflDBzsOatV4Lxc9JdjvoAKc2SXNsFYZNxN/64eLtlRxuH4auYGcKulU5R6GbQ/cgK99pXqYuKJum8pW3TbqBVK7yOvIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781234895; c=relaxed/simple;
	bh=eA1/4AZ9Uizo/UpPNbVAah3h9C17A0vqMBWni8I8am0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K/t2OXRp6EKlGcpAX4TCi/zSyN5CkMJRdPhZUBACQvVCD96pKDnLNxZNtvbkVW1wlSsh3S4wE/OvT/CBKoLpF/bOJZ0oriULSp2iYYcgQhNFGesj6Btg0UWUz7/QHvjjgRwhLvf2mu9HJZXyeEwiLHfnkcejqwsyCJRBk22lOxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z20mdl1d; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z20mdl1d"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304cf518c9dso928621eec.1
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 20:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781234894; x=1781839694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lKsUisYLKT5n4R5y2fiEQO+23uHyaUdKBMEExjId2JA=;
        b=Z20mdl1dgcpa4Wa8RXKoiGM+Tc50a7AfkmVoPZxWhQaQObvAKqiCbPLkGsRv0T5qjQ
         kuxiMi6tEZ8Kc37WWjmes48+yqo6WqiMAEiyOZzI6hRM+uMv+NSna3tiZrHvXF9RnWVk
         7p995m8NlR5bdycjZ+8DS3geifpUV+GP3QgwT5WWFdATDvvXIirk9CzRMZQupe/QVNkO
         43hkR6Q6wvEl0+z5lvcDMWenADG2fUrD5ExpETI3IH246+0mS1cq9JtMNr36kC0ebMvu
         5BZpag73u6mZGxSNiOosD0bN8puwm85HtO9D0VRjHHCqHo8GHDABPy4yAVVvEx1mwnVY
         N4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781234894; x=1781839694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKsUisYLKT5n4R5y2fiEQO+23uHyaUdKBMEExjId2JA=;
        b=VLm8bYBtIV6QCe8hbUto7B3zozHwvtzNYn2zd2KuX967NUX0yxhSxF6iZaIxi6LRYA
         HjGF9ITaogbIsuDDsi9nAHwv1OZX016c5sbsbUnEsdPf0Teo7U7LsuV/DV5Q4x0VKWin
         fEjpfHnmmK/23YlEntneZnO+tjFaKJy58+10r5TPxcha3vgcEy2lVYTtTjEPZhB+u6DO
         zVnRJFKsnZdOHYuE71Fl7ldPuOYWDVbbw2Lhci9icFDUSf5bLszRZBLDtgl4J/dNMPbZ
         48Qemd+IAPdkJ691AYXvQxfprfY5EbTUtuDSsTBGkhdLYgc5VNZiTOxzICAwCnMlz5NR
         u8wg==
X-Forwarded-Encrypted: i=1; AFNElJ+kuR8fJ2eF5KLFeBf44JXcluqdAcC2VXax24QWaByVfJ6+FKbripre/p6HTs6PBNmPq9+6Vw2SA0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOKTaHN5/33lne5vCPlFepOUrfgTVbbAZOMTXiSQp9vg1jK8LO
	brx8Gd5JcDW6kuxMUIFElH/K2bLumnBssymi5JLRdr7wws3lf+u8VV2H
X-Gm-Gg: Acq92OHfqGc7uDJr0mhQzSmYD7V4nrDlqz6s2cgTPbPjMYu4t0BL/krJDgksYX9TKlh
	9kr6g9a5whpa6JijSk++eMNQSom4acbGwVqzNTCxUBExVPBcwIKYHrUwKVDj/GM2xW3Rj1eruxp
	JpDZeFw7t+tKna/DuPl5w0EW3EyYdyVBo8g8aGee6h62DDX5ktypwDgYSfTqMSbPlJzbjABHS4I
	6oDO69bigkeTGhZyOdfWAboEiprHylfG9pPfds2yeXo9z2KRsJewFqFGTMG1SpgU7065HSnuU+B
	GrTYf0ekNeYNhmBts+646r9LNgPlZsNCx1muZSqG7MzkfcSljEx7BcOSaZb3PX8hu2xu5At+79J
	KTFqoU+JQ5X0qSy0LpsP8f4YreJJDaW+yD2YpHiHzX7TMXlIh7NorL/a9efu9H9u3WqOPJajzF8
	lWO8USF9gBEOrs
X-Received: by 2002:a05:7300:7305:b0:2d9:5cd9:b8ff with SMTP id 5a478bee46e88-3081ff4b302mr684782eec.6.1781234888987;
        Thu, 11 Jun 2026 20:28:08 -0700 (PDT)
Received: from lgs.. ([152.32.251.59])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e4898c0sm1633241eec.3.2026.06.11.20.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:28:08 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] mmc: vub300: fix use-after-free on probe failure
Date: Fri, 12 Jun 2026 11:27:56 +0800
Message-ID: <20260612032756.2910943-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vub300 driver lifetime-manages its controller state using
vub300->kref, with vub300_delete() freeing the mmc host when the last
reference is dropped. The probe error path after the inactivity timer has
been armed still bypasses that lifetime rule, however, and falls through
to mmc_free_host() directly if mmc_add_host() fails.

The race window is between arming the inactivity timer and reaching the
probe error unwind after mmc_add_host() fails:

        probe thread                     timer/workqueue
        ------------                     ---------------
        kref_init(&vub300->kref)         ref = 1
        kref_get(&vub300->kref)          ref = 2, timer ref
        add_timer(inactivity_timer)      fires after one second
        |
        |   race window
        |<---------------------------------------------------->
        |
        mmc_add_host(mmc)
                                         inactivity timer fires
                                         vub300_queue_dead_work()
                                           kref_get()          ref = 3
                                           queue_work(deadwork)
        mmc_add_host() fails
        timer_delete_sync()
        mmc_free_host(mmc)
          frees vub300
                                         deadwork runs
                                           use-after-free

The inactivity timeout is one second, so this would require
mmc_add_host() to both fail and take more than one second to do so. This
is unlikely to happen in practice, but the error path is still wrong.

timer_delete_sync() only waits for the timer callback itself. It does
not flush deadwork that the callback may already have queued. As a
result, queued deadwork can still hold a kref while the probe error path
directly frees the backing mmc host, including the vub300 storage.

Fix this by using the same lifetime mechanism as disconnect. Clear
vub300->interface so that the timer callback and any queued deadwork
return early and drop their references, then drop the initial probe
reference and return without falling through to err_free_host.

Fixes: 0613ad2401f8 ("mmc: vub300: fix return value check of mmc_add_host()")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
---
v5:
  - Correct the Fixes tag.
  - Add Johan's Reviewed-by tag.

v4:
  - Fix the Fixes tag to point to the commit which added the
    mmc_add_host() failure unwind.
  - Add Johan's Reviewed-by tag.

v3:
  - Use the disconnect-style teardown by clearing vub300->interface.
  - Drop only the initial probe reference and let timer/deadwork drop their
    own references.
  - Mention the one-second inactivity timeout in the commit message.

v2:
  - Rebase on current mainline.
  - Correct the Fixes tag.
  - Add blank lines around the early return.
  - Reword the code comment.

 drivers/mmc/host/vub300.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 6c3cb2f1c9d3..c1c21e95f5bf 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2336,12 +2336,16 @@ static int vub300_probe(struct usb_interface *interface,
 			 interface_to_InterfaceNumber(interface));
 	retval = mmc_add_host(mmc);
 	if (retval)
-		goto err_delete_timer;
+		goto err_stop_io;
 
 	return 0;
 
-err_delete_timer:
-	timer_delete_sync(&vub300->inactivity_timer);
+err_stop_io:
+	vub300->interface = NULL;
+	kref_put(&vub300->kref, vub300_delete);
+
+	return retval;
+
 err_free_host:
 	mmc_free_host(mmc);
 	/*
-- 
2.43.0

