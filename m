Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F41E3E5EE1
	for <linux-mmc@vger.kernel.org>; Tue,  9 Jun 2026 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991611; cv=none; b=VbhGbuXsV6Bi7pvSMIxr0OgocwXqAfydXu8CYl8IaQ+STNEO99ltkf1VkcWvzi7GuA1K+Txcr1grpAnO3pDaMGflOCUSOHqMzjD55Ssbu/8mCeMLbthhTK2sBfzH2mysanOdOiEMZa08akK+BNYPqjRteulga2eZcM6FZwdiCr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991611; c=relaxed/simple;
	bh=jD3L8jwoh7BLSovJJN4zvcH6m1V/AR7MZ04B9wQ9s00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhy1rlQtqkDcEaXmwDGEdNQB/0iiEaYTISwGp+IIfzU9i3xnLA9xLV24dDq7A3EK7AuHe2f7A3MPrusKvpEDoEpr1bjN21IkHFSTAdVAWrTWS8Dv9R9AMzpd2qnXPrKyxQX77tsEzP4gm1bF3m2Z9OL+I3MH6Vg7QhMihyBR13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HCH16y7k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EADM2Rho; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HCH16y7k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EADM2Rho"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rKmm1585653
	for <linux-mmc@vger.kernel.org>; Tue, 9 Jun 2026 07:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	41nbnSBEwQElk6GtkzYHQTOlycyPOuLRHHoqlbc4AwM=; b=HCH16y7kViKLrFhs
	7UsBAF+HpVtfvq6yHiDLxz+pt8PFwySxN8mnpW1Gdfh0XVDOyxaWimOZPRIb9Y6l
	WuYg/+wd1oCH6AjumAJ2aPpG7xkNc2YACExFChrPhea6T72oOfpaFljXnqD0+aUD
	Z1fYgJzF6FAhZKI16j4THgQ7UwvIjlAQTd7Xifd428Jf/bnFybCjkE9lIi+uqpaj
	o7nWVA2f5XcNAgEXv+ZaYAZxwkA4+j4eYpdeLUIcZNmJkqcI6sDBCvKiKnQhx+A1
	LsgMIy0sOAE7ML6VDQ5/2TQqt8u86ih7bH1BBDHRJ8S0ExMqnVRPrbZrU2TtWXee
	bcEBug==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqgg16h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2026 07:53:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-517ac42d958so52121651cf.0
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2026 00:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991609; x=1781596409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41nbnSBEwQElk6GtkzYHQTOlycyPOuLRHHoqlbc4AwM=;
        b=EADM2Rho8jJ7QHq+ihpO4OvLx6V+mPk4ISvC+FlXlklIRIWNUXMm3LwFyRFS5UDwTf
         Vm4lBn29ClU64bJ0emEutXr/uqnRrqi4DjnVDfiTTB44Rip+0IdACfg+EFjQZXc8XVNx
         9L+EV89Ic4bQ2mUItfPkXUBwSdrlZ4OXr9p5w21e86GUZz0WCtFIPIMITNyWfQTjr3aE
         V9cPO4dOqMKgbLkHY9HFSlNpI2FbbjEyzZuqLHu8wuiNQawAWl5VFyof2RLVd+On6m79
         Qdk6pXuRsNKhVM1UlU0r9ucFb/8piTarAHUp+I1+nIpAxtnJeY9rHN65ItxpA6sYs7Sz
         6EFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991609; x=1781596409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=41nbnSBEwQElk6GtkzYHQTOlycyPOuLRHHoqlbc4AwM=;
        b=glc9scr8tiJMNnNd7rVGkeORo/mTKDEqZ4MJIJtB3KOxB8/sjvjWdXe3Fb4wdFAVY2
         rPSAFitzOSHq8MKOBTy4+latoYUqz+dDVYh/TRRpecGRsHQH4uDVlmJptu1xnqenNib3
         t5ycnXMwQK23/jCOaMEGWbILWqFG5jqamsBnVUPUXnLUpQdRaAR4ZtBCe/dLS3jwisGD
         K/ppXDb0bs7R17FPvHjoWVhu+SoccMoFoCXg6YUA4gVIZEy6nvaaNkfh0JpSBkHfeQpr
         OyxFxjf8/DZHrL7De+kfq+FhPVykX76wMIcD5XbF+ALyqx2NY1eJloJD+BkQOYuy3dV7
         T8HQ==
