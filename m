Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8882344DAE
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915857; cv=none; b=MC9zdkL9wX9dpJ6p5xpy1dMbGAIuTwPYUU4RPRTAyBojHC8phiOe3XJ7wQixQc0johgl/icjWclhga8LlZeKO5MRH+ZyP7N671am/Fs5Lu9LrqMhYA/henST5JWBYPKsUjBwpQ73HRTcBafJJ5usVNwWCekN/46TtuyxQ+IA/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915857; c=relaxed/simple;
	bh=jD3L8jwoh7BLSovJJN4zvcH6m1V/AR7MZ04B9wQ9s00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7F6pjloE7g4Fwx1XecW9qL4rWwkjNfGdBWuHHCJkAoHGLjEsoTWnOwNPMHblv1goFcY7L0LlnaVY1G39rcYagESgpHcBd4COW6aY+3aMSiyqlZbfoy/atLSXCtc7rUiwWwI8BtEMMOEjR53ciK16F9ywiZR8w4bKLgAUkaEqrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hZQpRPo+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hr4bCXZY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hZQpRPo+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hr4bCXZY"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586PjTp2733082
	for <linux-mmc@vger.kernel.org>; Mon, 8 Jun 2026 10:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	41nbnSBEwQElk6GtkzYHQTOlycyPOuLRHHoqlbc4AwM=; b=hZQpRPo+nxilxMSI
	MMd5pcC9T+mAN3WIClek06Ot8+e/Ai2PmtXJR1Bu3+KZbDdoe2285pscWypVAbn4
	Ur3BnSeo9OH2q8sbNYwqp3BPlAKJ7q5Qnih4dU2Vzv9u7i6hBiy38j5Jrfe3D37D
	SCtq/HTl5YOqo42uhJh94D/tnWW3GQyLuvyxIiKC93i6vhFj+nLPlFGsw3GBEFqM
	EMx9SM0Oia9iv+1qjpuZjiK2IL9CAv4gank/QuwJ2Ob6LSYHcRzdICOxpZXivgve
	W9CwtJ6yqg7NinEBd0Q5d9N/mM9pUL2Tj3z1+UJ2wI/cwuKMOm+dGb9ZZ5qsNGGC
	UIU4Xw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf7j59-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 10:50:54 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8cce2b4c290so15112136d6.3
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 03:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780915854; x=1781520654; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41nbnSBEwQElk6GtkzYHQTOlycyPOuLRHHoqlbc4AwM=;
        b=hr4bCXZYD1D/FgfGLH8fVQtgaFNfZ/jcG/341Xv6HxsE0xVAGR4TxeYnZNV95gZD2z
         Y3fRbZEWXW7ZpazPux6+u3A4EHDDY9wEjqo9IHRFfaO62tkPnBUhtTFjeLRjFnrKq0C5
         tEpdUMmyrdvnoSEutVCvYrnYX9+uxLnvw1ArQVq9wJjlklsqUIA8A7uoIHabO/bNUiC2
         MsQhRLX9toF5H9ohuTu7RUyFsuU/mggbcwyYIWeMNJvJft5bAasgJ1YS20TpOHAOLaKm
         hSGcMgaET0GV//I47h7B2CVskXcPWYEdenv0JHtKS+55I0T7fMt7vpNvu4Yg0vrQt8V5
         727w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915854; x=1781520654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=41nbnSBEwQElk6GtkzYHQTOlycyPOuLRHHoqlbc4AwM=;
        b=aE8IBmn1d0v5p36Mb5i8Xr4qa1LFCZj45EScomxrVxTfu12HqanlXlnUu5RK3f+TvD
         UKn906x6taCLdmYq7IlhH2INuhvpqqOXN5skm4nnBKxzrUVZAJOl7Yeg4sOjLzbJlGlw
         lDFLi8A0PRLLF2ZKuD7sR4UJ9ly2Jl25lz3VTCMM2WenPQMRcE47loBk4IsMduFG7dLB
         IqrMVxnH/c7g1NoiIi0e1hGOLJiDR3DtGZ7mUm9oX0y+8S76R687Rtd9zCeLGK1SYgw7
         d8dfQgNhETgBKZtYAo+YpNjwpkLR+ITLnUt5tbGGFK0V9On0iLuHwVXTFRNhXXH2TtLo
         kIFQ==
