Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528793EEAEA
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270465; cv=none; b=Tn6Mv9olb5VDgCvwFzpHrPGI6tiTNhsavNKVDPYxQQH3i5TF6j5Y5ETS6qbOwXaVghd0/EHqTqFj3VSuWie9zIMj57t5OYpjaNi62/82XGkBi0LWdYdNZItU2TJFb3srTSbsLZU5Es/Qg41WXTTYnSSZtwIHr1ToB0q2mYTkYY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270465; c=relaxed/simple;
	bh=ND8QCWihnx/5SzmAjMX21FeKkkTEai7fgVEY9yu2Gdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XkFr8+Wp4x67F/UalYoKnwLoI8rDxSA7HH1pG7M6ThtJVEGJKpV7h/nALWQqEtkZpUl0gjBrZTmX9X9cS6utEYmt9jF5BzcfPj0knafqWf08NJuBT+mk1nhuV/cwnXpcmOZnHdrsgBS0jbc1u0S4/yqUpY5bWF3m0Ta1+GvRTPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ih25a15f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D+y7On5S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ih25a15f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D+y7On5S"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCj4xd3733320
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 13:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	leied0AaOznatkz/yNwlsN4mHUViLaKycB742NpUAE8=; b=Ih25a15f7iXbpzty
	m5yjqdwpdGC0IJlGeKlWrAQFy2yLuxPcCWLUN8imPBgtPjAN2FeWU+7FvlYmF7Aw
	WDhZ/Fh5xxkRuZ2G47GesuXjMjrqPzEO5eLNJlUJ+6d4EQRonYXjTUutDr23Ilkx
	knHZSte48LpRQMBNP8oukwa0eyryq3WWcYPVFsJwTXnnLFOljrMZ/kLSuSDH7Jfy
	Ap3/z4CFWrtBu6m+1szEDiF81RrHgu8D+65N+qeR9NQ3LtBmF0876KMYSU9+7elW
	ET9ZNqVwygbI9ivhL5dBV63/0R2CpY6zAWMJcecJ2+Mjwd3wLtxpZN6ZoqtoT+/C
	BpPZ9g==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2r72xh9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 13:21:02 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-963da2c73fdso171704241.3
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 06:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270461; x=1781875261; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leied0AaOznatkz/yNwlsN4mHUViLaKycB742NpUAE8=;
        b=D+y7On5S4Nd3LyiHl3/maoqli1GLJc9ThwAccgTjV/KmliIy3NLBAmI053ixl7qKH/
         2nGKAz1+r48Ry5zKlf/jrqpIo70G8IqvapLgzjM+m38BzVV50QDjAdtX9Shv25AbWfrg
         LerPPdQk88gCezMxOgAk4ULfEh4OLVZzDZE0isjnAmZXQSW9EqKbaMOBN0O+HMY532Gj
         WYLpo3XisfkThqqj55k17mc7q+yqPQWLhwLoWT+FrwplbTn83Vsf21RE5DVEZk5xMch6
         aXLBFVeCRY63wosn2GZ1Ex3mIk+EXTihRgS/TU7VO5l76EKdz0kQU1E2E4SeqYrzrdmz
         5QnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270461; x=1781875261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=leied0AaOznatkz/yNwlsN4mHUViLaKycB742NpUAE8=;
        b=K2xGuvhtmQrhAc50QXPj8pU7KVdtvVuC1jxQ6o/oKY2ASPO74mbsmPhiLQWb1nqkxG
         a7GUx+qAlz88076U7dWzWlxrwKIAKmmpHQW0bTk6Ck8fHoEFSMxwC+ScSW0WysU88fD1
         RA0l6LswMUmtuMTInk97JJ205aJIoZALL3iS2h6koEw8ALePn3pZL7+yN37DbSHI8/Q9
         xCmkJlHUyAkiiZjmDnAryUtMIMIqnnvJn6PTwAHPhHi3KGsQc8XUOMdAahcEb3LhliUp
         GRQhNJSmzV3VjDwRH2NWsoJ8kXe8rkyaNhiJTLwDIIislmaoaxXW2pt6gUdjtZGtmHVx
         t/DQ==
X-Gm-Message-State: AOJu0Yzn1T+B/tRhOLLz9pudGz5d4a94ivm0+P9du89q3t6yIsCvEO7m
	JuoPt0rOsVE77cWHlagtwQvgP+rLCU2VkpBR6S9HSP0PrQPg0uU2ATE97KrnRLg8nVCAbjS4rf5
	Iu02+AX3wnjzCJQOZFwVfqXx6Hiho5j2HvZeE7jsnYWxdxH65LjZAvj1QKbBK4eI=
