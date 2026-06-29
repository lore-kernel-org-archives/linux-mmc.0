Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048DA3F8EA1
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723331; cv=none; b=t8aZ3gqGHS0+itpYssM8uV7UId9u/fFE8jqtejVUQ7VWVuWCjukiGLizGJL/VkkhCdVRsFKIC2vMgvUfnxG9V/kotOkjT1suf+HaLyCpWRg0ZXr1fFX1ks1KdBBf0NHp2iQyu4BqwC1RtQIxk9e84YiMmxb5xgcyYk/0HVOojFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723331; c=relaxed/simple;
	bh=Q5Wxi0COcXv/gy+y0D0pXiE5Pb3m9E8JU2uB4atickw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZzGTKCptQ+MFrzVm+8+AReouFqPi4EnuNLdISMxa9faa9DlnFTiszXaIAHvDqtd9I32G4DSaCjgKU4O8s9oaqS0DJxgw+Z2sAQIj44Mk6InzXi21O6VmeUhuqbeQWtt/qPKJy2GUKh3i5zSJqLOVsW9nkeJJ25132V7aCAIbqv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gtV2aL4F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KAcVGx79; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gtV2aL4F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KAcVGx79"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T7DqmN2188734
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4BGE4mxzpnz+OGxMlb54QsPRqPzv5icpmnSVCakRRL4=; b=gtV2aL4Fz4LX+hTN
	/6NwxrnCWdM+NDO0SF1lVC8rX50YHMG7SNeEQckNKu96PogiLC3h9k3LukSLeYpj
	cX+KIGUoQbqroZCojs52V87NEE5uP28/DtA75oDUqLuqgsSovEONCnRPclFqQNFy
	q8S89vFDTM8gdUPATfPSUXiXIgsfxkBKO3txBVDtCcVKLCcfNpzeCNR4OGjvDLBK
	e6O9jqYaEX0088rI3JAgwT7Ztw6C+yd1Qib3ibfIAIV+/cVt77+BA4k5vz1SKM/g
	xPP2NSZ/AHjSrOYPeHB1bsQQvD31SIsxa4+4qh5R0ZE6ryuH0BDBnNVzEgxLwlGe
	31j9kA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4trdhe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:29 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5bd4b488c10so3665084e0c.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 01:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723328; x=1783328128; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BGE4mxzpnz+OGxMlb54QsPRqPzv5icpmnSVCakRRL4=;
        b=KAcVGx79T7ZUy4531wrr1DA/Td5xk61qZEVGVKjhE9OCfO1Iv6He881v93sUvvY4Dq
         hxO0EMUSbBYPpVPd8OdLIZHYbJxpJQ3vq7ZA3y+UnsVw0FyfrAWpXJWVkI44Pu8oX8Qy
         pg0ow4N9ynHsh10szYPCLuH5qdNeWyi6KX2/VzBhXO9XbqshMbfb+qGRBZtRqJpLdYHR
         20zWYvrLfUWuDBIKYYpy+HZkF1HkhIrBpIV7THG+5FoKMYAJmSv2xYZbSl0KVXyIN7qc
         +SLZLiOhrCGmW28z/vqp3khifRVrzUdgR2bKmd9HPKAwxO4w1iQqFlYMpqYvaR/2i5wZ
         KqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723328; x=1783328128;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4BGE4mxzpnz+OGxMlb54QsPRqPzv5icpmnSVCakRRL4=;
        b=WYJqKUYuXVrmbH32WbfkSM6tN/czOHJU/rUEJgww/686qj1UYB1zHUGLLrvXOHxziW
         ISDWuKfGj13KQXxqfKH+HdThe5jg9jaR0pEO7L+CHAVDPyPvXy9qqj9wmNJypx7jZyoE
         PeGRp2zB7u8tgs6xxVMtOUgtBiZL2Pun+z71lveH9WCh6Z5uWw+qw3aJRv6I+5xbrQmL
         GqqabBeiqA+Bu4CZl78JWrEQ/YKDmf+vliBVRK/pSFYrDODj4yFxOx/1+ZV264Bs+e3p
         bGguGjJaTpAfeCuVsjzjBhr6P7El6YzcY4EyQ4w0e4g7yTsCcDVAXTkQk6u3jJnoY+Zo
         LJiQ==
X-Gm-Message-State: AOJu0YysOAJdZ4TdUTZfDth17WNlbX/NU5Pdx/2WghedsNUb2p1qzlBQ
	SWvdsslbxNOP0KDTjM570CmbhffemXjvHPyFa9KYJPG7LiRmo2nvCZ/dAclCfhXRSEy7A216Ovv
	LpPOD7JbVwn9M6rVjITifeMXGVEB73Om/pn+afVTUGZak9X1R7kGfQog6TcIntzY=
