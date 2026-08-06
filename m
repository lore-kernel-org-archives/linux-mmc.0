Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9089456E1C
	for <linux-mmc@vger.kernel.org>; Thu,  6 Aug 2026 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027150; cv=none; b=B00uLfjbuMXbDNr+vV0+oCA4FE/l1IlGg0UzPYbzuuy/H1InRxU18LA2sMwoI8N6AFqmiAlg4KCECIyPl4DhQYYg96YjMumIVp55yqFfpm/UfjPpvYM0HuXk43M+h0QYII2F5UiAOk4QTAUMHU7QbpGmAwx89g1VP8b6wf+PI8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027150; c=relaxed/simple;
	bh=L92wgefYXvtbzOMdFEhUTkLwtCR1yYb0ZcvRRGDMuNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fsfY/dOLxikyX5RjdAxNwMJMyFBLQNBzTZ/P0/NxNRo9mcXpIoksgMZgx2ROB/mImMQwyKUCp+gvIyP4iOlCf+8rmnCKta31z0Brs+Q7JUXMzHJ8n8gyyce077C1PxWFDDIfIRFXKHEhcT+JjNOkAz1z3YY9wwnI7iusw4uLjYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tu7wovN1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W6zuJobQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tu7wovN1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W6zuJobQ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nghN1876508
	for <linux-mmc@vger.kernel.org>; Thu, 6 Aug 2026 14:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cPeNqGPMRBWAfsA5CvuzYdqPrDk9qOkztMDjoEMaK1o=; b=Tu7wovN1yUeuNh2h
	YaUwjkkkN8p0Y3Y4/b64xoMPKryZFIwHN1MEm+K6zTfr5B/pupMFOE93Y0b9hszq
	HNNiigNAb7txL8R0o15QcYwQijLQfpziy61yvktiD2bmL7qvQ5x3BkjpywMlevzV
	fZy0AzmR83bdWZ2Gq4azy4Y6Ail743FLZcaAWYcNiMyT7cMQ2qFbGz7W2SbHDBu4
	znBl8nhMZy+S8kN91o393vnzDBtZSZHE7JyB4njZ0mqAVxeO1IyJxAcKAfn5fLf3
	AJ6xisRMQLTiTjg5QAmDVuWERq8L9crSL7HxA3FyDTNPvCeJyfDDgi3zoitBNabc
	9o3wxQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjucjqjn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 06 Aug 2026 14:39:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-529ae8e96e8so24853871cf.3
        for <linux-mmc@vger.kernel.org>; Thu, 06 Aug 2026 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786027146; x=1786631946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cPeNqGPMRBWAfsA5CvuzYdqPrDk9qOkztMDjoEMaK1o=;
        b=W6zuJobQMzovX5XY+ges5LegvJc+QfPblYTnJUOHwItKm8JCYcHMPM6gG0zfGOIWlW
         uX1PAe1KN24dK+jJi/+KKB7Jj9oFD1V1xRME7uj1zk414emthsC8lTpaSxzpBwBiMELf
         Y/tPHG+Ca8hh7H8Wy+/8dzhMWEfqGUnNxV22ok18TrieqA1YtYAD4Ff4CSvDoEzN4T/L
         zCGtGsbKlq36d7AfQIUADN+U/gEIZWMPlOlFzABzMXfnjSWTPSsEqxe1x/48OHcG4opF
         /MWHov3C7FErWl506blcIMe/kn8/vcPdyByjXqQyMRCWtSPaA3qw649fFZvWCpv4Evky
         DM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027146; x=1786631946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cPeNqGPMRBWAfsA5CvuzYdqPrDk9qOkztMDjoEMaK1o=;
        b=A1pDhKtLb68+JPXv97XNwGhPqWrUvLv05PyjzvC8k4N1hWsbQ0ZKXVuexRMpBgzVu1
         /7AWtGA2l5b+CXsE3ZGb+lKCUSVgpo1lAG88RUeXGZx6XpBC5y0EhCfkfCTXvB1wansF
         mmYTcQRIAvKl7xRyXodhdpizx9hgnC3J/Q7kH1ShgUp67vnf8CNsHZvIW+f10VsSG2vt
         W1fj7mWXA58aUbTl3vLne7h6lxZM+x2Ny8HiyMsfsQnx+/OrkRgQeSEX/oQaqeVyd/jL
         dsy/doVCEF3Xg6bvXjInoT1kOeZDifErLwVVNY8+tR8FE2lZXu5yWLL+/6XtdKjuWMVx
         +2IA==
X-Gm-Message-State: AOJu0YzkFQOvwXRCF77fyylcrG08biYdWkq0+cgA594ywBmND/gCBPEl
	Tgb+f+l4IRyf/mCxSd5ozpcbEBLw98beWIWlU00l4WUIblIZYbLerzQB+HAviM6MWv27WPBbUty
	yINy2+OXGFsE+7Q1FhTs2LLc/E/U/rlDYTtB08oY9KcPS02aVXqs/a4G0dpb8TaY=
