Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CACB34A3DB
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915860; cv=none; b=RTliiJbcnzmoS/9rgUxf19m208Dngj6h0c8YurLN5G1jcSKJUGgRAkCXEFUrfOd75ZxPHbtQ6iFL++a4ciF8zravPbTpDBrBOZXsQmRsWO9CnTQ9sCQRdHPKjzhV56YHt3imt9dlgLLCgfKT0chD6Ge+q+VzCaYXy6lVGD+GK3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915860; c=relaxed/simple;
	bh=/5JSpbZRWY5COHZDhN4gNF7Jnw0iPmpuvearF0ixaPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zanar2D4sOXWSKZZcELPFhGthSeeA8gRtpC1T2dVh+dmtugf4WJ6mA9Uj68UmAB/qJ8wtjixj/F6f1aHyLVQz/b0llLaPJNasmcIgVZk8QqcXQg4YUOsgFq2W8C1+cbX46DbBHrGLkPRzCPWjGdnNHfsXa6XUQkSEIHOiyMoJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=obiN0suf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BXFb4bsi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="obiN0suf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BXFb4bsi"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OrJ12274537
	for <linux-mmc@vger.kernel.org>; Mon, 8 Jun 2026 10:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kVKEAS8GhVMCCsKzWvqDs3cunTV/p/7YyYFmPXPEJtI=; b=obiN0sufjkJIpbxQ
	8vAJpCWlvQ6AfuEVCWzooX/FKI2cWVAgVgajihPvBG19b2Db7MnD6XFd6oaYulzd
	HhttUgGezEYy3nDqlek/pgr3mhESpR6r89Qrx6Y2GHYo1JpdXrksjyu0bzQcH082
	2tDF3hRcdu3mcZlDs0BCN/a68yp2od1bgw+XXV5+VLXiI12SSyfdVNrzy9ogRs7o
	LE+kmLmZrn0LDN+AkwK0bwz8U+CEa/3uR6JQIFDE69I32B1wF8pheSIeUyejN19b
	5Fn0uxOby9T+pET7rrfrwTM3MkLqsPfCowSflBJl3Js4mOz1E/z2v9g/sVVemFfD
	OBDSZg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgy5kh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 10:50:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51771d41426so75785311cf.2
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 03:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780915857; x=1781520657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVKEAS8GhVMCCsKzWvqDs3cunTV/p/7YyYFmPXPEJtI=;
        b=BXFb4bsioTn9DQ5WdCMj70RNo3T5rjnxTNB1NhcekVfgEoP+fFa2mvVfiWOKJWiUrn
         W1CMfuv+Y3SZ/snnsNERzAFvXo8SppSUDku2HFqXUdH5EWOcmhDby/ycYs0mUuP4pZnh
         aiWVDayD8dq9mtrpnuP8jDOoUizdVyXvDgA20qX59KmXsc4yoO4IxQe5txi+lIISpPrH
         MsyB1nOaQ3cO6EISfm8wqwlZ6ZW6H34rvcv6NOYa3pJ+brd3S+X+3CTK6qAPjee/Gxoy
         bt3PRMxScZ+P42BBq2l1GYa3J4m4DECNHwHqmJMXIzqGfk4iCtTMK7wZXfDjgx+BuBd0
         rgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915857; x=1781520657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kVKEAS8GhVMCCsKzWvqDs3cunTV/p/7YyYFmPXPEJtI=;
        b=Sh7mz1jOw0AuAF+jNrUl6BEgz2Il4kfae11PjFJO0vkpJS/dxHelrqjET2cABhcL59
         1FOvdhF+5m+X4wVASE3VBArtwFtbzfdE+zXX57esWZKvQJAdHn/zm0wip5IM0vW7GghG
         f7phSpfrl4IYMzUYe/ZjanceSnQgxUkAlOKTUusEiKR/lQfn9OoDSBkzwlDiA2cddcsH
         JT+9AkNWY+KupqFGprkP4L/JPCmfV8QRV/GtM++LLc1alkWcCa1Pu7zIWyUUNnhAWHu1
         mxlEJErJXUiDw8/3IK9a8KBX0OfHb/+gCLj/WsSSGho55ya1QgIrYGsUna25pjoHe2Dd
         bteg==
