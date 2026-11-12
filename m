Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523154;
	b=ZRBDDEUT2M3t94H0O6NUByLoURcc7cWDhjdDQffUnUI+Dw/VPqob4oYl5gD5pzav22Hf
	 63ARREidSbdkNqileZ4R7L1EklhFdYoYc3daSNYVSCJ/NGdhx/b0iKUa9Fb5sBBK8/vB/
	 BNOWGwSWNlqXIhcfcqyLv4U5TpK/kEa9PSEWXNlVPC78ZAXvPlmwJzdGRfArr876jrlYz
	 8txDNVGam4hQLb5Yi46z1i1WRm5jRsKhluM2iotistRD0hXJDExTXj1uKKOt/qdHCcYqq
	 s1a/Sls06/dTsGrUQLF75G0+e8mz3dhetS09yLL3lRjKyQbNgvFNtuimhpvTYrJPE7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523154;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0irt2JVoUcjvaIoAcVHgoPFhj7byHj/beXrI+kj/NxU=;
	b=d3qkjmdFIbWCvLs1q/Njt5GsOB3YIsj1Zo5FlXkz7z+FObTvdnbuusHfNIGtQQRa9feA
	 BGosFC7ZnSKLbkruCTZp04qGx9tF7vqx3T4bV7ctyOMGV3V/lueODydWpJMiDGufVcAaW
	 d3V5xl5zIOWRoZeJ5ZT824cXVpvrpuuvB1L1U8ASGLeN3rxsaOuLivp2dKgsJhzlRv4wo
	 d4Z1qrGkHdlb6ju6F4NEaNOMOn57Os2TUtfX/EgcmtQDAniL7lln05ijjCzZyYfWFDQG2
	 Gac4HDsGC8zKXRJDauShwVvVqE0/5s0NXKQDa4LfmUW+pEyPoIFtAobDVVyNuLo4l2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M6tzjKRJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CI5e9VbV;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BED4606A323
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 22:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BED4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M6tzjKRJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CI5e9VbV
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACJZhNH178952
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 22:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0irt2JVoUcjvaIoAcVHgoP
	Fhj7byHj/beXrI+kj/NxU=; b=M6tzjKRJ1lKXpr5qON/WFgt6xquIyVHz6SfhQH
	rcsErQJDsLKjCGMrUn2SUKf9NcDztWYXBHQf8C6B8ntbxBP3lfUFx/3zp53T5xXx
	x98JK4p4o7BVezJP9k0xgXzK4ZuJt7Jk7ob3KEDrPhvOclGUbzFy/QDSA2HlJ08A
	qtjNcSmklDzD4A+2bGBMcjTpv5o02N2jK4ODAMcDMN1vdOf99dbOyFiQkxHvgzV8
	9WGUmg0V6uj10msMTmGv9OA7ShnvqmTWozYj7J1e2fcjKRLOIo1V+JkFOtKC4i4S
	hrFcCUzqC6Rjddur8D9I2AROVSFGsJzP9/DQTB7mH7A5dQVQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw9e1b3ud-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 22:39:12 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b3b63b9665so67424c88.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 14:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794523152; x=1795127952; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0irt2JVoUcjvaIoAcVHgoPFhj7byHj/beXrI+kj/NxU=;
        b=CI5e9VbVFcdcTTzvhoePS5UXqDXyZhZyaT356/iIYJ+QgpfYAhJSxohOu6eZCriItg
         tpCnKqHiMAye0YDWzeqWmUN7gXN+vORhx0pG9C7oWF0cSIYu12iBr/cZLO1B7rTgZVs/
         1e1/P3YYt6tYHeCEk2+QrCvQ1Otwt4QCu2S4Xd2VBfQC4zGLGOVL/JLJ8ZtEsZqXlQnp
         bHKE+jyWVVB10lCHEtmbwRHS8GYbaxj/qH/O57w3L4XKW/nyFq3ldF8i49KhLCaAdBw5
         1qdJNkmTJOMnBd/CNnua9wLUvhqI0ggKSNA6oRH5FzRbqjydqr+ncgXAqp286QqdTZlC
         SDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794523152; x=1795127952;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0irt2JVoUcjvaIoAcVHgoPFhj7byHj/beXrI+kj/NxU=;
        b=Vl45YlsUv6zmpRDFKTd4XzkNA95eJMMPQN4t7kLiveWcnBMlEtpn2GrW90tDfT1fS0
         9aAqKjED/HOmZrdPV1LbOkadz37Ff5VHJ5ew7pRXjc072X0PP0kiGzv4IRUGGW5WpyjL
         eU58sgdAKI8UbMywKteVLb4DzUn5/vCm5ijp2fo63GIlBtPZtOhra+yeLGvaGhB61bG1
         83vGk6Ng/AvaNrpZPo5lDDmxi2xzQ+GH2oINOR38ZD8SoHjE3YH3xbs6oxjNhdRgacf4
         2SYC2Ak1zfvZRf4FrdAQO8JBZF2Y7Ds/hekNZZ5FoQrNzsu1NmRCA2BwHUZOI4w5+Z9E
         msiA==
