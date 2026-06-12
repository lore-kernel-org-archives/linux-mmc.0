Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378643F6C32
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270478; cv=none; b=Tw4aZYcazivZfmDistyaBjiXmiD+zx26NXAFh+8tM4Qh17AXGwbzHUEe8vLHB5HpjaNllS4oFV3B/q5F7M5Evu1eCeILsZyRGbi1trZAnS+/ZNV0CJq7mj/eZpJruqdFLTrGMQhipRBWaA6PWgHEb9XFGEtZFpRHHSYkUuBJZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270478; c=relaxed/simple;
	bh=ypWJcxTFcoficSRoC35+QGJSmgp4rbapgzdY+p1eZdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ltta69xrwnNwbIKyVLZDzw60NBP5QWQxJDHd0+MVOXI9JK+tVz6qKQ3BgvlZ6XNp4yhakVdyH8DhXVP+sN/e0+nDLXGFzgVR5URe9QhIVE28IV9wI9bZpBL1SQBF3QrrxWPhTmlaPAdX8oAAqrgQUBf1avxnEvS+cIhzbKCDbng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UXPv4vG6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wd/koqgr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UXPv4vG6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wd/koqgr"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCj8mZ3721568
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 13:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WA3j5D2UTvJeMm0sKJI/fgSeryn3GsGPtg1BAGqRz9o=; b=UXPv4vG6UW7DSy/F
	p+Csfp/Xgj/fdj7Pl6lFTvxuCHZpG0BaDgnTcFWCTGWnsaF+q2JOb7HBj2s4kEQN
	oH32LJ99f+p2UOBZiLVPMnK6iDIvSd61kP0rpPye1sddlUGszwiKi5nGtjCJ2ocZ
	TR+nXNy5DBjEurEck0cr/aWBwyurge0jXsiVSa0JtOQWb9yS2xeve8q1Knt5HNyb
	gdyyNFtMzW5z0jZjnOGq6k1kAOUcAhnkOuXe1MYVq9uBItznisQMzVyRr6rAVr97
	HiQdyX0/PDdKK5KNmserwSqyFnpAZ+xpJ3L2k7Iu/s07I0JLuHq+ETwZecESy+ys
	KHAbTA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1cbke6a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 13:21:14 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e7624e584dso1712944a34.2
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270474; x=1781875274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WA3j5D2UTvJeMm0sKJI/fgSeryn3GsGPtg1BAGqRz9o=;
        b=Wd/koqgrut35vc1ucCYTB3UNHmX2QaDsAFKVEIZLufjQLQje3ePK55q4LgRpBNtMqe
         wSWfz30jHvxjsrzABi5PunKRwFjCgspn17O7qIqpMcx5Xa/Vv3SYBtfv+cEEnBHGb+gj
         FuTaYwXJHsTGKUSWGNbjtoMKcWnA3wb1NPw661hRoF0fWt9mKMkjA8ASxTF3jIeUIsAW
         Fk9FOqxT4RGkwIp0b8HE65IpeEUaV2+/fUcpwxm+WMYm6+iV6lR0bbNJNeNvGdhPLreD
         q0y1j1NB2418aewjlDB0JYERB6EMecAdtM7IVffZbzgcfIIv0hIBdrmCfIA2B+u0AChV
         98Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270474; x=1781875274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WA3j5D2UTvJeMm0sKJI/fgSeryn3GsGPtg1BAGqRz9o=;
        b=khXJ39SeYyxidFkoVqWkm1eLuHziiz13ZQ+CyOzAv6rLbOw92azHgYsGrw9f5+r3k0
         wb8HOc4BQqp36K3zcjKxtXvagHAyyi4ECbehWhh5vm3/WZj8G2yEJuBhN/JPFe9fQe9/
         webmt7ps2OSvS3U0zlNydgUgHtmS40QYRxdcJ75vk/Oe6OZJEn+M9llkWZHIeqTMDzBh
         G7BTYlL+2J30UdyfzrHEwmrRcUlndICSH2o3WvTYkrBkS7F4ZZdVIDswugx+E0OhqjN2
         ZUnsntGYLODOi2tNlwAJUriJ7Nt1w22Jc4CGB37qYbVCDRl6IawIhvla0ItBjRUEPx0L
         ddiA==
