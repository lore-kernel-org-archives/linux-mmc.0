Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5473B28A1F1
	for <linux-mmc@vger.kernel.org>; Wed,  7 May 2025 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625546; cv=none; b=KbJm7QY+nGp25L58T+QLYnF0spXYZ4Hb1AAmju0f8zpjYYJbxwGiRD/dUR3AtD09wrOE8Fi4mqYby0y0IsXHC6kQK0wiKeYFcWtzE9H00oyMzeB+TdUPsc6FBdQxPctACx0nA0qEPO6wtq6sqbxeID8Zn1kfhs2vHjBM/qftSaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625546; c=relaxed/simple;
	bh=BoCMbvYbXwuYaIYa2ZOI/4SahlZTKyBaSej4Y5/WAf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HL/J66sKMH/iCen/ngUVkoTuVG5JHc7SpzKc+7HyFEhHd3jq3jel66TUbjMUn80K6aiGYD8HM7+pCkotxzo/KVl3cl6LO1me3r4qo7dHXOoZyOeN/9xUBOgLWUSNGZCjvw3e0cZiVBm9/Hof1SPrpSz2jIcupO6UDvEFBWMIICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b+hlZn55; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b+hlZn55"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547BDbtU018998
	for <linux-mmc@vger.kernel.org>; Wed, 7 May 2025 13:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ekMVttPxZhF3qKOXPn1wRm9Cn868fnvIjZd
	+AcUwsOE=; b=b+hlZn55K2mCggA1RsjuMWwQI1kX3hFu2KV9dvOxz8tCNL+yfi6
	GY1v2sBZ0pRBT5aN3xYu03jfd45WfqI+TcsfJptde1rSl74dw/ju6OfM4856C3hm
	7bMsCm1xpCIilw3F6hdx96y5VEE5MmMZqvvIsPXgE/IPm8fVfnng76GT0UsVAom9
	cuPl7G8b4YDtzk4icE4I0pg/7wAnZpHjavmjM3p35XeniY8xXfKClQMaD9njKj7k
	QVLU3Mv+QECAemE+KCP6HRs4WGxcOk0qCZhuz2NQBn9DoqN2eg8byU6VBVWMMCXM
	Bv5FumAYcQiwa77U843vzDgVo+lzoMV/5aw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5wg5t1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 07 May 2025 13:45:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5bb68b386so1476161885a.3
        for <linux-mmc@vger.kernel.org>; Wed, 07 May 2025 06:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746625542; x=1747230342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ekMVttPxZhF3qKOXPn1wRm9Cn868fnvIjZd+AcUwsOE=;
        b=kgJPmBQZGPG5q9kj9X9oc4UR0z+FyXGGwLAyFgVoswu7AiYIP+KkGGhEaA9anOqGGc
         QZukcVW4UlCiAjsq2XJmJRnvWeT+qFnE6LehMVUNcznISOTl3ffFVyo1m8z2U+d+qNqI
         rCsETEas0Oakv+6S2zZx+wYdAbn7Vc7yf65gimxvcinZAzShPLhftm9t4HYHPjkNPWiF
         bVS25v5XPByjf/T02m/z8F1g1hQe7vrrjU15keUZP1YXoaev3iutpEPxYAi0vc5zkcaG
         XdFZ5CrrBIC1c9EtNJrg0+aIfPMOAoVhTjk77YP3U3fzzOcKOEWumbQnMzo6GVtZamFQ
         Uisg==
X-Gm-Message-State: AOJu0Yx+IdtPuzRUs+f+us00vuPgmXw2lbVx1g0bdDqOTGsIVIQE0cf0
	vYZITLnvaGYJjFxUPV1OTdRvgdTH07EgZ1JOicIe2kehedKMWLsRyKJi5oFqIR6E/bszynERBAZ
	3p5Yh0Q+gKr9nGhouRUrX/1y6oMQth9u3a4AIgN9jmBq2Fdy+aG+sxDoaT892rUd24TA=
