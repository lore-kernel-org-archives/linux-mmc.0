Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8544C65B
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427263; cv=none; b=EVqbJEkpiQdmvehykD8950kiCn9L42BhIqKbXDpQpqtOwsGigOasScb9sWvAzMCXggX8RnfY1U/JEYbREm68EODpbBsvTbkHoH5bnPd1BSRknHLpdk+exWEMXoeR+/iDoOYexUMDyFFWJRfx2S3ifhhEgjqO7EWDDFUQy4abWBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427263; c=relaxed/simple;
	bh=e1BHr0wmF5299UV1v6fL7f7L0crddyWGWs5kiho4htM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s6LCyc4PZJd8rsKkcIWs7d0DshUntLM9UyLZp77b90EOUEfX75Tu0tPKWc67zO0yHQt+/SM+z2CehXNzqHG4ZYeAa/MDEpZlxOem2cBHCsw+eyizQs4ShLGN+SpBL//VRYotzgbDdLMG8wudEqPmgtdhqSnSMtNe80cWtjJXC3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FSJ9MQDu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y+UJhdOu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FSJ9MQDu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y+UJhdOu"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQnMi731339
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 16:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aDt5pjeFtajo9LKvxXqbwHoJxyk2CqVKt7fGD3zDCJY=; b=FSJ9MQDuIz1U6hI6
	SpkIH2oF4oSwoCYtA/PO/IRefZoco8KcIBWM8ukHFXxfjDY1wkhzs/720TUR4ad7
	glCxACA0h303CnwvgEZEbeU1fz9MLabU9RfIasN2ceNOd7GTbtH/QIMG/+l3g8tG
	df2MSCFWktAk2/EXaeGPKCEcIOAJFyiRv6UBhWouj/zLOxegRtzOKZ43WsXbDHQ5
	qgRB4FSzNo3SF0eGGstsrL+1er75AZSg3v6nWtpSnRSRXxCKQchS+3UQSSBHMZX9
	MQ8PDC+3Sbya6JUkiod2wo483m2Ie8YQcM25pzOxTWjz6TnmTKTlpv48uJvFvEOB
	TF4iEA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8j7rfaw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 16:01:00 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-907ca5abf1bso386136d6.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427259; x=1786032059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aDt5pjeFtajo9LKvxXqbwHoJxyk2CqVKt7fGD3zDCJY=;
        b=Y+UJhdOuFXiXir3ZtH7Ed/JvNqCbUw5hfCI8MIwAwozddCeLk2ncB6zvYMRPu53Bhz
         mpeiPMz3b7E9d5yBV6gk7lWkIZSSyTinvAQWa+0fSQTyblePj84lhtEZZgTXnUyMNaYy
         hD/kN+Xsanf7dgtnmzLiH8X+Q2o7wkAjh5pgRU1p5s4EJerLd/NjP9FSI+V3pSH2jnT5
         lMXIICD2kQPCJlIEyn4eRIFFSA1Tn0Q096nZ+jjP918pHN7GXRTECi7ZeVCeaEWeCbq8
         qcL/zchA+IG3G1YWn/PAT94Z/JwgdGZuKa2L8c1zqNoqPxdcQommElTAY9xuAdrz6cCp
         BJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427259; x=1786032059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aDt5pjeFtajo9LKvxXqbwHoJxyk2CqVKt7fGD3zDCJY=;
        b=QvD0hIAbhk8sCMk5WlVXmJEufV1fg9CLf9YvlBydXqkqbGuS/pQUQhTp/sxatyB4fd
         YEIDNB4/37R0043C+E7xQGphS0sQI45bqUIUXOjtuSJ0y4jI6SPXtSPEYcTP796nv3jZ
         nzdkiIUiiMTS2VP+lckJuwJw4IvrgYhDnv8J9El0uQ4wcHoXpKnrVtI6u8YAhgvGik3h
         utdNJSO0LYZafbrc1c9JFPn0DlnU+CcjpMDxjP/cvj9rKwlts6Pw2LnC5M2GQvEDWL7y
         cYOpP+tNjVhnEP2TEqQLXEJrbg69ZgeQm4I7WwbodzTgU6MmJT+rkZiIy93rqLCJfuGO
         MQaQ==