X-Forwarded-Encrypted: i=1; AL+hErG6Uns1r0+zsrOL/7HG526aKCeTvqdQZ+M94rIvEfdyiVrL/TwWWmVJzhzliDc8WtV1JCT+Y6J+7rw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XIBlLjSCCHybkzC4C51T1y4Odg1Wfpm8jkCGHp/chH1fROXMH
	jJf8EZSTY6SLogtLnfncxTF8SYIM4gb36hySXyw+1Xg9yZxnsXM7PEYM+G1J41sJL9/CBrYoIc1
	1RYJ0cjW41Kz+u9p4j1yRc5Kq4VDHSnk2PupgN3V1VKMcSXQstw0xVaQJMJSy4Co=
X-Gm-Gg: AYBFou2iU55bYmAJ+jWh4Q5VsGJdX39yZi1qj9/cbXaS4IdiyPBZINNFbG9M2LDC1+w
	QXEJ9ShombJN/zLanEAB13dwwUpxjekDOR+4L1IWyQI2TBS9k6wsmZz0aIWfKisejjh1Zqm3H6/
	g4782l6+wsZc6EhELGQ/8dlO8blJH53HS6p7mAbpjA9C1MX8beryu+WhhBqvQGnqu19URNRD6pC
	+tc/FFewmWX3bJfERXmLRqijw2H6GbB0gdnlA+rGAmf1OwUapOZ6cLER4AfUqSO9XzmIvnqyXE/
	/WJlfjJirmLeNfi12he1eiUJ1RNF00n7NcjdATPfcDQAws7XwKo0jye36HJM+qcyEpzo712F9fw
	CKOzVOee5v3ovsEBzu9eukKnYTcr72SavKTsgiQ4lvNi5/Pn2jgAs+//2ZeMYpSlJrzxVXFod35
	xmArY2sMJHqA==
X-Received: by 2002:a05:7023:c006:b0:1b3:a87d:a6b6 with SMTP id a92af1059eb24-1b503163eaemr788136c88.42.1794523151764;
        Thu, 12 Nov 2026 14:39:11 -0800 (PST)
X-Received: by 2002:a05:7023:c006:b0:1b3:a87d:a6b6 with SMTP id a92af1059eb24-1b503163eaemr788113c88.42.1794523151200;
        Thu, 12 Nov 2026 14:39:11 -0800 (PST)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm2333496c88.5.2026.11.12.14.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:39:10 -0800 (PST)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Subject: [PATCH v13 0/6] Enable ICE clock scaling
Date: Fri, 13 Nov 2026 04:08:26 +0530
Message-Id: <20261113-enable-ice-clock-scaling-v13-0-258dc817bd63@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOI/9moC/3WNQQ6CMBBFr0K6dsi0QEVX3sOwqEOBxtpqq0RDu
 Lsjezc/+S8z7y8i2+RsFsdiEcnOLrsYuMhqVwiaTBgtuJ6BUKi0lLICG8zFMyUL5CNdIZPxLow
 gscFmqLUmbAW/35Md3Htznzvuk8vPmD7b1CzVD29WbFX938qXgIAHtZdD01Y96VPMuXy8jKd4u
 5UcolvX9QvD/vGQygAAAA==
X-Change-ID: 20261113-enable-ice-clock-scaling-10505f466c08
To: Abel Vesa <abelvesa@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Martin K. Petersen" <mkp@kernel.org>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA5MCBTYWx0ZWRfX6oR3RaVWh8LY
 aHAzxnRuP2crbLCZhVpuE/9OC9ZY2nR6SURF/tbTw+FcUxZ4Z3XQaGluBohnnXUOjyaTm86/+Vw
 omB3q34vMb1SR6R/5PWJyjUENcceRe0JXrdiii8USXljCPv2L1bpEaFauUp6U8zCwg0DSL+KxXA
 QhAEzvFy7oK3OetHOu8UvSDuDtp5EeAs8fFYjJ8btBssER09JQ11Ly6H+kmBiGGsyHj04LdwV25
 Zv9+xuSzxiojRGG/48bPTKqV1NlcVz8nl58/QWNUYLQBv3o6L1GM8qU/1LpSnR6dGzj7vrKLFPz
 oIOIJJWH2+uK80PnU/MeiPCRLm/pAdQOoNSLEH7gpa57W/IKT7IbIzAOac6EZj62PV6G1ppxjWU
 0TS2DKKAL2PqNXmol9ECpKz+w1QpEirDFcrlHCxi/VBOAR5pgdQ/yAfb7xj0sFRXKftkUfvJjje
 zg2Df5JnNbaFITBIy7Q==