X-Gm-Message-State: AOJu0Ywyt5h3K4thnaa04l4tXbdHHLY8LKq7m9vBR61mf1WpdDyI2CAO
	vSjYX+2zccKj621swu3Ya87aPDfih9YHRlQTFt+K8k0ZYAixIPYaH8pXphKykQENEBfcySzRcWr
	vMahxGqSwUqITiWo9BYioAt10NjaUDWzyg5boRG9+Nu7ePJ20N3tYqG08Rq/3mRYL09EYiQKP2g
	==
X-Gm-Gg: Acq92OF9JMNyb1CEDLRTI7g8mGRPZCVcwSLkThQgbDHIOuLXXxoXAM+IQg6ZMduB6lx
	TEnSwwChKfyZCunLr/m3TVFWuEkAegG7BZ6n59Fd+rZNbLvCSmnH6XSVIW/og1x+GjXIoJYb/1R
	L7TIpfZFS2MFoFqFAHA/YaCI84uK5UdWpv+RWT/izGEzuPDuRGAtyPvzT7n8EQZd46P5yx/BjVE
	DIQrQqZCgr45Vt4cW9Nh2ljrm5ddm9wa2N5Y3FAslhx74T2Ssk/8ICisd0SCMzEg9BoQRWXzJwa
	iYwU/aHH6wQnPh7vrIz3rWSuktyfDkUUFII81bfsv7X/uD6BAP9QAzh+MdbIpbD2WM6TLBsYk4J
	xdNNpBEpJMzYseIRCwgmmvsfPRYma2cbXbgWVoz34IRcsEhJqOx0YLeoZButKzNfXzXuqSns1ql
	p/qv6gv8wihLM9S0J9GfsjpJg7l1D/Sw5Ci/6hrnr6CpQjyFotwNA4BUhutjERsje2jm2t4yX/T
	ZIJmOuhF3nJ
X-Received: by 2002:a05:622a:5905:b0:50d:770f:ad23 with SMTP id d75a77b69052e-51795b4b9c4mr203105051cf.26.1780915854220;
        Mon, 08 Jun 2026 03:50:54 -0700 (PDT)
X-Received: by 2002:a05:622a:5905:b0:50d:770f:ad23 with SMTP id d75a77b69052e-51795b4b9c4mr203104591cf.26.1780915853745;
        Mon, 08 Jun 2026 03:50:53 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9aa33sm850399866b.24.2026.06.08.03.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:50:53 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:50:42 +0200
Subject: [PATCH v3 5/7] net: of_net: Add of_get_nvmem_eui48() helper for
 EUI-48 lookup
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-block-as-nvmem-v3-5-82681f50aa35@oss.qualcomm.com>
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
In-Reply-To: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a269e8e cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=bEbww9rD5qa0LKludeoA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: 9IMDI1UQm9pUg22QDleKsdkf0dKsF5RC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMSBTYWx0ZWRfXxL7zaqoIqpfW
 L024orIzjPsMVYP9mr6Jt1ZvzxLRx1JddltmWEwjRE9BzZKhcdh3cMbNqCiI7rVQfbm8tPxk5nw
 pL+YDpXKJg0x9h8CoFMTlieNC9/mws2zOhdFZMOy1mnkR/Y+TileurC4i3WYaHdMgSqoHbCnPDt
 3MQg3TYWsas+EHWdSwqFhu9nFI1TF6QRf1VNuVfRjy/+wR/t1dznbXMru5ZhuFhzH5Xsge4aZZT
 d9DVH05s5gxocYJ0KfjKyjMoF5v+RVvc4eCcOsiVOL7CoWU51D+Swzhvz0FOg9eNYrIKtONT24D
 HSOI+S9CpmUXOmSSe3bKTi7gYPTw3suuHt2kP5u97LKYoqzjBxSGv5VwPlQROtt2hYMLoTpXczI
 c0p97Dfx8KzguLhMKUOlBp/0y9QzlaFxPLnlwUshsUFc6FVMJtCSiFwMRUzjvjYInLxf3zEnaDY
 jrFHbV94X+B00OYVoSg==
X-Proofpoint-GUID: 9IMDI1UQm9pUg22QDleKsdkf0dKsF5RC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080101

Factor out the common NVMEM EUI-48 retrieval logic from
of_get_mac_address_nvmem() into a new of_get_nvmem_eui48() helper that
accepts the NVMEM cell name as a parameter. This allows other subsystems
(e.g. Bluetooth) to reuse the same lookup-validate-copy pattern with a
different cell name, without duplicating code.

