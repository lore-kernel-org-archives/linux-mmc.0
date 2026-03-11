Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED033B8BD1
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222388; cv=none; b=IpP8mz9XmqDVgIBLct1IzqhOJAlUIdMqADoykaUFEM8/HSclZ7rwHfRI+UWsgO+zRgzrJg9MMiSB8Vx64WZdV6XjLvXQSlnbqNf1iKlN1717SPGWjpDYzfbzUZE2Txq6PUGhaG9VJJfUBnd09rPAk/oEQXFQmWSce29pwuKscGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222388; c=relaxed/simple;
	bh=wVcoXDFeUyKAEj7Wp41jFOLTmfWi9c0kwmWks3uxC40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e1IqetT9kd+0BpBtrNnQiRCMsD/51Bte48AWMb9V3VYcfjAJFA+HGV1IGc5HiMVp/pGzQfLZto4ePWlEgsPBthmFfzP5a1+4YV5wDiRJ6WbnLe4aLIHnL8bhHk3p/Ka7oIfLOh2wyNiM8Squn+FxKnZs1Jzc516FmaJBnzKrXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HRNcFFVw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I8jDPApA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HRNcFFVw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I8jDPApA"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B3pkZJ3893470
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 09:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HdAzK8Adxop+WYXouQbytrygK+EysY6Fo59E5Zf9tzw=; b=HRNcFFVwm3e9NbSa
	hzEUcYHFEE5Qh5Ge4dQpYhA4tm8BGSQGupVZh8mYlpPYRQ5y4z4sCck3pYLsTuNY
	P9QlLyQRzsz4Q1Siktbif9iaAz6MKBboQQX5nYInFrRWK+QpI1QLVYgTPnvKqVH7
	wL/ALEfdPfcDunog/o7RmH0CyRCO+ENgTdjOjpkLrhoQn+bRZzL4dXgI9YagyzGM
	YBvMNaIHf4jWB4FF62s8TbnwKh0xZkZIG0PY/B1/fghmufkW2si6rKbSktzNFAjg
	1/2SOh8W3vcyJS0lw4U0+vEOlWm9q4edKuivInVoUnIrHAE3slIcIVkmgGDJEKnb
	k3uMKw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctkmyv48h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 09:46:23 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829a655f5e4so1828028b3a.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 02:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773222383; x=1773827183; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdAzK8Adxop+WYXouQbytrygK+EysY6Fo59E5Zf9tzw=;
        b=I8jDPApATHpsSxI6PsU+upzfoiWWJJEHY5fvxxY7QZPB8k5tYV3jnrib18SK/u4Crl
         mdN9NqkYBguaXg6sONGCJiiOIbWz+eKlN8KuMTvfOS0IsF0EZ7jbFnVA1pfPGn/3VzHb
         quAwheSfOuaCcY4Da8Uy2uxux48WoVXr2Dhy5hv0Gp760A16eRIIhxK8zfDemPOA8RBH
         ioayyLYOKi/Il7CiJYFBxvb3RtdBv8nQjvx75XqKLU7DEzoOnG174sIe+cCWCe9YmX/w
         Idiws6/8ElCuMWwMrtT7O/dIvhBLKYss1DJWf85Wnwe+Qc57JRxsoQtPuOa3NdHuNCzS
         dLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773222383; x=1773827183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HdAzK8Adxop+WYXouQbytrygK+EysY6Fo59E5Zf9tzw=;
        b=Qd39rKtrY95expmz6lnQ4N8pHdwbFwZfqpISLIiA3Qj6HtP4sSyaBCQS+jeM+i1qEO
         LiaYXMrhzvtIMFL52M2R8Ygo2ckfkWGx8LpDilufdzu/2juoDlWsjkKLW8Nh4I2/SPK+
         fHPmFJ+c8U9zlFy5WD5ivajczu8umzS3tGV/8a3Gh235Lbii+RTftIDuYfVf0poTVCmp
         VeEyvct3j8Z/F0X7lqWFsYqmhahE4gZHTvcHz56qMHt8pQmAmjRjj4ahnYTx1LEZEysb
         ovLJMxTyS3T8D3/5h1SHR4X4IzTriAWf628HX6/OeDG/JdotZb1HSOPaPIIfdcydH9Xa
         l86w==
X-Forwarded-Encrypted: i=1; AJvYcCV9D8E3f21W1kEgaNUzVjkrUqH1G6TFGhdBPESLOb0fr6osK7ajylXniBlbSncEvV7wd+glAaoxApI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN4QAtSb1AzDgneDsLwvWXqn8zsmkBfeimf1iJ0SdvJblS4aCL
	t4IMyyNpErKEmKIiYMuaLrMHqSczXBABskA27KGrcwQy8pPAucpxj11H9WKS1gXcpqdwmoMQnTX
	uLW2XpEjqrWOO0S1BTZ15Pfq2FZyRdAfOzo/dVpcc8h3pd6glsjwk3xcHdDWjBEY=
