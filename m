Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D908018DB26
	for <linux-mmc@vger.kernel.org>; Thu, 28 May 2026 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976430; cv=none; b=IdmjDGCF/xngvnuN4OddlFwiBuse9H429dn/TTPCJnagkXcK8l8quxTdvwqE5qC/CWK1uyFwLUSatFn5BTJG9/3Kq5iG9n6zMNh7NljbQmQsUYqS6gJV836aaxxkcY2DsmqQBENar46xY+E/NuJW6HUmrW/9h/z48gxsWQvFN94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976430; c=relaxed/simple;
	bh=Z5jHEKYlnHq9blygIp04x8kPJ+G9+sAPZfircpJPTSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F6JnzOt6HyjexqnesVP2gv0VFXa5m/IVoqONQITDqSIpgRikLwIo+7BdKiOkTQE5VHr3xVrBtMUjJEuTP56A/kBNLyNh40AJFl7LyWFE9XKU3Kp70WWAh+kC2IFT74iJpb4nY41/REAdODWZNptnPzf2Av8NYKoimTrxF5c1p88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nmE7Zc6n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hSn1tAHL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nmE7Zc6n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hSn1tAHL"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64S8vYH71697184
	for <linux-mmc@vger.kernel.org>; Thu, 28 May 2026 13:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=r8C5tBkc9P5qygIlEDIPmRkW+nBFHz9T0Fu
	3Uy/u1xU=; b=nmE7Zc6n5LkB847ukuW91Sj8tY1YA20FbeSXts3BqwN6Hkl9o3d
	zdRwbo4cHkFPkD1zb8WlOGsG4BiC1riH7jZ9D/ev6arhbw6pCPTBap9oZdVXcEGI
	zGVGYomrhe8xoO3LJFLL0JDN4cZJ5H8ZnCOxHeG05/cRi3uYHd3CVWkNZaDr0Amq
	Nzte8qzrkh3bw+xndkwcmQzJ/CQvupNW/tdPD0aNresZIIY7OACM/S0tjL8CcStw
	5Ckmr6VOc0LwP4C5lpr9aLL1qvPLRyzJTY/hhk6Os+vRkSCEOmdbEZg3GH6Sxh4m
	V99bWcdN/FD5lIWISyvwCQBVFdwTY4b+AEg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yajywr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 28 May 2026 13:53:48 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-516eaf9fb76so96984061cf.1
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2026 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779976427; x=1780581227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r8C5tBkc9P5qygIlEDIPmRkW+nBFHz9T0Fu3Uy/u1xU=;
        b=hSn1tAHL3ZUFEIiipJXcYRVDQ56BwnSkanXztbkb7u7/8lUxTw880GcCKbENsbQTj5
         caIAGm5w03N6IXah+bHq/EtmrBpic7R1MkT2elnauPhG8+z89uA88kmH0fHQhpMUFBS7
         LmsxCYf4h/iNMDw9gJtKQtzW3qY6NkfoUKcFbqPsblU557ba6caLnT+s5xBdnr2r0esB
         UR36lRNotOyPXKBLEPd4diZ/XMqd0u+7B/iwzGjzVGR7QCh9Dz8N9CnHJQ1ogIKzIDOX
         IAT5AXph/XHTo8/2VgWVR47ppXS6d/erRGF7ObNzqjXboD5NZ7SR74NybNdv/Qdx4T/s
         JsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779976427; x=1780581227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8C5tBkc9P5qygIlEDIPmRkW+nBFHz9T0Fu3Uy/u1xU=;
        b=CVNP4kK1d88+h9RMUzx82Ieopiks2S+G9NtlZ1FluW3vvct4+GgivQTijFHC9P/QE8
         w6DB82i7NngGtwyKbu4ogn/rK+NSYW3RB0yx3u8MgeIQ9Ob8Cz57BexVGfslGRyrbiEY
         PsLQOuJbbbFQR7sW0yzzJV6U24N/XNpBT7jW34YHZSTG/8f1qrdjrBathBghnDMMdL4K
         57eh20QjwbGvuWLCFSNDT9q5K4nx/HCv377yDveRMY03MxOA4xwuLVQjEN5hioLTeuNz
         hTkiFBKDfcrIBL4uEj/Al+DfUoxzwUhRUmeHD3p92ZcWE4tgxw1FzVXfe9ujtW6s6CnK
         7/Cw==
X-Forwarded-Encrypted: i=1; AFNElJ/Rdtjk4ji9tp1mZB6MwdYE7nmpC2wF4n4LGuMyZvwbvStyGbGfXxInmYRlsfUjta/6ypOqQxtFn8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5lAA/u1FyTmSs2BYxSku8us3V5fLWv9E2OGLOxeHkUT7N3wP
	tIrsBapM32q8Q2RmFn2jd7S0pRGY4SHnvwkt8SLhFZ2T1guD/aQR/Eor8sB9WMzCbezcMLfEHW7
	FVSNqknGdABCAoqqwFdV/SAvYawrwMke9k8x4OceGg8+OIcBwJhqiL27yEoUXngQ=
