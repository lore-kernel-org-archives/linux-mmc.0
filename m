Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0547A888
	for <linux-mmc@vger.kernel.org>; Thu,  6 Aug 2026 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027141; cv=none; b=ducjfZ3rpon9oR2W+Kvn69Zcynua7cOY1472cnE2Tikl0swGJwaby+7oKLmB6yVlI9lfXGzr0PCSCKwxa4tpMMlrI3gyu/7jtWh3gGND6TuAEgExMHa0rU2NWqZDMNqtcpmKFGu0k9QgRA++AQLEjQMt5KifVThNpvKPhE8C24U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027141; c=relaxed/simple;
	bh=NYZrwdZQ8Unx+4+MfgqEtix1DA4oaM8IOP1pJXmdN5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=okW9+f/9furP29any6kFpm5+X/6LuQvqqUdAWxlD688EnZ5w0ZybXp2otrshtj/fWNO4tKIt50zLETe/o6iHBq8Odvd4VbX2jQ01OVthhA7dkPNu9K5NmhbGtHjfCfewbNPTkV5Dxutpo4q7Dz+gQ7BkDAoOmYUGNqO+o2mSemc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KOkasYZf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CnTstnHu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KOkasYZf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CnTstnHu"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769ndKn1578682
	for <linux-mmc@vger.kernel.org>; Thu, 6 Aug 2026 14:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oLlLllLuzegCOZuXn5+dUp09HoQyVIGVgRcx14v62PM=; b=KOkasYZfyawfqtfx
	kp3fH+4kNrRaDxs/Ft0qbH520UYzF8ncdN1LyjUUifvmWrKfyxhOvX/rRAIbP+x2
	PIDKDAe9Yn4/XKcQekdSfwS5rkUtBHkMZU4GlS4Inrr7UL9bSZ6wHEFdc+bfQyjC
	S5NnzLF0UjugyEN1aKT7FLwdsGmal6wmLHhCA8jWKMRe8agjDwvwcItJNnLYndeL
	vcczEhML7MZJAHOjXJeHQfgwof9syCrGNWh2/nxRhf2Ja75/eaBHUiSYLrSWu96s
	6Z0S4mz+Mjnuwl9UU/uyhlygxL1I4eRnsw4oygt65Z9qvPoW6+hRJlluuHgHwhLp
	cCchZQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvju8jrc9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 06 Aug 2026 14:38:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93106d8af18so216580185a.0
        for <linux-mmc@vger.kernel.org>; Thu, 06 Aug 2026 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786027137; x=1786631937; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oLlLllLuzegCOZuXn5+dUp09HoQyVIGVgRcx14v62PM=;
        b=CnTstnHuoCPQ3CVNB+OyPox0Hx6XXKo0pInZJjKKsmaMiTXcsVDMFJxH0B6aw2WV+R
         sznVhtzhnQBPVMHqhisfpjNhnLh6KkicmWwPWsfVjfCAtD/tEbJUYa9ZoX6azEDQnPwx
         ZXFO0AMxuEK02poCZY8vZM20ZaPKSijzV/ZC57Feh91YjPlmpzfPTSIXWww2hxDHD8J7
         h7lkQILRosz+emWQ1mo6FeUjP+P9rNJJh7eA1cQM4YUYsZCDzvcXror/nUVGa7R305Hm
         I4v1HhdIKJgZXVJ4X4RQDJDvj63uZ2jjI3bOnvoyaDwNVUnAPP/2lZ6sf9rw/3FDUUMn
         TFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027137; x=1786631937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLlLllLuzegCOZuXn5+dUp09HoQyVIGVgRcx14v62PM=;
        b=QRvSCCVfymZ7R4teu8BU4/MQQjjgLjxWTFaFuPWRFpg3vuwwk7CXivzl0XuCs0L0vt
         VH8DRXretp+rSvLXAOvq5n1sorNsRBCpuUh/nn3iq21s98YoMn8teoXrSjfyqQDgQv24
         +PQ0YIHWeDkHTCDGfAVj+AIYCw10Mr5hANC4ctOoOb0VErCqk/fN8jR+OSQLLL6DEVIn
         ARMXDfPreoMHhqe2oXpo6FgpJkF/XDL/xc9cHrNrcEY+Ywtw+1ApLt1gzts/EbATNP9b
         5dsGF9XDWpNyGEh5cfKRtYfC119C522MWZV6W/UjeSAnY2W9xcjsOMypes/OTN83f6IB
         Er9w==
X-Gm-Message-State: AOJu0Yxve2YOoWMoCxh2jdUuWm488wtJ3/zdPrLGTslmnKiMLoMv5opr
	YLmaW5oP+3xXF3lDgNlc/LCfMCunFNJzH0S75UF/kHaXnCwRWYqA7YaucsIkMZv+AFi5tfA1LKX
	K/UCcyvLCreN6/SJLirjJRRIX33WLhnEjsBoBl/bUCYBjSGZuCZUErpyG/UTDGHA=