X-Gm-Message-State: AOJu0YweL5/7RLuwmqe16EBh4DAnVujHQ8P1Z8CJ681FT5/bkvxIdquy
	wSlwoh+5kTIeyHSkiJoo8ZmzNjq29e63BqnZj1IzrcGuU96MH4BmFg7JpfukikpxaZJRBK5Es/G
	ONmdnEXXEUJI4QfOGDRL/71zd3k6F8MmHwRWJnZt3AMJ/gkLPGTZ7dlCtBFXg5c3H4lMJHDp7+w
	==
X-Gm-Gg: Acq92OGxp2cCHQE5QuOK0n2Am+MuqMwm8kqKSBKIswg/evZJZIvyEZE/XkbYR5jtAC7
	bIIOExm+/whKWH4oavOT9/EgsOkXIpVio3R9ukKw4a/mKQ6o5J16eLlp9fcPxzIG5HJOOsWbkSN
	sjFYlz5gly77JIqJKZsa1ap+V4zHIC4oxSRUO2PUOZgN93oetUegX4tx5RnZKktRlugDh27480F
	hQ6jvJ1/w6MxvoGeA82zfwJDWqKRH4InnRqvgku+3/PR1duLSw2D/hN4gh/3z4hcnjSh3i6hx1e
	HtLZyjGo/mR0w3C3GS1hP4fy0J9v2I8yaPayA8F5S+J3+XVPKoKhC2OY2QRgTCQxSSnK8yRC/+F
	J5HsphWXOnIm9nZucL3rYJSzuM0p2uWJRIWqskD7ISqM2jBt5+LPNB1J3sGx4HAqIGFFpvVMmGB
	ZdS9pGOZf1oJq1Hqph1v9zWtJvbkd0xRA5FPHs82ThKM4dSzdK2a23y6RSEh6+7QFpoLAljk3CL
	lZbbOC7mGSX
X-Received: by 2002:a05:622a:47c3:b0:516:d4b1:48cc with SMTP id d75a77b69052e-51795a4838emr190287221cf.8.1780915856847;
        Mon, 08 Jun 2026 03:50:56 -0700 (PDT)
X-Received: by 2002:a05:622a:47c3:b0:516:d4b1:48cc with SMTP id d75a77b69052e-51795a4838emr190286901cf.8.1780915856424;
        Mon, 08 Jun 2026 03:50:56 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9aa33sm850399866b.24.2026.06.08.03.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:50:55 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:50:43 +0200
Subject: [PATCH v3 6/7] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-block-as-nvmem-v3-6-82681f50aa35@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a269e91 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=tQ7bI2BnKgK5Av-YYOwA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: SEprL9cd5v_ODY3NQm3f_X6ctOkqo6kB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMSBTYWx0ZWRfX5dwbv74+CLzy
 YUiG2lLobDXEnFt1MA6yVGYV0OfgmQR7B/MoZehDw6BPnQTnVS3jHj1rEbAwUmfiuOTS19zGpp6
 miafL5Dl1jPUCHq3pS28KytQm07MI+6iKqpu3hRWe3IAbsYnAuN7hBkAwYIOtuGNLrY/ujKZwjS
 /q66A4GpIMon8yvgMrEizZqZU55pf1wau7JA9EvFExNwWi9g5cdiV9qNOOsYODAhWpCoeKD06cu
 OCK9BG6c6BPMgbbtMBqzms46tlYSeXVSIXQmTCfD2tqN/qDrDAeC2O7xS4UPxEBSJgLk7q8oXxL
 o819FJHxm1Oef8XDKnyaT0ahfykgBa0I8EhJgLt6JD68S5mKBkQIfCc5ghqKcOKB4QynAv68DmZ
 smOwjP4skN/kaveMe87VQwCLJ+MpE1f4xFRX8z64hftk/LT5Art3fHmSY4sc5T7mS/SLS+6Ryu+
 58xVYTGdzNB4a39SCnw==
