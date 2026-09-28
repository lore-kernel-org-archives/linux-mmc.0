Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF79532B113
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610725; cv=none; b=tYiY8IryJeeJQhyOLTqwfsprx4mKKKVq+2fjgpzPv2u8m22WuKpTJ+Q0Krr3VtN9FJrBMlPzs55glLpqpmsTVKM594+uG4CpuFgE2/u/mH5ohjND0SGmyY8ZTalKWogxz8eDwtxLGKrrsV4k9gp5rIOypZTyLroL6jDwoEGuP5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610725; c=relaxed/simple;
	bh=zmQ+cGSdLK7YhG4R1i+dzG2u52GR9O6BViCki2jfEGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxiTj9X+BUzUC3fjk03uHufRwIwB6Qy6i8EbD56UtRf1I6Z6fD3D5LXIz2DeWclOg9zxijql7HUh0H+O3HzeHDQZXoD0O0/9R5OI8odTvPNmUPJtOFihVOWj+HDifpT/ud09oMmFesbbhlVgV7Uvgju87DbSgramXzCcLwhMIBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ST8MG4CD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A058ra4r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ST8MG4CD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A058ra4r"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEdxi92863983
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 15:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=T0AF+DcWWCvi8THZVLIS8nXBQEPcNEV+6AF
	+JHgsS9o=; b=ST8MG4CD0L5RBv5oT1KamUJvvBGvHgYTCmLOTFqFp3ZglsL3QJo
	QfshErlB6d+BeY7ZLTJjJjkoU+28E4TsDWpgXtbr/Z5rEYbdBzh846Rm0vDp5ulk
	MZWuAVcZWUKQtjH04rMfd9TqwcexcebtgHzFshf5VSAzul80efRd0yZA7KmpzS+w
	XNNjXTCbAc/puOZqx2IyB0OBzB59ww/pMY7SmrPHKnD7DejD+eD8DOsxJi53OK6y
	7873dyCTrSzaI7sN84QLkJGxPEhrom2lTTLOfyFfSDMrXaJ183iZlUyImU3xr87I
	2dN2fQTuiYltUP+HeslvXYTO4YKLWnf6dDw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj6t2aj4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 15:52:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a082c014aso640108885a.0
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 08:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790610722; x=1791215522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T0AF+DcWWCvi8THZVLIS8nXBQEPcNEV+6AF+JHgsS9o=;
        b=A058ra4rB07k+xpz/bBKJqaeEqiV4adgtodVnbxv7m4/pRIAfbByBEW1TtFY4VyoJL
         Nr+abYYqgYGUuxyiCdu2KXJz1055i3hJsjByeBvVIUZ4Hvb8FFk3YAVG2RqF7q4ea8eh
         +b4VIl4Picf39zltXA+5KImCxkswbPWWa1+Ifl8NMQUE8A9LPN11LuTAIfDv0Ko/K4Yp
         qEAOgFEYNbhRX4IPvg/aa2aBKcVutXUDzLzQ1tLslrQZDUS0BMvM5IBUvEPN+BjxPMzY
         oi6Y8MQrwvlMfQ2wcl67K3ag1I0T2R5clbMtzGS/0hMAaeQhKxJlwojvy8Ei3Ye9BwQb
         AzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610722; x=1791215522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T0AF+DcWWCvi8THZVLIS8nXBQEPcNEV+6AF+JHgsS9o=;
        b=qafi5/54H4/z2Iu2bTP6a2gVc3memIakEy36vYSP04+zREUN2mBmp4OVlBCDxp/PSS
         wvM+RtXERPcOsKiXCflzBZbn48eQo5q0XF8endBOztRypT18n6zcIWVhGnp+WiUPzHZQ
         f+ytlhsNspLXfKQ0J7rVbJn0IREsHUqvPJMFYVu77Z0lgetvyMue+voP/wEVfoFbVkLl
         ZHjsibz6UARWfmvxfY2IRt5t06wrLmrcXeFLDIHk0jIP/KbTbnfT3SsuU1zXX5At+T87
         wB94K6hCSDJPqxA1fH8WP0Nz3ggdL++nCQh83aQQks0AhHwIa/FwH8prwcW06l2tUVjY
         xC4w==
X-Gm-Message-State: AFuF++nawRXWiNN2K0KGCDFhSn79O0xw5+VLqbdyTAsWwXKmkA8Sv55l
	m19QtyJi5zJx3H9qRju/V84odVwAzkiVpXAeK+qgu+RKbvqFc3kQ0Pxd4K7Fdf2Qo9PE7931rro
	y9Sm+ShlnpNLAwil22cTZJOSjbyE1CaxIYzLxyIBG/PxtGWCaq+P5eRQ4jZFpe2alI0BYwiI=
