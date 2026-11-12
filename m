Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489520;
	b=eup84Mz7dXW20LSjiieoLiZxY6FH7VwWmvlfX7OVQH6WTki7IpNssICCw7a70dijzK6/
	 i/ilByFPb6mlfyi4FFo80aoRgu53RIi3UPNXLlzuz8cOIWlGOqfhnH3mt532D51FkcYy3
	 3dS4U/ui6PrrUiXfE4d7hTsVZinCfm3DbUgco77WDzr3zWahAEY/1yDEmpwUZ0yX3G0Jn
	 ZRgE16LIKPWqe4+ReLM6HjLO8Acrykw3ZEZfklzGtLCdj4cES00kkKAPdGClvUmqj0icV
	 0Mcy/6BYuCJ1/8kSzsUbtrJ/74hpMwl2JUvX8tyIakYyuc8LUL06fZ86GXuX/tnZ3FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489520;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0reVTygQYZvGgH/DtOXkcK6EGhSpuDmU2CumM9pari8=;
	b=GVjV5slpbDsOSV5dQ/ZIrYorwfn6HoHgqYrGAVe97PB/Yj/U4xcFlbnJDs7QkMrI0iYc
	 JoWcMMI1Gsm/UyLRs9jBU3Itd2koM6HBoHOGUw6z6r6QpKoPL3FDrPTNGxaVjHLQxqImV
	 IKCZcrblpmVrmO/tLUH3XtrIw+pqaub9s4GUJNjaN+fydISMJIiiTVxx6VHq4wNOyBUBQ
	 8ziOql1+x9cwiMgKWtf/AwjJGRXQJBCl9vJ0HFbXtdjy/i7LLDSQYteiswjXcDMnmTilX
	 Ckh8xwLdXwuZZTYRNbPE/umOiMJgCmc36VoFnALic4JwX6uGMgrFvHXauvqs1CDYFCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k6oaWtMF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z4kQJXkk;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B5C606A323
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 13:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9B5C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k6oaWtMF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z4kQJXkk
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACAUdEo1629246
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 13:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0reVTygQYZvGgH/DtOXkcK
	6EGhSpuDmU2CumM9pari8=; b=k6oaWtMFbt7v7dpBKEPbHRgaguk/AXr79CCMIA
	pYowYhoiV7TQWcgNfvL9ZHp8lSojuQngdWRd5eZNNoCI52UWL5E/YHIsGxXslnm+
	0HCsAVXhIUyPrxvx4ey3y+S0nn5xd8F5qSMZszNFrCcYnhp/KbqsJ7dFKzkrc7Xz
	DrP7GA1rbekvL0WDG1t8e06WYdLsY8kTV48XF2x06rNB27drGlvJsz2zyX9JkvvJ
	xlhS4svxPKicXfAJ/3sW8UQKjl674+sPOW+urnTgt90R7ZPFPXkTfKm1TWCOiWG6
	80hGQMiAeO9wbMuYosH28vf4tmaQafsQwgUjxinUNUr7ySRg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs00hqy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 13:18:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36ecd5db581so1179892eec.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 05:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794489518; x=1795094318; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0reVTygQYZvGgH/DtOXkcK6EGhSpuDmU2CumM9pari8=;
        b=Z4kQJXkkuBYcYZ7tSzY6NfHQhbPL/HYDW075fvGpkibLkkkdo3+HG+l2T33fhATo/a
         yK8E82veWF9s4CygE+pXYrRHDK4m2QV2Ul5yB9Wrs9OAKmnKcLdjuDdWtV8YK52u1LZT
         VLRrvDl6KuE0ID+oMlvl06ODtwu0Z1qKwKtz50I1KAIVAa9WXn2uuh5/ZH94uKGBeeQj
         umQkMFPkylZwyGbDI4/AOaSVOy8tudVrsRlzt2ibSduWLEWXp/NxZPm3294eRQSxzZF5
         DBMh3bffPWHZiDrqVmgqjNpRe+OXTYJ2BCeJuznJIkM6Uxk0LqcRjS0ECXPVVsmftUb+
         O5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489518; x=1795094318;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0reVTygQYZvGgH/DtOXkcK6EGhSpuDmU2CumM9pari8=;
        b=LZRei9wcw4YsPLanuGQBr0jHm8T4s0iGOQyubO9mR+JTiaVPg0jVedCLLlc0GFPgE7
         EuDdsauIriaDS0U2M76hqj31waCzG9ACgKpEd0o6TL5oy9c9ghjqwq184oWroZj1zXZy
         eU/7NH7SGlyuOF4wG5IBdz53jQhrWiM1WXFB1MB1wC5elYkavIXVussYJbBtlgbGKyO1
         pmS/4kG3hQEGEQul9jXomJEWy8x2vospPmGGE+1P2v+tok9BDxsiDj6SnaAT8SyxAQ52
         1Ru2W9QfkSHbe/ygd8ccll0ieL3gy0pcRDfvYwzaGiJ+dj+FJG9KxW/5ibXsIwVRGLCo
         TfWQ==