X-Gm-Message-State: AOJu0YwzAgix9NYU8c+zANlW38Y7ol+nXqDhpMiPgL8iLmZYkjSu8jfc
	BXdQRhSETULXRA3r0DjdmBXJOzz39Sbt6RydUu//vl63DrrGJJmzx/cPluLhzWg8e4xbQZEck5b
	D/T+U9Yfb7T95KmhyFROi9DDiOkMRBtJUnwQShAqTRxwKsrGIANQucehvNFcBaw4=
X-Gm-Gg: Acq92OEECEIh36VPMBqv5egQB8Ey4R7v8uy4GkzPtKTl20Ys2AbUZAKbZv5OVycaZmu
	czk0kAtT5pHjym+PNQahAB5LXOOBW72KbW92qiuiea2WQiyG2rSOftiopcg8lsl7w+HuVsC/rtn
	r8jFAfGWf32dgrYwTpxSi9R9xmF5ByYIKRTAyeNlhznLhtwRLup4FCE3Wv8Qq4RXfTyc1qfeLXl
	kFzMeDMxwI1Mp+wDQY1Ad+ogdB9DAiS3oO0lOqf34dju5SnOWU/FSz3WBuyA2HZcR6h3I/nH5ta
	6aAWN188A+nmwzDWICnBpT9jUf+uLbEAM23BQU/XVqw+9vE6fMyTnRp8o8RwhqLOBl5p6Ay6ZWz
	JEkxJDEum75TkwdDDf5UzYcMr1P5tbJxVIDRU4BihJnq1NE8Ta0ZXjYt+VTZXVc4AdEID/J23q5
	1mAq3zONsbR8SUXWtbYlVpXeQpLPlvkQJB+uA964y8SBq+3kIq1zBCW2lENKEwCq4/QGiuBpgE
X-Received: by 2002:a05:6820:2108:b0:69e:98c0:a9a with SMTP id 006d021491bc7-69edc62d4fbmr1893527eaf.12.1781270474183;
        Fri, 12 Jun 2026 06:21:14 -0700 (PDT)
X-Received: by 2002:a05:6820:2108:b0:69e:98c0:a9a with SMTP id 006d021491bc7-69edc62d4fbmr1893500eaf.12.1781270473640;
        Fri, 12 Jun 2026 06:21:13 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:12 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:20:57 +0200
Subject: [PATCH v5 5/9] block: implement NVMEM provider
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-5-95e0b30fff90@oss.qualcomm.com>
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
In-Reply-To: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
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
X-Proofpoint-GUID: Ef9zvPC4TjxrfpXx0ORzVRfnLre_wieE
X-Proofpoint-ORIG-GUID: Ef9zvPC4TjxrfpXx0ORzVRfnLre_wieE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfXz7hm5YALoFLj
 nQvaUFp/tDE3VZiognwQJVG3obrdxdgpllHJngM1HhJWOu3/bCmURPzp4qe1YYT5j36KMRpCFb0
 0n46tET4YiaDsX1FognWzfv3vu2KSSQ=
X-Authority-Analysis: v=2.4 cv=S57pBosP c=1 sm=1 tr=0 ts=6a2c07ca cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VT4XjZGOAAAA:8
 a=EUspDBNiAAAA:8 a=QS6QONgytJYYblx7mpIA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX8hHbSsVfhqg8
 UWd4Zg+u7pcq6pPvXurhI0QrhrOXt3WO1E/aw+7bwjdYUNRLKwnDReB9F29REqijJIFnh7iLKwE
 LXw4XFEHQrbzqUGN8aT8yWDimutuB7B9+udQhA5SWqsi2q51LGIT9ydftZd7A3RLEsNS0t7dHmK
 lWPGPbDBda+3o0AXtbfxu9Tfn2mnSAsWBJi/BUaU/Rhus3RGhP/MHr3DhNWXQtbHQSgBKsUdA1l
 Scw7k9XvdHrBjJ47DPYMcATMMUvwFCJT4u3Uf3/rEufhF4LYhOzfv5F+mcnnhpcanyzm8sjjVBR
 79sbSrDa40Jcp9zU0KoH2b8qrga7RhUB7n2QiokN2PEupn56A4itRWH7TlydabT9BIvb4KfGwqP
 X1/p5nLymzyTuVlVVKAKcdK76mA16oQUr7aSi6MsT6P+r7692O1vypQn/El57Jrivi39edVi6wd
 uimXe3JyRnvP+hQFHUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120122

