Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795437894;
	b=M8so3lsaZ1LYmkO/KgV4QrRE0HyBjMJIfofzoNPihUuhAV+7iTf0ONHhZBryBQej1RY3
	 PrfDKfWq/TU+inv7aXCSRCbD7NwpRq9cvXqQMTViDFJRnor4t0m2fSDLJ5le3U6kaNJwq
	 zEdfNb+O2PcCavY0AyYyy4y7KAgjXx+ohyj3J2S4ugafOI1oE8WLPrKHwQJol7dCU8hMO
	 BuaEZ9OmKDrTFbe1k7o46PPgVg/ICN1pXBNMwq9uVejtVy/tlsbrxIopDl0rVdyE1H4fy
	 cbP9v6E0L0YWXvwGW19J+DwIueZF5Vgx1eWVxtRInG8rARL+VgiyfncVB7Z0Q8hbuLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437894;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=q2LLXgfqwD+xrLJorPVwTBLDULLlABEy70l/ShybkrI=;
	b=i0kYB1he53Xy5Y+u49GxtZHQ/lE+kywxHlyk2FF0nJdb3/OcNRvBsVFj4+/rRIjupT+F
	 vSaSCwkJ/eTXx3yuPmyKxWUSZuKrDZNfx/Z3qxowB7K6B3TP7mFUsTmNokgBpGanRai/F
	 jXHrqNi50oUqkoJFPZqXknT8RgkNYAH7FBPKChtEIcuSs/UCpqkonfOQZ7ojRnjEGS36w
	 gHrg5GzCD7gGI4wcqOjyURvWtSgGPQG2ytPr7pmzBm/Xp2w1PYIvR+Wy21+TBp4tlTwly
	 UKYWzcx4tyWvnWyImF9JnnJb/xWp0EKAsltuYMgxF6Z1BPoLLd9a7svEjHEUz6bbwvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d4XbwIfa;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T3lNwRDm;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40D8606A33E
	for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2026 12:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B40D8606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d4XbwIfa;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T3lNwRDm
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCG9wS2478555
	for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2026 12:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q2LLXgfqwD+xrLJorPVwTBLDULLlABEy70l/ShybkrI=; b=d4XbwIfaFgm/G8Dz
	xl/ht/3kCWRIcMd0XvU5QvDpv2xoviFpVh0bPMuS7EFpE9zcTSDPmdZih/S0RXoK
	T0Zlpg684HmOWajh+tFVV0lVtzpVf1xJXWcLnbc0zQn2zGBFaRV3eUTHyX5gGpjL
	8MHbnsq+62DhuP4Tjn2WCgrEE8Y5p8XRo4NhfLrSUf5fkr7l/4DTcccHoiRoPLLX
	3nSOnupI5viJsIA7rZ/uH3FRwhIMvE4HlBNHGJH+13cIbXkA/uQgxTnqces37Ijd
	5ewwLIJjXgd38wmlt7oBIjDdEmZZcxxJ/7fQeeQfyuHcKrEemjnycNQKqZLIYMcT
	et25Sw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1p9dht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2026 12:44:53 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9213659143bso64693336d6.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2026 04:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795437892; x=1796042692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q2LLXgfqwD+xrLJorPVwTBLDULLlABEy70l/ShybkrI=;
        b=T3lNwRDmBv2qflit4U9ZHSCTKCxynVZBuAwDZVceY0ziElh45jpCiQXofXZrSvKPAi
         R/dHA1qXXnyZYbB6tyKUZu2xmoMdCbeFZl4y8A51VoKL8UjomXTcRmW+Lw+3KAv/mCV+
         Y5301PH/C+b5EDpuqcMYi0JLGiNBMp9d3wC6crGTXGPPe1YCLk6EDMQM4Q844evjfUxd
         j1SAVkgwD76pqW+TJL1lR/GFFG8klfcIJi6PdvqNhgZLow8VQdafRcvjRUTmEnIbJ5EF
         xAaMXFwLsUdRCUkDtdAUwlcWSWpCIRyh6DMhRNCrqUE6mhVdEGwRSk8wbThJCMM1QBKe
         pPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795437892; x=1796042692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q2LLXgfqwD+xrLJorPVwTBLDULLlABEy70l/ShybkrI=;
        b=b56yxtMVF+Jhy4HijjfqJMbTTKO1FOZ2nWPLxRPqko1t1Q83KzaY5a4f2a8B0A09So
         SjeqRt1hIHutxcFTxdU3GyQ3UNSt4agMoQxMCBfKEzuA6PrBZsnikgq2Qi8fLSm/148T
         WhmB8mK1+wqHYmSKSSdTKfX4HRQMdp+8b5TfdmF+Vwxb50/C2IKgSwqcK9QmCOgh0uY0
         7jQQb+qOvExfBgq3uCVitM20ZQZnZ9OE0ARK67O3597x+QVkwh6xAHPNO79x2bq8v+rA
         1q969ezteh4IZg6vKX7JCNwHmKlJ+1ub9LNFyWElhgIKENIYvyUcBZ5/V6dR6vt8uwKo
         gCkA==
X-Gm-Message-State: APuU4Z+srFQZv78VCioz+MAVc4/VlIBsOqYqI07+HvIiiuemPmw52edf
	19yfRw93F62j5LLsU2d5OuM/crNJCcoCZTYGxgRWRIepnBaj2vNWwJcZyaivweudFWDHP2PV2As
	ZKpszcXiv5OyuyS1mN3iLON6d+jI3AQgObySi+pPEpbIqHXL6Nu1HL7G8MUGwvT/IQUA1pEbJpg
	==
