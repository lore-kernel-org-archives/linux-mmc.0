Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE03D9DD7
	for <linux-mmc@vger.kernel.org>; Fri,  3 Jul 2026 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086333; cv=none; b=B34scs9S3l14Biu8oK2D2AH2BsYWeLssSOkK6qtyqM3TwDVgwfSaOpGRCsC0YPxpDkU/m/1yQoRsqLt15Rctw/Z3Pw0VLaNVZmbrnBbtZ5TbUtZqV5NJCYp3Yckj+do1WzNJQjjd4YLe9T/rz55S6KVOWygEyR/RuxN+ilc5/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086333; c=relaxed/simple;
	bh=zkO7UGTBhc0abSbmAA7xbPJx3KQa3FMC3+fWJRmAgxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0tv+Eqcw7r+2nRfA2cSNS76FlZdteTOSAOJt/bfRRktYFYNCfnRrfUEFA2BJ7XBZbP1Rvog46jpO0Vzh70Jm6SkFxaWv9yQekTOiBQBqBlY6/RLQNpofXvdED2BG1FemYqd6gkG+99E7qpLECvooqwSG/1jAOKLFmn+ql7NFRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z3c7nV1P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YG86y5To; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z3c7nV1P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YG86y5To"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663B04bi3108915
	for <linux-mmc@vger.kernel.org>; Fri, 3 Jul 2026 13:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=; b=Z3c7nV1PTRoHjP9Y
	N8NDqCV0gtQJFr0W6O1wUDef4OW1eTa7rUWJcI+L3YuZPAYrKIcWudhVKzTJqrJZ
	eb8HX8BJlDfPhqHG2jSC/hXQilE0PXXKmZ/EXQukwgOqzO7ShYU5tnZ9sGpb5/lD
	7nQTCQR4TcNLAguTL9DWCbTEh0LP/73+RhvONYTPVoYavquvmBeDzrHwrI6hcJqC
	GmOV22R4aAteWaxzLt8ZOebOd031WA5/81BkzbBNFt/yQnXsvV37lXp+vd7Dc9me
	M/Bixtazx6p0hww+H1DWI4pq7M76d95uIY0eGBfVH2w/mfeJPD8nzdIBx4LRNVld
	RJCFBQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eyba9h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 13:45:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e695a3b28so178346185a.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jul 2026 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086331; x=1783691131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=;
        b=YG86y5To+FO2Rv/VMacw7djrQ/2lb8pPNYpBbtK4IEjIK8N3JHJ5JXQlA1eTK1SNuO
         7NQzEY58U9JJmpZcQqipAVNQKGdWr5JaOEZkfu48PKhB6xW5Sc6ICmMrITEzK0KHrZbK
         RpRpZBM/4E/gbCXt+c80sxg/yQKn9VhFc0LUWPHJKMQFo1DtINl2Wt2bL0DVj5KXMfpq
         HtwducqowYCKv+repivOuhGH//2k5c4C6ufuQzu+AD7vFmaWYbjY21xDyV7kKeKl8V/U
         uC1syAzQ9gVEbsYDBhYpf4K3hf1OiVrphM3yMaUSGBcAGxAfac0rA6xGMKMaZ3vWGVTE
         JqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086331; x=1783691131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=;
        b=mlYchKL1e0qHdNiltmxqGdgUQ1/2G5Pby5VOXlm0XkIeX6WVEXiI/1Q9jeeoV70QWj
         OrpsCR4z0GBr4BOFDmp7nOYFmJ/L74IFibraYa4jOYjagWybrVW30CYM2m4MbJE9AFTQ
         QbSGg6QaoNAW3AH+BkfJn7Hl1Tozcs9ngAim511c0fsVKd0vNoVREoXN+QckWBLngMAK
         5xESFkMd+2mWJt4TM8RNNbHMoMu1qVIse8fmk/aSgv9s+hHqLTkhUICvPmKnIswwo4x2
         e5nEbUxCOhPG5m5mliTCbgrdtfVwjQGsOZQFFuEsrbRyPIlay1fTaHxcjeGYj3LaTw9c
         IeLg==
X-Gm-Message-State: AOJu0Yy+cjZZgCRCzuOC9pN7Er6d6efphCizzo+A9JpREg0solxy5G83
	LUWKcfTa9WvkkzwVjv/OBGadRAm353dkQXqBiaLVVQobln5r/ct/SRnXM37U5x+7AK4SQiqInN+
	XY+kYiwLiOlpI3xTD5tYONesY+Tl1Qt7tQZyh5qaOg4TPP8/MB8WWCtJnJnAgRXg=
