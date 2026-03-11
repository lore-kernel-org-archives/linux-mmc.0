Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE562BF3D7
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222357; cv=none; b=Jix9MvF448DJmTXpP3jMHUkWtWowgt7bJYLCWACxqq6C1Kf4MGfewMGiIQuFjvOgOZ3RBps/S3/3GhU6/8r57Dj5Nh14JupRsG83CNa9QOQNUO8ev/Q41ekekXgvV5nWWMgsJo1dccqixHoxTcceB19v2HW8jEcNSSpk8O+uw8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222357; c=relaxed/simple;
	bh=eviXIYp4+eDp8HGG0HEzP5fhxPOfHlKuW+1tv7onERg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OTWSmtmrLo7Tit8wfkKeigYpb7mLDCXLOUUzFwuTyuSqUix4kxqqTCox9Hfr6KnANIO7uGFC+/rtPLUw/uU6ybbK7+IHlh4MXm/+h8yyUBd/Hr2arEWgZzMAAGaczuIdI6uNRmHAdLeIORHJkaydf5d66aqqXvsOQB+JkMsvVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iZqfmXmW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b8Ec0JVQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iZqfmXmW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b8Ec0JVQ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B9VD7R2179858
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 09:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2tXyMSW1oEmLQusxgSGNZX
	zPqI8wrzYcRuxPzyxCXjI=; b=iZqfmXmWFV14MX6cr8QujjBQrCTNQy8NP+KawW
	myNRn8Wsd34MB+mujsBIwpy+N3Yw3hjRX+bXlPo5QdQtNB1aSXgumGg9bIqLIZf8
	o1hb5XtrSxWjuD2w+VhPp1XZFB1e022vSxIfVnOERVF58Ya7hyuzk3zDqz0TwqMs
	RbRlhmrRbOhkvy24w3ZacOXtT4xSS5YmiILzTYTzx02uoSsGUKmGoghLjCaminLj
	BKo57SiNYPD+NcqsBbJlMiFBoFh3lKQytyO+B1lUfJ7jeTfvfhGSEOoLDy/nwtLp
	vw7Hv5bMLnZHCJwh5KuPtW56sVYsT3bav/fGeWo2beulkleg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqvstw3n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 09:45:54 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8298c733f52so424661b3a.0
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2026 02:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773222353; x=1773827153; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2tXyMSW1oEmLQusxgSGNZXzPqI8wrzYcRuxPzyxCXjI=;
        b=b8Ec0JVQGyld3JJjBL6OcbaiMfCxRpcFMXkUBGbWLQ6QsgAtparFQ5dssGfXXkzrvG
         pwfMqTv9OhFdlRZSgOpKx2tVS2lbyR5V0v5c9aotG8rAhFosTOqognCPFu0vHGDwcnMe
         GD1335FFX+pnuisvaCHzxHw9O1SobJXSuNkZRRC62ihG75n2yIuBy4/QHUHdhDqznNtY
         cvyQ9jsgfnAuWbZylGqyIAhShGKYvpjIDYsxA4MgZKuHPC8ti/dwXnN/CxAO4b6aPFGN
         xxnQUVWzRdyyP+4LDAWL1er/GSpSrU71x9y5u5hIknE0XrHv197TKquoVaKKqTxa1flZ
         aWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773222353; x=1773827153;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tXyMSW1oEmLQusxgSGNZXzPqI8wrzYcRuxPzyxCXjI=;
        b=WLEUYLE2Y2cdrjyHCS+ZTPQr5Xo8uj25k+fc34Jo6R++Hc/xjS704yzAp+Z6laMkKV
         3xAbwQOxC7StPSYIkZ/EhNYWjUF14m36XTXjLo6EyBJ5ESe8cTawt1mV3INwp8rTNUkx
         dFd7LiB6HKZk18qGtvnesoe3BpdT21rM36dPe6e9k9Nk4ObI1fP6mkYRQP+qktCUCGVq
         zT1xEoQfAEDoablyMaeEaG/dkQy/CZuepSSvaZxrlXHyUAMleeKfgBz2yZKS8cGIL7Ux
         bFLtsh+unYAzSR3lvkmSwwYo6O0DjRI2U8sySG6mjpEemW4fh13/bEcykJ2DXyljqByQ
         e1NA==