X-Proofpoint-GUID: vMDUQ-HLeWfJ5hPt9yL4lpEUPDE6t4Lm
X-Proofpoint-ORIG-GUID: vMDUQ-HLeWfJ5hPt9yL4lpEUPDE6t4Lm
X-Authority-Analysis: v=2.4 cv=F6fC5ahN c=1 sm=1 tr=0 ts=6af64010 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Exo_CllCKnlFIUbYcS8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA5MCBTYWx0ZWRfX7uULB2OmZDQW
 CSLQzMQXkAa6xNJo8stheep/DB01cfrUTt+UnXHI0BcTzbjkcuC69lAstLda9i2H5m9fzrMkTIb
 RbCOerATFk8p6YHfw8SzmoPEeKIcDDQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120090

Introduce support for dynamic clock scaling of the ICE (Inline Crypto Engine)
using the OPP framework. During ICE device probe, the driver now attempts to
parse an optional OPP table from the ICE-specific device tree node for
DVFS-aware operations. API qcom_ice_scale_clk is exposed by ICE driver
and is invoked by UFS host controller driver in response to clock scaling
requests, ensuring coordination between ICE and host controller.

For MMC controllers that do not support clock scaling, the ICE clock frequency
is kept aligned with the MMC controller’s clock rate (TURBO) to ensure
consistent operation.

Dynamic clock scaling based on OPP tables enables better power-performance
trade-offs. By adjusting ICE clock frequencies according to workload and power
constraints, the system can achieve higher throughput when needed and
reduce power consumption during idle or low-load conditions.

The OPP table remains optional, absence of the table will not cause
probe failure. However, in the absence of an OPP table, ICE clocks will
remain at their default rates, which may limit performance under
high-load scenarios or prevent performance optimizations during idle periods.

Testing:
* dtbs_check
* Validated on Rb3Gen2, qcs8300-ride-sx and LeMans-evk

Merge Order and Dependencies
============================

Patch 2 is dependent on patch 1 for the qcom_ice_scale_clk() API to be available.
Patch 3 is dependent on patch 1 for the qcom_ice_scale_clk() API to be available.

Due to dependency, all patches should go through Qcom SoC tree.
 
Patchset v13 is rebased on top of latest changes picked onto linux-next.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
Changes in v13:
- Rebased on top of latest linux-next due to conflicts on the tip.
- Link to v12: https://lore.kernel.org/r/20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com

Changes in v12:
- Rename ice_mmc_opp_table to sdhc_ice_opp_table.
- Fix typo and remove redundent comments.
- Remove caching of the core clock frequency as suggested.
- Move sdhci_msm_ice_scale_clk() before sdhci_msm_ice_init().
- Link to v11: https://lore.kernel.org/r/20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com

Changes in v11:
- Include 20260530-add-opp-table-for-lemans-ice-ufs-v2-1-2b46d3ac37d5@oss.qualcomm.com as suggested.
- Link to v10: https://lore.kernel.org/r/20260603-enable-ice-clock-scaling-v10-0-b0b728435356@oss.qualcomm.com

Changes in v10:
- Rebase on top of latest changes for ICE driver conflicting with previous patchseries.
- Link to v9: https://lore.kernel.org/r/20260525-enable-ice-clock-scaling-v9-0-c84613e9ce47@oss.qualcomm.com

Changes in v9: 
- Kodiak ICE eMMC OPP-table entry corresponding to 300MHz is updated with SVS_L1.
- Add 75MHz for Monaco ICE eMMC OPP-table.
- Fix error handling and initialization of has_opp variable.
- Pass ULONG_MAX as target freq instead of INT_MAX from sdhci_ice_init as it better adjusts the data-type of
  the function qcom_ice_scale_clk.
- Link to v8: https://lore.kernel.org/r/20260409-enable-ice-clock-scaling-v8-0-ca1129798606@oss.qualcomm.com