X-Gm-Gg: Acq92OF3sYcx49FkUxRbJfu3uGNIdN0xnI+C/2+sC5UikFHLjwKlfWYFa1xcaF8rcpZ
	btvmPtsyY8UQqvsPncEAN0LI7AAbJWVZHzeR1zWKsTMUJDK5p8hkPqYoDVs53Zwa4jiO4jOgY17
	PW/uYe/OgBF7sS+DEBnYixk378D//oKyEnHj2prz+ss8BnX1eKzmcY66pQm8AO4qxYpLwLm5INA
	YQqVfQzmOmLHu67WIFeFEv1FdkhM+TsjxgT4jXQY6KIPp5VBg7DxEo2+aKkDAf61AzJRJK6iXGe
	h1pqZ9YtJ4IHqqpUpuYIPd/cr0ywLfsG0ydxFDjBDejrtmfma4OUjZKZi0MqKfo84+24ZAOYIwz
	AiwuRWc3IxZTKV3J0hxHUfuKK2lHOoYfRFEniZod1ULeysVDgQrrKgt5GX2tbIJCZL0fpbMtlqk
	ysTRnczGdYgd9tgjCEu6B84ZKACTWp+sxoHy8jDUzVSTB5w6XVX3lNCIAa6upI7VopUGJdLq1b
X-Received: by 2002:a05:6102:2b89:b0:611:61d3:819c with SMTP id ada2fe7eead31-71e88b2a46bmr1202690137.10.1781270461465;
        Fri, 12 Jun 2026 06:21:01 -0700 (PDT)
X-Received: by 2002:a05:6102:2b89:b0:611:61d3:819c with SMTP id ada2fe7eead31-71e88b2a46bmr1202596137.10.1781270460929;
        Fri, 12 Jun 2026 06:21:00 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:00 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:20:53 +0200
Subject: [PATCH v5 1/9] block: partitions: of: Skip child nodes without reg
 property
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-1-95e0b30fff90@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: sS4L1mn52e8xF1R_B_Vzyexo1Xn9FUJF
X-Authority-Analysis: v=2.4 cv=RJGD2Yi+ c=1 sm=1 tr=0 ts=6a2c07be cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=e4y8cmn4OwqddjlM7QMA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: sS4L1mn52e8xF1R_B_Vzyexo1Xn9FUJF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX9nzDRX5lVg88
 8zi0F5R+hjS4OLsSfJWrC9ClJh2+x9ClMuaxxn3HbI9Hm5RaK6p5zrDuqt+uB82N3s/fU39DDGQ
 Fh35Ez+z35cFFXr6Hssy0wnvbSHIQy8hwQGoz5QI+wACecUDIb6Nf0HWmFIed1TV4FpuKP3YuW8
 2U5nSVSFqLnnlxytwiy6FuFy05AOHI/iOLjcJ2BNcazc/+SYl8LHb3dyQNf8CqWDj7ZkszMO54a
 /30r/r3ZyFeuQ0bgpwc5lhJpdohsv8bZrlpwEG7mbIqBn+xLx5SsWbsY2BfZsxRuim8YGtH4xkh
 whHrfLiPOJg3E+cmMX+SEMTev4KjG/rA6T/Pn9JWTdTZxfGxe/rR3RBIyyc9fyh2VhJ9ZTqh5NW
 2VqlHK6ExFp98MgE4Mu/fzvBD0odubHAzOb4U05FIi4SbJM4LYy7vDtpRYYjVDoGH5EqyypbpPM
 STQhQA0+GfBxNc2Eerg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX/XWfV5gZyMFU
 n0mAxVXIP1wZJXqL1uuZDocWxee2OnEBqACi3iKPvBM7UwAjM1JgTtnaOQGeje7CVviu22VjDZw
 W37HonWAUQyg4+d2xEqyG7PkecxC2To=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120122

Child nodes of a fixed-partitions node are not necessarily partition
entries, for example an nvmem-layout node has no reg property. The
current code passes a NULL reg pointer and uninitialized len to the
length check, which can result in a kernel panic or silent failure to
register any partitions.

Fix validate_of_partition() to return a skip indicator when no reg
property is present. Guard add_of_partition() with a reg property
check for the same reason.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/partitions/of.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/block/partitions/of.c b/block/partitions/of.c
index c22b6066109819c71568f73e8db8833d196b1cf6..534e02a9d85f62611d880af9b302d9fd49aa4d46 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -15,6 +15,10 @@ static int validate_of_partition(struct device_node *np, int slot)
 	int a_cells = of_n_addr_cells(np);
 	int s_cells = of_n_size_cells(np);
 
+	/* Skip nodes without a reg property (e.g. nvmem-layout) */
+	if (!reg)
+		return 1;
+
 	/* Make sure reg len match the expected addr and size cells */
 	if (len / sizeof(*reg) != a_cells + s_cells)
 		return -EINVAL;
@@ -80,14 +84,15 @@ int of_partition(struct parsed_partitions *state)
 	slot = 1;
 	/* Validate parition offset and size */
 	for_each_child_of_node(partitions_np, np) {
-		if (validate_of_partition(np, slot)) {
+		int err = validate_of_partition(np, slot);
+
+		if (err < 0) {
 			of_node_put(np);
 			of_node_put(partitions_np);
-
 			return -1;
 		}
-
-		slot++;
+		if (!err)
+			slot++;
 	}
 
 	slot = 1;
@@ -97,9 +102,10 @@ int of_partition(struct parsed_partitions *state)
 			break;
 		}
 
-		add_of_partition(state, slot, np);
-
-		slot++;
+		if (of_property_present(np, "reg")) {
+			add_of_partition(state, slot, np);
+			slot++;
+		}
 	}
 
 	seq_buf_puts(&state->pp_buf, "\n");

-- 
2.34.1

