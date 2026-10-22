Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662724;
	b=grERDsJ2PwBnrAc2w+4Jo3QqRhSuWLVDXj/0sALtoIXJDd1rXBCMeOqRybMg6qLIShNO
	 n75PcOqsUo2ClS0cOF5bIA/SfhMVD0kPi1eF1BUKnm/GjwwnwrH7Hn1EMqitVPi9tt492
	 2kMLjIpomsti0o7TvhKvgxJtxyn5qKX9/xlSiWi9OUWC5mFu+pSe5SBE45mbJOjbIUExk
	 NTqKdHO+SyQFdMjNFlqX5iuuE+Lb9PpF7eNgfzZsS0oRAPSKEJJ01sYdb8fR1gbdWHNoG
	 o00irp3w7S/BeJadxvgevbcZgG+jHxFAVUhAhs2dyDMAdmHhplVfY9XYLzK1IBK4q8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662724;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ibZbAM6mxwTviQGJE6mRb86msHnx1wYpor8WMO/JeSc=;
	b=CLXDdYcac5wIGo2JczHHx/gQba4WF7SiUcvY/sJGs8lkkZu+zRTR/WgpDesc7v9Jvn73
	 /s9dF8t3ehpky3ryex+08RZM6P7KU7+RKLWBKETDKvaZWNHHQVxLpr1S7A3nA8c8X++n3
	 YEa1cx/TXKoCk0x+E65ihBX3mvkaZ0vjDKe0m36jxbfqUBRpWkkjLWsCKea5tLIqDUzhK
	 7weMuBeIQKpLwljrg4rajrQDO3QS0OrqVMKUAYxr9H48c6OnBMuSIgkRaqHZZ8Fkidwr/
	 YmhwOmQiB2YqRJWbHDvuA91aLqNkmeNIQDy76YJncMiPxIcUfGDlg7WMrV6TbmO/jPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C7Xzwrny;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SmUBGrpg;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11901606A31F
	for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2026 09:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11901606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C7Xzwrny;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SmUBGrpg
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M9hboT3955556
	for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2026 09:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ibZbAM6mxwTviQGJE6mRb8
	6msHnx1wYpor8WMO/JeSc=; b=C7Xzwrnyd9b9GwslpMsBv5OubS0kInrGpENouM
	O6O3cNuzljTdAxD09OxwUiu9GneqxHbEdsZjGn+jfoKED7NRGKTKE2fcQ6uk2aU4
	aHOx5/8peflJn1j+eN+OtdzZRFVnGN402bn2b01qb0jENTsOk8cFPAKUjrA9M4CF
	nS7R/CdRSOAi8y1VzfipC/szB5xyyTx0ARJsDnGY525C1AtpcvGwLttpLkH5wX4m
	EqH7G4D841pyLMsaPNtpE4lRa3bYiFa3bqh8MiIBBpVdm58gp93QijbUw3MKu+Ym
	d1QydRW2CzCnCszkW12IbKIYFmwBjD0AZ/iFiJJApc2T4O7w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93c9r0b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2026 09:52:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35c3c370b17so2807580eec.0
        for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2026 02:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792662722; x=1793267522; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ibZbAM6mxwTviQGJE6mRb86msHnx1wYpor8WMO/JeSc=;
        b=SmUBGrpgJUf+Tq9+aT80UlaXIpb35ocvWF/8JPjhbZZwzP5H1GhnQn3w2vKhsVB9aW
         mwML6HYM43P939haimf0VL4Z/F3Snrw83eywgLTyx0w6tqQ9bOFfqjMmEhfqak4llGxa
         sUGAq017CS18nXPZz4rfLqj41UdNuxNsCcOL5CwRFYacvVjjz+lPIYBQPSg+KDC/UbIJ
         zxnHu8nxZr7BOp+G8ZeMhD4kSm0jq8qNpWTtmr+XaU8W/lJ3nN4gAYzhyOae8XpS2pPV
         zOAmzanlrWrLyi7kDs5ulX6mllRZVUr+Owr98kqBFzA1rZfC5aZD2n+6bRg8sq8d47hf
         2Tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792662722; x=1793267522;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ibZbAM6mxwTviQGJE6mRb86msHnx1wYpor8WMO/JeSc=;
        b=nMZxdLKSUJES/F9IW2HuMm+HeWpUC8mEO2+BuagnO3BjsTg1acFiAeeEtpWKSP16IT
         jQ000iLG5LtXQ45uLfEacqi2iJ0ipSr5bZ6tA6j5NCIBzbz+8awNlO3ICPkqo3mlY8sn
         vSkJiaSFUC8J1O8VMH/B1n9TzBT63VkXP9wiGKPfcSHwoZQ2UlRYjjVoGTOI55PZaVPr
         dBxUHKyM2rz7CdFfeTbia6/XTySvsLt6xi5+ig3rc8RDYL/7d8ePgI5l/Zq+HKQzcX0p
         tr3gbTfzkNC6TBGu+O1XnNQ2a8fis0BfvKHNlF0O7g3kJNXFe15sQwGCSnM9ElEu/PRc
         kHlA==
