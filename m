Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E4944E669
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427268; cv=none; b=Xt/AUJeI/LB+TtVAS1iHNjDpfXA5KegtWnvXQwUQ8zCz9eypYNymYz6W7cejda+/gbe+GrsBi/+qRHCFiquEGj1NZa7TG7BM9svXIkqpnTOXGRUVytEH/p5uskatfKGQoWa4rdpmd+t4LDUgBGufl5ixdB7ztoSESkeirtcwp/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427268; c=relaxed/simple;
	bh=8FCfjPBXOgeSOCE9oMNfyVBDBWfxZtU2M5HiiMnr1BI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fBWKzKdPFsdl+MWvcFHumR3r4LctIsttwXIIETcD35WZlgG50/AkLnpSijGH+F5dVhVJ2JsCW2aVbyb0hZGgJFWHxKXvTCvHk4XCDTvEKJ7TaGO+QamNB6S5LHPtYKI0GEdD/3rjupqBa/wPMLZHKSoA3vWHyriP0tpvbLf5lSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CoQ+dBJ2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cHrQXpcE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CoQ+dBJ2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cHrQXpcE"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQqpr1490188
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 16:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r+r+249nF6a2qrtXG3fwd0XKqhJprD40LYapJr4TU6o=; b=CoQ+dBJ2w2OXWcV7
	89Yvmm28+CeLZyllRsKsEYx2lctJzjxebUPTXvnncMJYuuM8mG5FftOXEjE7Pbub
	i+c84ERsedV8jQDpkqL/kyr+aqqvCUcojbG6t4DKyuqLvEHA66yXRnE4TVQy22hC
	REpHvQ0DdAwnpUAwQdeUZU7fkLkcTHMeAy/Z10PpKMBKAamGTX9MaUwnXdH3/IBG
	MDiA7KkJal0svawJPgwTk88UazLOKDygNC0qYWI+dM9DoVjYo4aQaq6ZRdj7B3Qj
	8xdnU8MqzLJLaQiVSlkOSrRbL5SFX1RIrOoJFBUS1yoDaOd2WB0Px17lCZUOAVhY
	iGhUqA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8md0drs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 16:01:05 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-73858d44c8aso3127137.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427265; x=1786032065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r+r+249nF6a2qrtXG3fwd0XKqhJprD40LYapJr4TU6o=;
        b=cHrQXpcEzZmIZjPHspRJwPF8XAsOh+YmLHLO6p+OW+uMv9/JnO2b055jSIaTwr1xGo
         k0Cehiih41MReG1igfg94QOjm+cfU41lj/o8G6cNZbpc3yyqSwDysxgQfMBx/Z0U/XS1
         5w2/tw/KLaWqM1ZeGBpq5J+7OLU3KRLQmYz3i8zANNNZz7mTKrlkEr0mmW/tqMHfQI26
         pPNHytZdX8WTQUnSgfQbLUzWjiyMs0mYs3dmjqQ3BeY3MPaIX1RTj3vJWG8fRtiTCwWn
         tpFSlIlPZUzkAOmxD1TBYweeGM12X7BQBsp9m2kRQFZ1X55xt3ZqLMoBHfG2pFv4xVLa
         sgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427265; x=1786032065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+r+249nF6a2qrtXG3fwd0XKqhJprD40LYapJr4TU6o=;
        b=rMgzA3TlbNMU70aZvhjcyIJATz95l6Lds5GPHdMa+u6xE6FdnaMCk/5OC5/6dDZf15
         R3rtpcrCI4wZXJiiSXHSsjYQM/ujsydnpSKdb7imV6iyP4GtRqnhj7euMILD/VL0LwSd
         5EkvmFauCN2npCgx6JnilNebuYiSnmwXvjsEcBKbbIpwSHVLxqSqs+ejYoNyLF9eu5qx
         RYyCZhr+qu0OnlJkSadAfRkvI3XzxB4i0Jv2kPIsec9IfQ7FOuc1hNVUM9+z0xk9CsN6
         fPtCiJxp4ximNDtvR7txPmMqLzKAk/ryyRSrwelmQwGKJI8jVqWUpw4/rOUf6S4aOVTV
         xa1g==