X-Gm-Gg: AR+sD12zzd+s42SrePTE/D5IwmZSpcVXuzw8c/rBOIJFXL50KNJpxbV/NzvmU6V7m/s
	N4feBr7l6iclKWRpcBajQbwTm68/Ki2hyfpJSgi/my9DCVMMB4h9KH0h+2a6yWXxyogcG4bMYdV
	xyIOitChqVr3gFmvbJwRYL1Htfyu1mTBwIkCFNyVyq6FDElD2SurLENqWFnpFxOQ912ggika3p+
	xbjjk52FhE/CQbei6gfJyy1fw6J+DxGj6z6JneCUbYLKOOK9cshe0lMeZM4ThgNMSeaDVyzsKiY
	1BCY22tOFUlHSb4B9o+rmk57sOvy546r4ldXOK98ctDFj73aHF6MQewDKNK9I5rX7nvOk7p6Esb
	9VQEBtBzDh2iqVz3RKOaba/GqV4JUL3sFQ6RfWAWJ22PEoMM2BdvHe2gtJa52EN8quIJ6W2Bowa
	+xQUoR4J/iK140L3NpFjJHYl5Lh8HUI/dLNvJS7p0E7W5+UJu3zQ==
X-Received: by 2002:a05:622a:1489:b0:51a:89c1:1eef with SMTP id d75a77b69052e-52ce6022480mr139973681cf.14.1786027145650;
        Thu, 06 Aug 2026 07:39:05 -0700 (PDT)
X-Received: by 2002:a05:622a:1489:b0:51a:89c1:1eef with SMTP id d75a77b69052e-52ce6022480mr139972401cf.14.1786027145034;
        Thu, 06 Aug 2026 07:39:05 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([90.85.108.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm270552166b.28.2026.08.06.07.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:39:04 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 16:38:40 +0200
Subject: [PATCH v10 07/10] net: of_net: Add of_get_nvmem_eui48() helper for
 EUI-48 lookup
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-block-as-nvmem-v10-7-be598b2a5606@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX5a+NOCnK0u44
 SSLPjBpmZmOLEnkNNFNczefsmS8D95+qwK/4H3/XpAKQb8wqgIRIuZLheJeC5KfcLf/VJNGGXzI
 8mLrma0CXa1Y3SVu1a56Zhl+0VREspw=
X-Proofpoint-GUID: BI0RSV38_icSzJb9LOOssbiyPLi-I08O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX+4qExYi9P47M
 e3aHPqRpVB6yFoZj0qA2CdI1URYE9lCwfgYdiACwKhGneIpg+1bvoKo9ajWYTjr9L21eCC/nP2H
 eOFsdkc0NNzXSpIisqvnCQEqrGhQcmTaFfl1BA1KIiteQTKe156oaubPyxH9zzqF/Tz8Ng9mg7r
 fHYxf7eI0scX8jLytSKgL4SZaqAbpmxoeX/IBni6eP0LMiPKMAmJNrTnRS3rXk8reVj8zZkfgY2
 BxTJaLqsl+keQIBuztbflprS4ZW+3NDhyi0Icc+SSL/g3+AKP2Ore3ZeVscDqiNLhKc3AZ1nOM2
 19n76kp9D+6Dl3pD+JvmKk4x2394H2z4yY9wDL2/WuWQ/fpgRAltLcOHj18K3DixgtfQFpCHYnb
 1qW9r26sqUiRVqwdBnA4IQoTcdZeD6Ciftoe23wWgsGxP3xuCaDXPE6sWdNijFMFjJP/qqbvUcD
 goFWbRfWb7A9ebhQbDQ==
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a749c8a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=JDRa4Jy4r6/BpSpxP2cCow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=bEbww9rD5qa0LKludeoA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: BI0RSV38_icSzJb9LOOssbiyPLi-I08O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060114

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
 net/core/of_net.c      | 52 ++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 47 insertions(+), 12 deletions(-)

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
index 93ea425b9248a23f4f95a336e9cdbf0053248e32..999ca0e9258c41580823b80e0ef6db26617bc968 100644
--- a/net/core/of_net.c
+++ b/net/core/of_net.c
@@ -61,9 +61,7 @@ static int of_get_mac_addr(struct device_node *np, const char *name, u8 *addr)
 int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 {
 	struct platform_device *pdev = of_find_device_by_node(np);
-	struct nvmem_cell *cell;
-	const void *mac;
-	size_t len;
+	u8 mac[ETH_ALEN] __aligned(sizeof(u16));
 	int ret;
 
 	/* Try lookup by device first, there might be a nvmem_cell_lookup
@@ -75,27 +73,57 @@ int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
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
+	memcpy(addr, mac, ETH_ALEN);
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
+	/* Reject unprogrammed cells that read as all-zeroes or all-ones */
+	if (len != ETH_ALEN ||
+	    !memchr_inv(eui48, 0x00, ETH_ALEN) ||
+	    !memchr_inv(eui48, 0xff, ETH_ALEN)) {
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