From: Daniel Golle <daniel@makrotopia.org>

On embedded devices using an eMMC it is common that one or more partitions
on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
data. Allow referencing the partition in device tree for the kernel and
Wi-Fi drivers accessing it via the NVMEM layer.

For now, NVMEM is only registered for the whole disk block device, as the
OF node is currently only associated to it.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/Kconfig             |   9 ++++
 block/Makefile            |   1 +
 block/blk-nvmem.c         | 109 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk.h               |   8 ++++
 block/genhd.c             |   4 ++
 include/linux/blk_types.h |   3 ++
 include/linux/blkdev.h    |   1 +
 7 files changed, 135 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 15027963472d7b40e27b9097a5993c457b5b3054..0b33747e16dc33473683706f75c92bdf8b648f7c 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -209,6 +209,15 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	  by falling back to the kernel crypto API when inline
 	  encryption hardware is not present.
 
+config BLK_NVMEM
+	bool "Block device NVMEM provider"
+	depends on OF
+	depends on NVMEM
+	help
+	  Allow block devices (or partitions) to act as NVMEM providers,
+	  typically used with eMMC to store MAC addresses or Wi-Fi
+	  calibration data on embedded devices.
+
 source "block/partitions/Kconfig"
 
 config BLK_PM
diff --git a/block/Makefile b/block/Makefile
index 7dce2e44276c4274c11a0a61121c83d9c43d6e0c..d7ac389e71902bc091a8800ea266190a43b3e63d 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o \
 					   blk-crypto-sysfs.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
 obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)	+= holder.o