X-Gm-Message-State: AOJu0YwRbUzXueVCFcjrTMfhZbOj9z4lM/3eaxLoQpOB9auwE+Kft0aP
	UirOrTxgBwADr346nj74MDtSkCHFARLrqLroFsHkUaP3oC4DHz+Qols/F4l78Ys35IU10hZ8K4s
	rVrxW+ocXvCyzom9pBAYYECxX4fOJ9LJ8oooo775A/wvlRpON3S4focuwadWaYI8=
X-Gm-Gg: AR+sD11dfutYAjUchAuP/o0+dzSnjmajWaXxHJd2sBCUWZy52IryJSCOe8mATuaib+i
	J3nBqPmwsr8TOd/FUm256DCeTBCOlXLsT+Q5HK/DrM7lgPCKdEHpXja5AK0y2QWT6rj7FfdTQNO
	MGHPzCZKAegFtJusAeNlxT9vOROecY5bYsQN3LY/rix/O010nKmyyHAGartZyFAvk1xx5JyQtQR
	sDY3PG++RxKihALYokN0maPoNHojhH6k8GSnpAXtWn0TzZNsh/GwvDdHsSLTY61r9xRp5s/fcv4
	m7babvKcY2kEoeSlZYsdBxPeQh3hzpe6df0LSlJhlriO9fWxKgmqraY3jI4rarCp9YwoXz7TeCH
	F4v2EjvRvfwlSIJeekVrdNki0MWf3AB/eVozHr6+qJedDVw6kA3j6bGBd4FI1XS0hluOWqS6/uZ
	uE54G9oQy994YVd3Py5jvqcVDBUUPpiqC/ijsRWB/djoFw9sc5qc+V
X-Received: by 2002:a05:6102:1484:b0:74a:b5e3:e96f with SMTP id ada2fe7eead31-7574dfce200mr1067403137.7.1785427264793;
        Thu, 30 Jul 2026 09:01:04 -0700 (PDT)
X-Received: by 2002:a05:6102:1484:b0:74a:b5e3:e96f with SMTP id ada2fe7eead31-7574dfce200mr1067275137.7.1785427263969;
        Thu, 30 Jul 2026 09:01:03 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:01:03 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:39 +0200
Subject: [PATCH v9 09/10] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-9-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=UZphjqSN c=1 sm=1 tr=0 ts=6a6b7541 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: 80lAT9y4MUcqVLWt2jG5TCq2xWELVZ6v
X-Proofpoint-GUID: 80lAT9y4MUcqVLWt2jG5TCq2xWELVZ6v
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX3OV4VcUns2QL
 1mAH+tVK2PTz/uIkirONjnTloBlPkHIGzFeMOK/4sflA09IaNqm+X1pEAXF00ZwxLMxh+Rsy5Dn
 j3NDzRwoENc1FzzwWjrbq8qRyzsZ6zY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfXz+8B+3Rfvlcz
 pURE3WVQgTDpIjFFoZHSFLrcbeXIzoOXwvcixDHT5W1Q3lOnjynsfxxzJmJ6Ef3dkAULnCROsBk
 nXJvmFIAy9R0WoJYZOi8AUvGy9t5eOgUdbrKjuUkxb05hpKFE0M59RtbmAwYclrpBFeKHYfaZH1
 QgW8/W9cspImTyd/h/mYbx+C+14Xuh9I6+ZfiYBdXF10B9e2EvggnNMJwo3zFKjXH98sv404pxC
 wXkVdlLhrCmzcaSCP/CUQvUxsJl+1Sm5nUw42U+AXmLxV+eIGKTczZK9bmbKBajj7dvVA0XTjqn
 KRl7F14ZntD+/dhltG6dYzRedksFRjqhIUsn3GUUoAKzY5z80tIFMZRC8EpHq5dhN0eSsayJtPD
 PrwD2VV+OajSD8TPZNdv0Je8kFn8zq0rO5xVN1bE7B1zmFDTSToG0zPgOsy9TgvhdmlHrTo1/h4
 yo6Hy5SFyOE3tjZyoLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300120

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 04ebe290bc784ea854ec7743bc753c3e41f556d3..06cb787b0559f3d712ec2b88d9e25a7d46fb00b3 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -723,8 +723,11 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, &config->bdaddr))
+	if (!bacmp(&bda->bdaddr, &config->bdaddr)) {
 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
+		hci_set_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE);
+	}
 
 	kfree_skb(skb);
 

-- 
2.34.1

