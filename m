Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF293FB044
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723353; cv=none; b=uHdqlGeBtxmNz0Rf2z9Xn9xydJy2OtrIoNe5g+JTDd4Sy/yjQms5OFIY7ZoEPl3Y9C81aOLFKPzkCGdUvJeAXP83B1fg5SrBir9jVOGVUR8tmK+8O4LT4k8OnmP437Qg1qyzBHIRE2tEe0JEp+Bd9YBE+1FdS0U7GAVhg+Le84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723353; c=relaxed/simple;
	bh=DhpKvk+qKi33tdqHXBdyBn+qHlFJWo7f2LRbmA/QYF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQGyuyAhdI84JiKArkK+U86Il5JOPIZtUgTOKJQk85az4HihQDqgV2PyxqoCUDUTi4udDTFMxuq31uMHf0sQ/+BaEVnZceMne49BcehMPzvcypSTfWPkITtvhjXvWTyw6mcBDAQBGESpAvxIyI4r7mdhwwpLfe0ZJo4PdRnuU1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lfDvGzah; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WyrvYIAU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lfDvGzah";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WyrvYIAU"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rFMG2076627
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=; b=lfDvGzahDOgYX5Ff
	CC0oUo4cAzW/QEmUxZrtk2fhPOP2lXAP9AD1ydUq3wZVe+kIJvPZd4keEeW7Srm+
	xAtIIasA4rAn7fdL0ErRC8xPfgZtQYiZJDgf/mPwog9Z+uvH8YmCjFRXUGdmE2nf
	J66c2Rgkld707x/0ZdocfsHcX+bKh5RAqrgSdkCLI/R0zAJ/BsaDGUxfB0V6NEjU
	he9RfcUkfK135U9WYtfobF8EAynA2buZdpGfW5vEHy3Elfoxp32GP9Hk6yGonbv4
	sfooxxl5Do+mhZNh3Kj1QFPfl6ZzZMRPG7DkQ98SxWQgp2nY4PoSfnD/P3rpAoxR
	wmzfUQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7gh1n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:48 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-966a617821aso1484903241.3
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723347; x=1783328147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=;
        b=WyrvYIAU+ZqJPtr/1psR3gvEHv8Mm/dD31TxPdeSphY3+5OvpW/CbfqGtrAsVB8x/g
         TPNycD//BJ2YmmDcAw9GEvS66tqBJaJruWP+zZS/t1OegE3jAtSy0XURPsdtBx3YpwEn
         +fyv3MVJdvbnZ9BpqfeqSG8gmNrJBY7iAevEaAOkYHVxeOhkeii+E1LRWay+3Ya40SA5
         0nQU0jOi8rEqOXdTSMpTM4bWwiVgnd+zpI236Ml10r4/IAjyG2dRQm5Pgy/t9V/FCS8o
         jvtwwJcnuBPMlnseljZ+1FN2PxTR1BSXAZ3Z7hUlretUduSuexvwjApCpqcRpwxlfvg6
         PAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723347; x=1783328147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=;
        b=e+tJRBnMGwulO/9U4fXHILrhridJCc6jw0ul9H7l98ZagAKKlqrUx1fr2OVP6kWSpn
         5j5LXXNeD8P7chMj7mqXTA52EPMFAd2x1mjLNWQnpvSV+f0+Bs4b/CJ4AxsAUixFJ1mN
         0KPZoZgXzuX5RKySNXEPkvDVUYsiqCd4gXBquHjCMeTxY/j5tC/Jya3f8R74pDXsB0Fc
         ezWK+yetj15LCJKscwifDN40muQwskWqT8pGd5fosmVOT7YX42YAL25FQbQfGH9FwaTb
         nPrlm8gwVETS6h3SF0dO2HMmcJfig5OAkUjKJzGamzcqivErpCHekiVABHPhpv2WenH5
         Fkdg==
