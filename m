Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8306644CF56
	for <linux-mmc@vger.kernel.org>; Tue, 28 Apr 2026 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386201; cv=none; b=gr5v1cGFtDCCMmn/NN6zBYqzPhGsZYt5ebOodANyRaKs1HewdakPDUcOBmzqzENkP1YSBItL7qBvRIr8sMWbZC7QreyEeK4VrNhqPsqa0GhFS/vc86KQUvOd8dQL+/62z75Tr3aIFhdVD1qCkA33D6CpJTlAvFiNeJ2nTDnAOVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386201; c=relaxed/simple;
	bh=dzIl8YppqJhB6Od+T2zCGC/CJ+cKszHfDpLPF2geGtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eS6p8VUhP5VZB13siGhIuUp/3AKm8XgibCfxCoTeN30ehOLT0tCDr4H21Vf0AVVzvc0Yf8k5de7rE6SAj8V6z6XH/RJsrHMuo461+jLfGB/i4EekpWEkPddUKFjb2zBA6jJYok2QAgHhTSou1/ql/U4o6GWyuKRtwxCtBXKJFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WW78sBvI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VfEeCoYe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WW78sBvI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VfEeCoYe"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SBqmSv1625047
	for <linux-mmc@vger.kernel.org>; Tue, 28 Apr 2026 14:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yCqCzlz4VIr+zRAIjiPoA3dsT7YZuy9FJGQk0vmxxKY=; b=WW78sBvIUBy1eVFU
	njJYuxlMhWipbbcVudjhYGGP+XiDYinoeKFVUBhnPDAEGLfcScUrldggbPiLQx4w
	yRGYnTpOVRigSrjJgWenphU9HcLPtD80UsQ0NPNBxJCNY+Y2nRA0oaebXe1yf2ET
	XnvV+zwf2g5DC3bcqTe4l+IIwbQ6DCiXA1shrVwUbs6Je2t1uHc0Urky9gWUYWuV
	TWmdr6s7Zws1UD2ea8CbD5W5+zyyqfWV/QYthqt5G2CR7BfPyZYhNd+ZBIO8Mmek
	Ci+ElfzTMJxdzLH8mj+xDSTUQDkGLtZwg4YwdNwabusIJW1pSgyugppW5hNzLx5u
	Ey/iMw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtgmsbex6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 28 Apr 2026 14:23:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50e5a336b44so153510001cf.0
        for <linux-mmc@vger.kernel.org>; Tue, 28 Apr 2026 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386196; x=1777990996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCqCzlz4VIr+zRAIjiPoA3dsT7YZuy9FJGQk0vmxxKY=;
        b=VfEeCoYemwkTM59YTf0RVou51QvqCcBtqzIklZk7eUfFk/u/P1sJaeKwZ4ID0BT5aG
         RSwxEQReUAdmnQYKwKrhsCAb44buIOCLX2sSggIvrRASgtkc8LqLVR43JbzcwAyeMF8F
         4XN9Su5y+RAc1sgudX1dTFpfvN4RrOhnLIVatpRnC8oXYW2F/miRyXpffCqluLU2f3uy
         Y/IurEEyTmGO0psUeAAhAaQzdQbxK7YdsprsS+Q1P4VWbBOpjOSeGV/Ka98DIflKk6fJ
         JjM1WHzd/evBduwmKHf62e0wyZmaIBpbjd90oDShmEiBcTd3GYmWcI9FDk45kYYK6bek
         jOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386196; x=1777990996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yCqCzlz4VIr+zRAIjiPoA3dsT7YZuy9FJGQk0vmxxKY=;
        b=bJseGCyfJJj4stveUULIhY4E6b/pLeIaZKRitu7WoBZIqTnzuAIvgXhYDckHt75RcU
         677ysOR2WHggEcuGfQW9+Ml2qwsou46jzINNUsx8HU8eQw97duOGhegTboTROwMWvAI+
         2JLeMZTvA7gFRgoybr5dxq6zref8PE9gbrxVEz+pHYWWGn5tDaHyFhoF1ALfnylTpmsZ
         Py3NyJuzCp0TKp7V2Pw1uatERlO4Vxsyjht0c32RnYMaIp365TuE8xd1luYjdK43Y79S
         FlKq8dIIUrj7E/EZH0EuybhDZBc4PR7a8/RyotxzbYsktHFjNVtiqelvrmbbUXooEwqg
         v4kA==
X-Gm-Message-State: AOJu0YwgPOtX3G40SjDT5Qh99wztoO4nlSvZ/FRWfNLtbLgc1BPZItUo
	P6otneQp2iAKitnjMRHpZywms4kW9PPXAXhrAf3qFnNTGGWb4XfXK7BJirgVpgQip06UJyifHO1
	gle20HpeNrxnNDYi4TdOLjX4PpyDfa6UD93G6kkeYj0aDPJJiOeEbLHhrDM+niM1gtul2562T6g
	==