X-Gm-Message-State: AFq9FYLY+oOViYdyORaW16zbDuo2ejQGTQUx/ECoQrFb8DCx96mlGJzG
	kXcGiF0lt1Pvp0CHKZGFA2zifqkJm38lzUd3Qnk9bUlmLr8c/DiZiZ/WV4nDbdjXiD4VVuc+fw1
	jLYDv1mO636hO9ZgwDDR2FxWZ0sMsH0syC5rtfP4P+g4d6U1w/F4J2QWlXMWdn0E=
X-Gm-Gg: AYBFou0iqflAPlBuC0uOc/9vy23J9PrTmuDvJA67a2cGkkdt24UCV41Jyzanc3lIAx4
	DMnZBpBVm//UDvnOsdJh94IjS5RSjG9QYrhQZ2rvnJQlXbDRgBLE+ybm4eGftdHNIpH/UYDkuET
	/3jR+f84lU+Pvb0CmeSd1od4DaP3OAtujz8PvyPr4Wtn8KcfkPhN+QBHo/zhK4j9AHYBFNVOLeV
	83i/izesRGnko+YfMA2Pia10eq3lj8fNwnE9hP5wzwSCjhriNCIKRe1H9BM404OuZHcEA0tcZg0
	rdFNUOduOTyFPHxpS0Zh5/V8MtkNxU2LHkOeP+S3WglK9cC0lrWRHE4JZryylyrVlEk5/3fAvhh
	8D7xvlTPFzy9awmZh/RYGRl2TtZsxlPvB
X-Received: by 2002:a05:7022:f512:b0:187:efba:9ba2 with SMTP id a92af1059eb24-190a84c55a9mr4905124c88.44.1792662721793;
        Thu, 22 Oct 2026 02:52:01 -0700 (PDT)
X-Received: by 2002:a05:7022:f512:b0:187:efba:9ba2 with SMTP id a92af1059eb24-190a84c55a9mr4905106c88.44.1792662721247;
        Thu, 22 Oct 2026 02:52:01 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e153519sm15742170eec.3.2026.10.22.02.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:52:00 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: [PATCH 0/3] ICE: Enable runtime PM support
Date: Thu, 22 Oct 2026 15:21:49 +0530
Message-Id: <20261022-qcom_ice_pm_enable-v1-0-f7a84086c651@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIALXc2WoC/yXMQQ6CMBBG4auQWduEDmqCVzGmocOPjpGCrRASw
 t2tsvwW762UEBWJLsVKEbMmHUKGPRQkjybcYbTNJi75bEtm85ahdypwY+8QGv+CqeTUsvV1jSN
 TDseITpf/9HrbnSb/hHx+J9q2L2ZT2vp2AAAA
