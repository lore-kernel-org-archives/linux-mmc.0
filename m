Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46B6438FF3
	for <linux-mmc@vger.kernel.org>; Tue, 28 Apr 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386221; cv=none; b=WiPH0Vs7z6IjJDGFPwWooxRq7fk2a3KG6IQsS3UFnCrWJADEJb369NMcdtx5jF3m7+XOIEByGId9bmpQBYFM3Bb3XzbSf71kyvk0ybxZeLNJwDCfbO3OHgGDI0IunEEz4+okTjNLWFFIS45Gdonr8sfXZ6dh1qjqSU/uI1VAlBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386221; c=relaxed/simple;
	bh=cLdgwybwmVheaxNq3A4ptASzy5fGo7sa3nM19lVmCQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gSwkqI69M6V1l7JyJusC/ZPEx54RGrKXQCbHzG/HTWzHtcP5xGVrsobvF2Gjfau/1I9YiifH+n0je6iWY+zWBL1EVSJkETI3JoZVvwQZCW+jT0gXAyy5PrBj5yO6lw7u3lvYvBX+UTSUnnyr1UVYrIHipe5lTgklkPmrGaeIsHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PQ+wYtuQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=idKfXJl6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PQ+wYtuQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="idKfXJl6"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SDRV3u3968092
	for <linux-mmc@vger.kernel.org>; Tue, 28 Apr 2026 14:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=; b=PQ+wYtuQpw3oPdCo
	Gv/gVuNnwt/v0F9FkMF60jbuMEHY4L14JYQaQUOwHFH1G3xmd8JGROy1iaQc3qCf
	xacYJ5iFZhhEvfINckpnl7pe5XdKIR8RrXz7NmcKQkcfYMsZ8670/KE+i9433HVY
	I3uzks2RvFKVhlkSnnkcQhsQxSe6Dwpsp2xugO+/dXf+pDwjajCKcGCmOEUySDpy
	Q7yvsCalSlXcw5IhBPFHJd69TWdMafW4FPvkDPWc8Wd8Qr/L/Dxn3e4F1h1+zzVp
	2Opc/mqH2z6oKmknDbAJV3AgLHGknJwt8JpiVaaMnqAYbOAWwooOJgnk7FlbifJU
	5umC6g==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtry0hgsj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 28 Apr 2026 14:23:33 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56db02d3ecbso9189543e0c.1
        for <linux-mmc@vger.kernel.org>; Tue, 28 Apr 2026 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386213; x=1777991013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=;
        b=idKfXJl6dS8Zzp7sfP2ChRmhq51ljHlNA9yqsinQs464iNOepLrcyvtY2x+R/2fAIJ
         phjga98Pt+GpAI0TR5gTgQbkAYfScQJ2vhRxhPKQvjT32g7quORhZfB5yxAkRUQSNbqk
         Peg4thCXJf2IZ97cglEVNw0EhUuiAgngg9zqTOSA6EC+YcI7OGtGq8BGD67ejUFvv1oc
         Z2SURaOzdqLAz73lkD5/GNrFpdn08hQDW/QxwfqrxFohLIzwpd6i12bZIhvOoKx/hsPB
         Gk0sTN1qLKpCacvg+m4Joqc4PLj84kA1QPfIsKbR0GWQZ1N7XlfNUTmzG3Wwg7trSGPf
         D+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386213; x=1777991013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=;
        b=DOlam66U/kip5ni4xtLEgRcYKQHDD1EsUTMq5H7bk4Bfh+ARiyNP+A9m2Dddg79Lhk
         dR2g7kL3supzKBjZiyi6UfSIaIy9lih9G7rtazi7v2dCE/mk/vr/m3c9qevcCN/W4yO4
         A8/cksu0RNbZyad1Feh8piuyGWowk/Wun27a1/sUE4+zLFTqZZk6Mz+QhSqgutaK0z96
         EZoLPHm/P142cj1w1Ils7fyVMufbAo5lD0dXc7yvU36JzePtyy0AN6fgbVIjE5RxG/ns
         Ck3A6NCs0dqnCCEk9CzGmkrFBq73g12M0z7TTWYLNG6QA6m0U6oEwQ8ODdRwoMcv3gSY
         rNzA==