X-Gm-Gg: AYBFou0k11SQNgsPOoZEooNM3iFXdkqYUN/nfePnm7Z1xWxxDUGrXBMpe+8ZaXAE03z
	zEF7kaF1JXlm7YFTlptOG4o/YhjfMkDx/IyZ66Yz+TenME+nh0ahW2BF5akeNcNlrIe+YeWecJm
	euFHsPyrBWoXuBW7+Ls5f4PstIiSXPsALYUt2EdqveimBJ5Vf19OWuednqzmPr6yIwBUVEJxkCb
	pwOY7gYHA7mPkArZQpDdv4j2XDiPuJu8fgV2s6ngTxlB2PNoqLQbcC86dniGht9scxB99Naoy9Y
	6Ktdj2nXSdgGOaSVwyIb3A4Hk6Q8oVCcLB8kvLmZEgixFY8F9heiUXe/KQ4ICtTzKqBCpUHfiKG
	fAOU+ePf/IYQeKVIuUyZZPpr1ELqtvDe5+AEkbR6jLcFxf5DXh9C2Oc4Ejw==
X-Received: by 2002:a05:620a:488d:b0:93a:1196:ce5 with SMTP id af79cd13be357-93c43db73demr1950338585a.33.1790610721876;
        Mon, 28 Sep 2026 08:52:01 -0700 (PDT)
X-Received: by 2002:a05:620a:488d:b0:93a:1196:ce5 with SMTP id af79cd13be357-93c43db73demr1950333185a.33.1790610721258;
        Mon, 28 Sep 2026 08:52:01 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc3e12208sm282175166b.42.2026.09.28.08.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:51:58 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Cc: Robert Richter <rric@kernel.org>, Guangshuo Li <lgs201920130244@gmail.com>,
        linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: [PATCH] mmc: cavium-thunderx: Drop redundant calls to get|put_device()
Date: Mon, 28 Sep 2026 17:51:48 +0200
Message-ID: <20260928155149.134516-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MyBTYWx0ZWRfX7ps1ZUgZXUXs
 yUjWIKUIbVS089yolcFHtoy7ABPJt9gx9YQidMPyxuTL28m+aFDlRKoj3qYnjv7LvrShGzPWNaP
 cEAmvYKy6dU6ii7tkA+rPd00nsETN772RiaGVnFE0hJvGe39hSsZX+2q25xTPNASLUSl6xFhvC2
 p6DcNBZ7GPgg11MSV65ERj4wvvDQKqT4MZzCkkPyq+boNmC5jeWLM4KSs1kRr4mxm2QA+a/BMaM
 NTtjlnOqspuI1j0hTOMwzZ9vEzG9bjhU5JP2kXOuuMcn7xjyzrla3nqLHGj5fU+LMAETILumCyE
 wo3A9rbZQbJW5MHppQ8/Ju+dm9ZTuX0gv6J8r+TCZs+iZdpdeOJdEEEgPKyWrVI3qDrqpUHJ1hA
 a+xK3847rm3kExHUSeQlu2dnwV8wPgRTw+UPT+xDzW2zqOwUSeDXJCZUhSduohxhw13uyJa4b5H
 dL2rnSYlXhx+RDIaaMA==
X-Proofpoint-ORIG-GUID: epT481Bdxd1_yZpN_qUo4M8Q5y_UtkKk
X-Authority-Analysis: v=2.4 cv=dZkVTnXe c=1 sm=1 tr=0 ts=6aba8d22 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=gW215rox_sT49jLpqXsA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: epT481Bdxd1_yZpN_qUo4M8Q5y_UtkKk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MyBTYWx0ZWRfX74SCki5k81tk
 9PjmEegJoPiRxMigogabV8Gs8Bg5tccv9i8xaSjf4dq5hmfsm4yOewoEDIA9TSatmTUH4HMpDhL
 jHtZ+X/RxQtvtPq6X7dvPsqsQXj18oo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280063

Since commit 522811e944ed ("of: platform: stop accessing invalid dev in
of_platform_device_destroy"), there is no need to take a reference for the
device before calling of_platform_device_destroy(), hence let's drop this.

Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
---
 drivers/mmc/host/cavium-thunderx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
index 84ff6d82ae3c..eecac003e546 100644
--- a/drivers/mmc/host/cavium-thunderx.c
+++ b/drivers/mmc/host/cavium-thunderx.c
@@ -157,11 +157,8 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 	for (i = 0; i < CAVIUM_MAX_MMC; i++) {
 		if (host->slot[i])
 			cvm_mmc_of_slot_remove(host->slot[i]);
-		if (host->slot_pdev[i]) {
-			get_device(&host->slot_pdev[i]->dev);
+		if (host->slot_pdev[i])
 			of_platform_device_destroy(&host->slot_pdev[i]->dev, NULL);
-			put_device(&host->slot_pdev[i]->dev);
-		}
 	}
 	clk_disable_unprepare(host->clk);
 	return ret;
-- 
2.43.0