X-Gm-Gg: AfdE7cnPI7E+3EjsNV2HV63DR8rhHM87t/utQHUPMP3Tk/gJ3aks1Fg0ruwBw03GP7X
	iANt2uOHWFoD2LfeHEM44rHry0kVJ/kB3mwiirjivHAe8TlK+8oMJ5mNT/a8RIvAu+M9ceDlHgv
	Vr1v0ZhEoBIY9K2q7XnCK5I8jkBINUZ/77ZVM7lId2/SesYhGTHwUtiMdA38UkDGUiPxEKuGkZh
	3QroP7+n5IbYQeOcXiL6Az9sm0a+Xe6FUBPIdI8j02Gku5Oeo+TkVShCiWpyR6RojXj7YyAotnY
	3h+W5WqEkj6L4L50LffVW3mrmyrPuzXb7uinodtg280zzXD6ebG561/jLlHV7C3S6Gtj5p5OQJ8
	rWYB0PpRb3/3tSQ5PG2WWIPzEWVGSwCClxqJhV226o0/x6RvfN1Z2PieatFN7spD0/eK4kTUsHE
	QLK1AD6bzjBMJrY6+JaNYAgYwpw6NPgDgLNCIgll9g4KKI4LrFq0QCq1jCCBgOrA97igIs3qjej
	iwhNeceNcQM9POmN+vl
X-Received: by 2002:a05:6122:d12:b0:5bd:9d27:1ded with SMTP id 71dfb90a1353d-5bd9d271febmr1874547e0c.3.1782723328215;
        Mon, 29 Jun 2026 01:55:28 -0700 (PDT)
X-Received: by 2002:a05:6122:d12:b0:5bd:9d27:1ded with SMTP id 71dfb90a1353d-5bd9d271febmr1874507e0c.3.1782723327621;
        Mon, 29 Jun 2026 01:55:27 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:20 +0200
Subject: [PATCH v6 1/9] block: partitions: of: Skip child nodes without reg
 property
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com>
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
In-Reply-To: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX9a6THQKtZ4jU
 Xm4l6JeSBSvBgo6xOXpcwAoc+oi0ukCf/oyeKg5qW2GVTZIZgX8y6cdh2oT8eJyqZu06F3R5KoF
 25ljNh+teHwoyVcR1sRB2jsnzcLdRoKmn4msqJqi0taXgFs8C36jeF3aXMvSdEk9bU796tzB093
 oDml2kY0WDj8ZJ91LF39y2vlCHBGIZaFWKjCoZLEX88AztE1oKQph60cX5+5Geo/NGSFcvsMIhq
 AiE4MkczJZPv+BPoYxUGJQ+vEunUedEmRh7jgZbdjzTLo+3Zt/M14sS4AOl6dLnQpaYitfeMdW/
 AwFFiJl+DoEJy7OKx7LtuO6CH1u4glpWnKcJSudSZWFKryQGbrefmxThoitkdyORuSGwW+ocHFw
 94GhOPDfRUJzCjP5mbGVjmc3GV4KiodPg25Kn71AJlH2ZDSChoyNNiV2mAx0g/Cj3w6oTc8ubve
 PGZxBJ6oIjQFtIYHIKQ==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a423301 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Wp80rbrglrcOpQJs44cA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX+gOBrDX6am55
 GtYL+kWKFUq5i1OyE47ebt7I0elHE3heZdCLTKXt+c2xKZ2v/db7hjEHlb76Nc4yzkoMXPAC8+N
 4bZwyhOKCLBk8l6/1IkrNWSegG9DJQI=
X-Proofpoint-ORIG-GUID: P3pJlZPCUl1BZM8bcbGH1w-KeaHMKnbT
X-Proofpoint-GUID: P3pJlZPCUl1BZM8bcbGH1w-KeaHMKnbT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290071

Child nodes of a fixed-partitions node are not necessarily partition
entries, for example an nvmem-layout node has no reg property. The
current code passes a NULL reg pointer and uninitialized len to the
length check, which can result in a kernel panic or silent failure to
register any partitions.

Fix validate_of_partition() to return a skip indicator when no reg
property is present. Guard add_of_partition() with a reg property
check for the same reason.

Fixes: 2e3a191e89f9 ("block: add support for partition table defined in OF")
Cc: stable@vger.kernel.org
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/partitions/of.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/block/partitions/of.c b/block/partitions/of.c
index c22b6066109819c71568f73e8db8833d196b1cf6..534e02a9d85f62611d880af9b302d9fd49aa4d46 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -15,6 +15,10 @@ static int validate_of_partition(struct device_node *np, int slot)
 	int a_cells = of_n_addr_cells(np);
 	int s_cells = of_n_size_cells(np);
 
+	/* Skip nodes without a reg property (e.g. nvmem-layout) */
+	if (!reg)
+		return 1;
+
 	/* Make sure reg len match the expected addr and size cells */
 	if (len / sizeof(*reg) != a_cells + s_cells)
 		return -EINVAL;
@@ -80,14 +84,15 @@ int of_partition(struct parsed_partitions *state)
 	slot = 1;
 	/* Validate parition offset and size */
 	for_each_child_of_node(partitions_np, np) {
-		if (validate_of_partition(np, slot)) {
+		int err = validate_of_partition(np, slot);
+
+		if (err < 0) {
 			of_node_put(np);
 			of_node_put(partitions_np);
-
 			return -1;
 		}
-
-		slot++;
+		if (!err)
+			slot++;
 	}
 
 	slot = 1;
@@ -97,9 +102,10 @@ int of_partition(struct parsed_partitions *state)
 			break;
 		}
 
-		add_of_partition(state, slot, np);
-
-		slot++;
+		if (of_property_present(np, "reg")) {
+			add_of_partition(state, slot, np);
+			slot++;
+		}
 	}
 
 	seq_buf_puts(&state->pp_buf, "\n");

-- 
2.34.1

