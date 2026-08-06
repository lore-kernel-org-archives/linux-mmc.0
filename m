Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D2647ACDC
	for <linux-mmc@vger.kernel.org>; Thu,  6 Aug 2026 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027157; cv=none; b=VvWJlQFrZSuOMpuj1HY4tJZMu62HIAqMD/EINtL0KW8b8YjRiS8Li/v/Yxb9UHI4t3Ph/lR2L5toaMeiCMUL+wvoP7V/d5PW4qQM6h1hoAhM1kqiWFkQ28LkOiFRw1N6pWeUbGZOnIymvYWa4H/19VjIX9VoepidsQiJNMuQYU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027157; c=relaxed/simple;
	bh=8FCfjPBXOgeSOCE9oMNfyVBDBWfxZtU2M5HiiMnr1BI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JjLkQMypKoTB9hqGXOYiRZwGz7zCAkTXFpNCErDY3WSCJ0O6+FRyVEgqZrxDa4zaJlsZ7XZrFzNj5miBFGVTarNm780AkDlBm44TabtVsFWsh/PxuPahM1VsHnypeItCiT8GMz7y4TYj8bgsqdlCwCIHC1PjD6BFMeLMcFsucw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QiS/BjLC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KxpK1nvC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QiS/BjLC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KxpK1nvC"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676BwnBs3037260
	for <linux-mmc@vger.kernel.org>; Thu, 6 Aug 2026 14:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r+r+249nF6a2qrtXG3fwd0XKqhJprD40LYapJr4TU6o=; b=QiS/BjLC/B/ZEeVX
	leRVFOHaAJqMLNNOkf2Jz8C6MGNXVKN5Vf/0NWYe41lq8NiS1jJPAV3YsY3ZOUNs
	828C4l6IgPKiuUH9sVJXPZUZ085ZneGDG+p2OKNlHwsdG+fW41bKbCeQLr8hHJc3
	lKivAWR5nCfpgOhkRRH8A155NsVkGDA/oChU9txG0xMG/y0xq5MBWRurXXoTRIEF
	kyXUAFfO20Y98sbh8K3eRAvfb9xHes6C/yLXmWyqSRdhSJjVT6ki5NH3cBDLNPAl
	1w42y4alJ7hBsZ6gbmV5NPkMqY0IRRSxlgO9CsWyiGJa9+7r5nAehiEXA6VjAla5
	noHa+Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvsvd0spv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 06 Aug 2026 14:39:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5174a236220so21691611cf.3
        for <linux-mmc@vger.kernel.org>; Thu, 06 Aug 2026 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786027151; x=1786631951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r+r+249nF6a2qrtXG3fwd0XKqhJprD40LYapJr4TU6o=;
        b=KxpK1nvC3udKWFMjX710IHO95Mh9MzDbIabdjk6y0Q2dCuhRR7hfOuhRVLcHlEccTS
         BkrCXMlwjAU25hvgcXXHGX5BuTT5fGSewTdRnefx18uZPHUJY//Yp2KihXKV2E0c3Iwt
         nf8JRNW80jlgp7KO+wfGjjwKu8JvFV4K+5rZdsY3Qka87QPbDM1iwgb5D9AjHBt5wv+T
         ztENrCn2BHzrnS8aWj5Iz7U25u5PYRhV2MpAB51UNe4x3Rq52dLRqIvAXW7n/X84bqdd
         1FOH4BIKLbTknbqJl25Z3DKLvuIIy4MssuKX7OXvDI0SiOXrpr4CnME7uoUukUEd6AW4
         WtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027151; x=1786631951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+r+249nF6a2qrtXG3fwd0XKqhJprD40LYapJr4TU6o=;
        b=CUzbP5TKnbYtu1zYNqESoyzcLQ1LKbQOnPvfm5QWPS15VLNlE0Gaddp29x0Fvh0wmy
         lnyBIkrODjBKmW4rQzL2WdNoNKoZQcLqNHgAW/G5BOvetKk76xD9jAK8FCYHYTuna0Y0
         lGN4cug5RRzIT5ZDbn3XNJLt4wxNIfnTqw1uJicFJUuTBEFKhzskCLEZ8LRQA+BCiQ9I
         Z+aTbCsDiNt7wv72DnRsA3/RfZcWBCuIpbxvbZfP9KxBpDFV01dQR4bZ3KdDEU/jN51y
         n3KjiegrfrEJtbe7NZ3mw7QeZ4ID1h+ekRJXZeCI/tCX9pRdnS2oYOHKAN1ds3Kbhyyt
         gHZA==
