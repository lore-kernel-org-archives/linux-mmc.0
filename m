Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A2137996C
	for <linux-mmc@vger.kernel.org>; Sat,  8 Aug 2026 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786230644; cv=none; b=MvY/lUXMxB+TWRMs3p2PogHT9+auZl5SdPVBKMVoekoK9HAwNhm4aRes1lyRjxRiy2BsOYoL+imip/kcL0RaK/ZjCTafYDhLN1QCd7tR8qEVXeJZm9TfD6GE5dPRN/Gb2vzfU9lqLljvHYPYmh6KmELDInLLZ0Hg2gi15Im3EdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786230644; c=relaxed/simple;
	bh=SOGhxp+1sUkxTnYa2Y+Hg42iVdlfTKPm/HSgw2Sdnx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QteRRtHQAlmxMK/DkdWc7EgFJzz+Q/kDnQTBfZQwOE86+YJjVyPAJlNJXduG/1Uo4hRmbnmRq4MJnEVWeBK/+vQQ2hlEhW/Q9pkK3c9YwL1xDr3MPYMBnZUg+79qrAg9JwqyK06nYSlQg55ctjNP70qh2quhr4ylBGe97Vu/npY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTJSa3Ba; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTJSa3Ba"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so690832f8f.1
        for <linux-mmc@vger.kernel.org>; Sat, 08 Aug 2026 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786230641; x=1786835441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c/nxiJ23QQ+QBEnsdwZyRs3K50ewyvyizEPj4Iojjvc=;
        b=WTJSa3Ba1V2e5q9vhQEggKRK69iVZspu35/GRZLEslvfW3uDxaD3JvzTtuYncdAkP+
         IhyimTyohpfSKfe11LHf6Ynt5UgfqCSKXaG9g0g99I8bP6n0TmirR5A0wgV8/mZrOQL5
         uxkfMc09k37K0Q3yEOACsnT6byNIVeuB29CNFml+xM62lHk4n6kZBE2SqQK0dw5VmMx/
         AXNJ1foHzkN1JBf0fAB/PtHoCJWfCq10JISXMES08yBl85clM0N6k7o5l4bwgt+nppnh
         st9pFmingRCMrQCfG1v8MgJSg6TB4MYyfX542VO5VCFe/KvqQAENDd6vTSFP1eytcsQP
         GpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786230641; x=1786835441;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c/nxiJ23QQ+QBEnsdwZyRs3K50ewyvyizEPj4Iojjvc=;
        b=pj5t3weHQmbxnsaFw6jIcuDfdkGlDWRK5omaglqIbs9BzmU5QMkLqGq27KSmDPu6mp
         CIhrINYpTV5FxOqpM9ArQB9QfVFi1gdUNIZnzLH1Tnldgo9n4Meu55DmLNynUXb/3iEV
         l8jJEtVr+TSeLBcwTkvTyHIEc5lRkUb9MlZ4s1wUEhuR++Mhh9ZHPdMjqFRLwEI2hWvo
         TcMLiaVSkfNzPfeKcb4cpGRdEowDIvLJXlxNS7GBuHNOD543bGxu052xGPssFOlfPeqT
         WQqEnZfuxkVBNZ+bvtzqhcP/EUFxUfKp46TVM8IgaVAKovpWlLAbADgQbiyZjgee/KTT
         YR2A==
X-Gm-Message-State: AOJu0YzeyDmPl0QCzOioo29d0zGbhjZBw3dSqBcsD/WbY3V2pL4siIb1
	uZu0j/GDXAV0strxkqmmbNA83rjjRluVMm4fgNGeUhJI+d1uBQs6+gnJR2HHbFWHj50=
