Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17BC53CA97
	for <linux-mmc@vger.kernel.org>; Thu, 15 Oct 2026 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074404; cv=none; b=RdCwVji3c4x35cUXSAwumQaOQBrG0CXTY0PzstdMAMd//XALQ60z+urNzPEAr/+2GxIh5sWod+nBoFm/NDpb/jkirwYpPiKl3diCX8vGKQuUzR01Fm2ikT8uc50VEYU3vcZLGjtDOzKvjNPseuomyRwnJ2Hf8hWTkOdi5sxktG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074404; c=relaxed/simple;
	bh=a8WAuizjOIp0uvWddVAkkazbg53HG363DU1eiQXDUGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hAig3ESkB86YEWvd6bvqDq87s+ZjY+z+Am5X9CdOQbzsNwdL+h9buc4jo2tTdKUWerYr0I2Kcq/7nBxaoAWhGq1TnKWOKQK+V3ys+04mUKRb20ebQ224Vz2i+tzZjGM/ocQeCXVZMhEmysQbf4Fe1HUdsQPDFkGXSwPh2T97p2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YcwVFhyx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XremOrCM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YcwVFhyx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XremOrCM"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jh4i1956108
	for <linux-mmc@vger.kernel.org>; Thu, 15 Oct 2026 14:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S2pLh6KbXd9OKT880BVflHuBCk2sw7UKfLHTzSWPYoQ=; b=YcwVFhyxfMrHENEp
	raSVyukRIDGjDfYeppHUHgebFWXvB4LYRB/MVNCe/T/B7RdYx5JkudSK4UqQBcHJ
	LNttiBotdFqZdwtMcrYDh7plOiWvJwkwbdlayekdVub022QeynZH/RrBn/N8YfOW
	ZPZGSU+xOAdSpJKpsd4FETRMc+wybVA17KYfkKj6AkFddmV29+Oo3e6iBGKiI1dS
	PLSdBVWwWYiY2hW0ZrFHmGe1AiKPVyGmZJLtyfxcKVdFz2rS4cvBekyHb7neTyuk
	Yik6xQXnx966gznMXS3l5wpdIpuG+mlqTGWQEQEZCFhCIRwXwj2lQqJJyL0tzGml
	d/ghQw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakdeubja-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 15 Oct 2026 14:26:32 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-98c73533990so25067241.0
        for <linux-mmc@vger.kernel.org>; Thu, 15 Oct 2026 07:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792074392; x=1792679192; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2pLh6KbXd9OKT880BVflHuBCk2sw7UKfLHTzSWPYoQ=;
        b=XremOrCM9fA3984rhQY0aMdVZ9D4mZ5U39CIPEE3EhIQe0FTP9EV/dkMdcRH9ifg8b
         jHlmNdZvRbKijeOkCUiaocXQ2fepAtV09/37Zat9Ry1PjDoa4w+wynevgpcXowBrfJ7D
         ceksw81Rj/ub4IKlGnJ0Zgniu3oub41pdKk3JrVEv4bP4ErgOXxy38f0GeVJRICEMg9a
         ilQWAEjVNo/s7tXthOrw6jczehd9TC8tOU0zxYv3sHFWjCrY4ob+dApspI28lF6Zklin
         3n+jxFwTnI/fl9XMWnIwCdCn7ZD6ECtJby6DV4V7BSvksMYuHYXeLOozw3mf4ZqZEEDU
         6GWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074392; x=1792679192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2pLh6KbXd9OKT880BVflHuBCk2sw7UKfLHTzSWPYoQ=;
        b=CMU4QQy4mIt6S6Yeitu5ATgihiwX28X9C3aoUlIOS7qqjsqkkuwa8/Uj7iNs4Xe6sR
         y8hjFRfblDGISyGqKKkr0lcEBUX1T0Wd3lanlCmaz89qzoldl+L0fDDUkFxuSxiahayJ
         NXh1D/DULgcdkts/WXjCiLOYXWi1pf1tf332kT+DUwkxnWmGGMj6+Q9H16hGxWGyJssW
         CII2wGOI0HWJCoR86l6NxYcEmMRqwGVcAgt0Ngk7Oey28PHZ/TH757PeZZ5VTm/9f5IV
         1lUcB5OiC3okgBeeoItnkwSs9IiyzJBv5tvNm5kVuVGk+jJLZwzcJ2823pSAokVfHiNG
         aSvw==
X-Gm-Message-State: AFq9FYLDIvaZqny7PD3vKnoBcsP8FRqKoasnz8uYmka8nLKMaoXn4quj
	BMTeqa5RpIgjGMNVfmHsinTtqruo6UscTUPTpvimHLWp2+YSDZCV3WqLGJFopJVd1TTsGSa0qDa
	Au/QLpohCM+thGNwFmpfhNguLMRCUTjmJpYYbp4Qp1uYd8dSpJCEUqqXhDM8gsSY=
X-Gm-Gg: AYBFou24F+WLcCt9BOHE05hH8/d/LCBHMkF1eQc/NqTlN9r7tLOou2R35zv5gAFb7Cb
	Jexiox6wbC7OgFKygqqRF5CxqRx7WIG8R1+ZhXrIxshxBfHWJEeWbRGIqxf1moVqimTt+Z9/01x
	41/1A76YHpbOZShmXIbuHsQ/VKQ/FZIG1ZOpqvkdov9vyzMNrMwiaDmVwjdzcRr0RUcy8/skQTw
	776uzKOmsNwhkSwDIRjHszBcaqbA/+6BQm/YeKoyAGRNlC/s5TOzqm6olFNBNmXaIjzI7Fklt3I
	InUUfk+aEqd25tIYqtCpLwmH2FuPpU8Rh+HLs6G9EK+yT0T80mvK51qUgyM37RJUt8Fm/A3MUwC
	dNzyq8/GfP0H05WpuJeQnv5rDj8uUhQ7E0dKmifv5aRYQIYsY4/h839a1qsf6jrzLa6XsZze5cw
	rCsPDRl6sXclFWtnD4F2vs7zGFimlrpQJAaDAkE3oESWPXwV6CyhA=
