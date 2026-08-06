Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E947A87D
	for <linux-mmc@vger.kernel.org>; Thu,  6 Aug 2026 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027144; cv=none; b=Rdy742pftpPT6aWjY71A6Jvcf4rCVcjdTFQTwCtqNTnrvlafeIxU/Pv92vwsvkRXMn33ZBPtNG4/za6jQRUgrCUAIdN/rUC6iR5MRYJp2DphKpEhS+UPreQMZFvX9To//4k4iPbh5eSUc5vBwoSndHlM8ccf77BkPqbC5mfmVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027144; c=relaxed/simple;
	bh=4VpmiI5LpCl1NsX5cM3Chy+y0oCRqLImzwBt/7bn6io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GM9HXzOc9H7LctYemHHXU+9pE7jQI/qEwzxsD5uhVvaYf6WD879WEgEvREZaMebAH68wvq/LFhmXRlsWVg+QOo/XFAmk6LmkCL/wt2rVDHgQIwDJ7DNe12ZZsHBrk/YysB8rL+5OPlOlaEqx3WN3prYh5jkQXAn25vOuy2Vzs0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X5mfZwG2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cpreIGeM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X5mfZwG2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cpreIGeM"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769ncnL1580570
	for <linux-mmc@vger.kernel.org>; Thu, 6 Aug 2026 14:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dxMrTZWIsd5PR+qlzxRw6lsq5IV1Qkuw+tEVxsLuc90=; b=X5mfZwG2vEwSz4nP
	8Dpsyg8NvlJfWbUAYbvIhbsXmLWeyvGydzWxPRGf6yapBYAuNdhIKS25Mri+7Aw9
	oV+vjRPXsp+0Lf2NpedoxE5IkL9Ply7KWRrkfL1JdA8sirUKVD5ScQu/bndt0wMG
	fJL/pQ4d7oMOtAEASrrWKCOOqovDh8tfX8zrL55Ou732i/6pAvCWje13V7BFiSdR
	Xnzijtq+aKKk5p2rNqHzg8SV9nhAG56q6PgNS84K1cs1ENJmzdyOaQDoxYpDjkF7
	yx4wRHCmrGYSZOwVa5N4a+qxqchJWXfZ2C6AwCCuwXGO8Mt7eM79na7VJSmZyQ0l
	6NXH+Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvmrjj8pc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 06 Aug 2026 14:39:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0f0a0760so37504101cf.2
        for <linux-mmc@vger.kernel.org>; Thu, 06 Aug 2026 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786027140; x=1786631940; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dxMrTZWIsd5PR+qlzxRw6lsq5IV1Qkuw+tEVxsLuc90=;
        b=cpreIGeMcoijCtxUBW8xjuP08uopTKC0PafEOfLqWBDqmN8ALnVDmGscpuTsXnm+o5
         yI5eDc30UQHBKTvS7MYpNN/PZbB5vcu43qeOtlPEVNjFV9bhd/rzEydZFkQdGRW7taUw
         WhBVBrSQ6Fwp5IYtg0LgLYnF+Wpav5uF4KmPaDwXVAIVWjCw0hW5iUaz+mGK3k7wnaDg
         GgWEG8r9yh06k8IG+jZywk3MFXE0PUIEiiKWAwSHGFb7j0Otsw4n9zK51CZcAQJZ2KX8
         A7OKAWyoWlQ92VVcvpiCEACQjyiDaad6Xr29zbKSQGsd1uvA86ratt3nDLCck5s+2gcj
         tQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027140; x=1786631940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dxMrTZWIsd5PR+qlzxRw6lsq5IV1Qkuw+tEVxsLuc90=;
        b=DXdtlRQ1PjmejzWuh67XfZhuIylNIZKYWHBJr170VsXWAmipuTk8dDd1r7/v1l3B9U
         JSRs4aBDMa/EATEjgvGZIgEEEpw2YR7zjqHamwQP7lEIClTMt9MxgO8F5HkJ9k07zxED
         NhJFcKVAksnvaDB1b1WOvJ28zMOws+K7p9ra2WkZwWjAn9wyVaSp16kng7QqUpPKy/v7
         gnTaZ8Hwnsbgd32kVC+vWu2v6fsE6JkcK8kMTUvp/pUJLl1CwscWcoestF5d+zppTcTd
         w6uXfPG4RoTIeGUg5ZC73KZQKz0LwNX8Obp7myQ6RRbciClfH5XZCxNRZMU5ZxEoAEQb
         IkmA==