X-Gm-Gg: AR+sD12hLT68vL7G8S/wt6Vr65S3l9R9rhu3B6YiUviUxiN0vyGRwuxKh4wZECw9riS
	RVPvoMxudkCmdC+W2kxm809iQ5fTauwvdw7OY8h1tMV5W8OPNdGEPznIUaXsXnCkk5TO6RGAsuU
	qygM+H0a8x9pBYUi2H2XSFkhi/XRr2b3NWdWBMXFVedxowRfWul5cwXV4HnKPKviOupmGkPhz1L
	u+Z8XoGmQaCvi+O+hgEE+L8qFHf11zBDwqnTc2NUsgkvG9YpLSrAbYkLkFA2WFbsH58S5TqBJiY
	NxpV2DHlKQ808VbYX0RqhR6ia+eHUjYOtkTVE7Uzn/YNDaKtOzmIg7Z2bzBPAdKiIqB9yNO3I8o
	EdZjXgV7G41Om1br6IT3DYkQ0Y/Q1csviRiXmxkQ8ILLmf9zmNFWrSN1hgw44QJK3N8AUbfu1jo
	SXL0enQLAYJY4aTyCHF0bk3R/OfiqqQAne4qduaVc+wmrkS4wL3rRODNkZinB+TcmZaiIz3g==
X-Received: by 2002:a05:6000:22c9:b0:47f:e7c8:3fe9 with SMTP id ffacd0b85a97d-47ffd15cb0fmr28848341f8f.0.1786230640483;
        Sat, 08 Aug 2026 16:10:40 -0700 (PDT)
