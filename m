Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6811730EF90
	for <linux-mmc@vger.kernel.org>; Tue, 12 May 2026 04:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778558921; cv=none; b=a/GBkF0xkwiGYRLmu8x34Ni0fdkFQsZ30tHFXctFwnOc4LRaHl2TQ+nPsm+xrQnjZYmDs9pwZoDB+uA4hSDZ3+CFp4kN7tELWML+jbDkgLDCb7jCtww88pBo/eyv7AJ/pqp2kDUTDUzwbLf8OEdTGy1yVT0vJfvQl4l3aUHjaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778558921; c=relaxed/simple;
	bh=15Injmg8rK8ASVqp1eiycQ+rgVM/qUCUjHV9ZKRmK1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r9RkG1z/o7qbfRFhFUIRVJvfc8VsOLDpJS8NkgSSB8aO1sflowIY1nMiRBSjlHpYpe/Ysl2Tt4S7hbYdNgI0unpbzEoIbkJzoDaHnUc1ZYQNmp71L1Ob5sYSrbjZKkU2V+RbRT9U7Tdy2RxlD8cpDY45yD1TBYl/j3F/BX/Az/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HloNPhUT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AM4hHL1m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HloNPhUT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AM4hHL1m"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK895q2172952
	for <linux-mmc@vger.kernel.org>; Tue, 12 May 2026 04:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X6gGgEnllp4zvZoYkPCyMOmUb+keOCb7VayvIxiJ+aM=; b=HloNPhUTK7PWr1y/
	WH7OOakh2tbuJkbI4BWePgq2axLROMe+W25sJLDUNBT1zYC7oCuoFHFLZ508hJbt
	niFJMCAdwZ10iANUBUzVyxbESEZ4lkvhdushTUaTXEo//MOx/bBRJqoapVE1wsyV
	2JszTufhgmHXatEVvJjpR/PmHdptOcRIPhXtXuDh1/noZCoiNYxObWD3QZuroHHx
	9tA4un2uufdDQdI9/2CzwY6IlHRwvXZ83xoocdS9UhIqV3BbmBAiALKlfWvqhN0q
	NmfuaSNpWY0Gwve7DkV04lQpQMzNcrmmWui/MhrFVB3jHRmIb/M9xwmMKzzaFgI/
	M1GQ7A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nvj9df5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 12 May 2026 04:08:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ba6fe41283so59227155ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 21:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778558918; x=1779163718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6gGgEnllp4zvZoYkPCyMOmUb+keOCb7VayvIxiJ+aM=;
        b=AM4hHL1mLNy13Evndd7piMk3kUsfE6kPENclVP+UxeU+9sHfYIHS5lpP9dvWx29EI2
         fJMvMc0D+ZiSjzLRKem8TjMaWcHLgZUJskr8ywzuwwoE06A0qUTgvJX1sJyZOqXtgCCh
         tC0UO2xPH8dzcL95aVIx2o9bd4YFq21hYNgtL8IS3sSaAU3jreiLbu/hWT08nqj+q0Ls
         rFxLukSLxi+hHWyQ9G3G2r+Mp1mqkvfi1pUi94iK7e65lUG8HBJ8ir8igLofRRi0cnBU
         6eJqcJ+4GFOsMegmOMN9C1OHJfUNj52fLJLvkWc0HTMyimiF/YTHskTaNHQU1ymLXcnk
         qKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778558918; x=1779163718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X6gGgEnllp4zvZoYkPCyMOmUb+keOCb7VayvIxiJ+aM=;
        b=lJU1hGkpDSpRihiuFDqAv2EBeuKqmDcRd3ipwbTXMMrhnkIyasn1ZHitn2DTH7o/Mp
         RQIbDtGguwkcqxqSEELwFOMCOsjqKN6RlVN7Jp+WFyUnmIQ1KM1B2S8MWcsrEctI331A
         TzP3Olv3BU7orh4a6ydWIVqZnXlZxyuR685ob1QRyD5mhxgFj6/nl9WcrjPXtMYxeL3+
         EeYFEyRWF55/rfT5vTuBvj4kC7HjAefkAavf4Vb+VDjzhK4oaMeLtUGoogzzoQQB2Fuy
         pMCSlfhv2bgLQlR5oqgFcyiC2cWMVKMJu1CYvZGq14jOQF6AEoTy8gwBWy3dbBL7apne
         TQoQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Z5vfAHKODjV8qOAMWhLCfJOeKDyxRiJi4gvdoqJHrjniQnI+nav2FYpq9pDpuNQlKB5aTRkIRtWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ZCvj737L5Hmkan8Tds8Rv1YHhsFzXgCdZC00TOyrKXH4UAQ5
	hiSecg7sdY04fvPN5+qzh7TTBZBJJDpmBczUQthEMhJmvMoYVJvbQqO5rVvWQhEmBxqy7Jh3+qj
	5gbgP4sp5rZSnPRCfr6aQ7X6Ft7qS4BuujLPHW7ENmWZ4/MNZmyD7CfoFPEO9Yu0=
