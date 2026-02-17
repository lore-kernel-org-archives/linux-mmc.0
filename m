Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD370296BD0
	for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 05:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771305945; cv=none; b=lH1rnJYRgiXGX51KZkagNzvA+jHmEzGh8Td8bZmBP1BbEgZK3gI1x0p2s461XEYwqXj+xvdVN3zeI0QsVdqcUCziasa/IEau4yT5eJOpOYVjCgpd+kxE708MgJbzDbv38t/5rHmTDGycFNWpLD9tJNfN5RMpaaO6bUu3MPY3Xgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771305945; c=relaxed/simple;
	bh=n4OspjWSZagJvM5sUsKFGeAfc/MvM9mYMg22T2KPfuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQ9cppDYwnEstiVHHeyO42XRC7/8bdWWbH9RWvXQpaAxlBPxq+ZNi9YWpqUWM/n9vzIW8HQRLn9tlYUXNiehQSrqCN0+yB8y8AR3G3KQJpNnP1Td7oph4uBOFzm6zWt7h1R17dj8drp9eEaxhEhmZ6sSgSk2khG5+i1wnxGKmJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Idccab01; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WO7M61Nj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Idccab01";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WO7M61Nj"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GNvE3j241227
	for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 05:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6XSNpW0E5rM
	zc7aMxxDVhfPGX98lq9GTw7LghKYK+SA=; b=Idccab01nJg7M17L357QDeY8kFA
	vHcRVBPYPVkdxCe1asaGFtkac7L8Vjh7APv+MJlbwuEWhTRxo3gHKwmnB03EcOg9
	fo2wn4Zo/bZy4saaQdyizNsJs+N/Widy1KEnZExf205KVLVv+m27mVpVryr+j95V
	KrnEXySLNFGVHLNRcBY1lQLyQ+PiAKHApDnmKeS8NgrICZNyQocjuBeicvO5jci7
	uWDoni5jAIjHxaIrnc38XIGsG575QAUE9kJgFDqYbrNiaGX5L0DIW0xLyYziXK3Q
	Xjyj+fgQK8tjhR32w+pK2Ldicv+SkqTxrfXMWRoNFHtQDh1VjIwaZB35a+Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc5kh9f4e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 17 Feb 2026 05:25:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35626b11c51so2969604a91.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Feb 2026 21:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771305944; x=1771910744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XSNpW0E5rMzc7aMxxDVhfPGX98lq9GTw7LghKYK+SA=;
        b=WO7M61NjFxiQYFGtiogle+507VzNFLGc2MFIWflL1VQ+yL/mcW3KX0BsdOXpAswb4X
         SEfUM/myuR8dQ9w2gc6iYpLmlaflkbD28PdUhG+Z8uOG/BQsB7akepSuoeMM5xyuGPgo
         HQlXRZEMvmfh4GAhY3v8RU9v91Q12WQo8W/Jh778q4uT+wZ70pa/4VFygbO1FflExFiE
         +osdJNq6P9ROeVzIV96t2ymvDJbyh3NaNrSv5FS7/KpNajPiRvyDwA/xbj+YERjbDOar
         wTnuC8Ip0LDclEaNmRfGty+JqLtuouV9/nSWHQ3fc1bwZHb5VuFG0rriEtXyqQopjm3g
         v7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771305944; x=1771910744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6XSNpW0E5rMzc7aMxxDVhfPGX98lq9GTw7LghKYK+SA=;
        b=ekYP+bzhzy3/TnMMIXE+/tsn7Sw4U6IMq08zW0Rw0UerxDYgMkxXhye6mkRVxXcw87
         j6lVzR8tmVtZ0ef2UxSvPB6yEeOjE/r1H0ByFgdpdzUvPxw15btTMe7R0mJOiVBwfOC7
         EyzUuxHdheRHfyVV8vsoQZwNYk0Q3sHlR1TW99oESnzjyvCuZKRhTRav/QMzj50QZ4be
         +C9EMZUyqUGHCIcjzp97GtSGrxUrGcSEA1wlH5FmYLtCeOpdrmtEq12aE3IlmLLKiCZp
         cb+X6fr3q/GMFFgRUxjg/gBBvbIrneDgWS2Vfk4yFMdgdcx6bRgut5yrB94YUb5vvcUw
         Dx4Q==
X-Gm-Message-State: AOJu0Yw6d0CeppBHTPR9qx+ZkXOvrng0j/jwsnhYgQ7YH5YhDKnAm8OG
	z91svZqvD8DIhaDJkvG1Aa7ZrElaMlcnUwIrSSKwiAZbw1CeFOrA6bKw5PXBDT7/Xn8W75Drh/D
	qYErOcadpeXwmo7zpPO0QXUCpEVoFNMHzQgvIE5IywmcJAVTl3Ibd+F0RLvA9OOk=