X-Gm-Gg: AfdE7clXczafaTFYhvMung80zaMIYS2GayiQiLM/lb+6dC1FlABUHEEPxVUGobf88xl
	FbPHqEr3+SNvz8RtVM0SU0P8qdiwiTi5nm1LQ+0drplNIcsbS1FlOPNB9Y6xSOSs0KikekZUfl/
	qL/u13s7n2CTiVGqrwcwSHmtYsNNEbfg2pf2GUAMDY44vkiL6szoimH1k+tXw055Ci960lJfqTh
	jpUSh61fcHKpKeIk4qpYWfQ+nstllZhXF6ctZomzoZ9BLchnTwdXfAkkCQ81XpEMJ+/2NnCBKRd
	ITdtpRLsjxJAaXZfzHqnstc3DF3jC44kCDrWhRvHQ9lvnchJB1UGBRUZW1uEofn80X4TQZvWdld
	wI/uNS04N7JHmTvdDHXfg3W+gZhlXhHjYANggteBizxT5FrYU0BrsjFK4hNFV5CBygAgxACuOvl
	enUH131KLT+5zgGWjfZ+zy5kvNSr23bm/x2+zCZfzBsfTgUdINU7TtGnAvoOGznuQ=
X-Received: by 2002:a05:620a:7007:b0:916:5f5:de22 with SMTP id af79cd13be357-92e8b29ea54mr485348285a.12.1783086330570;
        Fri, 03 Jul 2026 06:45:30 -0700 (PDT)
X-Received: by 2002:a05:620a:7007:b0:916:5f5:de22 with SMTP id af79cd13be357-92e8b29ea54mr485340685a.12.1783086329977;
        Fri, 03 Jul 2026 06:45:29 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:29 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:17 +0200
Subject: [PATCH v8 4/9] nvmem: layouts: Support fixed-layout as the nvmem
 device node itself
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-4-98ae32bfc49a@oss.qualcomm.com>
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
In-Reply-To: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX8bY9A6WnWfCn
 5LVvThFgWPtq7g38u7xNzQh56Vok3/BP28eIPr7WxYZz/fpIfXU424CB8TZGUUH3c4Pun8cgX8t
 6FL58t8qhoiCTKCR6052ior+vubCcL6sIq55UlpPq2Vrfv4eSkBisXgNiEdxnhuTCmi1rfqpXEO
 FJIobQsU2UflWjgKplBqi9139Xo5LXWyW+AsBs+ygkGks7NIYs+sG1wvnbZPCSIYeSmI1ERpWAo
 ViJhFbEJs/aA4FVyuzYBqwI/2S305/LpyFf0FB2JpYZk7tsE4+2dkz8455zy5qBJJoWSjy/1Qiz
 Be2TRPGOXkBmf/QmjIPC9grbrT+q8O3sgFZAzxV3p2IeVgYOjZT3WBQwR1lpZyAoW7gmsnoadHf
 h1S0m+mmbjfLL6m2KMR3R0AYS4UUE6YmMoHoeU0PGo6kJKPJ8o4OexyHvmRj0ImcFsENytb26tW
 DhmuhKgKiHN6s/LIUFg==
X-Proofpoint-GUID: S1iI-kVej79LoQ2nexJPcpERkpGLsPCY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX3mNrHDHfl78O
 29OfJIcdepqAKqXs3LgUSBg1iH1h/pjre4tTVKxeWW7Ij8lK/2eZboFnqujGod8q0OZwp7SkaSu
 Rrb4rTqCxhxvfpJ53V17NWP71p7LfQM=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47bcfb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=4SYEPDBQci7QR0ImIkAA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: S1iI-kVej79LoQ2nexJPcpERkpGLsPCY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135

of_nvmem_layout_get_container() only looks for a child node named
"nvmem-layout" to locate the cell definitions. This does not cover
providers whose device tree node is itself the fixed-layout container,
such as an eMMC boot partition block device whose fwnode points directly
at a "fixed-layout" compatible partitions node.

When no "nvmem-layout" child is present, fall back to returning the nvmem
device node itself if it is compatible with "fixed-layout", so that its
cells are parsed by nvmem_add_cells_from_fixed_layout().

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/nvmem/layouts.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index b90584e1b99eab4217cbe7ec48373e18a7caf0dc..efa631ce7283bdd6c8ecda75915911b5e3a33c99 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -167,7 +167,18 @@ static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
 
 struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
 {
-	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	struct device_node *np;
+
+	/* Search for nvmem-layout child */
+	np = of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	if (np)
+		return np;
+
+	/* The nvmem of_node is itself a fixed-layout node */
+	if (of_device_is_compatible(nvmem->dev.of_node, "fixed-layout"))
+		return of_node_get(nvmem->dev.of_node);
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
 

-- 
2.34.1