X-Gm-Message-State: AOJu0YwdqRYtQpNFqKMQX0008+pN+OC5yI1nQZHs934cDzPCNKqagvz+
	j8lYl8JAswEOYZROO3v1ZHEKCIbcCA9jv5qqMFIBFIZvIekKAZ3LCwn/ZFYiy8LgaM9CXFi3POu
	6zjXHS7wES+J3yjNAeSgUNTeEgbuyNDXyRYyDPFhHN9DFgMt7hD8OTIxxD4bhSiQHepHTJrZZ9A
	==
X-Gm-Gg: AR+sD116Eab1kTzWAfCe3bRsyZPPJ3yWv4Ih3t+567o9wPg3fmogrxfRZFrnvnJND9y
	z34V2iXduH4AoMrri5jopNP+VSHRxGEq4zAPGMMhUtfiOm2LgEDEVYBcVA/hwbX86De1BUBjqr+
	QXS596y/8V1ww59bDFiX0uij2pDS4zEyLaxmn0tJOIDmaWdmYeQkKGor/BwgLiu3L4H9sYOy5cG
	9Rm71tsHJOjXltesJMluA4e2+i+gvaB6g93Jc2RMdt2xYIYkN/f6uWCKC9yb762wafANUgmMP00
	c4qoAdHtvAct89FlyCjv8Pn6J46mdm+k8sW3kCILVrjeW+wzfItZa2PwhtL9mSu2rKboFdaEyBK
	j9ZM6JvpmHgibAEn2MKutq6szl8ddzf9sAHNkUdwBb832LLSE15gbSmLW4B9wcJbg/r33C3H0Fx
	avzBgrEUOCX8AkZQPBJkCzAalX+QeYoKDQMWgLgvx9ZudJa0keNQ==
X-Received: by 2002:ac8:5acd:0:b0:50e:635b:5579 with SMTP id d75a77b69052e-52ce608e48emr133499791cf.19.1786027139826;
        Thu, 06 Aug 2026 07:38:59 -0700 (PDT)