X-Proofpoint-ORIG-GUID: SEprL9cd5v_ODY3NQm3f_X6ctOkqo6kB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080101

Some devices store the Bluetooth BD address in non-volatile
memory, which can be accessed through the NVMEM framework.
Similar to Ethernet or WiFi MAC addresses, add support for
reading the BD address from a 'local-bd-address' NVMEM cell.

As with the device-tree provided BD address, add a quirk to
indicate whether a device or platform should attempt to read
the address from NVMEM when no valid in-chip address is present.
Also add a quirk to indicate if the address is stored in
big-endian byte order.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/net/bluetooth/hci.h | 18 ++++++++++++++++++
 net/bluetooth/hci_sync.c    | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 572b1c620c5d653a1fe10b26c1b0ba33e8f4968f..7686466d1109253b0d75edeb5f6a99fb98ce4cc6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -164,6 +164,24 @@ enum {
 	 */
 	HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
 
+	/* When this quirk is set, the public Bluetooth address
+	 * initially reported by HCI Read BD Address command
+	 * is considered invalid. The public BD Address can be
+	 * retrieved via a 'local-bd-address' NVMEM cell.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_USE_BDADDR_NVMEM,
+
+	/* When this quirk is set, the Bluetooth Device Address provided by
+	 * the 'local-bd-address' NVMEM is stored in big-endian order.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_BDADDR_NVMEM_BE,
+
 	/* When this quirk is set, the duplicate filtering during
 	 * scanning is based on Bluetooth devices addresses. To allow
 	 * RSSI based updates, restart scanning if needed.
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd3aacdea512a37c22b9a2be90c89ddca4b4d99f..589ccdfa26c1281d6eb979370523fff0d7920302 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/property.h>
+#include <linux/of_net.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -3588,6 +3589,37 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+/**
+ * hci_dev_get_bd_addr_from_nvmem - Get the Bluetooth Device Address
+ *				    (BD_ADDR) for a HCI device from
+ *				    an NVMEM cell.
+ * @hdev:	The HCI device
+ *
+ * Search for 'local-bd-address' NVMEM cell in the device firmware node.
+ *
+ * All-zero BD addresses are rejected (unprovisioned).
+ */
+static int hci_dev_get_bd_addr_from_nvmem(struct hci_dev *hdev)
+{
+	struct device_node *np = dev_of_node(hdev->dev.parent);
+	u8 ba[sizeof(bdaddr_t)];
+	int err;
+
+	if (!np)
+		return -ENODEV;
+
+	err = of_get_nvmem_eui48(np, "local-bd-address", ba);
+	if (err)
+		return err;
+
+	if (hci_test_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE))
+		baswap(&hdev->public_addr, (bdaddr_t *)ba);
+	else
+		bacpy(&hdev->public_addr, (bdaddr_t *)ba);
+
+	return 0;
+}
+
 /**
  * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device Address
  *				       (BD_ADDR) for a HCI device from
@@ -5042,12 +5074,17 @@ static int hci_dev_setup_sync(struct hci_dev *hdev)
 	 * its setup callback.
 	 */
 	invalid_bdaddr = hci_test_quirk(hdev, HCI_QUIRK_INVALID_BDADDR) ||
-			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) ||
+			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
 	if (!ret) {
 		if (hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) &&
 		    !bacmp(&hdev->public_addr, BDADDR_ANY))
 			hci_dev_get_bd_addr_from_property(hdev);
 
+		if (hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM) &&
+		    !bacmp(&hdev->public_addr, BDADDR_ANY))
+			hci_dev_get_bd_addr_from_nvmem(hdev);
+
 		if (invalid_bdaddr && bacmp(&hdev->public_addr, BDADDR_ANY) &&
 		    hdev->set_bdaddr) {
 			ret = hdev->set_bdaddr(hdev, &hdev->public_addr);

-- 
2.34.1

