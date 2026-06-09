Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336843F1664
	for <linux-mmc@vger.kernel.org>; Tue,  9 Jun 2026 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991615; cv=none; b=XnFaryTa1agAQkn2chHX25xd2dJ+1ayT4qLmJeblYzdXZP28haL6xeDKVewmDGf7nAxRAFHFQzlPOmV68Zt4az3jGYqF84OaFdbeOUl3eR1C5f2LMsmWS8zI6KhK7OWQg6pOwkqznOMS3Ri3tnYSlisVamVsrCweCQ8CRjLdkNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991615; c=relaxed/simple;
	bh=DhpKvk+qKi33tdqHXBdyBn+qHlFJWo7f2LRbmA/QYF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fNEagdr04da3v83MZD8V9Z7opnLXu76syGrFWnT05mZea5CrCZUuQXQofgrOyyv1DbwqBjmKaoXYZDNqLnAuhc+OprnYilTUjm1DADY8MPa8CBSGDa7DFOaDiWohzFz1rjShMbBuy/2ooROQWV5f44lIuYAxWOSA2qtNEIUnU+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QtSHxEJ0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FbUmFrut; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QtSHxEJ0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FbUmFrut"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rO1i1517656
	for <linux-mmc@vger.kernel.org>; Tue, 9 Jun 2026 07:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=; b=QtSHxEJ0Y6rPMv40
	pv0dZM8Puc4mUpXvZMddxvB85ke0qi44hnbXN+nnoKZWU6VwBO6Wsew4TtaqZV1k
	WXMqFWtU+n5WChEHLfVNyZmrXeW/ti/njqteaeD/GroXNwgDOaambGQgOKbz2zyR
	ZI5Wfdsxi97oraH/OTZhWkb7T6gW0e7q4+vAzZlrWxAkWmEVqEn/eGiT4U9MYbCn
	hSFlhRR3dX1WoJCJWgVyab7AwOE7FjvM/DAXlF1CjMxKGbibnPGASUvXjLqHWPrv
	cy4O6GTR9E6QgiwNFGV8n6VigUlp5XFxyThfhXKrQvPofiFPFnlGijeh5Lvk7cnJ
	6DeXgA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epenr81g0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2026 07:53:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9157d38ab37so607268985a.1
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2026 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991611; x=1781596411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=;
        b=FbUmFrutRPh+sEBIw5AIewyiCaJngSR2NuUIhMpoTnxB+pUh/aVL3gT8+ZVIXll3i0
         G3ydsHH5b6KrlfGRJ61Ly8nB0wkTJOojVBcsWri4QzK2OfTe7pBHgHmLh602g0erVMlV
         EIf0IVS5kNNxt1pk4RPYsalzb+A3V5dTLCKJiJRvkcw/piSr0qvI8H724wChBpcVXR+b
         Tr/DpuvTrvIiB3XkKHWsttaPxYWV68DuibrOWjNkvGm6fyYWijeti8kUllszrRSHBn5/
         8M7XfFy855bNoZTGjP3NxZmm35YbuVClH4s+XF6bkpvu8iHUdV6WGrWgNgYGF1c7OW0j
         UZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991611; x=1781596411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=;
        b=X/0Eid0fLpcEFddhSM7ELEpiD22Q/yCyGt9+piEgi41inXx+E5ubG76wh421mTty31
         iythhQlf7aSCIZnBhfIjv6DElW+gDMsI0SbGtPihvf/FKV85tT+Ppc7CtqoK+ghCcqGS
         Zp1RqHrmYdv3nyqEEOXFb6Syk/FUNcU0yQrIFlFd0a2Igdij6zKk3sR/sBpLDYUcZiGK
         KxFmcHH7GqehVZr4sFdWrhgmHpTas8b9zVUiS1YMnGUOq52RGNnteJIrlrBR6BdZpz6D
         A3oYTsPsuEXMilmlekOsK7uF/qfxKoRH+XDIFKXFVhJhQdVYSZW46gesmDdv7ORfkGuC
         ePew==