X-Received: by 2002:ac8:5acd:0:b0:50e:635b:5579 with SMTP id d75a77b69052e-52ce608e48emr133499151cf.19.1786027139362;
        Thu, 06 Aug 2026 07:38:59 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([90.85.108.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm270552166b.28.2026.08.06.07.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:38:58 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 16:38:38 +0200
Subject: [PATCH v10 05/10] block: partitions: of: Attach partition fwnode
 to the block device
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-block-as-nvmem-v10-5-be598b2a5606@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=VNPtWdPX c=1 sm=1 tr=0 ts=6a749c84 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=JDRa4Jy4r6/BpSpxP2cCow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=2ffTNAQyBkxXHBiWhEgA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: dye83en_G3lGO-hHiW_P4juWmOY_JWTr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX8MpQV+jxpXI0
 xB2sz8ixELO3RDTQHZco8QXAjHcHA6cf+5xqr0r+ft6aQEXPxR2o/3ZLY/ZuoMbrKqqTTLB5aJM
 jAMtnMFIMM03EBaBHYlKRCBH8An+Kh0=
X-Proofpoint-GUID: dye83en_G3lGO-hHiW_P4juWmOY_JWTr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX4OeDr4F/R7Yn
 JdBx1IPxUWWSzsfM731EHamrE34WWFcfMHIGX2zNE9B//VkI6gbHwvev0PfuNhCB0PaUfhRll9k
 W0DbfOXIlPXNQ+1GeUk5SZwGo995WGyjbjahAnTQzmbV6zJcneNE0Lnk42vun524q3uAOM24OYc
 uGHTPbsWKD8sfntUMuTUMngbCSZe3/uChful7DqiqRhnOOuYHjdB/mNlN1tHhPMS1gIhevVvCMG
 dchayb+nLOtYPfrbrdJp9k/Ku1wTrHdRqyV3IcRRSpav5oO3jjKDf2FNuaTPu1nj2b6rn7Gq0lu
 XtBK+tqjdOtqg4metIis2AvwtmQ8Lik2IGzbT39rrid6mBgdA7AaPNBoR3tzNw3NPXcjxZZinjh
 OG9opbuLUk5R+RMvedSJQoEYgFz9UcFSKxMRvfM3fxmf/H1lANAixP/585EJcGiYPv4iP/dYGpo
 8S0Ie7xwTOeApPyB5+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060114

The OF partition parser reads offset, size and label from each
"fixed-partitions" child node but does not associate that node with the
resulting partition block device. As a result a partition has no
of_node, unlike the whole-disk device which gets its firmware node via
add_disk_fwnode().

Carry the partition's device tree node through the parser and attach it
to the partition's block device with device_set_node(), mirroring the
whole-disk case. This lets consumers describe per-partition properties
in the device tree (for example an NVMEM layout on a partition node) and
look them up through the partition device.

No functional change for existing users, partitions without a matching
device tree node simply get a NULL fwnode.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/partitions/check.h |  1 +
 block/partitions/core.c  | 20 +++++++++++++++++---
 block/partitions/of.c    |  3 +++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/block/partitions/check.h b/block/partitions/check.h
index b0997467b61a54a8a621b9c155c8329289649460..326081499d9a6be730dbd659c110449cfa06921f 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -17,6 +17,7 @@ struct parsed_partitions {
 		int flags;
 		bool has_info;
 		struct partition_meta_info info;
+		struct fwnode_handle *fwnode;
 	} *parts;
 	int next;
 	int limit;
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b5c59b79ca7cbb28d4d93478ee1c80908f76ee9f..eee954df1ac6ef7dd4f02ad5c9d49aed778bf015 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -11,6 +11,7 @@
 #include <linux/sysfs.h>
 #include <linux/ctype.h>
 #include <linux/vmalloc.h>
+#include <linux/property.h>
 #include <linux/raid/detect.h>
 #include "check.h"
 
@@ -110,8 +111,17 @@ static struct parsed_partitions *allocate_partitions(struct gendisk *hd)
 	return state;
 }
 
+static void drop_partitions_fwnodes(struct parsed_partitions *state)
+{
+	for (int i = 0; i < state->limit; i++) {
+		fwnode_handle_put(state->parts[i].fwnode);
+		state->parts[i].fwnode = NULL;
+	}
+}
+
 static void free_partitions(struct parsed_partitions *state)
 {
+	drop_partitions_fwnodes(state);
 	vfree(state->parts);
 	kfree(state);
 }
@@ -139,6 +149,7 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
 
 	i = res = err = 0;
 	while (!res && check_part[i]) {
+		drop_partitions_fwnodes(state);
 		memset(state->parts, 0, state->limit * sizeof(state->parts[0]));
 		res = check_part[i++](state);
 		if (res < 0) {
@@ -247,6 +258,7 @@ static const struct attribute_group *part_attr_groups[] = {
 
 static void part_release(struct device *dev)
 {
+	fwnode_handle_put(dev_fwnode(dev));
 	put_disk(dev_to_bdev(dev)->bd_disk);
 	bdev_drop(dev_to_bdev(dev));
 }
@@ -294,7 +306,8 @@ static const DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
  */
 static struct block_device *add_partition(struct gendisk *disk, int partno,
 				sector_t start, sector_t len, int flags,
-				struct partition_meta_info *info)
+				struct partition_meta_info *info,
+				struct fwnode_handle *fwnode)
 {
 	dev_t devt = MKDEV(0, 0);
 	struct device *ddev = disk_to_dev(disk);
@@ -343,6 +356,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	pdev->class = &block_class;
 	pdev->type = &part_type;
 	pdev->parent = ddev;
+	device_set_node(pdev, fwnode_handle_get(fwnode));
 
 	/* in consecutive minor range? */
 	if (bdev_partno(bdev) < disk->minors) {
@@ -449,7 +463,7 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 	}
 
 	part = add_partition(disk, partno, start, length,
-			ADDPART_FLAG_NONE, NULL);
+			ADDPART_FLAG_NONE, NULL, NULL);
 	ret = PTR_ERR_OR_ZERO(part);
 out:
 	mutex_unlock(&disk->open_mutex);
@@ -564,7 +578,7 @@ static bool blk_add_partition(struct gendisk *disk,
 	}
 
 	part = add_partition(disk, p, from, size, state->parts[p].flags,
-			     &state->parts[p].info);
+			     &state->parts[p].info, state->parts[p].fwnode);
 	if (IS_ERR(part)) {
 		if (PTR_ERR(part) != -ENXIO) {
 			printk(KERN_ERR " %s: p%d could not be added: %pe\n",
diff --git a/block/partitions/of.c b/block/partitions/of.c
index dab36513eba336344c9558d486a8915624b0fca8..d4016f9b77ec078eb1adb32923107c012ca4a751 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -3,6 +3,7 @@
 #include <linux/blkdev.h>
 #include <linux/major.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/string.h>
 #include "check.h"
 
@@ -65,6 +66,8 @@ static void add_of_partition(struct parsed_partitions *state, int slot,
 		partname = of_get_property(np, "name", &len);
 	strscpy(info->volname, partname, sizeof(info->volname));
 
+	state->parts[slot].fwnode = fwnode_handle_get(of_fwnode_handle(np));
+
 	seq_buf_printf(&state->pp_buf, "(%s)", info->volname);
 }
 

-- 
2.34.1

