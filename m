Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0546AEE3
	for <linux-mmc@vger.kernel.org>; Tue, 28 Apr 2026 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386222; cv=none; b=k/8Zl/J1BYe47bJS47h9cWdprJw/8p5ClgMV1H03/bF2dWyszofMXe+LUsjIHaFeDtebcRwKCzSaaQF9vCXAgn7r9eNti9I+dQOHtijppENXsh7sjkQRSwG6Ln8jAdmxBWR6ZigF7sadhrA6xIOL093eQeJT8i3NYzDWYAG8eK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386222; c=relaxed/simple;
	bh=n11bfCJoefHvmThlP8x1PiTVeFVsEIhjZBpXIg5IZ38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q2mdny+YqyyB93asXwHg0DqT6mr/LkKzPVdl8/Tqax3qOg85GkQ0+vYAtbK5oz1NX1HKu29NZsYx8LU/1s4cmdDtQiusPJPUnr5Tf9BwW2zGyrX1w+m+MqWwZxJglcENR4+hezMddA8eql1yr00wSMRb72W16ExwWFRjoAWSmTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iPGoa7ID; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GkDUHFtK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iPGoa7ID";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GkDUHFtK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SA3uux3274958
	for <linux-mmc@vger.kernel.org>; Tue, 28 Apr 2026 14:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w+OP4W0xAiPDjd5bYE2eMNSeXnhE/RBCJAZjyE4cLE8=; b=iPGoa7IDfNVUwgax
	iQmx3Hn13dlYxiKhW6NWQgJkVCcfVhWY3w1NXgiUS/AO4kbXtAzsbJqfdPE5LbOD
	aMaZdelub8/Unp8pb+HXCzEQBsR8xginxDxZ9BlF6F2PJ0wLwDzUrqo+sdtDjJgg
	8FcBPFGCgBaJlXLIhj9Wis1DcxlQZz6GYLY/WXYtai2KxqkaTJ3x+/fi70R8b0wg
	68KmHm/howOh5nqx9HVMUGO44qYYBxUDt6ASdrC9UxNoI8W+c8giWCAV02VWXESm
	vxIU4fZTShIm+pLIAwBfOkXCqylEyi+86em422/0qZen+6+ECfncdGkpPZGVtiQ0
	f5FCwA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtttjgy7n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 28 Apr 2026 14:23:35 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-56eeff9a2e3so19652528e0c.3
        for <linux-mmc@vger.kernel.org>; Tue, 28 Apr 2026 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386215; x=1777991015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+OP4W0xAiPDjd5bYE2eMNSeXnhE/RBCJAZjyE4cLE8=;
        b=GkDUHFtKN5UxgNeqWe8HuyqPh2iPoDbuY1EIbLJnrV/iE6Xmbb/byjlF6F6LGGm9tO
         4PEj8le9+2jbvWWgAzCMkjo9+r6VgeZcWWlIKW2gFiBkMFSkl6qA8ozQvjm5Z7t2J81U
         eUserXL++X9qM88evPez8gn8MF8qXt8XNjWOptD6kQmDwqsMBMvbGW3bQKUw+3k+jJEA
         yuJy2g3naX/3tG6GxaDhgbM4bemRrq8wkr7gJN8rsuI7AxFCbDJymmpUX3VTNi2kAeCV
         T7emqjciWneRVw+IrlD/IJHe/D+ywTCSEkkA1Acp1Bxr6ED/lToeL6liCJz1kg1LoHyp
         q2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386215; x=1777991015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w+OP4W0xAiPDjd5bYE2eMNSeXnhE/RBCJAZjyE4cLE8=;
        b=Gyrgv3ZU0d2wfXuftkPP67jFZBJc4vsh6xHptMIPkJf9mKOTBTlxCD9PPQ+ZnQnwwC
         XUXZPI6ctgdox6ItDBMQAQiTE8kj2ABjcGO4ecrHha/i8w4o2P6BS+In6r0S33KJzgxO
         7EAIcBz09K/VCnJ3ZXQy7pcdTlVG3P0kQgxSOGaDq4trNfXCB6saA4JP1F4dc7zel5QV
         GihdSF+2Kay+nxau7Xfi3G9p/TEVbUYU6PAZv262/XNJP26baV0TJnZiDkqjif3BiPsa
         e7AUCKqftLVp+iwUE2Ei3dcQzQ6p3iYRw9SkhdP2c0uOjOCiGTNQNEltyDK8itzG2tfd
         M9/g==