X-Gm-Gg: AeBDieu1BGdU7Yao0sON02NMyg3RKhsBE7edEzQ4XfQZoX6BrTVrscdJkJGH5dj7cpv
	LgiVTLjn3m/Tsz+rgvvm9MDbmLEM+MJAX4JNRN8otmZeIf5A15u4ljff2fkwWrLg/Ym5V1tmr2+
	y93qXmRVz5wW04BMCdRRW5G/GP3seetTX2Rlfs13BpWNDK//bsaLoz51y/hjna1tXw4O25HK5VZ
	bhDtOvIxxbwwWbsLG/2DHAiWVBEd1mKfE2UD0C9I2i2Mxoan8gY4MZJrjeq3ti3+EnME1pywzCg
	DlHeRcBxP2rmt6iit7amnzZbHfa+TPg0ytz9it2kzlVHpnOKV45cGajIL7Zo7X4ebGcai01j+4e
	LJLtoLhxI43cd8LpKDyVHfz5K9OK+4f7kexYJok3XDiaSdYkPHRkMtA1WdaCCFmxva5S5UjJhrq
	bx0kop1wTYaFUyIQG8SAf4fnXT6O8=
X-Received: by 2002:ac8:5750:0:b0:509:5c6f:c0e with SMTP id d75a77b69052e-5100da85790mr39311281cf.37.1777386196012;
        Tue, 28 Apr 2026 07:23:16 -0700 (PDT)
X-Received: by 2002:ac8:5750:0:b0:509:5c6f:c0e with SMTP id d75a77b69052e-5100da85790mr39309901cf.37.1777386195170;
        Tue, 28 Apr 2026 07:23:15 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:14 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:07 +0200
Subject: [PATCH 2/9] arm64: dts: qcom: arduino-imola: Describe boot1 NVMEM
 layout
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-2-6ad23e75190a@oss.qualcomm.com>
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
X-Proofpoint-GUID: DOrm49EVHuS7lt97f_vTCfecxQJPXLmQ
X-Authority-Analysis: v=2.4 cv=R4gz39RX c=1 sm=1 tr=0 ts=69f0c2d5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=gjCkitBQ8UzLeNF7HDgA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX5Cra7sREZugn
 iKiuh0Jno/x5jbBLQPDXzrifpY8MmKORpsZ7R1BGUDbqDUSLDL5R/aZcj2fJCdQTteu6vWuaMVo
 6qK4D9OYRCdMEH8NiyIxA0bWHqLeSVFc6auN+dOeWrSHwD4uc4D+td0QvfN8NgpFKam12bu55jM
 MMtEE9UQ5dBEktid8WleeBY/jZ9laK9wydmF8INHfXDS5RXgcMvXYiB9oYiPt1JPMbXRqZ+wplv
 fE+3ZxAuEHiWE6LrqQHDnHhgJvgDlsj1UcN+yDW4Zr6q1NgNyoC2hC+ELPrLO3ox0lfVaN5By7q
 eVZtXZKhcjkpW3+Xf4xFi4FmnKaq25LCfo5nZLSlFpDLuByLY44C1vFtATjErhNaD0P9lUiySX5
 6xXNrE8Y7asR3Nps64BYc68uOBIdpY/KGbrEV/NnqN01bBr+YzQjMJLP4dPGCv8lsx34zJwUgVC
 7uop+B3aXLcxcJI+tGA==
X-Proofpoint-ORIG-GUID: DOrm49EVHuS7lt97f_vTCfecxQJPXLmQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280136

On Arduino Uno-Q, the eMMC boot1 partition is factory provisioned
with device-specific information such as the WiFi MAC address
and the Bluetooth BD address. This partition can serve as an
alternative to additional non-volatile memory, such as a
dedicated EEPROM.

The eMMC boot partitions are typically good candidates, as they
are realively small, read-only by default (and can be enforced
as hardware read-only), and are not affected by board reflashing
procedures, which generally target the eMMC user or GP partitions.

Describe the corresponding nvmem-layout for the WiFi and
Bluetooth addresses.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index bf088fa9807f040f0c8f405f9111b01790b09377..dc85cf94f71cac8666cab30ccf37cc2d2f8fd941 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -409,7 +409,31 @@ &sdhc_1 {
 	no-sdio;
 	no-sd;
 
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	status = "okay";
+
+	card@0 {
+		compatible = "mmc-card";
+		reg = <0>;
+
+		partitions-boot1 {
+			nvmem-layout {
+				compatible = "fixed-layout";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				wifi_mac_addr: mac-addr@4400 {
+					reg = <0x4400 0x6>;
+				};
+
+				bd_addr: bd-addr@5400 {
+					reg = <0x5400 0x6>;
+				};
+			};
+		};
+	};
 };
 
 &spi5 {

-- 
2.34.1