X-Gm-Message-State: AOJu0Yzk4a5N6MEWBcRmP2+nB57673pa3Rj76PWbxmVJl9L+M6QFekUf
	X2jtneMgkAA7Z7yZvY0CUqFxT5QfJMBCDpWrWwXg5xT291wSKX6BBVNA13mGDqYdjf6KwSDENnR
	7j1f+ZhUZYwNuQopjGt1T/OcbXYNTx6V0e33Xligdj8eStWRtfotIKB3ZKf1zARw=
X-Gm-Gg: AfdE7ckUoerMI2WIRBKYxOXJmlhkIyPVjZpVI0Mf/GPtqRdyzijEQjOW5KGL5CwDVyV
	IejNgG17AlLxWXefB//n1qjmOOTxtExlgGSwi9jqN3aYZp01Cu8e2KVynR4Prt5zfNynnfgX3zd
	O2HAjv1xYmPhiPJPLxQo8t2A6CzjjX3/+HSxuUR7AuY0IKB7AOeJL6XbV5vUH/cZcE2+VhNeVsA
	4o0r48qha/DqFRrACx+PAbpc5X9Xn7e68Yl33J0pClLFKJUusjAChU/8SVOflN2B0R9NNmqfDMN
	zg+vXOiGc2C+TLINAyRKFAiNuTWnxCe1K5S+aZDgwuqp8OF6ZG92uOwJgUSahUkF35Qp2VWiQdp
	vt9KkD2VXRsnSez+QiFDVyyESopmb8i+p6P2qr9KvIjJr+IxeIkLpskkKZHraA6ZhXe+LJgK9CV
	S85cqUNG4a9xQmeR7dESbw8SANPtOAdJ5UTRIaYEBne8AKZEg6rKZv/BbumKRAeInPs/pxxr6Lx
	dzSHPBeEnsIoOompdLC
X-Received: by 2002:a05:6122:f05:b0:5bd:9f23:a74b with SMTP id 71dfb90a1353d-5bd9f23abbbmr1750226e0c.9.1782723347157;
        Mon, 29 Jun 2026 01:55:47 -0700 (PDT)
X-Received: by 2002:a05:6122:f05:b0:5bd:9f23:a74b with SMTP id 71dfb90a1353d-5bd9f23abbbmr1750189e0c.9.1782723346638;
        Mon, 29 Jun 2026 01:55:46 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:45 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:26 +0200
Subject: [PATCH v6 7/9] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-7-f02513dcd46d@oss.qualcomm.com>
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
In-Reply-To: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX/S04sxDTx1++
 5Od1gN8LB2xvV2bxQQZGQhFyZ7g4hnONGTluA6Gb+a2bjXw4b76H8oXKrdxK/q0jHqfGC8+hos2
 2RniXDdHh2V14gBl6aoQuWpx7t8hX1U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX5pH0Ys3TC6Fd
 S7d0pz031/CX2xsBDpyUQduLGMuI7nxRQtH18pXS2RBYwl/nzFK5bM7UW2V65FafGMVu8YwfKGQ
 2Fin2Ny3j3Qbkd7umbRHvyNuDR28PsIbA0+V6HLejjmd9ZEq1OqTtIAjbsB1qok71f0ZERQFN8U
 E6ZmR3RAG+KlHnbKKZPExL4vbmlKcKciiRcAEEnmfyZarVOF03GJwdvOlS5moXVSyFNAnP2vJph
 plCT/NIuKFzcodhRmcpC82MgaEaigiKBLveii1y8WCJrOJURzSpBSFuccMhV0uUlFDX0qXaibFT
 tgrNTA6qkkF3KHXRvesAneDLUXLFRNicbDE7ldIgDTaO484SlEkpxgZKfiiaCvuEIWh2at6BrSm
 mAI8EdYwLB2Sum9bNdD97TC3QcGUWaoKt50BADkQ9gbQVoHqwGfEimzprLc7GYl5AvFrkmRyWBy
 OMg8id2qtZqJor5JzWg==
X-Proofpoint-ORIG-GUID: mon-IhIWVzjIQDYqZtwcbL_YLMV8tBmk
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a423314 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=tQ7bI2BnKgK5Av-YYOwA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: mon-IhIWVzjIQDYqZtwcbL_YLMV8tBmk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290071

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

