Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A9D2F4A0C
	for <linux-mmc@vger.kernel.org>; Tue, 12 May 2026 04:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778558934; cv=none; b=bExbL6KHqpcEyhJ27pf5Ed00rnVrZfLNlqR98AXrP94R9AlPBI/P2v4snk3oEr4fAAYF6HKhgTO6S/WNdd99QP96yn0rroQjFjQGKcip1Nu+En+NMtVaw82qAGPbGFgtOb/o0PM+vDJo/Vj4CrgfwFrOd9MIwkyvcVDGYPkFxto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778558934; c=relaxed/simple;
	bh=QSWsO4NtB0gyoZ9UE8wQtjGZF5+pdJM1iPNPKJBGnf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Za5sXG1jXGnM6OgxMrDcfmor9MzzXBIBxzUOWp2gUmTPSkjTO+qAgZaNmRNY1QgUA1WLIvFD7jTNVuQDq7+iCtcNp8JdqMus/Sgg6Ohe58oHo5oydrsCoq2FtNZtVcErsxtdWexfvjD+tRhq7BBEnUH4c+7TCzI33DB3x3NYyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=So3+h3e5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iT5X6WM8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="So3+h3e5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iT5X6WM8"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK8K5w2173351
	for <linux-mmc@vger.kernel.org>; Tue, 12 May 2026 04:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5iW5TdGJXyw7GTZ7b4X8R789iXoMJ2Yg7+PSjFZ5I6I=; b=So3+h3e5lvFqRYL+
	HkmUGibOTVjjXqWXsoAKeXdPom8G8m9DFcWk5ijByiMR6FC8YJMfC1E1kKTfz5Ga
	ZqyvRbJSBDGn6OahWzH3e308481+hat8kZPba3hpOJfJ2V4RHsI1k98TElo4p3Vu
	g2tVf6ocynl/1bS6Ob0XdD5O3vaxN1uG/1LnYCV3HTTFhtTxjk8qTY1s5oY9LRV1
	iR8Cfi/RkRgYW2ipX4JeobsD9gPDBVhbQuJDwMPNTMKtKQv3oVRU2BCf+pLMfmqB
	iveO7LOn0ItNuZO/bXa7aMt+w/QQ1hbEdUhqsdhQME3TcK9jEt3rxHkLYJW6Ix7p
	ZutqsA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nvj9dfu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 12 May 2026 04:08:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b4530a90fdso124349785ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 21:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778558931; x=1779163731; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iW5TdGJXyw7GTZ7b4X8R789iXoMJ2Yg7+PSjFZ5I6I=;
        b=iT5X6WM8pWx4WHmWuvoN5aOBq3JvWqRDFNW7DeBTCQwyg6GoQ69xcQDwJhI8c/ZyVZ
         2fgN9eZBJKKz8dc/hSPd6pcF1DeiS/e4J16Mn83jYIBcnTxk9Ge1pXrXGu6RLkkk5XyV
         7vpFhtS7zPw8L2jnuX7YBDtpnRSSD6xSiplO4ElaETrfDE+81M+OeVINKtZqaYib6jdt
         mrI0PxREuU1UE3MiQAO3KQ5BNvRNEtIRlTlxPZ2ungwoIowZrlWG/13qLp4fLYAPJPAZ
         MGgRe3pTCCVZLgZPmcBl4NpmeJBO5MBOZQizLk7LG2KWCQMiaZXk+homAXdLvF4SbaOW
         wXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778558931; x=1779163731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5iW5TdGJXyw7GTZ7b4X8R789iXoMJ2Yg7+PSjFZ5I6I=;
        b=h+5Ux2+O2Y+u0ulm3IrCsOxLah3ov0VlZaVo0qQucI/twu9vltYqai2MvF6qdyIMXi
         WWHzdnKNuQoB9vXmJKcB7hpbDym7864bo4Q3hjlVgep2vIRLtfBo9kgSWf4i426vYuVf
         iLPrqw6i679NsCNQ/pIaZdyovumQZ21REe6ROz8pfGnksInFA3ml/n4CZUMMPYJOGvdW
         WQc6jFvk9WH3ntPtZFEkvt+4tSOBUSXKVWL6AlSROiYNkszH55kmC0kvK9nRiO1fowA9
         IHZbhkwbGDViaNSjmPupSLC0Kr+CS0Q48nwJLsqqe1p7M+QSmHzAeFtm+g8HGPIUOKKI
         YweA==
X-Forwarded-Encrypted: i=1; AFNElJ9BSldtjGDW8PQbpRxmjV63B2i7gcIv0VU96Z+9EpidiVACmnW/s6dwyK8C6l0Mix55TOjVBCjq3Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPVxkpXBFEYbsu0WUVFq9bsBVKVczs/6LTyLOk7JrUCv79j1TS
	WRPpaOYQAfqXwhhX0BKk4UX+Pl1yyvnvdQMexZHKha4aT8CiMdNAYS3MLZNDS8uu7TKUnXI46CL
	FcBe9Hx6/GOH5iVqes959CBHGulmeZKlu84gDcd1diPvn/U2UKgdwJpi3cF0ueu8=
