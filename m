Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68783EA951
	for <linux-mmc@vger.kernel.org>; Tue,  9 Jun 2026 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991607; cv=none; b=k3aZ72D3zQg90UMIKAiwYal7Ebou6YwgLb07Y0DSl4ksLY6KnuOmAr/up/LycefYFoPOslE6WKjDHNOY3LCZajSTK1Wg2XIu3OJaxJIMyvSgqIX2QGoqFVpWtCa2waoeGNZU/YcatLvYpEn2F3XGWGQRoFGlNnGmoZ1AzeN4wCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991607; c=relaxed/simple;
	bh=ZvvlPNqqkkVbksz5kyXL+Qu0qP+YhN+IDwhB95LLzt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dtaqMHYZiXH0zW48Ht6zTyyX49Hp8qnemwzl0x/+R8Dmu7JwUuF6bzU5NOexdyId+URImgkvTfD8tVLweVD6+c7Wt49BeoxuoPvURoxWpP63mz64+4P9BX47VAOur+PBmOivUXHUOmc7oyA6ccH1FX72eNBMo/Iqt2JJSOBf3BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nhlzDDIK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z3pA4ggM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nhlzDDIK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z3pA4ggM"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rNnX1584125
	for <linux-mmc@vger.kernel.org>; Tue, 9 Jun 2026 07:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bMh93vm3egRnMVo/u4zkORrzzjLIq42iI82oCTBPTEI=; b=nhlzDDIK49NjGM7u
	e2PSjBmJIGKIWvCfTnk67JWHJ9Y6TFJlMPNk0Y3byb1iVn2pvmbKDTq6FDQt83Y6
	wayhxnRgDSjAk7i/B+dCm5NtWo2jnu//kftijgs/cWhzgn1dks6D9+LEEnze5aHg
	9ei5fqC81hF6Uu/n9diNdARwOVyQA1l58NN0Iz5RHSBof1PEEA7EHzo7xoPjU+uo
	XQcugnRwIkMu6UG9Qsh4xlQtS5djE13aIivUnlPeV0NkkIiG0kA71k6Upk31EmsN
	yAqQIzZ1fyDJnBEaIrWmNd7TnKaL0HVCt7uBFLjUinhXrDi25J+oeP/E85YA7vkO
	2xmQjg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epdeercge-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2026 07:53:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5178fc89b2aso88019211cf.3
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2026 00:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991604; x=1781596404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMh93vm3egRnMVo/u4zkORrzzjLIq42iI82oCTBPTEI=;
        b=Z3pA4ggM6gcwmTFLHMVNNULCrNVnn43itHiibyniAro2nhLwp169ijXguaY5PqpSyy
         zNeRAzwHYQpj/fbHHHnEb1fF1tPyaBXJfvVGrCnuFSiniZqzGN3GvQcchWp+jk88hVn+
         SqxFJyTZH1/MyzYHzEpFTF+6DTJSluhAmmLinxdhu74tMmKQx/6AYDN2CzG3T4rEiBKN
         F21HCmW4tb8u4IOuXHQxtzmzKXI6hXez0EiPB8AZMBGg91BiLuU3V/uZ/CsLonQBYNiz
         UhmqdGTcnNKGVyTIQ79ACYRNIrAbaD4gc4z0TEocxzGAP1P5azewCR+qZ53TAR0fwlqp
         YOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991604; x=1781596404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bMh93vm3egRnMVo/u4zkORrzzjLIq42iI82oCTBPTEI=;
        b=Me7TDh2SlYRVfGkzc4sEzJy3BSav1Q6t9o7TtdjoaKQHXNFNfJ/UzQK7xFgQDKiS7q
         t6K0VyKQqD+TI0a9fkTg7OIJ/O5D0xgRBIRu//aNGFAAqIKnRn+xNk1nstOct8rPsrBi
         Pqw6esJZWphLcRrtP/t0VuKKmFKOcPUmmX/t8GD1lEHkQR81yHTP1ycvhl/S1pdTB+8d
         ckLTDWu5hcWrh+qzxQYMlAFiufAdPzq4+jk1io8hO8QbAC83aP45FmX2nLpHV9HP1/oX
         tg4EsACp/QgObpALzK1ubOyJOtQ2g1cVmwwOM8eZ80BjRsnAuFaly5haE8eLKbWabxIT
         3TNA==
X-Gm-Message-State: AOJu0YwlSNCWEWQ+LsCI3mIJ8gIZc0YWnJkaiyH87jngxFPNNV8G5cGY
	G3puuC3Mpdz/GevaUZ8nssk8bsHNido/tUurCsjsQ2V4/FxOOtb05VO6/OsG6lQkkuJrG0rsYEH
	PFEj7q+lXN8llcQFCCKQcVeOwtMdsLspRpCruAmFMJp1j6aXrZbV9IIvoIFIYlWE=
