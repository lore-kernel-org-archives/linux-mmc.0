Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93B25776;
	Mon,  4 Aug 2025 02:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754275732; cv=none; b=Jqu0TFVFeos6mH2KxGeOv7gDI6fH+zSiiA37fU4psenR7WRFRvkBKu5/2CMj2o1Yf4eWl/eIgxukMnFxSYPW5ct0h/9YbqePMccyDk3aZrv63xbttAf3YwmDyRX6vsIe3wYKgMXRdjrweHvJuWJmLk3ajfE2QIiACNxYo06Fcto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754275732; c=relaxed/simple;
	bh=kcUryOuv1VuSTCu2lee1btEOF3MPZYA1WnJ2mmVutoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YwbukmtW4SoCO2+xFWhytWFvEn2lSkbsxfFV1T+tvgE3AenVHgGhlx1X1j/1JCG++9nl/0uJF63khrRTJvqv0b3iFBQd3d/JSsCFbaLzpwl+hmdB/FXlV3Y69dM7V3X+6SDEWLr+3TvNPdxIvAj/jlqVpYdz/Tldmp85y94WNwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 869ac3da70dd11f0b29709d653e92f7d-20250804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:9797b32f-e724-4445-9598-d91e21db278e,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:6493067,CLOUDID:7da665495432d8b0b545f4f2f174ee25,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:2,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 869ac3da70dd11f0b29709d653e92f7d-20250804
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <lijiayi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 908476407; Mon, 04 Aug 2025 10:48:39 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id DD9C316001A03;
	Mon,  4 Aug 2025 10:48:38 +0800 (CST)
X-ns-mid: postfix-68901F86-759240832
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id 0AC1316001A01;
	Mon,  4 Aug 2025 02:48:31 +0000 (UTC)
From: Jiayi Li <lijiayi@kylinos.cn>
To: ulf.hansson@linaro.org
Cc: gregkh@linuxfoundation.org,
	kai.heng.feng@canonical.com,
	oakad@yahoo.com,
	maximlevitsky@gmail.com,
	luoqiu@kylinsec.com.cn,
	viro@zeniv.linux.org.uk,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiayi_dec@163.com,
	Jiayi Li <lijiayi@kylinos.cn>
Subject: [PATCH] memstick: Add timeout to prevent indefinite waiting
Date: Mon,  4 Aug 2025 10:48:25 +0800
Message-ID: <20250804024825.1565078-1-lijiayi@kylinos.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add timeout handling to wait_for_completion calls in memstick_set_rw_addr=
()
and memstick_alloc_card() to prevent indefinite blocking in case of
hardware or communication failures.

Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>
---
 drivers/memstick/core/memstick.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/mem=
stick.c
index 95e65f4958f2..3eeb93b51f80 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -370,7 +370,9 @@ int memstick_set_rw_addr(struct memstick_dev *card)
 {
 	card->next_request =3D h_memstick_set_rw_addr;
 	memstick_new_req(card->host);
-	wait_for_completion(&card->mrq_complete);
+	if (!wait_for_completion_timeout(&card->mrq_complete,
+			msecs_to_jiffies(500)))
+		card->current_mrq.error =3D -ETIMEDOUT;
=20
 	return card->current_mrq.error;
 }
@@ -404,7 +406,9 @@ static struct memstick_dev *memstick_alloc_card(struc=
t memstick_host *host)
=20
 		card->next_request =3D h_memstick_read_dev_id;
 		memstick_new_req(host);
-		wait_for_completion(&card->mrq_complete);
+		if (!wait_for_completion_timeout(&card->mrq_complete,
+				msecs_to_jiffies(500)))
+			card->current_mrq.error =3D -ETIMEDOUT;
=20
 		if (card->current_mrq.error)
 			goto err_out;
--=20
2.47.1