X-Gm-Gg: Acq92OHH541SOk7S+xKVHgdOa7ShfuDvgkDCO8NzIIKQQXIdXKArzE0nt65NrdwxZ3M
	WvRDflevdO1hm9DlkRVrYB1ANrIJEOJRZBdnNa39/u2GUcNYxqECV15Zzl0f6XiYOV0OTL7bo6J
	qDKbXR53dbG9kO7p1s9r8uQz83BBr1tl68JXfeM6KrZLX80alUR+Gdz4I33MUBVC/i/SImgtlTT
	qVV3gaP5VjkJaStV6VPus3cXYTglHHhrDnTzsKOI/lJmXR9KEbuZdAnOIYGujzButqNeGtQutR/
	IPXMToK/gDZwcz9T/ebB3zk0cjkAXMklL3i7EDcK1d6bhO3MLEfVCaCecGHH3icJAqTV36ubH2Q
	yGdgsrQwSgdmWu6h9NGpw6JxPnlJTxOHpa90b
X-Received: by 2002:a17:903:4b03:b0:2b9:7ad1:bf2b with SMTP id d9443c01a7336-2ba7a2102eemr282246925ad.29.1778558930959;
        Mon, 11 May 2026 21:08:50 -0700 (PDT)
X-Received: by 2002:a17:903:4b03:b0:2b9:7ad1:bf2b with SMTP id d9443c01a7336-2ba7a2102eemr282246515ad.29.1778558930424;
        Mon, 11 May 2026 21:08:50 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d405adsm122646725ad.28.2026.05.11.21.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 21:08:49 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 12 May 2026 09:38:06 +0530
Subject: [PATCH 3/4] arm64: dts: qcom: Add Shikra CQM SoM platform
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-shikra-dt-v1-3-716438330dd0@oss.qualcomm.com>
References: <20260512-shikra-dt-v1-0-716438330dd0@oss.qualcomm.com>
In-Reply-To: <20260512-shikra-dt-v1-0-716438330dd0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778558905; l=3489;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=QSWsO4NtB0gyoZ9UE8wQtjGZF5+pdJM1iPNPKJBGnf0=;
 b=gfH0gl7LXrdq7byi/X6JFwIeqcpLx56NZFzcpnEaxVxou1o3ed1tKm7R+IyVufAIRNPzXChWv
 KjFGppUQdoaDgPP12iFAzFLNqNjDxmQNFFcbw2aD4BC8JuktxT4IgvE
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: TWzSrctGn5pE0czisp8ODdscb7ssSbjy
X-Proofpoint-GUID: TWzSrctGn5pE0czisp8ODdscb7ssSbjy
X-Authority-Analysis: v=2.4 cv=H8brBeYi c=1 sm=1 tr=0 ts=6a02a7d3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=yuh6J1mAL7zzRkeivMgA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAzNSBTYWx0ZWRfXwqmL+FBKz6nL
 rhUVZn0Q5XXEMd690UjpZLbYRslg+qqPaPoyEcsZs9oLjm7bPZGPFI83igspKhR/gviQZeL7onC
 ShPdecagUw6EzXsrdbACtzZaMoTGFYxKWRCP91VdJG6VtWb1mBTIq1whuFU2tEW+Ur/uJPFuKZm
 ek4HgxtQhr7wp+EnHKxDIgFvEddrSUYmvI0GpxwWoWUTvFzku4+jeDg7xzBNnwPgOMWNaXX/kes
 scNgbP2tjNvrApzgYHdBNU3sc/QWvMgy9yXCvYg756SV/88COZ5TVkOYziRtXqOC14hhgvsc2ps
 s/4nKxbhyiqwjSRT57MO2kR5fko8uqB+PuBpDfqG9ufRqUE7Bpf/SLSgqkXgB/iY59VJFPcvODh
 KHlszOy44u3yOjC35cgsOcu6ytrWyABlxiydArb8DyqLRqrM7YtTeptGXKLMupu6QoqiWYLykb7
 DBXCGS5T2smK2RtTU/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120035

Add device tree include for the CQM variant of the Shikra
System-on-Module, a compact compute module integrating the Shikra SoC
and PMIC for IoT applications, designed to mount on carrier boards.

  - shikra-cqm-som.dtsi: Retail SoM with modem (PM4125 PMIC)

The DTSI includes the common shikra.dtsi and adds PM4125 PMIC regulator
definitions specific to this variant.

Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi | 112 +++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
new file mode 100644
index 000000000000..401e71720519
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "shikra.dtsi"
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm2250-regulators";
+
+		pm4125_s2: s2 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm4125_l3: l3 {
+			regulator-min-microvolt = <624000>;
+			regulator-max-microvolt = <650000>;
+		};
+
+		pm4125_l4: l4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		pm4125_l5: l5 {
+			regulator-min-microvolt = <1232000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm4125_l6: l6 {
+			regulator-min-microvolt = <788000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		pm4125_l7: l7 {
+			regulator-min-microvolt = <664000>;
+			regulator-max-microvolt = <664000>;
+		};
+
+		pm4125_l8: l8 {
+			regulator-min-microvolt = <928000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		pm4125_l9: l9 {
+			regulator-min-microvolt = <875000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		pm4125_l10: l10 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm4125_l12: l12 {
+			regulator-min-microvolt = <928000>;
+			regulator-max-microvolt = <975000>;
+		};
+
+		pm4125_l13: l13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm4125_l14: l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm4125_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm4125_l16: l16 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm4125_l17: l17 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		pm4125_l18: l18 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		pm4125_l19: l19 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		pm4125_l20: l20 {
+			regulator-min-microvolt = <2952000>;
+			regulator-max-microvolt = <2952000>;
+		};
+
+		pm4125_l21: l21 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3056000>;
+		};
+
+		pm4125_l22: l22 {
+			regulator-min-microvolt = <3304000>;
+			regulator-max-microvolt = <3304000>;
+		};
+	};
+};

-- 
2.34.1