X-Gm-Gg: Acq92OF/fn+cbi/jg/jAyRXZlpBdd8yYIjLMOUW8i2Yom+2YbJkwWg3bvwNQ/afyVFo
	Do5f5FwVYwTcj51gSAy+vx5Bnz6w3T8pPdQLMgvZBYisPkM8fkPTiLpE5a0tTJ8JXEBJblkF+aq
	ehMgHX3sABsS7+xxX0H8j0nKoE6qHadCbH4gEUiU3zjYWP9G2w5ahEm/JsdQaxwp8f+wyaA5KMC
	w+S0d1WAkcje2k0wXZ3slVyzbgf/8al+uGr6yFh2lLuYqWu/21tkLrwiupc8Lmnoqa10IpKMkmN
	746nCvAz3FXLb9OHFxRmE1nPNvxdPsxHzdKm42Ki/tmKVQch8MsWzlFFJyininqY0kBknKejGVp
	x8/4gssKxkRbmBs+E0ZOSLhjW/tcKTlhguxP1
X-Received: by 2002:a17:903:1c8:b0:2b4:65d8:6a20 with SMTP id d9443c01a7336-2ba78f50177mr287506425ad.2.1778558918386;
        Mon, 11 May 2026 21:08:38 -0700 (PDT)
X-Received: by 2002:a17:903:1c8:b0:2b4:65d8:6a20 with SMTP id d9443c01a7336-2ba78f50177mr287506055ad.2.1778558917826;
        Mon, 11 May 2026 21:08:37 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d405adsm122646725ad.28.2026.05.11.21.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 21:08:37 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 12 May 2026 09:38:04 +0530
Subject: [PATCH 1/4] dt-bindings: arm: qcom: Document Shikra and its EVK
 boards
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-shikra-dt-v1-1-716438330dd0@oss.qualcomm.com>
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
        linux-mmc@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778558905; l=1405;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=15Injmg8rK8ASVqp1eiycQ+rgVM/qUCUjHV9ZKRmK1w=;
 b=qsd+1ESlEP8UXvDEem+D9Z3wOKU5SlGZVippPIxIqbom5EjN/hps0owmuD6qyom/WZlyQsIrd
 rFDT+XPk5CtCmIIk3GlfKNMXLOIf4AwITOLAjL+jl3JRr8Ro0Q6zjxn
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: xQ4a2WHbo1v3qVxVEVy8ilqTxFKtrG9t
X-Proofpoint-GUID: xQ4a2WHbo1v3qVxVEVy8ilqTxFKtrG9t
X-Authority-Analysis: v=2.4 cv=H8brBeYi c=1 sm=1 tr=0 ts=6a02a7c7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=s3D7Wza4eiaRwqfIe7sA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAzNSBTYWx0ZWRfXwCSTnzMHM5X2
 NnoWF2EBfnzTsCcKNuKgqGYfwxJwskvwRLKum36e1WkDJpmTrjrrznBm+qeHv3DH0Wm0GCghgRe
 ic4ADFcJbItqcACOC3/VWScTXefak4j0H3nnp7Nh9kqK2K6ml9bIf2bN4hQcTLdNyhOzQtGxU1c
 SGgLG/gOVUsFmay5TMyC58RnuatdX0/vrt4jdnwy0dLRB2V7xFGn00DwtSMVsPVpc2YeuYkqv48
 OrRJGi/G5PYR2musshA9l8QMnNHwzO8fN/R+E2JHwwYpgFoMc1wJSWe7Fec5uZTcTPI2ZqbtLpd
 c4nxFcFF+OVGhpDDDnO85AwLlk7s+4dIe6F8/M9XF7R5LeIK6A2HttGujBfJvw34Z9UYoc3MVBE
 cefpISzsYow59uvjYiDFPcfcp/HuhodI/spbmhjOJ/YoR3f5ffYUJzOvW7kGKslKrbb8aVN2pek
 t4taLZ8lS/m8vXChMWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120035

Shikra is a Qualcomm IoT SoC available in a System-on-Module (SoM)
form factor. The SoM integrates the Shikra SoC, PMICs, and essential
passives, and is designed to be mounted on carrier boards.

One SoM variant is introduced:
  - CQM: retail variant with integrated modem (PM4125 PMIC)

Two EVK boards are supported:
  - shikra-cqm-evk: pairs with the CQM SoM
  - shikra-cqs-evk: pairs with the CQM SoM, with no modem support

Each EVK provides debug UART, USB, and other peripheral interfaces.

Add compatible strings for the CQM SoM variant and its two
corresponding EVK boards.

Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 2741c07e9f41..f041d71d7957 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -963,6 +963,13 @@ properties:
           - const: qcom,qcs9100
           - const: qcom,sa8775p
 
+      - items:
+          - enum:
+              - qcom,shikra-cqm-evk
+              - qcom,shikra-cqs-evk
+          - const: qcom,shikra-cqm-som
+          - const: qcom,shikra
+
       - items:
           - enum:
               - google,blueline

-- 
2.34.1