X-Forwarded-Encrypted: i=1; AJvYcCUBDpNOy2yBaMDNaCAA6JHomBttBa6qe5+c+8s/iY+Kv0SZPfCNXyJSbR4TO0AvAmizz7/bs87n6wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzovGXmkAeb2tMKWXAXxfHq7U42PzvaH8W0+CyuKGQNEzGlPdfN
	t4vHtfCwWFodnf7NvAJfEU0aqMxlZTeTQzC9ADQcT2JRyMD3TRQAKacBgaEaTWkDOCVGOwBAoqs
	jwkAQaPIXpruIY8hwEPy0kCug8gLgdqk6YScFLpmRXJvWb4Hj1jJSxiqYlBc3N2A=
X-Gm-Gg: ATEYQzw46B/oMIVQS1VigIZqSJB9O7rRJsVCy3gEpFjXXIPGe/2nlb2NyrZ7qVIPMBy
	kpGy9aHW6nHVySyjVOt2NBepFKzpJKU4SElozWFjAWv1xhkDre1ZUJX4EzDs+CKt9tGIglmoGCH
	vE9J2/etdrIy0m9jZKAcRbytoFxQXw0YWntLEEI+mjpTmoi4oVYvHTOdFPbxrhCkIZLApnM8tK/
	M7xtuxifYGSfAdarnIQLyijpaYfV7/oij+8T6hH/R36pUdJcj+h5jzhPgGnP6cf82FR7YRQ2n3u
	Kl20CP3JhS/vX8A6nkUMI1bmCRsRBjYd5cu69g1eXsKHjn5KQx3AdJDNkFPZCnDElvrO221NA26
	Vd4de5jo2rycVVlwUw9LRPQg8jBOb9kTM7OouSp6pN3IhjlOYjZSyFgRXgyPI4+hJXOE+rtCRL+
	h7q5bFmiW+lJ0Z0mkyvdLldnkBhIHfhtKbfVeEbn361GwCHNYU11XNDiWR
X-Received: by 2002:a05:6a00:2e21:b0:81e:1b77:9e61 with SMTP id d2e1a72fcca58-829f7aec3b9mr1907952b3a.25.1773222353521;
        Wed, 11 Mar 2026 02:45:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e21:b0:81e:1b77:9e61 with SMTP id d2e1a72fcca58-829f7aec3b9mr1907936b3a.25.1773222353019;
        Wed, 11 Mar 2026 02:45:53 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6df5ff0sm1677403b3a.21.2026.03.11.02.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:45:52 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Subject: [PATCH 0/9] Add minimal boot support for Qualcomm IPQ5210
Date: Wed, 11 Mar 2026 15:15:42 +0530
Message-Id: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMY5sWkC/x3MTQqAIBBA4avIrBMmS6OuEiH9TDUQWSoRRHdPW
 n6L9x4I5JkCNOIBTxcHdntCngkY135fSPKUDAqVwQJrycepVY52cC7a6GxYadtkWUyD0UZX9Yy
 Q2sPTzPf/bbv3/QD9J+vpZwAAAA==