X-Forwarded-Encrypted: i=1; AL+hErEal4WLbFqXJ0VgM3ozNdiIYqweWsXuyQbCKM58pvYJSdlyKXMryogbBnF70igdoQHf6casM1uD+UA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Bhs3pK1gxSSAosuJQ/dunnVI8Fkswr7cF37D+dZ4Q12VZJW3g
	5DjVt5QThMCxN+TBKbp2vd05RyxxDxOHGc1YTCaZYKF+N9TPg70LTTTrPo8kvRVfX/OEZQasl51
	K5/D1o3l9UGBXr8Y5nUUWn83BfCugmKW4IDA48s0YPPHbNFTbxPPohRcEJ043YzM=
X-Gm-Gg: AYBFou0Pa4pjFeptTa/pGlJzP5agSRWZypPFE7K1Q5Swbrhbt8ARRWJ3O6qPOuHujqO
	YxVo/jCmbKo4N7g/NLo9NhwTW0n+7oy0R/FliMnaAt2cywylDulreB7ka3MOvrrnvhnus8RU1Ls
	fhLC7Vqp91jLQFsEy5msUYGKsEa/qyrNDWgao3kxDUvb1t/3ZXSvRUEQb9hddWEOqbeR7h/ue6u
	Cws5mMEbCUg0e2BVlG53xhYI1YqPwYKB57ztQQ72WBViZ/bBnxNNOYJNyLteZI9qAG69yNHeLRf
	H+EahgyWLTNPxrY2chxmMG40urb23lfgiN12EvjHYoY0R2W01zxz7diT1xb1M7I7tVrO/ifKRDQ
	yM+/vZjuvxYfi+Vjgp5eu8OmOTecjpCYQNGHXszU03cyCe7JwHVSNzExxRPOnC76YOmrG/swIgd
	FkyZz0d2o=
X-Received: by 2002:a05:701b:2906:b0:143:271a:3df2 with SMTP id a92af1059eb24-1b3c0361cc2mr4490670c88.44.1794489517449;
        Thu, 12 Nov 2026 05:18:37 -0800 (PST)
X-Received: by 2002:a05:701b:2906:b0:143:271a:3df2 with SMTP id a92af1059eb24-1b3c0361cc2mr4490638c88.44.1794489516809;
        Thu, 12 Nov 2026 05:18:36 -0800 (PST)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e7d24sm43798356eec.22.2026.11.12.05.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:18:36 -0800 (PST)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Fix MMC/UFS sequence for ICE calls
Date: Thu, 12 Nov 2026 18:48:16 +0530
Message-Id: <20261112-qcom_ice_pm_enable-v2-0-177e454d6f22@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAJi89WoC/32NQQqDMBREryJ/3Ujyq1Zd9R5FJMZvTVGjiUqLe
 PdGu+9m4MGbmQ0cWU0O8mADS6t22gwe8BKAauXwJKZrz4AcE8ER2aRMX2pF5diXNMiqI3ZVcY2
 iyjKKEHxxtNTo9zn6KH7slupFaj6WDqPVbjb2c76u4vD+HqyCcdbcZBrxNFFJLO7GuXBaZOfdP
 vQBxb7vX8i1aCDNAAAA