X-Gm-Message-State: AOJu0YwdKequYaDS8vc0LNSdZDURYNAk+4778EykzQS2YMY1RGy7BOBT
	466PcytYoKjl0S0johZhNOij5tL4rn25mK0zRfBgM2B+wMMZbYf/sekoFfkELw5on2uIbLTLTtS
	QSdSKZt9MguvNG/drixoWZfsWO78gwZTdrFV/Rf8uRR25X4tr4cIwOXQ9lDuLMUE=
X-Gm-Gg: AR+sD10eiS7xDGp2mrr68sFyF04srdawuBVSEt08Lc1rnLV5Z3IN/r+CKBBHTtb9Ds5
	WMinsPidAf7bqs4htcCwgf43ElGLf+RZl8t7Y+4cZJLXk0XCrWEYTBu4X/RZnYWW8k92OziBUjg
	/OTRuE5TBd0NDgdXgFQjA2/TnlcGH62n5Og4GMlwwlguCzCMEoehJguRN2deGa4C1uxvZJZSU0b
	FkyRJFrzs0Kn1TWEPuw/2gLnd8FKkRnGIuaHAVL0+mbZGeMIk2jCaWILa3lGVca5OaL9Jmb3KL9
	lgI8iozEjBB88zC2rhcONSkkB1dYzw1uFY7EkZnAfR6IDdZOXReUpd2EGbOSvWb0Pe9e/i4eC1Q
	qk8hnE/PrEoN6+f34MYc20a+KhywjH6bCtYpkUEFQibx66kV6obZfuIo7o/YV46Cvq0n0/hHDY4
	pWdzCIeZeRC48R6HKVAhrMvFoC11p9Lxey1pvrFImnrf6dO/mjjNSU
X-Received: by 2002:ac8:5703:0:b0:51a:8e07:59d5 with SMTP id d75a77b69052e-52b38368a96mr31926921cf.12.1785427257314;
        Thu, 30 Jul 2026 09:00:57 -0700 (PDT)
X-Received: by 2002:ac8:5703:0:b0:51a:8e07:59d5 with SMTP id d75a77b69052e-52b38368a96mr31925901cf.12.1785427256465;
        Thu, 30 Jul 2026 09:00:56 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:00:55 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:36 +0200
Subject: [PATCH v9 06/10] block: implement NVMEM provider
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-6-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX/heo9AtpCsaF
 mANKkQyH0Z4oeuyG7+oi8naVQm8zCF/gM5L+bqPBjug0rxGJksXZUFBSXimi3hzAL+2XAQkVXNq
 H0KLzaDzqvKwIjhmMJpiRfC5uuxE3Gyu2DcOAauB3a+XltvSmtsA2FzpLb3KIfc6FrIjgtAbnmu
 W7aPbhmRdDTd8jXNBXpHXFdPK+WbERrCmL1S1CzUIOeGTpckLuOPxUadx4gL+JSf/iLSTqDxp7n
 00aZ9PC2e+HT+rms4mpULkQlStLtKYakuSXjqYoXe/TL51A1HRzhAbGQH5fFHl1Mcng0EKRjGOL
 +V4qaSItpIg5eWEtkULl73qf/MzvUR/QDL8SvNV2hM2dwXHG5UbPzBpg5FGtnnmx6d5uFL5PBMy
 kFQ2gIYPQKIIZUm5JPKscGkwOFTmVBU6dd1sKmtW84Dn155G/zCzr1yjkHlYSPxt0ksiRbyC4yt
 gkYdC4dynDzUNmsxrew==
X-Proofpoint-GUID: AvZPpp4XTqH9XzwwTYr8-ZZTSiT0B-Yk
X-Proofpoint-ORIG-GUID: AvZPpp4XTqH9XzwwTYr8-ZZTSiT0B-Yk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfXw2da56oqJgbd
 T1yB222Asi9VDVFNC+C7NVNNg4RZJiFl5vvaUC+qlGHNtGfufSbQLaCYu9glgKhsHFh500P/woW
 WXUUezCfiuJ0iEAPyP5XWikYD68cDi8=