X-Gm-Message-State: AOJu0YxbU6+kQ8fhjHXMoHIFTNX0bRP43mjNLd+H584e6Wj0rp3IELi+
	Zjpy7mzmiysKB73Kz4e5VLy2cMtT9jnEV3XgNZwp2n9UY2283KFLeDiCa6tXdp7l6sFUBY8hp6x
	xU3/Gl8lwSoCegY6qc6fkFGU5h+1HGxS4eOUejneV9AS95SRJJZJldnyFWqbFeKhvw0KcSoo+/g
	==
X-Gm-Gg: AeBDietllcid80hta7my/wvW/NONLaXlBCMNhOhepudjhi09r5m+LPJOuTCtgMoDc/n
	ZAaAnSwN0nXysUIWVLUYg5ui7Ol99Su8koBE10RK7EVZYuthOWjzXZ02f7i+0AKVAT9cv0MLJu9
	nu+Vf8gwOU10uKFvW56P4gsAOnyTF2E7yl9F3e+y+L9DnUw/QPclhMDspcldF2T/zfW36609OY8
	uY79O6cjzC8ncCLvw5WoVdW0qqAyh1c5Uu2ejPPXZnBkTxLDaZ8lPBUi5KOjwFb+bMf23FKdnTM
	1NavUvIQnW1+C/rIDpbciRVZP8iJl2M/0w+gNgAf/nteIWeWWHYqWuTAw8FitgIUHtqGlr3Ny9b
	C20x8zsY/nENleowEX1lh/XBbj2aP+8Q5/73D0SPjYbAj+/i6/L9lh8rSokNQyNH5lNbbUaHYwV
	eCYbRKb0cTzGmhKYdIs4hF98y2B/s=
X-Received: by 2002:a05:6122:4201:b0:56c:860b:c34e with SMTP id 71dfb90a1353d-573a55b83fcmr1687309e0c.8.1777386214684;
        Tue, 28 Apr 2026 07:23:34 -0700 (PDT)
X-Received: by 2002:a05:6122:4201:b0:56c:860b:c34e with SMTP id 71dfb90a1353d-573a55b83fcmr1687200e0c.8.1777386213784;
        Tue, 28 Apr 2026 07:23:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:33 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:14 +0200
Subject: [PATCH 9/9] arm64: dts: qcom: arduino-imola: Get Bluetooth BD
 address from NVMEM
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-9-6ad23e75190a@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX6A5qdpZOA4xz
 NvxgP41svKV9jr1Bb2DuOpmzPq62Jn7ig15jaHUEvMJFcUKnktjQq9cUYfofEIRyBp3ksXBwxHV
 Vo4jDORSEyQYS85f3aC9jbhbVp/xDnJJNFuz/9n3VOyqLegOutRvOMqDvV+/bqREaIay1QbcsSs
 VNL5HpLd97LOCUBA1ujEw2FwT2wHMqbhpKpNJBb0kUxe1F3CoEA8b3xub30sf1qy+IaT+kCzbel
 vCQ3BNJCZ9YjSZoUyYiZ8S1wTSC59KVveDBWlY4Gk/xzqKpk6qr22yd8NeeMDJd0ft/fH57S6Ji
 E/+GGZuUv4AVSlTuKRBXZRKzyAj2IQMPjyAoGx2I7BV8C+Zsi5DZD65b3VNBe2AuR6OMRBpGMPQ
 IxZqBHgYdoblQS1+EWHRTjqns/ozKqloXJiAHLlXRkoB49kMLPQG+zpbBzNrDA3MXF2jrKTRed3
 lCShrCSddS1mA5NTYkA==
X-Authority-Analysis: v=2.4 cv=TZKmcxQh c=1 sm=1 tr=0 ts=69f0c2e7 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=w5cLSrw8bnM9wMX07V0A:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: nTyXCSiAbNeicm4hhHbENEvEM-qyOHyX
X-Proofpoint-ORIG-GUID: nTyXCSiAbNeicm4hhHbENEvEM-qyOHyX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280136

On Arduino Uno-Q, the Bluetooth Device address is stored in the eMMC
boot1 partition. Point to the appropriate NVMEM cell to retrieve it.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index 35a30cd6f47d6d2e018f6841a05fe929fec15738..109fa76e05625461935e321e15dbfe6c7d452e78 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -536,6 +536,9 @@ bluetooth {
 		vddch0-supply = <&pm4125_l22>;
 		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
 		max-speed = <3000000>;
+
+		nvmem-cells = <&bd_addr>;
+		nvmem-cell-names = "local-bd-address";
 	};
 };
 

-- 
2.34.1