X-Gm-Message-State: AOJu0Yx0dWisGBaCAqlWRTm78N29+uAE5zrsYYBJpICNCverfIMspOzf
	/tH2z2IGPPmUnhzK4OOxmmC2xm2EzVqz+hYOiPL2Wb52DtwxSEqf4V+qEQc5HXF6ORch9+72kCT
	/DiwDGVCQ/jx9bcns+R8QK2q/DYASczrXhSF1Iliv+iYSjKdhyAtCy5SrZdEgjwo=
X-Gm-Gg: AR+sD11VEUlLrUa04dc+gBDAlPyB875zEQ4Q7XAfP/gTMQEmopTWxV8mzbzyXOs0puH
	DSrkeIlEp9zZMfVHtSEjRPGR3CpKB2R5t53Ydrryqjc7gmu0ugL7M0wvfpcyauyl2JcPXLBcxCZ
	+uSrctQy0zbWL3e0rY4h7Q8j3aPHKaQhx7cmcRfUQ+4fW8yJ7yTFWoD8somzoHNGaf08Mchfnc9
	70IygdklO39W2wNYonc/z2aUIFY2m4qle19K0IjzP2cx1UbwlAVMCeTYy6nMxTALQTRPZitsluN
	7VqKsapTsTL63nRcyIaWWZOLmk8RgdnZw3rOs3aY2kQv6siUaVC3P5k4iu6ieelzzYBSLvHBuVb
	EUopkccr5f/gj4l58y2F7mzdxQU+r7ELyckrZvj6wE12m2bbmasWHiPWaGmQ0MiMcryL/inqEXC
	PtXwjIPYC9GiqG9JaDOtsKIq8yZtKlIsC566aEX3IO46EfO4VwdA==
X-Received: by 2002:a05:622a:998:b0:51f:20e1:137f with SMTP id d75a77b69052e-52ce6035ce7mr175976161cf.19.1786027151142;
        Thu, 06 Aug 2026 07:39:11 -0700 (PDT)
X-Received: by 2002:a05:622a:998:b0:51f:20e1:137f with SMTP id d75a77b69052e-52ce6035ce7mr175975181cf.19.1786027150660;
        Thu, 06 Aug 2026 07:39:10 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([90.85.108.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm270552166b.28.2026.08.06.07.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:39:09 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 16:38:42 +0200
Subject: [PATCH v10 09/10] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-block-as-nvmem-v10-9-be598b2a5606@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX0HByIyvB3F4H
 Fge2JW0TUf6wT9mX7OoSHbw3Z2Iy5dKtmQa0nsqxoXBYdOTYrUsAoQSKB7owFb46QS1DHMp9Bwj
 Gk7bIt5ff46L4KPbQ1xK8EodiaafZrg=
X-Authority-Analysis: v=2.4 cv=WbY8rUhX c=1 sm=1 tr=0 ts=6a749c91 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=JDRa4Jy4r6/BpSpxP2cCow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 9TQ__i9pIf2POdQWtCMidUICkaQivojT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX/NGxx9OJpPHL
 dS8ENjzS+RrMdZJzjQ9o5sDf6EMUG85A+uA+1Q/RxyKCizJmfhdMXxtvJ8BpZD0wZbVq4UEE0Ps
 ScMvT9hWRJQeTj09MflF48a7af6psjZMLEhVy/Kg+8aDZ6rRIMTIr8NkBduvZHn1moWS4HeI9Fz
 eyCn5RrmjeJRG4bNchV+x/Bx5SR4Yjd08ijJWVGpXRH2vvyPXR87oMUXLwbwPEHKEl/VglHkzVf
 wBTsPzek38hTrlJ+DSoRRIEYsAS2K/qF1DHq3ksDkyePRVJFbhYOTpF0YP7j2v+BEf4sxkxIzMG
 Prk78S0byDMkCyWz/l7xWsePFfxOwYZTmo3dzWQNaCpckRk+zkCzur+hnA44n07yDkkySuG98Vv
 EzdZcgTetFM7jR/3Lf6Y6JcmcqygIcRYdCXDQr2PbqxoliQovAA4vb1QqEyuOQjyc2fDAQuWXAq
 A8+wCmL463C85S2D1kQ==
X-Proofpoint-GUID: 9TQ__i9pIf2POdQWtCMidUICkaQivojT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060114

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