X-Gm-Gg: Acq92OEclPCtHVqTWPJBhgyu1ni1eNgV6mFADuWEKYjlu4239aFHCTKgUGsyuW+Qn3+
	nUHzKA1QBMzYCn0v2zfjIsngPfbiTIAGKd9Bvue6OXjk7qbouAdgDKMxVJH1fuOzz1QksMI5R74
	EYjLiy/xHsrfVtmbYqd9NmDBBi89QE+uUBR88BtCul82flpMLXy/OFwi3nkpA/ezJH387bEl+aI
	cHCN4g7NfEKtW9UKcouXsAc5jK8nwpPQ4y2eGWMxtiGc4NXYkKZFEtoFsnrLP2Or02Dho4UWXTZ
	tmCqv4l+fK3YTarBuKFKYQBbN6m5xtn8XzqB05GAxH2yO8EMORVqK0jePE04lPAV5/yIsaRRExV
	v7eTOEBlf+Wr7HYsrMg45PnaAdJaPWo2/B2+UfHYgGod23kYm7ru1JuUvz8NsHudrMSbVwYh+n+
	iecbRDhV/3LlnfJHR23Ap1dQ==
X-Received: by 2002:ac8:6f0a:0:b0:516:e5d4:f86b with SMTP id d75a77b69052e-516e5d525e1mr299337991cf.49.1779976427000;
        Thu, 28 May 2026 06:53:47 -0700 (PDT)
X-Received: by 2002:ac8:6f0a:0:b0:516:e5d4:f86b with SMTP id d75a77b69052e-516e5d525e1mr299337581cf.49.1779976426446;
        Thu, 28 May 2026 06:53:46 -0700 (PDT)
Received: from work.wifi.ville-nice.fr (62-193-63-110.as16211.net. [62.193.63.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908b5a618dsm17225435e9.8.2026.05.28.06.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:53:45 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: ulfh@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: mmc: sdhci-msm: Rename the binding to include 'qcom' prefix
Date: Thu, 28 May 2026 15:53:42 +0200
Message-ID: <20260528135342.11678-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BedBYvuvqD7gDK5NnbxB9gVeHZAGciK9
X-Proofpoint-GUID: BedBYvuvqD7gDK5NnbxB9gVeHZAGciK9
X-Authority-Analysis: v=2.4 cv=E/r9Y6dl c=1 sm=1 tr=0 ts=6a1848ec cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xizqlaZpAqmNt8UN1ov9oQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=gEfo2CItAAAA:8 a=doSvXZN1fV365kk4ip4A:9
 a=dawVfQjAaf238kedN5IG:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE0MCBTYWx0ZWRfX8cCj4is9Q7T5
 V22/ZMGXkwHgdQcYHA+CFkOBNSfKQvL/SC/yK2AI8RUS79H/RHts2v2U1L6rnDIO0/fjM/JikUU
 +u5gHGOGaFQe9yzSmiQea7mM/2QdMEVJboSWZYSbFeis77jnQ3TB84WHS+h0jHBRMCKF8FoQCY5
 YbOX0n8ADQDOfilU/xStrBomAfwHIDim0hVQpD5k9lsLA5cvKLO2LqCNPt1js35OVhi//ZqqY+w
 COSwkDIXDRGa+yf2F5QvRYvCxTNI3+BUc/P3zjiKgZyJH64DZAyKeKzDgrzUGhJ29dFCo3EH8O7
 JcW6HKSvJVo0ftLZXQbdNpMqtcVUmTZQM4G2oXeAZZB94FuWkCM0V1/exvQ/KX/gY5hPFx1bobh
 IkrgiZfIsjr5RP0Lrt10lweD9tAf6BOGH90TzBTSh/0CYfWEJZHC7jO++YBowRtJfoFRw/gUalZ
 uPqOUgAUb+LH/8kCIMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280140

This is the only Qcom binding that doesn't have 'qcom' prefix in the
bindings name. This doesn't match with the regex in MAINTAINERS file and
the 'get_maintainer.pl' script fails to list the 'linux-arm-msm' list:

Ulf Hansson <ulfh@kernel.org> (maintainer:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...)
Rob Herring <robh@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Krzysztof Kozlowski <krzk+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Bjorn Andersson <andersson@kernel.org> (in file)
Konrad Dybcio <konradybcio@kernel.org> (in file)
linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...)
devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
linux-kernel@vger.kernel.org (open list)

Hence, rename the binding to include 'qcom' prefix so that the regex
matches correctly.

Reported-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Closes: https://lore.kernel.org/all/20260526151003.p4kn2vek3hpv4gzv@hu-mojha-hyd.qualcomm.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 .../bindings/mmc/{sdhci-msm.yaml => qcom,sdhci-msm.yaml}        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/mmc/{sdhci-msm.yaml => qcom,sdhci-msm.yaml} (99%)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
similarity index 99%
rename from Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
rename to Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
index 695a95e8f35d..cb16c08d22cc 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/qcom,sdhci-msm.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/mmc/sdhci-msm.yaml#
+$id: http://devicetree.org/schemas/mmc/qcom,sdhci-msm.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm SDHCI controller (sdhci-msm)
-- 
2.51.0