X-Gm-Gg: AR+sD11K7iqIpFzI4u6zIeC98QF2qL8bvJfse21ivL63KJX8XB8I1o13jHCrhzVl5KH
	OpWRB0uO1hDn1FQKdVEACpiPdguwldAh1P2mk9Yb7gZryd6qtiv9vug+Gs8VelAQ4xMlMs1VGT1
	pYjy4NwV23MhvK97H0k1NuqEbO2TB4ncrqk5Mtg82VVjD7i2vhbrAM7dcja+QQfpcz1LWVDt7/U
	GAVRkFnAii+K84qx6CJ1G3LtYC0CxtEB4RXyG58n5i5ijm7waOBCdAUOywSoJntujMpxBKqFq0/
	3GKzT5aeZ1V2c+cMvUYevEgSp4x8z8g4OkyEM2pr9MpoX4a8vRS2sO+XIAK8cwhr/ednxL7mqJp
	jn9zI5y4Jmtppw7iSX35cJcSzqD21a0yT1cQRHS9pyXH51z/YiqaoMO6K5u8f2V2WquIyOlpQq5
	tWBJir6tg1s2yh3ejH+AC+UGnWKIHV52UdRsLSxQlSHPlQmTnDMw==
X-Received: by 2002:a05:622a:4ccf:b0:50d:e471:2d1e with SMTP id d75a77b69052e-52ce61b4ef7mr159133181cf.35.1786027137069;
        Thu, 06 Aug 2026 07:38:57 -0700 (PDT)
X-Received: by 2002:a05:622a:4ccf:b0:50d:e471:2d1e with SMTP id d75a77b69052e-52ce61b4ef7mr159132431cf.35.1786027136590;
        Thu, 06 Aug 2026 07:38:56 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([90.85.108.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm270552166b.28.2026.08.06.07.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:38:55 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 16:38:37 +0200
Subject: [PATCH v10 04/10] nvmem: layouts: Support fixed-layout as the
 nvmem device node itself
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-block-as-nvmem-v10-4-be598b2a5606@oss.qualcomm.com>
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
In-Reply-To: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: s32xnXw_tvvIVjiawDUnncz4jcrqJZ9D
X-Proofpoint-ORIG-GUID: s32xnXw_tvvIVjiawDUnncz4jcrqJZ9D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX73r9xxBKfQSB
 hEL1FfhT4/JrXOscqQpvJtCuDlQViE7H0oJLJkm89wpACEbVHGNOAjNZk7LsLTSCO3C6iPmklZK
 mCbSz7X4iWtbyHjV/bjjntaZBHEkhTmsUiMw/U2wbo8Z1vFpxJ+asSo77xZN9US5g2s1sKVufnb
 4zDBLhA9twN6OSERdVs7zIHkroqIuD4uuOdz2O1gv1WwLI7ITVCQNpkZg/Jlra8w0zmupa2yqjX
 BLL7sFP/sckBf10Y9RfGQPttUtDwadyx8Az+EJmK76psPILtZU9svEOFOP09v8AGMCN6RGgP2I/
 wT51JsKBpFik+MSClGAsn4J4oL7qQkW99mD9QyUPv7X4EWSebIjNff6aB3LRfCxtXXt0E19Sj56
 cHmc2+9SxtGJ+gtHJj0jhma56wsrknZKnoitSRGmNA+u7LSaDfxNiVFE3kvaPyqGeflqLGGkxDw
 Dqwc9qNMbzcK6aADiJA==
X-Authority-Analysis: v=2.4 cv=K5cS2SWI c=1 sm=1 tr=0 ts=6a749c81 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=JDRa4Jy4r6/BpSpxP2cCow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=4SYEPDBQci7QR0ImIkAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX+qmzQVHKNHEJ
 0IsKkm4T4LK7WvR+Rn7jthDCKtHgRhU88Rpx/GvBK0/Bwoa3/U7NWiXy5JGl4JJUwHtNeDkyHQW
 jU1+T5a0OxO0ZWiHy0LXbYU7LgUkdWs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060114

of_nvmem_layout_get_container() only looks for a child node named
"nvmem-layout" to locate the cell definitions. This does not cover
providers whose device tree node is itself the fixed-layout container,
such as an eMMC boot partition block device whose fwnode points directly
at a "fixed-layout" compatible partitions node.

When no "nvmem-layout" child is present, fall back to returning the nvmem
device node itself if it is compatible with "fixed-layout", so that its
cells are parsed by nvmem_add_cells_from_fixed_layout().

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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

