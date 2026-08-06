Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3384B47A87A
	for <linux-mmc@vger.kernel.org>; Thu,  6 Aug 2026 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027137; cv=none; b=kPDW00txbrYzCn8LRTqcCaVLny+7Xo/JjSPisUJI5CVqcQtwC1TewvMetFNgUwZssY91eU7zDEH6LCcaHCoM55ZuMCXsENfT4FTbmJttJrC34Axo+cM1S7q+eTyoJWUkBHlvIG1pEdXfrJNQq/snHoRXjDil3fvBnse5s8DhgRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027137; c=relaxed/simple;
	bh=rFLR77CJJYP1sKLFQ6gl8hLWfcBFJvASp2MjESWcdt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cbNJmcF785HiafBkG9qmWMuFbQvMguZM7Q5/QuSd0zSH3OYsF3Gtr1qz0nCwuo/bU8C/bOmUar310pcUuihA9ESpKCLITLozncLSxbImPKfouW+jE6WB+vaUvliXWQx+A827F2HB3PL6R8ahWujaiBGJywFLaFInm1MtVtIXF2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DY8zLtgk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XvnSSbky; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DY8zLtgk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XvnSSbky"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nctx1580560
	for <linux-mmc@vger.kernel.org>; Thu, 6 Aug 2026 14:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=; b=DY8zLtgk6GRUKKXH
	ChvACXmhsf7wRge6WlyJBT7d4hVgvki94RA1N7o53IJ6WoMzYGRCarNMLpYLFwzG
	3nDXtEuYF3/p0zimY+tOUUM5+tN0nYnD3xU5yZ/JKpuk36jd8krQwo64bxdmJ3G1
	jPbL5DM0gz+L6MfwAQZpZwkHrjMzuTadkrWryDvyz/EPmH0GgWwxAcPX05E6xxTb
	9WvNdUp0TG0BznJspN/B7I+G+o3oGERTHb06nLVFrBuew8It9V3CJslxKhYZK1ec
	EzgD7VRnZwvDo51yH8+rP0bFF+mHqxw/xrDqg4XrzMAFpH0odyAqNQ6WaP3UVRl2
	PxMeCw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvmrjj8mw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 06 Aug 2026 14:38:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c12e43b98so25632141cf.1
        for <linux-mmc@vger.kernel.org>; Thu, 06 Aug 2026 07:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786027131; x=1786631931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=;
        b=XvnSSbkyxTgDhDK+fNRpObMIj3SpwUup9R7f+vFHVWNJ+3sWFkaiE+sdANmnJcilxF
         6UyJ2aDubqeuRPvxSpW0QUkuJ++lq1Fz5t9nzlm2X+P15XqXAYFHyZ3iTKVr+OP73Fcj
         erRuaiAD4Wt/Gp385go7ELw+YDOhhAzU4ImVMepgV2O9qPbbZu4l85aAELuVT5NUMedw
         35dyboP2gWa2M/CtOSBu5GpZmv3La0ochTQDYE6Ch9yqsWDFuGa7l4tcWZFd0epIPTcO
         /dS1JZj8tMKKw3ILA0byxPy04PecexQBLpBUJGG00Mh4CRRgrf45mbanbqnL7tANhxT/
         j6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027131; x=1786631931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Pq53qNpO4Cl13XpVwNXOs8IgmR52etnko+i3TUslYQ=;
        b=lP4j+RdaZO88GZnsaR7ch2gJm8WbLOPvU0gFKd19CRzi+pNyijzCk63vgvbFhJEYlu
         qCM6VWUJHnkEOaBlw5a40/oGHpD6jN07EdkmXxwpGyWPvHaXO4bZeFrdKrhZQRse3Lco
         7F6B9FiBQiIhsX8zmy3uX7ghSKp4cy/84yxng9OXORtsHwvQl3ao/AIxiaogNwOTryRG
         AYhLoe9lyixWEUPZELFXtnNgLzs8uglzBOgIWYzetESx+Y6MDPcNy1YRdERJpz4M9fNf
         4wcE6Z1MIa1mISe3ka5rAuyOCmJaemlMyA8zufM/lPmGEByf7r9xTjYvVwqZNknB8dnk
         QY6w==
X-Gm-Message-State: AOJu0YzHvt4N4V5sXghmh7dg9+I1c/RgKOCAIRZyOkau9sm7q1Xtw4M7
	7Ef1lWvpRlM1JwEHTVhWqqthhh97Jg6POHIxH2TBeQtjinRLiK0V4tzSMRjkKeH76AEQBQiTVpK
	iURwgpxc2KTpr5YNdH+OQaTnofjtnz9TAgz47Bh0rzHdYCOwaSPwIBAnRw1ZsWDc=
