Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD50346A07
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789633; cv=none; b=J3lhnl6vMYxn5B5ZA6hIzlXhXhS0zOKfT67ZF1CNwgCAVS3DEuVGL4xV1gtANUY++t+4Isj88AGQ2dQrBsQef+fHTOn/GGPw0oRjsCT728wXFIw9q7k2OmddvV7dJskK1PzdMFA+d8EHGxQ58LXXDGInQRQc8qk7utRPbaOYuKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789633; c=relaxed/simple;
	bh=n4OspjWSZagJvM5sUsKFGeAfc/MvM9mYMg22T2KPfuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LRhRSXfdb8kKLl/VxJeoIhgqosV3mLfh4wmhHSpxbn63rVBVpObShamEYOBFypPkeC8q7c7/S/AF+glpB+NXVI6bMyKvKZhViWZfAn2lVcd5aktX6ZRkWUArdz+sFgMcDv5FwOSh/zu7rage6tOSG/pt7ql3nzWVoqxAW+1bSY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cC+hW1Yz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HLTleoZH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cC+hW1Yz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HLTleoZH"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264awUk3220640
	for <linux-mmc@vger.kernel.org>; Fri, 6 Mar 2026 09:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6XSNpW0E5rM
	zc7aMxxDVhfPGX98lq9GTw7LghKYK+SA=; b=cC+hW1YzD4ioUAdwULKSlLZT82O
	9yRWcrcBhXn2FVUsWz5slzEl4gDIY+jQfP++wdMwnjoQcuIBo2O8b/aHY2/SrrEn
	4hmhsxzuqK50QhBJN3RK2sxgufBiLP9sJSZUthy7Ixlk6Q+hlOlobLIrhdmO5oTK
	0mBcGbDJS8UAlyq6zYAKbPCyEmq7kUYIHTwnDRy9i6kS3b5qP+mS91RFAD2q6lZ5
	uSDgh8M8jkOBwwC7k16mt1iWCUECb06dWs9gIt/CZqd6IjNIrR1/Tyb7xFWhzD4C
	ma2hVOiQ9RL+ecJct4OAMBfQEbuGIlNZCJuLNrwkOI4CQjwSdr6wK1s45uw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqf25tkqv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2026 09:33:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso8474832a91.0
        for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2026 01:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772789631; x=1773394431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XSNpW0E5rMzc7aMxxDVhfPGX98lq9GTw7LghKYK+SA=;
        b=HLTleoZHWeYo9vYHyMESxr518XyUlSMdUBiokQb9nzrrxhA7M+YkmKJhHcpF7XQ5mi
         8F36jVU8Dr+JTx811ucRGvTwWwIGQYgc67OnuUsaUHcdYsnNrEzAoEO+uHA+gRCHbRHA
         DA/puilARNPDFDL+1t1hBN0wolgmTGW1yh6QaFumvvwzMX2NfoKFbjJewfj+ZK6LuKv7
         FXcmxKhadD2GLvkfQnZHizlvVhosM5umjImBpDJgPqhQNLAi8j6Ul/m7AostgammW31L
         DHwnaQFI9XA1RSSTyPA90d1XjYAsjl1c61arvOeB9s6Ki2G7qi5YQNlz2I+0vl4cWbkJ
         S63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772789631; x=1773394431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6XSNpW0E5rMzc7aMxxDVhfPGX98lq9GTw7LghKYK+SA=;
        b=JfXMhHsUWMRzJAileYl32dLc0TnphutYvhiEgun5o3fshS/Zks0WxNgH/faoGa9qzq
         Ic0jfi8vMVfbCy38khaeUowicbCPZznqh5qSlfI6re2JarRpSMgewy/8CH1u9p0ZTd08
         5QahMqPxJB1IGXe0mOww9IeZ5g1ZaJiraalhtnJEGkaVbC6hbr0d6eEUuhHmBF+CnBp0
         2Ef3d5ehiIVP+GPSpEHd7jG0T9QaiUywiLyEA4pYIRfzW6GgeTKQ0I4nICWj+puLglkX
         pqIvU5p01VTE7T/n2hxGb8qhm926fhBDI6RY0OZD3hgopWuSGNT0NiUsp7zWwNBsg3jl
         FtCQ==