X-Gm-Gg: Acq92OGWwrQt+mZCjnS6tpJBPP4J/6buDaDB7Pg8n/lTBroAYknun3+PWtI23KZsaMC
	coeNUQ0XPoI6rLDjPxp6jCeMPJYg/CW4vnKg4+syFnvTiynGk6DiyX30Td+i7dyeuzZ9Z4fZe12
	YC1SgTNgjo7s+UXMWANsGQXDwWNF/c3WH0YHFNBdZx8eCc8q4CZrSsttMYRF6OWV3YHxUeIe5H2
	N5Sly5iQ9vZa/zG9sug2YnRYdUHleuZ3nUufcudVau84+wzd6nfAoCIWjUr7WTYUU3DUp5AoiCZ
	bWRh63Sc/uaMHjyM57ATb+e1/h5qLKtJuzju1mkBLGb8ooyjvN5tMlYlUf2TNEPuojAZRKobi6n
	ioDoXCOdAfctp/JpO4Wqiq60jtKf30w0wzNo3qSzmVbYW6pw3lsSFAsKOvlSu4WwJ9Z7Vzg64u1
	Ml6WP6o/VKDq+4VhBoCKepkaMxA6aq0+6Ko+++ZmcHkjFmoN5IJvygSICGzV48k4nYSaaOursN6
	glYgW2WE+ls
X-Received: by 2002:a05:622a:2b49:b0:517:8c0b:66cc with SMTP id d75a77b69052e-51795be3940mr295718201cf.25.1780991604171;
        Tue, 09 Jun 2026 00:53:24 -0700 (PDT)
X-Received: by 2002:a05:622a:2b49:b0:517:8c0b:66cc with SMTP id d75a77b69052e-51795be3940mr295717581cf.25.1780991603748;
        Tue, 09 Jun 2026 00:53:23 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:23 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:29 +0200
Subject: [PATCH v4 4/8] block: implement NVMEM provider
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-4-45712e6b22c6@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=H+DrBeYi c=1 sm=1 tr=0 ts=6a27c675 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VT4XjZGOAAAA:8
 a=EUspDBNiAAAA:8 a=0xOXAJtWE3glxeOP_3AA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NCBTYWx0ZWRfXzCAMm/+m58tx
 VvGBYxDXN23nlSuFlDKUa3LdMv2Bcea2i2ZnBQlovN4dsvkO+C0tBIz2LdvzjjZcQWwt+UK66ih
 0zKm2E2ElA50vwwbcz48KdMfvyuWk3SUF/+8JEe1Dn6HweqVBr5fLKV0yZuRrNcutlpAc0dWNjp
 REWlBiQnhFyq5IqV54ssUr1aXw1j+HPfV2MKAHSKkCRte03PaawVB37wvHWMYSJt5TkSDGxoyRm
 AyeG2QVnsvBCtPtXfZVG7xD9SR4/C02haGLmUolsk+3lEmzmd8/QIFZVc9pJocce7aQu2/4SFUY
 Lf7G+XgQqs27T0NuVDx+8KJl6uAu+sJTeV42uLlBpGExhs+fBKMkRqpsuL7qXgGrN5HL2wfsWNv
 rxmLEfdqNIBOXqfsaL7Q+Gci5ERH1k1pzW1E5UFrFSVUzeBNZhAfUfUYv2afuPVriRHEpPJETGH
 dDgdvOyq7eYeMbrKCCA==
X-Proofpoint-ORIG-GUID: lHqtqZNGZjxQXMsSRTv6yQC3QTBQzC-l
X-Proofpoint-GUID: lHqtqZNGZjxQXMsSRTv6yQC3QTBQzC-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090074

From: Daniel Golle <daniel@makrotopia.org>

On embedded devices using an eMMC it is common that one or more partitions
on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
data. Allow referencing the partition in device tree for the kernel and
Wi-Fi drivers accessing it via the NVMEM layer.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/Kconfig     |   9 +++++
 block/Makefile    |   1 +
 block/blk-nvmem.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)

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
index 0000000000000000000000000000000000000000..a6e62fa98675ee9bcb9c7035a611b5a573ab9091
--- /dev/null
+++ b/block/blk-nvmem.c
@@ -0,0 +1,114 @@
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
+static int blk_nvmem_reg_read(void *priv, unsigned int from,
+			      void *val, size_t bytes)
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
+static int blk_nvmem_register(struct device *dev)
+{
+	struct block_device *bdev = dev_to_bdev(dev);
+	struct nvmem_config config = {};
+
+	/* skip devices which do not have a device tree node */
+	if (!dev_of_node(dev))
+		return 0;
+
+	/* skip devices without an nvmem layout defined */
+	struct device_node *child __free(device_node) =
+		of_get_child_by_name(dev_of_node(dev), "nvmem-layout");
+	if (!child)
+		return 0;
+
+	/*
+	 * skip block device too large to be represented as NVMEM devices,
+	 * the NVMEM reg_read callback uses an unsigned int offset
+	 */
+	if (bdev_nr_bytes(bdev) > UINT_MAX) {
+		dev_warn(dev, "block device too large to be an NVMEM provider\n");
+		return -ENODEV;
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
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
+}
+
+static struct class_interface blk_nvmem_bus_interface __refdata = {
+	.class = &block_class,
+	.add_dev = &blk_nvmem_register,
+};
+
+static int __init blk_nvmem_init(void)
+{
+	int ret;
+
+	ret = class_interface_register(&blk_nvmem_bus_interface);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+device_initcall(blk_nvmem_init);

-- 
2.34.1