X-Authority-Analysis: v=2.4 cv=LraiDHdc c=1 sm=1 tr=0 ts=6a6b753c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=VT4XjZGOAAAA:8 a=71DuYGxFrHUPmPLwgxgA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300120

On embedded devices using an eMMC it is common that one or more partitions
on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
data. Allow referencing the partition in device tree for the kernel and
Wi-Fi drivers accessing it via the NVMEM layer.

NVMEM is registered for a block device whose OF node describes an NVMEM
layout, either via an "nvmem-layout" child or by being a "fixed-layout"
node itself (e.g. an eMMC boot partition associated through its mmc-card
node).

The NVMEM device is a read-only side channel: the block device stays
fully usable, reads are performed with a non-exclusive BLK_OPEN_READ
open, and no synchronization is done against concurrent writes to the
same region. This is acceptable for the intended use case of write-once,
factory-provisioned data.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 block/Kconfig             |  11 +++++
 block/Makefile            |   1 +
 block/blk-nvmem.c         | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk.h               |   8 ++++
 block/genhd.c             |   4 ++
 block/partitions/core.c   |   5 +++
 include/linux/blk_types.h |   4 ++
 7 files changed, 137 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 70e4a66d941ff66ecb0ec34f4f7eff7fd1e4be40..4899ad572c71ffdbb62460d57623216254893ddc 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -209,6 +209,17 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	  by falling back to the kernel crypto API when inline
 	  encryption hardware is not present.
 
+config BLK_NVMEM
+	bool "Block device NVMEM provider"
+	depends on OF
+	depends on NVMEM
+	help
+	  Allow block devices (or partitions) to act as NVMEM providers,
+	  exposing factory-provisioned data such as MAC addresses or Wi-Fi
+	  calibration blobs to the drivers that consume them. This is
+	  typically used on embedded devices where such data is stored in a
+	  dedicated area of an eMMC, instead of a separate EEPROM or OTP.
+
 source "block/partitions/Kconfig"
 
 config BLK_PM
diff --git a/block/Makefile b/block/Makefile
index e7bd320e3d6971a8abf584f5de42776bb54e8216..8200297fbcbab304beb4239d0c33da07011c3ed9 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o \
 					   blk-crypto-sysfs.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
 obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)	+= holder.o