X-Gm-Message-State: AOJu0YxdFjNf7oLShNtt9FR+o34yZJAmCe5zPrj46mpOeWrHuygmCiXF
	FwmSoleaRdJS/JkO5uOupEYtQVVqcvQyTaBVf95IJryhVzrCsnwcgMmoNqyydWxaMDwZyX8DbXF
	s6Sf6ELJ3i8WE0fbEe+VdwAOrj2M1IHNnaOVNU5J/McMOk2Sgwi2/5iIKoQs4tLs=
X-Gm-Gg: ATEYQzympkGtmjZLLytUBJcvr36tleDGxM7Y0fD6uXJ+27kLh255FouJFSUKwEbF9vQ
	0kGexWbeV1uvZIygu1NmrD4SDgMtC6pq72i2b/4Erzywe0wJUix9Jatqyqh9qOT3y8Wq+KLDz/r
	4iYXz/6HTxl5RMQBs71tk6LqWV7PTuxCTpyln886DRXRO0QQ99DUX+0rpLKVEPjVCAIu33l7XYV
	fRQ7PgaC6MO92LCfrFa7kVQ2D7vL+/jg8+hSBufV70RP4Ib7efi30M7eSC0bL82L5Pck+mTKw8F
	HgQ8+zsbb6905oSCFTsXhrcDHi8XaG07+qaP27h0JeSVFjdyHKicRya2fDr3sti1YcLk7eZ7VtJ
	CDB+uxUaZV2VlmSCNlAtgUxpbM2IdAlpaXiIbUL0Ool4rlsacGIZW
X-Received: by 2002:a17:90b:3cc5:b0:354:bfb7:db13 with SMTP id 98e67ed59e1d1-359be3932d6mr1377998a91.35.1772789631330;
        Fri, 06 Mar 2026 01:33:51 -0800 (PST)
X-Received: by 2002:a17:90b:3cc5:b0:354:bfb7:db13 with SMTP id 98e67ed59e1d1-359be3932d6mr1377967a91.35.1772789630869;
        Fri, 06 Mar 2026 01:33:50 -0800 (PST)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bbcacf06sm647549a91.4.2026.03.06.01.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 01:33:50 -0800 (PST)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v5 3/3] arm64: dts: qcom: monaco: enable the inline crypto engine for SDHC
Date: Fri,  6 Mar 2026 15:03:32 +0530
Message-Id: <20260306093332.4193993-4-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306093332.4193993-1-neeraj.soni@oss.qualcomm.com>
References: <20260306093332.4193993-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mAxblV41C2av3C-L70MOdtNF309TnZ-8
X-Authority-Analysis: v=2.4 cv=Uvdu9uwB c=1 sm=1 tr=0 ts=69aa9f80 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=X7TbQ3M2BclZft3SHBIA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA5MCBTYWx0ZWRfX3NQINBBKGbUz
 SR3l+7nyynnEfpuNj20oXhf0Fnwjv72Yai7FHh82+AFMsMtsx56fKRYyttXlfC2SCc2PCaxt2J6
 5CBGVU7oYMjbh+sOFeRPk/FZTM4SjOu2yfVbEimIMIP5u6oG97LTcl5T+2v/WJPA2e1bcqjdLVk
 v4s7ikh+dQwvWFweumbENc8RI81rZMJh7grpzaoWvt9TCjCsRqVCbXxBjIiHH5JprC2w0a1XbtJ
 wGs3DFS8w0T0bTsrlXlPuvTakznJDWZbZLeU2v1g4/LKrehxNrS60ZX2zy7f2p6hbwXqgUf3OT6
 rXhg8FxjNPWhMI4Z0rVmZzi8Fvy5vDXb8IWSdRRULtrRDoX4OAOQJgBo+IsE6nqvpHu9OqiSXyZ
 j78AEK4GpJFsKmHkw04kYdPHc6i59el5jRGjFNzTNuINPI5rQKBE/uyFb7Km564JjoWfAp6nUvf
 rGTL/QF+YLk9qYE6huQ==
X-Proofpoint-GUID: mAxblV41C2av3C-L70MOdtNF309TnZ-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060090

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

