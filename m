Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4632694F
	for <linux-mmc@vger.kernel.org>; Wed, 10 Jun 2026 03:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781063355; cv=none; b=TXZdmZh+3SkIqLT9FlnXxSiL0RGr9kfNRFCPV4zMcrkWi5RLwjSVRIZwfmHEAFJ9r8wdrUQ8jzav345DLZu8LujCKrP12/N2rjsT9nttoQOJtafrbDM6agHG741ZfSX3TsEWLiSALA0IMqjs0l1fCdxYqYpq3F+KK3pPMWnO12Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781063355; c=relaxed/simple;
	bh=3ZPsDWkjSwKT01zPE216ZKh3Z1MtEA99kJpzp+Is5VM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OGYxSzxagbvsxznh6zcXOChzDIdoZIDLys82Oa8fqrvxDsXlVE+3wJV9tLfqUlQGS4hE+FxrSOM/HNp6e5Wv9Z2GLoB1cup5HU1mrOgBEcj+02yG0bCKRMN2Z4/cL56HVSPJH5MNvtB9hxbu4BLDCg8xW3yPihbtZMXGo8QY1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ko90n1JZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ko90n1JZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36bba9a1089so3779826a91.3
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2026 20:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781063351; x=1781668151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iV5Pa9WyzplSg7PADzRj0hOoDiZIDBR+IxRwHUBMtBE=;
        b=Ko90n1JZwFwzEx+F/YeeG+qFMNhOzPFAFRjZ29GPkb/r1MsEWmAZwywr8/fTtATn/s
         r83MaSGMTv1Inx0Aaj58ZQPy0MjmKAfMaRCZ7OHsCfnvAwfJTDTxOSuQMfVYgNfaaRvn
         vZMBBNGMLqr1OUP2ozgv6oM9XA9yqdRGroeaMyHjDWpFLPh8Zuw8MrTn9QP2Nib40zuT
         MRU3EwlKnaxDUBT2+ZGHrzhw9eZV1wnMH+evCc5QYZGJzThMIQyXYAHGY8TL4gnxgmmr
         4LA50/EXwpNEYOyrzbY2UN5Hcld52gTq2aIjLUjHCpEXa9SeWBVXRby7K/u1rUSGtBUk
         0BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781063351; x=1781668151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iV5Pa9WyzplSg7PADzRj0hOoDiZIDBR+IxRwHUBMtBE=;
        b=Nl3f8tsAvA6iya2HjUZbXp4Z9WAOoxMA+/NM/061q4pBPPi82UJz4Z50FPyC9uRCkk
         aJSeV11ztyeTyven3paXNgwZPrS9D0Kbbr6xVx7xAVzehTQZHMQvW75YQQy9GFr56avP
         ujOs3fHWcUdubPWFmD2EITbNs3IVMT4HOwXfVUz0XGFbnNNPMAF4YlLN7NN06JhftdhY
         hZ0MB/XxVAI07YNzN3nbW7l0eH1yCpE4xswl2/stN8gXCaEblDGNQGaQOhFk1FOEbsaU
         WV6qpWGFlugRMejGj0scoVpqEbVzpmlelGSQCbhVgeHrUPcw3lGDoqdrwxw4Gas0sWgQ
         nohA==
X-Forwarded-Encrypted: i=1; AFNElJ9gpfxAxNXiPYmlZjbkjdXNR2R6z1P2JDqqfm1FBGfVnComq4RBK+6AL93jnTS9nORI3ZGlQPEGaCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHxWprko2WDttu+aIGTdzB/nttwgnjafSOGi9ZQwQxdNh+eaaj
	wFd3vVMmpsMJw+aLn95CW4Yz+M0q2RXbGt0G3WlX4K5pQ2etNusOQeVR
X-Gm-Gg: Acq92OHaC/kNk5v3bXsmXM4ogZMLJZPE+4fYeZ/Z8BVH0pT8Kpv4Sx7pWGNHbedXPqX
	jLfTDRLYQMHZBb3/MHc1U8RQ0Gqz0RfJ7KXH657qSSvXgYf7CKuIKkP6UkPZfpcovqAiY+Igrag
	dz+PVt9EukoNUYuxpmJDsUlSClvRU+dTQ+7CPIGrstszJvbpW47SS2L65Dp2XXI+dimfYlextSN
	nUj7Cx4BaK4+2bLD2SwmyzFJi4h8tNi3oOtwmJEhlUi9crEiuJDyFIVj54SUi5QET/1QMKjawSn
	52+JmLQ9L6omSJr+W0mnqM4Jn35gY4ksbmKSU28u7gh3BmN7dotkecsbEBR2oPAES9RNcxjBsCU
	N/Edn7ioEWq158nrJPA69g2C/qBasEKEHPpEeOUo/9H7THCFqVY9+eudro71SHQLwv4g6Fy04b1
	TN1zHQiCxfQ5D1S3+P+vsRMJIZGkZBWLg=
X-Received: by 2002:a17:90b:43:b0:368:a27f:9083 with SMTP id 98e67ed59e1d1-370eee02480mr23604151a91.7.1781063351457;
        Tue, 09 Jun 2026 20:49:11 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6d013c9dsm21839143a91.8.2026.06.09.20.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 20:49:10 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] mmc: vub300: fix use-after-free on probe failure
Date: Wed, 10 Jun 2026 11:49:03 +0800
Message-ID: <20260610034904.1596521-1-lgs201920130244@gmail.com>
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

Fixes: 8f4d20a71022 ("mmc: vub300: fix use-after-free on disconnect")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
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