X-Gm-Message-State: AOJu0YzOQovMS7W58niTn2bPN9TjFSHdVYbL1/RuQAxpEYRHnG+BnWYt
	OfqBuigvwblJ7tCExWu66BnoRUXzn4TPzQE9zR2iA5p2Vt7Mq/J1mRztuhMAXyew7WjkeVw8Kos
	gZF36PwcADdp7uiTwyUbktnAWSaJ5yjIA/6yrCi00F23UGUF4OTMheS755h5GnOE=
X-Gm-Gg: Acq92OFISBKfSjubLfCGBzYIY967RtLMgHMzNWIsKqTaiXtcVGHT5ZBTLAz4FayCXJr
	eHhK09Cg7nM5RcLXMo31wLVbhksOvASmrd/G8RVXsFL/0yHXAKiMwRnmC2srCIHmJzbbPoL+Qj9
	noFEnlqBCLqsnWcpdkLMDGtZcD5pfiyxC+rwBPU3daRljB0G7sOe7yy9weuGSsig7ZdhB2kBRSd
	y1NUbiBEnXR+HBE7PJu4oadMqlbQWKvkeuErNXC0tMC2i3gOXvXgWTgwmsTAT6cFeq6BBRb5LF8
	Mrlx3tJGj4qNU3Yf/vuC7wS5RGr88SOj46mGEdC1ujH9wts3UmjbAKeEzENsIZd5rjNQyeeu6i5
	RuBY1mTh/jVd0VDUlQK4jMYYtTPQgaNXDDbOUZFUMqDrCepn+qmUi7Ga+eBlui4QoN5N5xiaKmP
	YsTJiq5QXJA5XWXxcfAUWnQqFYbVq8V/eh3Y1T+/X/umMCqf94AjfAjwgJ43NI1gFz59q1lWZtS
	yKoY6XbskKS
X-Received: by 2002:ac8:7612:0:b0:517:a02f:171a with SMTP id d75a77b69052e-517a02f1d7bmr164821591cf.36.1780991608577;
        Tue, 09 Jun 2026 00:53:28 -0700 (PDT)
X-Received: by 2002:ac8:7612:0:b0:517:a02f:171a with SMTP id d75a77b69052e-517a02f1d7bmr164821031cf.36.1780991608169;
        Tue, 09 Jun 2026 00:53:28 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:25 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:30 +0200
Subject: [PATCH v4 5/8] net: of_net: Add of_get_nvmem_eui48() helper for
 EUI-48 lookup
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-5-45712e6b22c6@oss.qualcomm.com>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
In-Reply-To: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NCBTYWx0ZWRfX5hmovU+7iwcz
 VhnvA9gXMQpb3tMqWWNoz409wjInazcUBBcQzqoHecZ7q4P3qzz9D3WYPfzZhnqUK4tPjthmD58
 c6uvm+WBjGQYHOnWv+6M/EWS799TB/tDIjY/TDKFhvoazneLDiheArSU4oFRsP3o+JYQI25MngK
 P/4h1tv50zrKGmHkf0sLT9l1S8bsF//Y8EDE1c4nLI9QnfP3CoeYTK3POoZiUGGyo9QEfL8+DTW
 O+aS0ML5ihyoyxXQvO/47bonWBus9wtHKF+U8igL8CJw6GlgKRtBtTqIOkVPIBr4RMxvpKf56Wg
 n0d90x2qUao53NKUlh9J4jMBRzH8/CvkRW8ajvl3dFrHnJJJgWX9PiczcNLGcnwET2dU2TO7QSN
 hq7XssC8TNooVugrdulV1RN1+K1anrYF4XyhVJIj8ZGQv3getGl/r8jXMv9bMUrYyzs8JhqihiE
 R4WfFYYKQFqXvyVOE5Q==
X-Proofpoint-ORIG-GUID: pExuBVGbXyeDLFiAkc77zx-vNYWUn9rr
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a27c679 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=bEbww9rD5qa0LKludeoA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: pExuBVGbXyeDLFiAkc77zx-vNYWUn9rr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090074

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