+obj-$(CONFIG_BLK_NVMEM)                += blk-nvmem.o
diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
new file mode 100644
index 0000000000000000000000000000000000000000..c005f059d9fe56242ebaef9905673dff902b5686
--- /dev/null
+++ b/block/blk-nvmem.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * block device NVMEM provider
+ *
+ * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Useful on devices using a partition on an eMMC for MAC addresses or
+ * Wi-Fi calibration EEPROM data.
+ */
+
+#include <linux/file.h>
+#include <linux/nvmem-provider.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/pagemap.h>
+#include <linux/property.h>
+
+#include "blk.h"
+
+static int blk_nvmem_reg_read(void *priv, unsigned int from, void *val, size_t bytes)
+{
+	blk_mode_t mode = BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES;
+	dev_t devt = (dev_t)(uintptr_t)priv;
+	size_t bytes_left = bytes;
+	loff_t pos = from;
+	int ret = 0;
+
+	struct file *bdev_file __free(fput) = bdev_file_open_by_dev(devt, mode, priv, NULL);
+	if (IS_ERR(bdev_file))
+		return PTR_ERR(bdev_file);
+
+	while (bytes_left) {
+		pgoff_t f_index = pos >> PAGE_SHIFT;
+		struct folio *folio;
+		size_t folio_off;
+		size_t to_read;
+
+		folio = read_mapping_folio(bdev_file->f_mapping, f_index, NULL);
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
+			break;
+		}
+
+		folio_off = offset_in_folio(folio, pos);
+		to_read = min(bytes_left, folio_size(folio) - folio_off);
+		memcpy_from_folio(val, folio, folio_off, to_read);
+		pos += to_read;
+		bytes_left -= to_read;
+		val += to_read;
+		folio_put(folio);
+	}
+
+	return ret;
+}
+
+void blk_nvmem_add(struct block_device *bdev)
+{
+	struct device *dev = &bdev->bd_device;
+	struct nvmem_config config = {};
+
+	/* skip devices which do not have a device tree node */
+	if (!dev_of_node(dev))
+		return;
+
+	/* skip devices without an nvmem layout defined */
+	struct device_node *child __free(device_node) =
+		of_get_child_by_name(dev_of_node(dev), "nvmem-layout");
+	if (!child)
+		return;
+
+	/*
+	 * skip block device too large to be represented as NVMEM devices,
+	 * the NVMEM reg_read callback uses an unsigned int offset
+	 */
+	if (bdev_nr_bytes(bdev) > UINT_MAX) {
+		dev_warn(dev, "block device too large to be an NVMEM provider\n");
+		return;
+	}
+
+	config.id = NVMEM_DEVID_NONE;
+	config.dev = dev;
+	config.name = dev_name(dev);
+	config.owner = THIS_MODULE;
+	config.priv = (void *)(uintptr_t)dev->devt;
+	config.reg_read = blk_nvmem_reg_read;
+	config.size = bdev_nr_bytes(bdev);
+	config.word_size = 1;
+	config.stride = 1;
+	config.read_only = true;
+	config.root_only = true;
+	config.ignore_wp = true;
+	config.of_node = to_of_node(dev->fwnode);
+
+	bdev->bd_nvmem = nvmem_register(&config);
+	if (IS_ERR(bdev->bd_nvmem)) {
+		dev_err_probe(dev, PTR_ERR(bdev->bd_nvmem),
+			      "Failed to register NVMEM device\n");
+		bdev->bd_nvmem = NULL;
+	}
+}
+
+void blk_nvmem_del(struct block_device *bdev)
+{
+	if (bdev->bd_nvmem)
+		nvmem_unregister(bdev->bd_nvmem);
+
+	bdev->bd_nvmem = NULL;
+}
diff --git a/block/blk.h b/block/blk.h
index ec4674cdf2ead4fd259ff5fc42401f591e684ee9..cd3c7ca723391c40be56f1dd4810e641b7c8a2b3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -757,4 +757,12 @@ static inline void blk_debugfs_unlock(struct request_queue *q,
 	memalloc_noio_restore(memflags);
 }
 
+#ifdef CONFIG_BLK_NVMEM
+void blk_nvmem_add(struct block_device *bdev);
+void blk_nvmem_del(struct block_device *bdev);
+#else
+static inline void blk_nvmem_add(struct block_device *bdev) {}
+static inline void blk_nvmem_del(struct block_device *bdev) {}
+#endif
+
 #endif /* BLK_INTERNAL_H */
diff --git a/block/genhd.c b/block/genhd.c
index 7d6854fd28e95ae9134309679a7c6a937f5b7db8..1b2382de6fb30c1e5f60f45c04dc03ed3bf5d5f2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -421,6 +421,8 @@ static void add_disk_final(struct gendisk *disk)
 		 */
 		dev_set_uevent_suppress(ddev, 0);
 		disk_uevent(disk, KOBJ_ADD);
+
+		blk_nvmem_add(disk->part0);
 	}
 
 	blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
@@ -704,6 +706,8 @@ static void __del_gendisk(struct gendisk *disk)
 
 	disk_del_events(disk);
 
+	blk_nvmem_del(disk->part0);
+
 	/*
 	 * Prevent new openers by unlinked the bdev inode.
 	 */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c09e0ceaac41ba59e86fb0c4efc64..ace6f59b860d0813665b2f62a1c03a1f4be94059 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -73,6 +73,9 @@ struct block_device {
 	int			bd_writers;
 #ifdef CONFIG_SECURITY
 	void			*bd_security;
+#endif
+#ifdef CONFIG_BLK_NVMEM
+	struct nvmem_device	*bd_nvmem;
 #endif
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 890128cdea1ce66863c5baa36f3b336ec4550807..f15d2b5bf9e4fd2368b8a70416a978e22c0d4333 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -30,6 +30,7 @@
 
 struct module;
 struct request_queue;
+struct nvmem_device;
 struct elevator_queue;
 struct blk_trace;
 struct request;

-- 
2.34.1