X-Change-ID: 20261022-qcom_ice_pm_enable-3c5d21b99e42
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfX/oxpj8qWbQ8P
 r7nlIsSkKpZcNf+g7AlAwJilbgFqXYe3JaA8hECYzf5bVFp+ez7j2gpRmpWmNAaGCH83Bj22bH/
 etI9UHloVghsaIibk89oOs4wzu97C3cnizGZw5YSfKcx7aGknMKrp9h8QZPp5yc+hkYjpCphDo+
 /mcuomigILoNzo0Kj46DuO7kUJ/6sKftIRnY4dWpD+QA/yL9xbFi4Gs1TJykGzdwmzrAd1DB2BU
 vsceKD/oDmjUgHZDeC5XmD1pEY1k/r+NIqqv43Kv3SEO7fBiWmIkDpqMHzMcFmMosReFadVn51o
 qZjBouUVZqJsI2gIcBc4Hq7pdg4fq6sxZsQzCg0NGh0/WosKK8CIzsgVMZOB6jMqMtFiiQl1Tyg
 7bk73Uxw3pfSweU0OAX7D4o1VmxBJWcHOaDrqPHW/nUv1ScUzYiFDFIq+A7hMi8zMYJAep8gCH+
 aS1JIBEzBLeRBQJwaSA==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af5bcae cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=bLk-5xynAAAA:8 a=1XWaLZrsAAAA:8 a=k6_AVi2K15u0NLJkO0wA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=FO4_E8m0qiDe52t0p3_H:22 a=zSyb8xVVt2t83sZkrLMb:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfXzqcEWvsi5Jjw
 Oh8N3qmHkLR0TAbvShq+3jBlnsnb7RtNw3hgaBTM654Wmg9Wgs5A39N4gsDmqsSor9N9Z8pwoUP
 JeZCqMiwatXADhppxjl5/CL9SSnc8Lo=
X-Proofpoint-GUID: DuslYgs38kFCV30YR3EMwsmgiYuu6nH2
X-Proofpoint-ORIG-GUID: DuslYgs38kFCV30YR3EMwsmgiYuu6nH2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120052

This series fixes ICE initialization sequence where ICE is modeled as a
standalone device and referenced by storage controllers through
qcom,ice.

Currently, ICE driver enables clocks during probe and keeps them
prepared after probe completes. This keeps the ICE clock voted and
hence, any key programming call from blk-crypto succeed even when
storage driver don't have valid ice instance.

This exposes serious bug in sequencing but it works as of now because
ice clocks are voted. Storage controller should not rely on ice clock
state and rather ensure valid ice handle is available before any crypto
call is triggered.

Fixing this issue require ice instance at early ufs/emmc probe so that
correct sequence is established and ice is ready to accept key program
calls from blk-crypto or any explicit storage operation.

Validation:
Tested on shikra-evk, kodiak rb3-gen2 and sm8750-mtp.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
Changes in v2:
- Drop patch 3/3 and post separately once 1/2 and 2/2 are merged.
- Tag stable kernel for storage fixes.
- Link to v1: https://patch.msgid.link/20261022-qcom_ice_pm_enable-v1-0-f7a84086c651@oss.qualcomm.com

To: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulfh@kernel.org>
To: Abel Vesa <abelvesa@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
To: "Martin K. Petersen" <mkp@kernel.org>
To: Eric Biggers <ebiggers@google.com>
Cc: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org

---
Kuldeep Singh (2):
      mmc: sdhci-msm: Enable ICE before enabling crypto support
      ufs: ufs-qcom: Enable ICE before enabling crypto support

 drivers/mmc/host/sdhci-msm.c | 21 ++++++---------------
 drivers/ufs/host/ufs-qcom.c  | 29 ++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 24 deletions(-)
---
base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
change-id: 20261022-qcom_ice_pm_enable-3c5d21b99e42

Best regards,
--  
Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