X-Gm-Gg: AR+sD12wXvm1zUH8CVLXmC+wt3QmcXGGeZzg/F/5j/hHVQ4yFI03mUbF7oH3Bfy0Xkx
	ZvV++vi2QoYdcV4vZzaNtKGcBG9qLBNgiCmoqI0GPiBZlNjz2U46XpicYSaMccyAgM3rgDHcbQa
	03DGexL/XZyPAK+yhMA0RuMIOz44u3Qf+JPXaKrqmRMnT1yjQC2DWsQuz6NBuhLCzBK2DPXiHnW
	WmQoKwzusp2B1R9D0f5qRWrO40gXPN8CEiEYZxuL72I02hd0YXSMxD4Kg1mvP+fNCMW9xCCPv68
	7OGJca5OaEY8P+2qq20RK/4veYcyBXG3nuDlxe85Gw8ju211EVQkFufqdozY6FRSnOG+P9wqu0X
	LHbt51HSx7Md7atqivTB78YjVsKKQlvAp+NDtC99EjrarxBSG0xLAZ08VdLx71Gy/caKoKJG4JU
	/uf1OVWAQYchG0xDT68xiNSk9mIg0aA2euIgpQTy5tMCRRe3wy9g==
X-Received: by 2002:a05:622a:1447:b0:527:43a:2f30 with SMTP id d75a77b69052e-52ce5f6013emr149751591cf.1.1786027131437;
        Thu, 06 Aug 2026 07:38:51 -0700 (PDT)
X-Received: by 2002:a05:622a:1447:b0:527:43a:2f30 with SMTP id d75a77b69052e-52ce5f6013emr149750561cf.1.1786027130781;
        Thu, 06 Aug 2026 07:38:50 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([90.85.108.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm270552166b.28.2026.08.06.07.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:38:50 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 16:38:35 +0200
Subject: [PATCH v10 02/10] dt-bindings: net: wireless: qcom,ath10k:
 Document NVMEM cells
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-block-as-nvmem-v10-2-be598b2a5606@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=VNPtWdPX c=1 sm=1 tr=0 ts=6a749c7c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=JDRa4Jy4r6/BpSpxP2cCow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: ZeMq8Txf4-AhZ-mstjC1Yh-FdaOcF8rK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX26ceDqG2/uCQ
 S17Ur6JEyJj+9uTWqvk84mX0Dm1h+UeQDthXGSOwWTpufj9Ru2S+oEM4mYotMsJIa/0n/QHN+rO
 iTpbtHHv9wsUlZLy+7tU2ywZStCDpOg=
X-Proofpoint-GUID: ZeMq8Txf4-AhZ-mstjC1Yh-FdaOcF8rK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX9bIZ8ShQp162
 6D28h3eW2luXzt9RqJ+6wMOUbNiOced21HpdWPEcf9UZ6F3PHxnoq/1B4VyvIO4OVfUwJZNseV0
 StHhHmBRcbn7bR3KGc2xkJ60AFALGnWQp5ACVEAMxDGMDBBRzB6e/aFQA3Dw7VyLAJ2Lt5FAmSI
 9Gsawo7980X+a7whJRyPQ7d8Nz79m3GxtLQ9Q2IHL05RVNSKLJ9qMx1Cw4yrDoUGZWA0RLWKeKp
 JLt4g2PoGuhqYhwRbm8nxRrrXOVjDvYL3w40lNyrd8HLpEb0rE/VBuTIE8fmdBhU1TNuvP9gahz
 yK+S2kTUySN2Bl9tgdoklfF7b+nW5FinXADX2GEEz2Uf7gjZqORvG4weYwC24GoAWUwPUY1LOlJ
 eMRG3Fa7qV4ipXoYn2Rz249vABc1c5PeXqmHHsQHv3He0G3+VZvXa15M6OWjiOkKs+WZB8a7a/i
 Y1IZOqtu+7FQPWfQxzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060114

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

Since such data may also originate from chipset OTP or be supplied
via other device tree structures. All of these cells are optional
and can be provided independently, in any combination.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index d4f4d72ee0d388f43437fc5a3047f90b464a5274..7f9d16cb7c14330e11ce7d567d585b5e47793bd8 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,22 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    minItems: 1
+    maxItems: 3
+    description:
+      References to nvmem cells for MAC address and/or calibration data.
+      Supported cell names are mac-address, calibration, and pre-calibration.
+
+  nvmem-cell-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum:
+        - mac-address
+        - calibration
+        - pre-calibration
+
   qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:

-- 
2.34.1