of_get_mac_address_nvmem() is updated to call of_get_nvmem_eui48() with
"mac-address", preserving its existing behavior.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/linux/of_net.h |  7 +++++++
 net/core/of_net.c      | 49 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/include/linux/of_net.h b/include/linux/of_net.h
index d88715a0b3a52f87af23d47791bea3baf5be5200..7854ba555d9a55f3d020a37fe00a27ae52e0e5dc 100644
--- a/include/linux/of_net.h
+++ b/include/linux/of_net.h
@@ -15,6 +15,7 @@ struct net_device;
 extern int of_get_phy_mode(struct device_node *np, phy_interface_t *interface);
 extern int of_get_mac_address(struct device_node *np, u8 *mac);
 extern int of_get_mac_address_nvmem(struct device_node *np, u8 *mac);
+int of_get_nvmem_eui48(struct device_node *np, const char *cell_name, u8 *addr);
 int of_get_ethdev_address(struct device_node *np, struct net_device *dev);
 extern struct net_device *of_find_net_device_by_node(struct device_node *np);
 #else
@@ -34,6 +35,12 @@ static inline int of_get_mac_address_nvmem(struct device_node *np, u8 *mac)
 	return -ENODEV;
 }
 
+static inline int of_get_nvmem_eui48(struct device_node *np,
+				      const char *cell_name, u8 *addr)
+{
+	return -ENODEV;
+}
+
 static inline int of_get_ethdev_address(struct device_node *np, struct net_device *dev)
 {
 	return -ENODEV;
diff --git a/net/core/of_net.c b/net/core/of_net.c
index 93ea425b9248a23f4f95a336e9cdbf0053248e32..75341c186123e949fbe21f1e51fce3ac74d4f56b 100644
--- a/net/core/of_net.c
+++ b/net/core/of_net.c
@@ -61,9 +61,7 @@ static int of_get_mac_addr(struct device_node *np, const char *name, u8 *addr)
 int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 {
 	struct platform_device *pdev = of_find_device_by_node(np);
-	struct nvmem_cell *cell;
-	const void *mac;
-	size_t len;
+	u8 mac[ETH_ALEN];
 	int ret;
 
 	/* Try lookup by device first, there might be a nvmem_cell_lookup
@@ -75,27 +73,54 @@ int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 		return ret;
 	}
 
-	cell = of_nvmem_cell_get(np, "mac-address");
+	ret = of_get_nvmem_eui48(np, "mac-address", mac);
+	if (ret)
+		return ret;
+
+	if (!is_valid_ether_addr(mac))
+		return -EINVAL;
+
+	ether_addr_copy(addr, mac);
+	return 0;
+}
+EXPORT_SYMBOL(of_get_mac_address_nvmem);
+
+/**
+ * of_get_nvmem_eui48 - Read a 6-byte EUI-48 address from a named NVMEM cell.
+ * @np:		Device node to look up the NVMEM cell from.
+ * @cell_name:	Name of the NVMEM cell (e.g. "mac-address", "local-bd-address").
+ * @addr:	Output buffer for the 6-byte address.
+ *
+ * Reads the named NVMEM cell and validates that it contains a non-zero 6-byte
+ * address. Returns 0 on success, negative errno on failure.
+ */
+int of_get_nvmem_eui48(struct device_node *np, const char *cell_name, u8 *addr)
+{
+	struct nvmem_cell *cell;
+	const void *eui48;
+	size_t len;
+
+	cell = of_nvmem_cell_get(np, cell_name);
 	if (IS_ERR(cell))
 		return PTR_ERR(cell);
 
-	mac = nvmem_cell_read(cell, &len);
+	eui48 = nvmem_cell_read(cell, &len);
 	nvmem_cell_put(cell);
 
-	if (IS_ERR(mac))
-		return PTR_ERR(mac);
+	if (IS_ERR(eui48))
+		return PTR_ERR(eui48);
 
-	if (len != ETH_ALEN || !is_valid_ether_addr(mac)) {
-		kfree(mac);
+	if (len != ETH_ALEN || !memchr_inv(eui48, 0, ETH_ALEN)) {
+		kfree(eui48);
 		return -EINVAL;
 	}
 
-	memcpy(addr, mac, ETH_ALEN);
-	kfree(mac);
+	memcpy(addr, eui48, ETH_ALEN);
+	kfree(eui48);
 
 	return 0;
 }
-EXPORT_SYMBOL(of_get_mac_address_nvmem);
+EXPORT_SYMBOL_GPL(of_get_nvmem_eui48);
 
 /**
  * of_get_mac_address()

-- 
2.34.1