X-Gm-Gg: ATEYQzwoBQBqylE8VT0JhpsHpE2hVX/gWXwwqINRKMUOe/RUD2b1BLp9mgApjrv7J+X
	RI0sgnE04Qt0IfKrQG7oGK7XcEDEvgiFHQ2mTwP84LFnnmmbCG72EQcaogdtICHffnBR9huIePp
	293SfsaEx4LxzLWQrCjUmOnr3caCLCZkQcN1pRUeGazpTzLzh+mXCIF9/EyRrTG+Cdgct/ZGsWc
	7SKWkTTiQpvzo1FRF/5SZK+7q+x8n2BDZrHkd6AmJFDhT3xhIstLEIsHQeP5kOutlkIDNO+09r1
	cANhvP7FwaLdIhAAJdp/CbwgCHA9Z5YWgBcAH4f99S4EwbdRTaYrM7In+izo4IYhBJ3LAhNqaW8
	RSs3x9tj90LOY7T6zle88FCaIgzWF20EgrF/iJgZ/SPBwBXl/sc63fu0eH7JCST0IOnuM8ZO2T+
	Vh20vIUi3lWafAdoB3+LCn7qj5ePOq0SQZdOd1iDCnD/FlauTcMlkjdgu6
X-Received: by 2002:a05:6a00:1399:b0:827:28e5:63f3 with SMTP id d2e1a72fcca58-829f7101c58mr1891268b3a.29.1773222382883;
        Wed, 11 Mar 2026 02:46:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:1399:b0:827:28e5:63f3 with SMTP id d2e1a72fcca58-829f7101c58mr1891230b3a.29.1773222382426;
        Wed, 11 Mar 2026 02:46:22 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6df5ff0sm1677403b3a.21.2026.03.11.02.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:46:22 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 15:15:47 +0530
Subject: [PATCH 5/9] dt-bindings: qcom: add ipq5210 boards
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-ipq5210_boot_to_shell-v1-5-fe857d68d698@oss.qualcomm.com>
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
In-Reply-To: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773222347; l=879;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=wVcoXDFeUyKAEj7Wp41jFOLTmfWi9c0kwmWks3uxC40=;
 b=CW8qrfjLdvi5KW/Y7s1g11eN9zOs9oWLne/pmovU50KXuX0J3QHf7h/Vw4JsYngZQrbaeYNZ2
 YhoDJUDkmruAu0u6qi1rg/a2rMkE/oEXk8vHAfxeXRu0kh7Ue1aaH/M
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Authority-Analysis: v=2.4 cv=RYudyltv c=1 sm=1 tr=0 ts=69b139ef cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=tVH_VOG3TRHTz8gau4oA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: Ho0G1W3knsIHhUDc2w_u0TGu4nzA6vSh
X-Proofpoint-ORIG-GUID: Ho0G1W3knsIHhUDc2w_u0TGu4nzA6vSh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4MSBTYWx0ZWRfX4ljdFZx4OyrS
 lJV+2XhI8U6BAdWqcZplnDyUvLBu7B9zfbPO+sP9lokB28NLVHVRodpmJe4bLwAu523+vgi3XfY
 vhVC8vTUVZ/ZRDdczIuI2G5cVlpSEHVmHpBIZSLUeBg60OtBTXLRArd7qyRQURqKnqUYPoe9xOo
 8pE/JlfpRy72pIqoWHKc1xXL1CSUQ8XGNpAH6pGhJcFo5JbJWKrd6fbzn2RB4GkL3uz/qJL7PqC
 4FfmlLdIDLX+9SGzYoJvK4XacDGr6A919RsX0GN5HywFAI2Fw1Z906wpYql6Da/aU098DppwA/8
 PTItYQ2ur7Khdvv1kCGQJHTom2KRY2YSC+YG3ImgCHB/ixWaZl2S7n3UFtwXM+mr41LQ6Ab0xGM
 ECCnjWXJWInxse6EECch+AyBfIwmPG42LcNGdv8ti9DczOWtu/F2KW/pLZ8dTJauqQO/lgUNMeB
 61nVDbgIuchcr5qeIxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110081

Document the new ipq5210 SoC/board device tree bindings.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d95acd4a424d368a481aa49d66449f784cf81986..9bf291511bc8910f0118e2e804c07c02770d5fd1 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -309,6 +309,11 @@ properties:
               - tplink,archer-ax55-v1
           - const: qcom,ipq5018
 
+      - items:
+          - enum:
+              - qcom,ipq5210-rdp504
+          - const: qcom,ipq5210
+
       - items:
           - enum:
               - qcom,ipq5332-ap-mi01.2

-- 
2.34.1