Changes in v8: 
- Instead of scaling to TURBO in ICE probe, sdhci_msm_ice_init calls qcom_ice_scale_clk for setting freq to max.
- Fix error handling in qcom_ice_scale_clk.
- Fix error handling in ufs_qcom_clk_scale_notify for the call to qcom_ice_scale_clk.
- Move the registering of OPP-table to qcom_ice_probe and remove passing legacy_bindings argument to qcom_ice_create.
- Add OPP-table for kodiak and monaco ICE eMMC and UFS device nodes.
- Link to v7: https://lore.kernel.org/r/20260302-enable-ufs-ice-clock-scaling-v7-0-669b96ecadd8@oss.qualcomm.com

Changes in v7: 
- Replace the custom rounding flags with 'bool round_ceil' as suggested.
- Update the dev_info log-line.
- Dropped dt-bindings patch (already applied by in previous patchseries).
- Add merge order and dependencies as suggested.
- Link to v6: https://lore.kernel.org/r/20260219-enable-ufs-ice-clock-scaling-v6-0-0c5245117d45@oss.qualcomm.com

Changes in v6: 
- Remove scale_up parameter from qcom_ice_scale_clk API.
- Remove having max_freq and min_freq as the checks for overclocking and underclocking is no-longer needed.
- UFS driver passes rounding flags depending on scale_up value.
- Ensure UFS driver does not fail devfreq requests if ICE OPP is not supported.
- Link to v5: https://lore.kernel.org/all/20260211-enable-ufs-ice-clock-scaling-v5-0-221c520a1f2e@oss.qualcomm.com/

Changes in v5: 
- Update operating-points-v2 property in dtbindings as suggested.
- Fix comment styles.
- Add argument in qcom_ice_create to distinguish between legacy bindings and newer bindings.
- Ensure to drop votes in suspend and enable the last vote in resume.
- Link to v4: https://lore.kernel.org/r/20260128-enable-ufs-ice-clock-scaling-v4-0-260141e8fce6@oss.qualcomm.com

Changes in v4:
- Enable multiple frequency scaling based OPP-entries as suggested in v3 patchset.
- Include bindings change: https://lore.kernel.org/all/20260123-add-operating-points-v2-property-for-qcom-ice-bindings-v1-1-2155f7aacc28@oss.qualcomm.com/.
- Link to v3: https://lore.kernel.org/r/20260123-enable-ufs-ice-clock-scaling-v3-0-d0d8532abd98@oss.qualcomm.com

Changes in v3: 
- Avoid clock scaling in case of legacy bindings as suggested.
- Use of_device_is_compatible to distinguish between legacy and non-legacy bindings.
- Link to v2: https://lore.kernel.org/r/20251121-enable-ufs-ice-clock-scaling-v2-0-66cb72998041@oss.qualcomm.com

Changes in v2: 
- Use OPP-table instead of freq-table-hz for clock scaling.
- Enable clock scaling for legacy targets as well, by fetching frequencies from storage opp-table.
- Introduce has_opp variable in qcom_ice structure to keep track, if ICE instance has dedicated OPP-table registered.
- Combined the changes for patch-series <20251001-set-ice-clock-to-turbo-v1-1-7b802cf61dda@oss.qualcomm.com> as suggested.
- Link to v1: https://lore.kernel.org/r/20251001-enable-ufs-ice-clock-scaling-v1-0-ec956160b696@oss.qualcomm.com

---
Abhinaba Rakshit (6):
      soc: qcom: ice: Add OPP-based clock scaling support for ICE
      ufs: host: Add ICE clock scaling during UFS clock changes
      mmc: sdhci-msm: Set ICE clk to TURBO at sdhci ICE init
      arm64: dts: qcom: kodiak: Add OPP-table for ICE UFS and ICE SDHC nodes
      arm64: dts: qcom: monaco: Add OPP-table for ICE UFS and ICE SDHC nodes
      arm64: dts: qcom: lemans: Add OPP-table for ICE UFS device node

 arch/arm64/boot/dts/qcom/kodiak.dtsi          | 42 +++++++++++++++
 arch/arm64/boot/dts/qcom/lemans-embedded.dtsi | 26 ++++++++++
 arch/arm64/boot/dts/qcom/monaco.dtsi          | 37 +++++++++++++
 drivers/mmc/host/sdhci-msm.c                  | 22 ++++++++
 drivers/soc/qcom/ice.c                        | 75 +++++++++++++++++++++++++++
 drivers/ufs/host/ufs-qcom.c                   | 21 ++++++++
 include/soc/qcom/ice.h                        |  2 +
 7 files changed, 225 insertions(+)
---
base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b
change-id: 20261113-enable-ice-clock-scaling-10505f466c08

Best regards,
-- 
Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>