X-Gm-Gg: AZuq6aIS66tNpC4LIIxoelLsEe3Plm7OpdkWL2jcI8l+DTRzwviBO1ZgHhzaAPRQc1b
	KjgYss0ARuwYM/o5u07w6Rg+qUWW+n5yidDdnDfIWSBMjUnDT3RtUeuKNy1jyfmiPvvXuZI7XgE
	Q2i1groj8c5Gk8bCMMOuuyyUAuIA+P0DA7E5wCE3SDEL1GLMtr4xNMy74/3IF/KBVM8NLj8Z5I/
	4cf/VY4pkohpuTY5N4i9u9Yh/EJRFKJb+EM4LDdwQdikwaA6SUf+LtzAYGloQhJ3ZoBAtawFchs
	cuk4Mh6p2IcOL9X6qgNCGNVggl/Z8OS+C4aDitsRr7ulL26IARujbHvO7dj+guRlysv3cfmuMVc
	lz2g7JUsB1o8Ie6dxNwryiUWzFhEoOBUJEMEqD+QaKkC3UtAEIg+i
X-Received: by 2002:a17:90b:5648:b0:356:1edc:b31 with SMTP id 98e67ed59e1d1-356aad5f600mr11599593a91.20.1771305943572;
        Mon, 16 Feb 2026 21:25:43 -0800 (PST)
X-Received: by 2002:a17:90b:5648:b0:356:1edc:b31 with SMTP id 98e67ed59e1d1-356aad5f600mr11599569a91.20.1771305943099;
        Mon, 16 Feb 2026 21:25:43 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356a87f47f1sm6537685a91.8.2026.02.16.21.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 21:25:42 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v4 3/3] arm64: dts: qcom: monaco: enable the inline crypto engine for SDHC
Date: Tue, 17 Feb 2026 10:55:26 +0530
Message-Id: <20260217052526.2335759-4-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217052526.2335759-1-neeraj.soni@oss.qualcomm.com>
References: <20260217052526.2335759-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Coyys34D c=1 sm=1 tr=0 ts=6993fbd8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=X7TbQ3M2BclZft3SHBIA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: nJQVNCya4bglVoe5XYo_rVePmTl6v8yr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0MyBTYWx0ZWRfX/Geyn/9S8fRr
 RWL4uRa2v1aK6YbgmJ3kP7ukuQkDa83ZJJWmmxV9WkEz3RDS1HSFIz3EnGSbgCLzEYs9GGUwmTp
 RjFkux/0lrHKXvwtvIIV6cnPwLUyWxls/SOKH1SdPau6NbWipkvGKCCJa4jGdLmCIJznOeBBKug
 skK0ys7EddAiyreSvzC8QVMJkd/s27udcc+wfMcF+bsz3Y+C+HpQFDs1Q6adhwp7IiNMb8qahJJ
 uTfjLdTqWhfdR8DZDBGk0gYL5VJ8egZWcyb5f/yC6nnpvUuvv9fJsmkjchciaXcMxpgeljLLPyE
 aikp7PrA6dZnKRVtfETF5d9gSdtTa/MYEIDSPO9gY5SSFoVoTXSrbil3J5nXWI0BI/oS3PtfBKH
 WIWonqTPL1OeHtwJ1iMUrYh7M1cQ+o2pnOt7jKrtmWHGK5xIqwtqRWOh04AZ+kqs2tyXqSlM/DU
 Gs9QpLx/rhIfK45JmLw==
X-Proofpoint-ORIG-GUID: nJQVNCya4bglVoe5XYo_rVePmTl6v8yr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170043

Add an ICE node to monaco SoC description and enable it by adding a
phandle to the SDHC node.
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 816fa2af8a9a..365af78b01ae 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -4202,6 +4202,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			supports-cqe;
 			dma-coherent;
 
+			qcom,ice = <&sdhc_ice>;
+
 			status = "disabled";
 
 			sdhc1_opp_table: opp-table {
@@ -4229,6 +4231,13 @@ opp-384000000 {
 			};
 		};
 
+		sdhc_ice: crypto@87c8000 {
+			compatible = "qcom,qcs8300-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0x0 0x087c8000 0x0 0x18000>;
+			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>;
+		};
+
 		usb_1_hsphy: phy@8904000 {
 			compatible = "qcom,qcs8300-usb-hs-phy",
 				     "qcom,usb-snps-hs-7nm-phy";
-- 
2.34.1