X-Gm-Message-State: AOJu0YxkAgR6l52yMYY/xUlq1Zf7BM2p/0c/B251QReVPhMXKcAUwR2B
	3F0WVRhwyqH0QjZIqCVZvBczjdtbnxAs87cuHQhPychBDA5VFXSBVS3SaquUKioOjiB8julBwIl
	WJ42EZWDSiQsKZ+B6olmzjmw3uIiKUAlpV8PMEfiAeoxqe6MwKMtdgD42KeK8Jkg=
X-Gm-Gg: Acq92OER1WaXzXzo+agukp0C1Gs4UZoqDq2/IuzEA0wL4AX8KuLlXKFgXRGFMs66U6I
	mLzOr6PmIud9oeBa7NPrxmNNBnaGB8Yyx8pukXUTHxJBJaiIQfywEx37m4a4EFKdVPMCIRLKsZ0
	3qLsnbtdc6VJRjrgbR/QUku3TMYGg8n5QgMwCMdR8biR68n9RaQDmhFMotxzP3QN0WqBlr3kHsg
	CVQPf593EStRngWL2DnM3ceeAzfWo2QD+yULKbDLfIl/WF6XE/vsbCoAHJgLF2DiMhJWfbqCFF7
	EnA5SgGpG9ejCASlHbHKFFwRV7loAHP3oRiu44U28rFjS84U05OI8sa4U1YFcsYbPYD2W+/5brs
	PSELTofHnV9mvi5DOdTmYMH1Fv1ynT9xp1ADcIK5mzQdWV/IEYVcLpjTZtoJRtKXC67oqSz8wzE
	Tt0zbwUBLstJdE29oS5lV0/gFu81NmChmF9rDL+8cSqLR2nkIzqCajtKyi1G902wQb+ctDRfNsz
	dGqgO7pX8ig
X-Received: by 2002:a05:622a:1388:b0:516:e031:9343 with SMTP id d75a77b69052e-51795a829e6mr264738781cf.11.1780991611214;
        Tue, 09 Jun 2026 00:53:31 -0700 (PDT)
X-Received: by 2002:a05:622a:1388:b0:516:e031:9343 with SMTP id d75a77b69052e-51795a829e6mr264738271cf.11.1780991610728;
        Tue, 09 Jun 2026 00:53:30 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:29 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:31 +0200
Subject: [PATCH v4 6/8] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-6-45712e6b22c6@oss.qualcomm.com>
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
X-Proofpoint-GUID: eQRfahVaX5Dadh9ARk0c_B0M335T9FRg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NCBTYWx0ZWRfXx8A/+bJAk87r
 zlmYD6+/2kca0zSY3Bof0fYpv4Pl8EFA8Kyy5JQWr6pH0tn7/vmDHtLXy9SO1fXoH9ugJNYfho/
 7IlmnAUHT8Qi+BIjBIFGQkFzuIcHkNsZDf4HnxhBYQy9K/UQXiXR1cD2VyxQqk2W2eHdsdMeTy8
 e00dHX/m0ShC4EQ6nVxEyH0B2n5RsHbARMbhu85WRaTp0Ec0pExzSUvI0YG7qCY2llx3Nlv8vUv
 pbngsousHsFIHNI9PTAIcmGcou8xeRzgbFU7oevY+klCBGRLZjW3sxX8txpjP+7WLg/lYYhr+rb
 4y3193B3kQ6wdX+NvYImYS6Szu3qhE+15ojtkzPlqzIKmxbnK+hiAUW2xPzfGryAOCxaUgHiG1k
 YoLMHDfv/gz4NdFBgSBqgvUtN4h/m6PpswgoCHQRTOmOXDJ4hnjjOqS3WL1ZEhrOwDkm0VWKT+X
 Wi3lvYYZaG7fNoUUNww==
X-Authority-Analysis: v=2.4 cv=NKPlPU6g c=1 sm=1 tr=0 ts=6a27c67c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=tQ7bI2BnKgK5Av-YYOwA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: eQRfahVaX5Dadh9ARk0c_B0M335T9FRg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090074

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