Received: from metepc ([46.197.185.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e7b3fsm19934216f8f.20.2026.08.08.16.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 16:10:39 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Chris Ball <cjb@laptop.org>,
	Tony Olech <tony.olech@elandigitalsystems.com>,
	linux-kernel@vger.kernel.org,
	syzbot+0e06aa1bdc6495bac24b@syzkaller.appspotmail.com
Subject: [PATCH] mmc: vub300: fix sleeping function called from invalid context
Date: Sun,  9 Aug 2026 02:09:50 +0300
Message-ID: <20260808231019.28528-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

syzbot reports:

  BUG: sleeping function called from invalid context at kernel/workqueue.c:4487
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/1
  ...
   <IRQ>
   __might_resched
   __cancel_work_sync
   mmc_free_host+0x19/0x30 [drivers/mmc/core/host.c:700]
   call_timer_fn+0x192/0x5e0 [kernel/time/timer.c:1748]
   run_timer_softirq
   ...

vub300_inactivity_timer_expired() runs in softirq (timer) context.
When the USB interface had already gone away (->interface == NULL,
cleared by vub300_disconnect() or the probe() error path), the timer
handler dropped the object's last kref via
kref_put(&vub300->kref, vub300_delete). If that was the last
reference, vub300_delete() ran from softirq context and called
mmc_free_host(), which calls cancel_delayed_work_sync() - a sleeping
function, illegal from softirq/timer context.

Root cause: inactivity_timer is armed in probe() and continuously
re-armed via mod_timer(), but - unlike sg_transfer_timer, which is
explicitly deleted after each use - it is never stopped when the
device is torn down, so it can still fire after ->interface has
been cleared.

Fix this by decoupling inactivity_timer from the object's kref
entirely: drop the kref_get() taken on its behalf in probe(); make
vub300_inactivity_timer_expired() a no-op when ->interface is NULL
instead of dropping a reference; and in both vub300_disconnect() and
the probe() err_stop_io path, call
timer_delete_sync(&vub300->inactivity_timer) right after clearing
->interface and before the final kref_put(). Since ->interface is
already NULL at that point, any concurrently running timer instance
takes the no-op branch, so timer_delete_sync() is guaranteed to
return with the timer stopped for good - removing any race with the
final kref_put()/vub300_delete()/mmc_free_host(). Before this
patch, a successful probe() left two references on the kref (one
from kref_init(), one from the timer's kref_get()); after it, only
the initial kref_init() reference remains, matching the single
kref_put() in vub300_disconnect() and err_stop_io.

While auditing the driver for the same class of bug, also switch
sg_transfer_timer's two timer_delete() call sites (in
__command_read_data() and __command_write_data()) to
timer_delete_sync(), since usb_sg_wait() returning does not
guarantee a concurrently running vub300_sg_timed_out() has finished.
__command_write_data() additionally only deleted the timer on the
success path, leaking an armed timer on the cmd->error path; the
(now synchronous) delete is moved before that check so it always
runs.

Reported-by: syzbot+0e06aa1bdc6495bac24b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0e06aa1bdc6495bac24b
Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
 drivers/mmc/host/vub300.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 2dae474dcd06..def8c7a29e91 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -744,7 +744,7 @@ static void vub300_inactivity_timer_expired(struct timer_list *t)
 	struct vub300_mmc_host *vub300 = timer_container_of(vub300, t,
 							    inactivity_timer);
 	if (!vub300->interface) {
-		kref_put(&vub300->kref, vub300_delete);
+		/* Intentional no-op; see commit message. */
 	} else if (vub300->cmd) {
 		mod_timer(&vub300->inactivity_timer, jiffies + HZ);
 	} else {
@@ -1453,7 +1453,8 @@ static int __command_read_data(struct vub300_mmc_host *vub300,
 						  (linear_length / 16384));
 			add_timer(&vub300->sg_transfer_timer);
 			usb_sg_wait(&vub300->sg_request);
-			timer_delete(&vub300->sg_transfer_timer);
+			/* Sync variant needed; see commit message. */
+			timer_delete_sync(&vub300->sg_transfer_timer);
 			if (vub300->sg_request.status < 0) {
 				cmd->error = vub300->sg_request.status;
 				data->bytes_xfered = 0;
@@ -1570,10 +1571,11 @@ static int __command_write_data(struct vub300_mmc_host *vub300,
 							   linear_length / 16384);
 			add_timer(&vub300->sg_transfer_timer);
 			usb_sg_wait(&vub300->sg_request);
+			/* Unconditional + sync; see commit message. */
+			timer_delete_sync(&vub300->sg_transfer_timer);
 			if (cmd->error) {
 				data->bytes_xfered = 0;
 			} else {
-				timer_delete(&vub300->sg_transfer_timer);
 				if (vub300->sg_request.status < 0) {
 					cmd->error = vub300->sg_request.status;
 					data->bytes_xfered = 0;
@@ -2327,7 +2329,7 @@ static int vub300_probe(struct usb_interface *interface,
 	INIT_WORK(&vub300->deadwork, vub300_deadwork_thread);
 	kref_init(&vub300->kref);
 	timer_setup(&vub300->sg_transfer_timer, vub300_sg_timed_out, 0);
-	kref_get(&vub300->kref);
+	/* No kref for inactivity_timer; see commit message. */
 	timer_setup(&vub300->inactivity_timer,
 		    vub300_inactivity_timer_expired, 0);
 	vub300->inactivity_timer.expires = jiffies + HZ;
@@ -2350,6 +2352,8 @@ static int vub300_probe(struct usb_interface *interface,
 
 err_stop_io:
 	vub300->interface = NULL;
+	/* Must precede kref_put(); see commit message. */
+	timer_delete_sync(&vub300->inactivity_timer);
 	kref_put(&vub300->kref, vub300_delete);
 
 	return retval;
@@ -2384,6 +2388,8 @@ static void vub300_disconnect(struct usb_interface *interface)
 			usb_set_intfdata(interface, NULL);
 			/* prevent more I/O from starting */
 			vub300->interface = NULL;
+			/* Must precede kref_put(); see commit message. */
+			timer_delete_sync(&vub300->inactivity_timer);
 			mmc_remove_host(mmc);
 			kref_put(&vub300->kref, vub300_delete);
 			pr_info("USB vub300 remote SDIO host controller[%d]"
-- 
2.55.0