+obj-$(CONFIG_BLK_NVMEM)                += blk-nvmem.o
diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
new file mode 100644
index 0000000000000000000000000000000000000000..05bc35b9b8f373ccb606bdca35d211c41d2764fe
--- /dev/null
+++ b/block/blk-nvmem.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * block device NVMEM provider
+ *
+ * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Useful on devices using a whole disk or a partition (e.g. an eMMC boot
+ * partition) to store MAC addresses, Bluetooth addresses or Wi-Fi
+ * calibration EEPROM data.
+ *
+ * The NVMEM device is a side channel onto a block device that stays fully
+ * usable. This is somewhat mitigated by opening the device exclusively.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/nvmem-provider.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/property.h>
+
+#include "blk.h"
+
+static int blk_nvmem_reg_read(void *priv, unsigned int from,
+			      void *val, size_t bytes)
+{
+	struct block_device *bdev = priv;
+	struct file *bdev_file;
+	loff_t pos = from;
+	ssize_t ret;
+
+	/* open and prevent other exclusive openers */
+	bdev_file = bdev_file_open_by_dev(bdev->bd_dev,
+					  BLK_OPEN_READ | BLK_OPEN_EXCL,
+					  blk_nvmem_reg_read, NULL);
+	if (IS_ERR(bdev_file))
+		return PTR_ERR(bdev_file);
+
+	ret = kernel_read(bdev_file, val, bytes, &pos);
+	if (ret >= 0 && ret != bytes)
+		ret = -EIO;
+
+	fput(bdev_file);
+
+	return ret < 0 ? ret : 0;
+}
+
+int blk_nvmem_add(struct block_device *bdev)
+{
+	struct device *dev = &bdev->bd_device;
+	struct device_node *np = dev_of_node(dev);
+	struct nvmem_config config = {};
+	struct nvmem_device *nvmem;
+
+	/* skip devices which do not have a device tree node */
+	if (!np)
+		return 0;
+
+	/*
+	 * The layout is described either by an "nvmem-layout" child node or
+	 * by the device node itself being a "fixed-layout" container.
+	 */
+	struct device_node *child __free(device_node) =
+			of_get_child_by_name(np, "nvmem-layout");
+	if (!child && !of_device_is_compatible(np, "fixed-layout"))
+		return 0;
+
+	if (bdev_nr_bytes(bdev) > INT_MAX) {
+		dev_warn(dev, "block device too large to be an NVMEM\n");
+		return 0;
+	}
+
+	config.id = NVMEM_DEVID_NONE;
+	config.dev = dev;
+	config.name = dev_name(dev);
+	config.owner = THIS_MODULE;
+	config.priv = bdev;
+	config.reg_read = blk_nvmem_reg_read;
+	config.size = bdev_nr_bytes(bdev);
+	config.word_size = 1;
+	config.stride = 1;
+	config.read_only = true;
+	config.root_only = true;
+	config.ignore_wp = true;
+	config.of_node = np;
+
+	nvmem = nvmem_register(&config);
+	if (IS_ERR(nvmem))
+		return dev_err_probe(dev, PTR_ERR(nvmem),
+				     "Failed to register NVMEM device\n");
+
+	bdev->bd_nvmem = nvmem;
+
+	return 0;
+}
+
+void blk_nvmem_del(struct block_device *bdev)
+{
+	nvmem_unregister(bdev->bd_nvmem);
+	bdev->bd_nvmem = NULL;
+}
diff --git a/block/blk.h b/block/blk.h
index 25af8ac5ef0f77c09b4d747827b275c32e9f2972..dad8f0d7a218edbafa9b6a03aed673657f3e8cbb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -810,4 +810,12 @@ static inline void blk_debugfs_unlock(struct request_queue *q,
 	memalloc_noio_restore(memflags);
 }
 
+#ifdef CONFIG_BLK_NVMEM
+int blk_nvmem_add(struct block_device *bdev);
+void blk_nvmem_del(struct block_device *bdev);
+#else
+static inline int blk_nvmem_add(struct block_device *bdev) { return 0; }
+static inline void blk_nvmem_del(struct block_device *bdev) {}
+#endif
+
 #endif /* BLK_INTERNAL_H */
diff --git a/block/genhd.c b/block/genhd.c
index f84b6a355b574af88c870938a8c69aeb9f8f44ad..0c9c5e5ea7baffa326a2d45b075688cf3a0edf5a 100644
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
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 72f435dfeffc63e897913571f319e5edd8e7ba88..e4a41ffcce12a08051bbd90437312b9242bf600e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -279,6 +279,8 @@ void drop_partition(struct block_device *part)
 	xa_erase(&part->bd_disk->part_tbl, bdev_partno(part));
 	kobject_put(part->bd_holder_dir);
 
+	blk_nvmem_del(part);
+
 	device_del(&part->bd_device);
 	put_device(&part->bd_device);
 }
@@ -396,6 +398,9 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	/* suppress uevent if the disk suppresses it */
 	if (!dev_get_uevent_suppress(ddev))
 		kobject_uevent(&pdev->kobj, KOBJ_ADD);
+
+	blk_nvmem_add(bdev);
+
 	return bdev;
 
 out_del:
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c09e0ceaac41ba59e86fb0c4efc64..6ed173c649025b95cce9253b27f68f2c7dbab8eb 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -15,6 +15,7 @@
 struct bio_set;
 struct bio;
 struct bio_integrity_payload;
+struct nvmem_device;
 struct page;
 struct io_context;
 struct cgroup_subsys_state;
@@ -73,6 +74,9 @@ struct block_device {
 	int			bd_writers;
 #ifdef CONFIG_SECURITY
 	void			*bd_security;
+#endif
+#ifdef CONFIG_BLK_NVMEM
+	struct nvmem_device	*bd_nvmem;
 #endif
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast

-- 
2.34.1