X-Gm-Message-State: AOJu0Yz7zOcgUm8rsQ13VmVuUDa2TCsx2XhXxGzyMDVA3qcBi4+tfp9t
	NZ2nh9Y7UhkfoGBvZOk2ZXPCBOBdimNNWOMCiY/oUUuxRKvm1nL88NZpwKwSo/JYmaeCC4IhJrZ
	5mutfxoSzfKjFFw169GZKGtjg72W5XYUGPAGE01rRD8l6XSwOaeP7vjPBfVa78GmDjv4CrbhUIw
	==
X-Gm-Gg: AeBDievn6dtEvhiGgxCAgDF4y+3q5LMK6KVYJVCCG3PZ9z337PueXEg4flQKL3tS9qU
	aCu13M+DAredFfGN3xEH7aX0nFKonTlbA7ctw6RCLcRhQ/zvVB0s8logRvDk9wXr92iCvvA3l55
	vSUgQ5gSL6lE8jv2+hsMTFJmjcNUJCa46vYNbHXtG6ZsiJONwDaK9Ffd2+wgv35y86EcWaxofn4
	wPYsuPzN6GEEqqb8F7dlxNcf0H0ADr2lRwSeh/R74h83A22OXU2AD8HVy5S1+tQFHaMzpFKsz0p
	JR8qzrWUtCVed42pakL4x2hJ9Zyxg6EoUzGRNuWaZOk2dG6faH8OlWy5ZptTjxktJwRcsmcbqVW
	0gdzIvsM5q51ZDx3uM7AH0yGtUnwycZxBF1azBFxJIGnbu8IW78oYvB/EaHBkx5zzhEt2uSd409
	+iTpDYpefvxcPGM+kDb5qgDUU7hg0=
X-Received: by 2002:a05:6122:4d04:b0:56d:b50d:3ee7 with SMTP id 71dfb90a1353d-573a55191e1mr1867573e0c.2.1777386212678;
        Tue, 28 Apr 2026 07:23:32 -0700 (PDT)
X-Received: by 2002:a05:6122:4d04:b0:56d:b50d:3ee7 with SMTP id 71dfb90a1353d-573a55191e1mr1867307e0c.2.1777386211467;
        Tue, 28 Apr 2026 07:23:31 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:30 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:13 +0200
Subject: [PATCH 8/9] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-8-6ad23e75190a@oss.qualcomm.com>
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
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
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=KuJ9H2WN c=1 sm=1 tr=0 ts=69f0c2e5 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: 0dNl6o4BnU9zMfTwL_PQOdm4mtquzcjh
X-Proofpoint-ORIG-GUID: 0dNl6o4BnU9zMfTwL_PQOdm4mtquzcjh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfXyK28ma3QS15s
 jyGGeHb3/MN6ZF4VQkpMW3lV7WrsunKTK/ed939wicVXCMBQPtI9TXdTitp9QFWDRh00LFMl13z
 IvvBl/iwgkG/YaC7MS+7q3g+nEaf7r3MpI87upV7n1Vy3NmMn5xO3evhrCOcH2ajN82VdGm5GyF
 g1iiJ2erCB897mIc69d+gBspxLMZUmS5+8UhbOKHza8VqRAdEm9sVXZnTXkktZ9ZfHzZ6P4tNC8
 Zw4jOk1kZ7MEh5paBrwTomVnT0wXQDLoggh8lEVQApw7m9me+VKDqLJqEN2PvxUhrfPL2yVTxSI
 YCi/7Q2sfQKQ0e6vNKB/SceukK3t/P+Vf2L4Og+cACb/EWYC6zdnKLCfQBMGucUUz3SmsDMza4p
 KLOeNZQEAOgjQWEMAcUqle9RnSvsJz/TSoq0jOSHXdOYouTsmGsRta9NWhHJ+PBmOo20X7RvrV/
 FXi+Ion6Pug5/1hnP0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280136

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dda76365726f0bfe0e80e05fe04859fa4f0592e1..df33eacfd29fa680f393f90215150743e6001d5b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -721,8 +721,11 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, &config->bdaddr))
+	if (!bacmp(&bda->bdaddr, &config->bdaddr)) {
 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
+		hci_set_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE);
+	}
 
 	kfree_skb(skb);
 

-- 
2.34.1

