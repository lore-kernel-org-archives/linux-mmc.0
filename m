Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C29387346
	for <linux-mmc@vger.kernel.org>; Tue, 18 Aug 2026 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063836; cv=none; b=Ip5XZRVNgeO8d3OMO6WFubtXKOYQBUSP+H5NXqKads/E9cI+yheex0UBhrtPOt/kliyAJT1nDKTdEy28Ier7GCHVWLz9takPNBTL6I+CH7iEIl5M5lKLYw75VnOJugERdiDlCBVuNMptDR11g/7tIza3Rta9AiObd9V9x/W2xwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063836; c=relaxed/simple;
	bh=m46Dt5gKDw8zpiiz6DLXZHnUa3aI5un+6SIdQMscraU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8bv3xAqKtMEC4u3/qAo9siN2eUSE1UTklrVqjYM0eOmihaSeyxfa1+xelc4MDKJ4DfjQ2B1cw/oxN7Msg1phHnA0G6QKcFV5YgXKurTCh9pR88AgzWMoQQ4VM+LV3nVFoBb3/3tH9JjGnfT6A5nn1u1r7GUlspaag/kulKaEx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwJwvkNF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwJwvkNF"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47de0093c42so4123387f8f.3
        for <linux-mmc@vger.kernel.org>; Tue, 18 Aug 2026 07:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787063833; x=1787668633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CSDrYDdus+4ad4BK/FqGE8bKP66ORSS2uuAZyEFAtno=;
        b=ZwJwvkNF/ccbC27JPuMmAWeLo7jrRmRSqq5XK9VhRqnbJ5G1Wsa57KSLKtBAeeuguX
         tjvKHzYjIoULyho3iJ5R5ZqCP9gQjvdpKZIs6PJFMrrEPqYktp8yq8hMPBG5ADMXpAdv
         89tX8IqzqUC6h9fO1LCKo0XC8eAOllcRb51oYDYNYxajVUk14cqQbnrTtC6zPaJQsK3T
         NsEGuTC5UuIxZFnc64iAgpme1eeDAeEXSrdIA9E0vxdw9Dz1S0hhbCewKPnvTCmQDXp6
         Yn91Hi6WbOXGj+1tEEllu5LgTy0Wes2KEpI4QshNMdKTxWUJF0oT3VWlOdQBUw78R7mE
         fhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787063833; x=1787668633;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CSDrYDdus+4ad4BK/FqGE8bKP66ORSS2uuAZyEFAtno=;
        b=X7/Gc2C5qTRBWENxPhASjUEEYkuTeQKP3C+DgQZDpWVZ9pGiGQ09c0zrJwX5p0uik8
         dEywPcLfv+5BMtS6f6pHYinc9MdFie6wPljfNET9rwrb+yZTEwutENM8+Yff3xonO1g2
         s9vNa9NFxRHDZaOJCzXnLKmeblIZJOokYwMN7Ta0vuLwQscuUtY0IuXLKU/pXFT10zvA
         ydalHcWq1+iD/k6P2JdUh+jABY3gfGVEGnYAoHRRLmPg6lyDCyFt3dW2WQPYXssy57Tn
         lkQerHPQUl2hz9DzTKF3yctxJaCohf4rmJ5L2UOXk0v8hI5lSW0leZ4Df5QYgni4rTXT
         J0jg==
X-Gm-Message-State: AOJu0Yxe9IHJy4LNTh2VHgMHJVDARM13ZMcJgwdOJiYqaDPHLe6M4ll4
	+shsS5jC4DhK5ywJ0bxNlgSPHpFCnbmkfAyKLG8WEGeEBvVuv18O0+eby9MZUl9J0v4=
X-Gm-Gg: AR+sD11IO4LTBeIn6Sfd0QyCRHIf6U8cuh9KFLH9o1UEwX/CStLBlMzjsaEeqXFCeH3
	0ntOel1O1uUYLzimWkNLI95cIvqhgHj25MvHhJAEcCTVTp+Tl+4p1UNeZsHQKpnLhW5qN5vxysk
	b5Y+icPXcZpL80FNwt02ryG8aJS/xqHiDLpZsovEj+9xz+AhErzUFUTJYiq4sPumK7fWNeeKrE7
	v/12G1e4nxw6B05JHVG/R37+1Rty1jgfDVcrbVLITwQEnXDE2wWxhA7m0N+wMhsR8pC7pe5xOxc
	pgZhKFpN92H3CUZaXeYtb8y1ZT2L7tiVU59Qmgoh+N4yjxq/yWurQSa/qZhrwDXyrmtaDW0E71G
	4nHhi60X8XZrh/pgUVLs8fk4rrxGY4oycOAWyFOc7e/JyjTmO/vXEiTD+GVGUCjh9VHdkWV5cjs
	8pg9k5u7Q/IXz0Y/xoAgZks73WyHl+99n+lvvGfi2T4yOl9VRLHIUkecaV6lK9NmYZwkTlBQ==
X-Received: by 2002:a05:6000:41ef:b0:481:5bce:4485 with SMTP id ffacd0b85a97d-48160724606mr56551161f8f.13.1787063832957;
        Tue, 18 Aug 2026 07:37:12 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a31543sm13312420f8f.4.2026.08.18.07.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 07:37:12 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>,
	johan@kernel.org,
	ulfh@kernel.org,
	cjb@laptop.org,
	tony.olech@elandigitalsystems.com,
	linux-kernel@vger.kernel.org,
	syzbot+0e06aa1bdc6495bac24b@syzkaller.appspotmail.com
Subject: [PATCH v2] mmc: vub300: fix sleeping function called from invalid context
Date: Tue, 18 Aug 2026 17:36:56 +0300
Message-ID: <20260818143658.61667-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aoLDMrhGPGOjNVpb@hovoldconsulting.com>
References: <aoLDMrhGPGOjNVpb@hovoldconsulting.com>
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
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
v2: I used an LLM to help structure and polish the English commit
message. I did not know
this required an Assisted-by tag until Johan pointed it out - added
now.

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

