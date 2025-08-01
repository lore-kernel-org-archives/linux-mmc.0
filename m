Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BDD1F429C;
	Fri,  1 Aug 2025 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754041527; cv=none; b=JCZSqpbGPBDiZM0QP2tQX6QhmuiK7Tp27UYhIPSQk7l2QoYaMSej9LKlu6rX+Elu/qr3M6m4ZG0ykUe6QH6Q/YKfF2NkbtFYWxj80RUhL6HmuoA1/wcQJoVQexpLGGHs2vDxfgEhVwF23Mc+lfWt2s+YB8MEQJDjr6e+VGzUJBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754041527; c=relaxed/simple;
	bh=KcfImWe2ntjQGDLAHqEzuW4roK41FAxxJvrp+z88SKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LpDJmdahNhXD2kmcjxef+UIS/VdXxdJHLGDjuv9U9pHo7yr8Hg9Z0M7F1P9NKHhlhSZkAiWqx410BjjmOsekUdPQ3qjmsxQgPlq9DdnuHzEA0IAQiD++EY/4JLQ9nsAXXBwFbeTxa2V0Qnh5BqGFie3W4QSMmYOUfk1KffzdrUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 35293e966ebc11f0b29709d653e92f7d-20250801
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:ca5dd5f4-92d7-4c45-b2d7-7cf99f183c14,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:8ece0e5e0af63e6f711ca3f2e1c044df,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 35293e966ebc11f0b29709d653e92f7d-20250801
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <lijiayi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 613529967; Fri, 01 Aug 2025 17:45:07 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 20842160038C1;
	Fri,  1 Aug 2025 17:45:07 +0800 (CST)
X-ns-mid: postfix-688C8CA2-9711391225
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id CA7A2160038C0;
	Fri,  1 Aug 2025 09:45:04 +0000 (UTC)
From: Jiayi Li <lijiayi@kylinos.cn>
To: maximlevitsky@gmail.com
Cc: gregkh@linuxfoundation.org,
	kai.heng.feng@canonical.com,
	oakad@yahoo.com,
	ulf.hansson@linaro.org,
	luoqiu@kylinsec.com.cn,
	viro@zeniv.linux.org.uk,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiayi_dec@163.com,
	Jiayi Li <lijiayi@kylinos.cn>
Subject: [PATCH] memstick: Fix deadlock by moving removing flag earlier
Date: Fri,  1 Aug 2025 17:44:59 +0800
Message-ID: <20250801094459.318184-1-lijiayi@kylinos.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The existing memstick core patch: commit 62c59a8786e6 ("memstick: Skip
allocating card when removing host") sets host->removing in
memstick_remove_host(),but still exists a critical time window where
memstick_check can run after host->eject is set but before removing is se=
t.

In the rtsx_usb_ms driver, the problematic sequence is:

rtsx_usb_ms_drv_remove:          memstick_check:
  host->eject =3D true
  cancel_work_sync(handle_req)     if(!host->removing)
  ...                              memstick_alloc_card()
                                     memstick_set_rw_addr()
                                       memstick_new_req()
                                         rtsx_usb_ms_request()
                                           if(!host->eject)
                                           skip schedule_work
                                       wait_for_completion()
  memstick_remove_host:                [blocks indefinitely]
    host->removing =3D true
    flush_workqueue()
    [block]

1. rtsx_usb_ms_drv_remove sets host->eject =3D true
2. cancel_work_sync(&host->handle_req) runs
3. memstick_check work may be executed here <-- danger window
4. memstick_remove_host sets removing =3D 1

During this window (step 3), memstick_check calls memstick_alloc_card,
which may indefinitely waiting for mrq_complete completion that will
never occur because rtsx_usb_ms_request sees eject=3Dtrue and skips
scheduling work, memstick_set_rw_addr waits forever for completion.

This causes a deadlock when memstick_remove_host tries to flush_workqueue=
,
waiting for memstick_check to complete, while memstick_check is blocked
waiting for mrq_complete completion.

Fix this by setting removing=3Dtrue at the start of rtsx_usb_ms_drv_remov=
e,
before any work cancellation. This ensures memstick_check will see the
removing flag immediately and exit early, avoiding the deadlock.

Fixes: 62c59a8786e6 ("memstick: Skip allocating card when removing host")
Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>
---
 drivers/memstick/core/memstick.c    | 1 -
 drivers/memstick/host/rtsx_usb_ms.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/mem=
stick.c
index 043b9ec756ff..95e65f4958f2 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -555,7 +555,6 @@ EXPORT_SYMBOL(memstick_add_host);
  */
 void memstick_remove_host(struct memstick_host *host)
 {
-	host->removing =3D 1;
 	flush_workqueue(workqueue);
 	mutex_lock(&host->lock);
 	if (host->card)
diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/=
rtsx_usb_ms.c
index 3878136227e4..5b5e9354fb2e 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -812,6 +812,7 @@ static void rtsx_usb_ms_drv_remove(struct platform_de=
vice *pdev)
 	int err;
=20
 	host->eject =3D true;
+	msh->removing =3D true;
 	cancel_work_sync(&host->handle_req);
 	cancel_delayed_work_sync(&host->poll_card);
=20
--=20
2.47.1