X-Gm-Gg: AZFdTZdylqLfWLlS8mj9V5Do2fV7cZSniXp8x7AaQtR1HN0xlIWLi7OCerBbNzdxMC2
	n6T2HBm8ZYYGipo4mKk0EsZlG3a3UGZn/mrh7/C3ayrxtqbhnDIiaeJVH5QxIugtNqj+RiKsrZg
	AmVFWnRzkLdFZasZkJZxRmTF8ZkTAuGSYybXl9sZSBvxgStFmrD9C8PUYFcd1Q3qJf+6e651ifd
	PwFHF27r688WYl2NglPdTTVzso8QPer5tpupGqMGx8RCfK8xlnKyNSSnAqDMDDDCY6c0Sxgde48
	bZRALGL+BICqOolWHEf3z/IzPnFOGlnUbE4aZ00MFL464T/ZSRqIyqJEOxa4GbVZhlaG2ofGKHQ
	4yc0Ju6613We7+OjBs2f5CuJu/4V/T2GUPELEbjSV8v5Hi56r10IxdgZG8TTohwKr1PE7H1caMG
	D1b2N3dVY96UH/STmSsU8fw1AiX/M9zzfHK7nQ6p77VBpGTRfL7Ektzd0Go2tr/rRuIn6FIWwyN
	Or9z+S3HOqE7Vo0yDTBtrK4L29f
X-Received: by 2002:a05:620a:4493:b0:949:6530:816f with SMTP id af79cd13be357-949ba9fd6ebmr1899079685a.42.1795437891898;
        Mon, 23 Nov 2026 04:44:51 -0800 (PST)
X-Received: by 2002:a05:620a:4493:b0:949:6530:816f with SMTP id af79cd13be357-949ba9fd6ebmr1899077085a.42.1795437891451;
        Mon, 23 Nov 2026 04:44:51 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm649355875e9.4.2026.11.23.04.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 04:44:50 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 13:44:44 +0100
Subject: [PATCH v13 1/2] block: partitions: of: Attach partition fwnode to
 the block device
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-block-as-nvmem-v13-1-96ffe1f59332@oss.qualcomm.com>
References: <20261123-block-as-nvmem-v13-0-96ffe1f59332@oss.qualcomm.com>
In-Reply-To: <20261123-block-as-nvmem-v13-0-96ffe1f59332@oss.qualcomm.com>
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
        Christoph Hellwig <hch@lst.de>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 5oXKcIxsy_umBtarlImeDvDYHiweYxIK
X-Authority-Analysis: v=2.4 cv=K+O3jCWI c=1 sm=1 tr=0 ts=6b043545 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=_IYX2gaGVZBpxN60pRUA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfX6tfaOE4NU3Iu
 gl5ramzH6EFbA7jSKELKfasNJPe6LlJG91T4VcWCwWxGLHFq3B4AF5djY+x5tcTrOXrV9YXRqpU
 frYwtO6L8turYn5aqHnDK0NidpUGvS0=
X-Proofpoint-ORIG-GUID: 5oXKcIxsy_umBtarlImeDvDYHiweYxIK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfX1NYaTT1nfqk+
 UpIOeBbVAyfFhEv2ygVbkYHwv6Q1RrnzDqzVcyD2k7kDoE27g5Rm/FnZtmrQ+IBi9IvfgpSsL8+
 lMwK0SnxKrZjxMKAr1DjAv5ZWaedRUm/zF2+G0ii7BcAR1ACdueYYNcuk15tQc6lXwwFuRdG8QB
 QviErj0BRHP6Qsvp5ywJ7KQSQqXQLX8bsYAQVl/DqSdpNER1aCif8XgQt3Cn/Ib4h7DE7o2V+SM
 dpLD1sY1YoiUcPDeS/WcqU4gf5MQnNA7h7qi3t7GHoV03htwy9PXsxo0gK9uyzqSUJ3EyxSxZ7/
 1jGrW98ZBGEiUYdSKh7SVQSRqs7ugjpWNZ7IAhHeV1mbaG92PIFQZBvGVlFgACkdtQZRqUrHpJf
 PdFiL/3/U3qqo0EAdmv4erfeZnbPIzVIcydvhQgyFwwY+VsVy897tN6HecY6R+bOYMKbhkMiWWY
 JHR948m936QjkN1ePRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230050

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
Reviewed-by: Ulf Hansson <ulfh@kernel.org>
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
index 53664ea06b6540e3d1155141adaafac7286f2d21..4fc7c80c407de42b2b31be2c82e0e6bc2a30c9e3 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -3,6 +3,7 @@
 #include <linux/blkdev.h>
 #include <linux/major.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/string.h>
 #include "check.h"
 
@@ -62,6 +63,8 @@ static void add_of_partition(struct parsed_partitions *state, int slot,
 		partname = of_get_property(np, "name", &len);
 	strscpy(info->volname, partname, sizeof(info->volname));
 
+	state->parts[slot].fwnode = fwnode_handle_get(of_fwnode_handle(np));
+
 	seq_buf_printf(&state->pp_buf, "(%s)", info->volname);
 }
 

-- 
2.34.1