X-Gm-Gg: ASbGncvB2eGZ6AzW3iDO7lTQLJqK+BEiYLUhSbshYXNurcKIhYfF3Th+Cc5mtWSfax1
	VkN8C5wyTFzPDk7Xs/h2OMIGDK+dug1LMNs8CynwZ26jAJalF2v3YrcsT6RCzQ8xhX/s6I4dmb/
	jZfZ2RpXQIoJQGA0STutLpmOh1rPNql9ksaS/fh4LEum1ktFsdWtpkc+e1At6Ym6QtfR0AuQ3aL
	lfLOdry5qJgcx1knEQVvMwURZ/hy0PVWgFfL6FZ1EiAoCrfsbKjXRs3TWl++Jp7KHsJLbvies6i
	mi4Vigr19LG/Og8r14DOmxX8Loz5QA47vx79rG798Ns1+0w=
X-Received: by 2002:a05:620a:29c3:b0:7c5:4a3a:bc12 with SMTP id af79cd13be357-7caf73b6e3cmr447826285a.32.1746625542051;
        Wed, 07 May 2025 06:45:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgntQJqihX/3S90sJz0Z20c+FXMMVIa4OEFZDcjdikJn7ZV4YGqvJN6CfN4oGzZ2qGw+db7Q==
X-Received: by 2002:a05:620a:29c3:b0:7c5:4a3a:bc12 with SMTP id af79cd13be357-7caf73b6e3cmr447820285a.32.1746625541399;
        Wed, 07 May 2025 06:45:41 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.qualcomm.com ([2a01:e0a:82c:5f0:3443:8288:a61c:5a62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891478fasm907795566b.26.2025.05.07.06.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:45:40 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH] mmc: card: Scan the eMMC boot areas for partition table
Date: Wed,  7 May 2025 15:45:38 +0200
Message-Id: <20250507134538.575912-1-loic.poulain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: c8RsCmQoGx9mUx-1ZibFDdPdif2XG7mu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEyOSBTYWx0ZWRfXz6wPSpo28mpE
 SuJ5bdHhRUejN3lraC5Yib+PdqEP2HesPFvN6EzBhGe3eWyjrdgfoY4Y3QIxuCY+z9UQ4YzkufC
 p2J3BNIcvL5GI0bRfTAZUklpjBjVpa08ErMv8MgeYtRkw0s0jEwPFVUVrhIccjxSIzyJc1jSV0r
 xfQd45kxMnH+LWA7TZw93ySu461PnlhncM2U1YyydOkgg7NzYjuVGCSaDorlQrHxWjdlfgXe2fa
 1ezqP1O9Ef5jXX9xVi5vOFQfJs67DcDrkajZeSwHjn8ikFa2U2YYxvutOiwh5SjQ2tCxNdBx8DT
 whHtx7tzWzriQmg1wViAqv7x0xHfO8LXh8GavvUz3ZI36HIQ37reskLKrU1s49UHnhWN1Kunxbe
 pexqdAZtESYTbNiiIrzeEl0LV0cckn3B/umChxfTqHOivLOXscVdYkJdr8xPaPm7i4VH5EF3
X-Authority-Analysis: v=2.4 cv=dPemmPZb c=1 sm=1 tr=0 ts=681b6406 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=QcRrIoSkKhIA:10 a=EUspDBNiAAAA:8 a=8lD3FDYNz6pvFhpMkT0A:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: c8RsCmQoGx9mUx-1ZibFDdPdif2XG7mu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_04,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070129

It appears that some vendors provision the boot areas with valid part
tables (GPT) in order to have identifiable partitions for device and
firmware specific data, such has the qualcomm CDT (Qualcomm Config
Data Table). Additionally, these boot areas can be utilized to host
device-specific IDs, calibration data, and other critical information.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 4830628510e6..c81925194509 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2655,7 +2655,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	md->disk->private_data = md;
 	md->parent = parent;
 	set_disk_ro(md->disk, md->read_only || default_ro);
-	if (area_type & (MMC_BLK_DATA_AREA_RPMB | MMC_BLK_DATA_AREA_BOOT))
+	if (area_type & MMC_BLK_DATA_AREA_RPMB)
 		md->disk->flags |= GENHD_FL_NO_PART;
 
 	/*
-- 
2.34.1