X-Received: by 2002:a05:6102:1941:b0:7cc:14d:52e4 with SMTP id ada2fe7eead31-7cc180e4504mr55394137.8.1792074391489;
        Thu, 15 Oct 2026 07:26:31 -0700 (PDT)
X-Received: by 2002:a05:6102:1941:b0:7cc:14d:52e4 with SMTP id ada2fe7eead31-7cc180e4504mr55320137.8.1792074388076;
        Thu, 15 Oct 2026 07:26:28 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5402:5e0b:9ef0:9b5b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd6428b3sm69083145e9.1.2026.10.15.07.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:26:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:26:04 +0200
Subject: [PATCH v11 5/7] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-block-as-nvmem-v11-5-f890ac74f87d@oss.qualcomm.com>
References: <20261015-block-as-nvmem-v11-0-f890ac74f87d@oss.qualcomm.com>
In-Reply-To: <20261015-block-as-nvmem-v11-0-f890ac74f87d@oss.qualcomm.com>
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
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=OdENnRTY c=1 sm=1 tr=0 ts=6ad0e298 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=QyXUC8HyAAAA:8 a=ZruV3ba3MPUC-7CJ7xEA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: N-T8DuuvA2VYxtLCGFZiubJ36gQXNnvr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1NyBTYWx0ZWRfX/EE6QAUXhM5a
 HWFPTZteL5HUj3jwoqy/l8YvZcH17ErNTUZmdBOBjTEO9rrB7vwtedIvnvj1hxpHQcmN6yWINRk
 1UcdQcRE8KexErzxRc37ECrBF/7IX8stL2adCKSRgTEKZ4zY53SjhKEzY8ob1+o5b3duT0gGGlK
 5KdS9XYZoa3+YwhScvq0WXRB8jtmfBGsMLjg1pVBwS7mhAVyZtjsB/PRzx9cD1td4jMyj8CNFwy
 jFgg+j7AXKxJBWrNJQKvMVxA+eAhmP3Jo/6s4O3zYni2azVJTPv6xLh9LoSisjyi5AV5rbvU6eg
 aY91Ktjow3an0XEX/8kxaCIyI1cz94kTbgTwPFuL6Cs2lT0nqBSRw+fAb3UxtQnuO91viSnLix5
 ikbq23vV8uA2PKYjeBJKR7G5F7fTRmn+FZmGVZbFe/S+MolHfBY+4c1v86cIcYIr1XgZ3zOowJz
 vM88C3tSe/H6FCuci9A==
X-Proofpoint-GUID: N-T8DuuvA2VYxtLCGFZiubJ36gQXNnvr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1NyBTYWx0ZWRfXxaurMokU/kko
 PRdIUr3cLxcPlFFt6j8EU1G3RA1kGl9VIQKmIp1TugE5lgPt8y6SW5f9yDoX5hvtya5eMbxIneX
 GRnVcvfkYx8HcAuQ0W2/lNwoRO8yCrg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150057

Some devices store the Bluetooth BD address in non-volatile
memory, which can be accessed through the NVMEM framework.
Similar to Ethernet or WiFi MAC addresses, add support for
reading the BD address from a 'local-bd-address' NVMEM cell.

As with the device-tree provided BD address, add a quirk to
indicate whether a device or platform should attempt to read
the address from NVMEM when no valid in-chip address is present.
Also add a quirk to indicate if the address is stored in
big-endian byte order.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/net/bluetooth/hci.h | 18 ++++++++++++++++++
 net/bluetooth/hci_sync.c    | 41 ++++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/mgmt.c        |  6 ++++--
 3 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1641d879dbda997604518207ffd5dd4b02c7bf04..ed8ebdf259fa323a6d02ba6f1d75b15b6945eed1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -161,6 +161,24 @@ enum {
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
index efbd2e5387c0b2cefec5a9919c4295fa41acca0a..a0f1f8fc39c38028b291014c33eb424856794fd4 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/property.h>
+#include <linux/of_net.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -3771,6 +3772,39 @@ int hci_powered_update_sync(struct hci_dev *hdev)
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
+ *
+ * Return: 0 on success, or a negative error code on failure.
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
@@ -5332,12 +5366,17 @@ static int hci_dev_setup_sync(struct hci_dev *hdev)
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
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3b9c82bd2f027e987447e50c0072ad0b5a3227b1..4520cd160a6c145c1bd27c197d5b2f617ec504dd 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -613,7 +613,8 @@ static bool is_configured(struct hci_dev *hdev)
 		return false;
 
 	if ((hci_test_quirk(hdev, HCI_QUIRK_INVALID_BDADDR) ||
-	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY)) &&
+	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) ||
+	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM)) &&
 	    !bacmp(&hdev->public_addr, BDADDR_ANY))
 		return false;
 
@@ -629,7 +630,8 @@ static __le32 get_missing_options(struct hci_dev *hdev)
 		options |= MGMT_OPTION_EXTERNAL_CONFIG;
 
 	if ((hci_test_quirk(hdev, HCI_QUIRK_INVALID_BDADDR) ||
-	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY)) &&
+	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) ||
+	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM)) &&
 	    !bacmp(&hdev->public_addr, BDADDR_ANY))
 		options |= MGMT_OPTION_PUBLIC_ADDRESS;
 

-- 
2.34.1