X-Change-ID: 20261022-qcom_ice_pm_enable-3c5d21b99e42
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfXyjff4q0feqdW
 bx3HUeT//pMzBx0k+w/So5y2T3JGV1LX6gFq82uYEf/fHKnYUIvp5A/xy6zLSFq6mV4o0CpO+5L
 T7XR9TaPh5//Bi4ZaYQB+/rCwyLE5l8=
X-Authority-Analysis: v=2.4 cv=ReAFmFtv c=1 sm=1 tr=0 ts=6ad9dcc2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=q2l7TY2mCMnZi5pTjLMA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: NvvaHsRDz31mOSM17td2eOCEtDCwkdxL
X-Proofpoint-ORIG-GUID: NvvaHsRDz31mOSM17td2eOCEtDCwkdxL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfXw+yW8ZTazZSu
 3ZYpejeOCB+3yeGetumjlSLW9YR+EYjOcKKokUYlKJR4GD2irWIZcByM4CI4u7uLMCvmrqmYA2U
 BXkGvc2kyVgpdOtJ7y0Pl29XTqmnV7RSA+JPpEe6oxT8YRRQYcuLer0kK8O0XsbfjXc78J33AqB
 8DS+sHzzNBD92lEZBHLYTndZMSbnOqwoCASsGHDMEYo8GQdSSuAkVUgkqAsv7NIwMWXs2TtT1jl
 fciXXygUiEUbf1h3RuAVZoutEvO4lwN1uSvOcm6VNt5vcGzbMODLjLjRrONrvLYMZolFfHYTPdx
 2x2GsFFLI3L0Mt/YnbiousaBhVgWgkN4877Xjf0WYZbCfuaTiqo84b2cB7nFaAIu2tswUC7pkTP
 veyU0GKyyDPCViemNtJM9+1LlmpPzx3VOyd6/cQf8J6PrIeQ6zTLskDtXe5ip2XArERh6bDzxKp
 0V7ZAu4Ws6qMGvyy/Dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220039

This series fixes ICE clock lifetime handling when ICE is modeled as a
standalone device and referenced by storage controllers through
qcom,ice.

Currently, ICE driver enables clocks during probe and keeps them
prepared after probe completes. This keeps the ICE clock voted even when
the storage controller is idle. Add runtime PM support to the ICE driver
so the standalone ICE device can enable clocks for probe-time register
access, then disable them and remain suspended while idle.

While enabling runtime PM in ice exposed couple of sequence bugs in
storage drivers(ufs and sdhci-msm) as any key programming call used to
go ice and never complaint as ice-clocks were always on.
Example, unclocked register access happened from ufs/mmc in
qcom_ice_program_key().

qcom_ice_writel(ice, 0x0, QCOM_ICE_REG_CRYPTOCFG(slot));

Fixing this issue require ice instance at early ufs/emmc probe so that
correct sequence is established and ice is ready to accept key program
calls from blk-crypto or any explicit storage operation.

Merge strategy:
Patch 1/3 and 2/3 are storage driver fixes and should be available
before patch 3/3 lands otherwise will result in bootup crash.

Validation:
Tested on shikra-evk, kodiak rb3-gen2 and sm8750-mtp.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
Kuldeep Singh (3):
      mmc: sdhci-msm: Enable ICE before enabling crypto support
      ufs: ufs-qcom: Enable ICE before enabling crypto support
      soc: qcom: ice: Add runtime PM support

 drivers/mmc/host/sdhci-msm.c |  21 ++-----
 drivers/soc/qcom/ice.c       | 139 ++++++++++++++++++++++++++++++++++++-------
 drivers/ufs/host/ufs-qcom.c  |  29 ++++++---
 3 files changed, 142 insertions(+), 47 deletions(-)
---
base-commit: 9a482184d910775cf648863148944945b74e2815
change-id: 20261022-qcom_ice_pm_enable-3c5d21b99e42

Best regards,
--  
Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

