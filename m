Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F34222F01
	for <linux-mmc@vger.kernel.org>; Tue,  7 Oct 2025 05:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759815911; cv=none; b=e9qkHbdRa/BaTtlya1tOle0y243dQDfFQH7eYNye7nUXSj5nrUj8jnND4PYuohuHZpLwlprdFFqHUZwFCPoqRy8Rt3BSzThtESAMwc5aB5swybiJ9t/4rYCaFC5hK5Q/X/3DxJrsIKMBAelimINbpHOl7ECy1EA2+vS2syQ66/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759815911; c=relaxed/simple;
	bh=OUUu6/gerX1YHi0u5e5w1G3QfwIy6Dp/7L+64GjSvBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bLd582GKxMHeG+b7gq78I4o/HUWUxowU3QaZwyZV8zPjqtpjPcpbiyk2pvQAFuWPv0rOvW4NsDA67VIWkPLrwTj0beqn9lALZle+UprMgGLlV6S0zSCXUmcVsxO9wxh7rbIgT77+5PVzONd4iXFajwCP+zd9b5os7NPmAfPOFO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GOmEItS6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GOmEItS6"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5972KuJs000811
	for <linux-mmc@vger.kernel.org>; Tue, 7 Oct 2025 05:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=haboOX8nrE8
	6yirNHVVxZwV9MxNGuoLfRh/h1+xbQzc=; b=GOmEItS60q0mnXZxKKLGR1rw12Z
	ufyTbKzqgW0qCm/ZS7D+M29MdXZ1MXSJfAoM+PfDOKcZFa+YWY2iYheRaioqKgCX
	s+FgRVWhlWZHHQaTl7pI6K2fqvgQHwPuosTkW2brU141gmYdrRlUZI7nugjTs2Xa
	NQ+I9E0KGQgohMwLVB2qaMwrY9GUaOnMTcrgkzG24cbyIfwPJwFrCc7Ry+DWJho2
	xyBlN9JWSS5Fo/nDwDNcWvnvXzLyKSsLXbvUe3H9EZWeCDDMLo9nz6E+4Kp05plp
	fHiO4+Hye3uxhiODT3r+NsMRuas+jWUcUJvEPsKrvcpB6rlJvcddvsGAfZg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49juy6x2un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 05:45:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33820f67cfaso1791158a91.2
        for <linux-mmc@vger.kernel.org>; Mon, 06 Oct 2025 22:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759815907; x=1760420707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haboOX8nrE86yirNHVVxZwV9MxNGuoLfRh/h1+xbQzc=;
        b=ufJ6HJAf3pfVuoSFlfBAThPgEhD2R5cg7mxsF4i3eu72SkEZ2SfJdMEBJHnR1NownY
         R22R8E/iNWWvwrHWApmy1lp2rq/yt05trDWhs/jxFIrVApfnc3Ol9UVuTdToGJ1MXfLV
         1Zw1YCCbgOqGheSXlQ6f2LsURPZ6XDPEEcS9xg7dIxEVcZ8/6AGxsgoGoucod/L7Zd8i
         Ck8M/lsE8NyKIrZhX/I7nADe4ORUguA/ZP4U3yLtgBIAXBr6Wiku0DDb3c2iNe+7PYFv
         hHq1ZQyS2iq1yyRlrnS3Rh1gswtfdeEPbvTYCrCUN7F53PPDiXlyNG2tkaflB+NfdGnw
         NowQ==
X-Gm-Message-State: AOJu0YxF90zC7QcjkBgLZUCUvwDnXlGsqWWfSPDCh+3T6Ex/8rqQdjtO
	SHUnTa8wMCxw26NmyV0t5b62OmumypRLVsDCelIJPVYcVAptnghPUSRBP8zPpf4B2UivWjfpxfk
	799WphPA/5FpDgrB/It44ZB1R/LZ6orPbakhTVUYAvqFSJuDBfo24La2Lw8suJA==
X-Gm-Gg: ASbGncvcmFFfvoP6+/kIBxcLCXCjyg7a2KFT/6AGXHmaHgh3mJoMKV8f+aIjzGQRmsx
	q3KsGSSjS41US6yx16g5Pm58j7nU+MT+Rq3fcE7x0EEFfQoV5fpGc+enTQekKSTA6CvKFmGOvpo
	R2e6Bsfpp38EiH8hY+axL5Osl0QbBYgto8W0xPtDXLM/fXcO7mUwl9+/OsqEmSh2Iq/onTbVyRU
	jSA3SzCVvAOkah4KDNWg6EovfpoGGWIdXX+dXE/EJXDYHbOiL4zr1EovlXS+LNGras7TINNDlxt
	k/D8Nzbe5IKPoIQ24tf47a+TQk8t1H7xkHxltl0oqmUKrbOjorQi03BUUmHgGCp+IBsrd1QKXDI
	b
X-Received: by 2002:a17:90b:1b0d:b0:32b:aed4:aa1a with SMTP id 98e67ed59e1d1-339c27a2515mr9170484a91.4.1759815906701;
        Mon, 06 Oct 2025 22:45:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKsGj2BOgSxlhze96cMSKXMXiS5pzEqDmUCSy2lI8W3FBFiISmCnIBYUBPxWKNp8p8yTm7aw==
X-Received: by 2002:a17:90b:1b0d:b0:32b:aed4:aa1a with SMTP id 98e67ed59e1d1-339c27a2515mr9170455a91.4.1759815906116;
        Mon, 06 Oct 2025 22:45:06 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339ee976b81sm502624a91.6.2025.10.06.22.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 22:45:05 -0700 (PDT)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V1 1/3] dt-bindings: mmc: sdhci-msm: Add sm8750 compatible
Date: Tue,  7 Oct 2025 11:14:43 +0530
Message-Id: <20251007054445.4096630-2-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com>
References: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IrITsb/g c=1 sm=1 tr=0 ts=68e4a8e4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=CJ-gMd5DwmXuTr6oK5AA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 9AqBnBfaYa26yXKdD21eYkZgxJJLVfGy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyOSBTYWx0ZWRfX0nxDCkH7IGUz
 2Ots4xZYOFDwB3z0/upjlvUTcaMg505I0l6++AK2AZS0HVXVb66AlmSGYydCRLjA6Y9IAtAsVsl
 qcxFEZKtDu1RYDjGe+yqv7dWl5SDes6JOpj4phQoQO7CONC9QUiEvamvpV+ouXtUVQbP63/IutI
 m17yj3lC8CEiN99KzG4x1ZTA6lb81kkYloNIKKEYpq1YVDlibb+39kUoWeqR+12gK8YypblNQJ7
 6M1uSiJapxDlpe6++LO8ntv7eQ5rWilMQHmGen2K1+7vglJO0S7jzui2BQ4DXIIrfNB5Jdshbyd
 Ko7qgaXH0GqcMd6SpK6zRNTVuaSy9qWZstzKmFsLBeplSFn23GO35yhwRFXA1CdUv+Gpz2chefV
 H1713bgN3NKAscAmZaIhyNxHBhqiag==
X-Proofpoint-ORIG-GUID: 9AqBnBfaYa26yXKdD21eYkZgxJJLVfGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040029

Document the compatible string for the SDHCI controller on the
sm8750 platform.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 594bd174ff21..027011223368 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -70,6 +70,7 @@ properties:
               - qcom,sm8450-sdhci
               - qcom,sm8550-sdhci
               - qcom,sm8650-sdhci
+              - qcom,sm8750-sdhci
               - qcom,x1e80100-sdhci
           - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
 
-- 
2.34.1