X-Change-ID: 20260309-ipq5210_boot_to_shell-43db656579f0
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773222347; l=2640;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=eviXIYp4+eDp8HGG0HEzP5fhxPOfHlKuW+1tv7onERg=;
 b=kJs9VJObKPcudpWltfXd1Qb50PPNBfrTcgJEEIC/F6WdErLIWUhwc7572vvZfrOYf/oGpK0TP
 y6Eg+2e0UH3Cgz9cp5pAmGiT8REVvYfBr5Lb3xFC/Nija245CtfnUOA
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4MSBTYWx0ZWRfX9lZtCP737aZm
 HtvTGeIjshEfoTcn2ymMg3+uqEdVNdxugKAuzv8FwMxW3WCLiMmhFKBzEnOkTjeXnUzA2cVB0b3
 GuRfbUgKficSl+pdrBA2XZjJ4CmM8b1eJ6qaMdjgl9yhDTzrd+W+ogVQbMhaU+N5JOf9fqAU5KX
 ZSf7/01qNSftd5qOWTEcso5kkK0UVkF4xNcIkwF0bUg/uL7awKrhgrl+NIKBa99pVEMuLWTPyKA
 9cAx1+r/J1nObqgQ+ISHzbZ7/8YsdOLtNRuYGSJ3n5sUKWV5fNBPCWqC7iS3wNf0mNoyivKYCTq
 C5H/+8mbFePRsld7hUnzyo6wkQxPngPIU/ZrHcSeRwfkXM6nF7DUEmQiGA00FJiPkEJbcb7WcD/
 qS7FhaeXXSEtGTUMW9Iwkf25KsGz8TOnjx+rm7Ks44XpLxUcRBkSxDGAx1aF5UUheLMxA4KXZhA
 LSBa772vt0drLaFWodw==
X-Proofpoint-ORIG-GUID: aMl1NCopt-Fctisfiuzp0e6NXhzfjgBo
X-Authority-Analysis: v=2.4 cv=Lo2fC3dc c=1 sm=1 tr=0 ts=69b139d2 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=iO1PHWQBdAPoGl4AmagA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: aMl1NCopt-Fctisfiuzp0e6NXhzfjgBo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110081

The IPQ5210 is Qualcomm's SoC for Routers, Gateways and Access Points. This
series adds minimal board boot support for ipq5210-rdp504 board.

SoCs based on IPQ5210 is shipped under 2 different marketing names such as
Qualcomm Dragonwing F8 and Qualcomm Dragonwing N8. The difference being is
F8 parts has the Passive Optical Network(PON) interface which acts as the
backhaul where as in N8 parts it is ethernet backhaul.

Qualcomm Dragonwing F8 Platform:
https://www.qualcomm.com/networking-infrastructure/products/f-series/f8-platform

Qualcomm Dragonwing N8 Platform:
https://www.qualcomm.com/networking-infrastructure/products/n-series/n8-platform

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Kathiravan Thirumoorthy (9):
      dt-bindings: clock: add Qualcomm IPQ5210 GCC
      clk: qcom: add Global Clock controller (GCC) driver for IPQ5210 SoC
      dt-bindings: pinctrl: qcom: add IPQ5210 pinctrl
      pinctrl: qcom: Introduce IPQ5210 TLMM driver
      dt-bindings: qcom: add ipq5210 boards
      dt-bindings: mmc: sdhci-msm: add IPQ5210 compatible
      dt-bindings: firmware: qcom,scm: Document ipq5210 SCM
      arm64: dts: qcom: add IPQ5210 SoC and rdp504 board support
      arm64: defconfig: enable IPQ5210 RDP504 base configs

 Documentation/devicetree/bindings/arm/qcom.yaml    |    5 +
 .../bindings/clock/qcom,ipq5210-gcc.yaml           |   62 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    1 +
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |    1 +
 .../bindings/pinctrl/qcom,ipq5210-tlmm.yaml        |  141 ++
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts        |   93 +
 arch/arm64/boot/dts/qcom/ipq5210.dtsi              |  304 +++
 arch/arm64/configs/defconfig                       |    2 +
 drivers/clk/qcom/Kconfig                           |    8 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-ipq5210.c                     | 2641 ++++++++++++++++++++
 drivers/pinctrl/qcom/Kconfig.msm                   |    8 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-ipq5210.c             | 1156 +++++++++
 include/dt-bindings/clock/qcom,ipq5210-gcc.h       |  126 +
 include/dt-bindings/reset/qcom,ipq5210-gcc.h       |  127 +
 17 files changed, 4678 insertions(+)
---
base-commit: 7109a2155340cc7b21f27e832ece6df03592f2e8
change-id: 20260309-ipq5210_boot_to_shell-43db656579f0

Best regards,
-- 
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

