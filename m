Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112065;
	b=3QbuxE1cAvkqJ01wKs1APadppbxNKggVwAdo0CSihiC5ndolgMrxiFIZ50s246d1GqqE
	 Z7M9JPzNKB6FbER7yjzhkDPHUEPsUheTbMDoiZuQu2M0LHz/pvCM2u/zfANdAJjYC1W4c
	 wNghRIQFk66046jF1RXlooDiXkOV9MeSNs/iFBKgB04Ubc7ENFcDKZpBBx4HuozEO1L5V
	 fwotnX05IBrO0aorYtk4WcPW21am9i/i8RUQgV5r/7Ef0j86uLy2p6idyBru6fyv8MGeX
	 Ppa5hQrJvYeKfNJjF9FRYifdKCW13U4sCjHfsd94NDBI6QyMn95xvwW36feZkAE5pmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112065;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=bYUBF2rOkLD/SmrVZb+dI12qHDch2kaBBxDj22+nT84=;
	b=wrNisFB8tDEJ7xfNCnfDHbBPH+pUwDZkI5qMhRD+0/qhTYS7vp82eyOAygQPHzt+HsY0
	 QqPybaauURGdx906IosbbfwWvy6Stjl3J2F8pe6WvCjiKHiUwKqUF8ptz7JaaVnHTFHXm
	 bfClPecypV9ZJNU2pHiZRJBfkt9RAj2Z5wer5SwOm1VqIbpP4Zbyv/oF0ffNquTTJjdGM
	 VlqS7Z7l2SbDdlYJ1igTlPI3GYcPz85ZpGeS+eTAE4V9DZoUfJ6XNtTcDzo8t6liiTwA2
	 zyQ2M3tq4LK6EHxhF7zz8SrphmCELp+RikslRlTozL+5n2muSwgta6q+OhYoQesrnBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="aIVIu/zx";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Dd6eZb3G;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75643606A330
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75643606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aIVIu/zx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Dd6eZb3G
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDo6WC3435136
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=bYUBF2rOkLD/SmrVZb+dI12qHDch2kaBBxD
	j22+nT84=; b=aIVIu/zx1n46yLnQI2S2T76jqppwr7K0wZOSd5S89ky1nPePZ0D
	FflfNHGESnL9xtcty23esbzf+yCruWVF8037+MMOMvPf3N4TH1LQQrn49PEFn2HG
	v+c1odHzXHkI5D9UsdUuTsjSBEj34sdLdTBrIlq8dRCz+vuE4LHI0a9Fe8EgnE1W
	eJUsYWC6uc8aYO1VVUkOsEutjfMd35YbCM5OjNqvCK2iV/dzA1FTu17HmE4bzukg
	Ixz6lWI/evgxvtnSelOozcMl2IBUpLBFgEFxx87nilzLLU2FL1aXYkdsPJr4dHm2
	/bFAWHjKNzRk36olczmKqj6YVg2+LZYvMjg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hje3dbjta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:41:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb7f9bb86so839584485a.2
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793112063; x=1793716863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bYUBF2rOkLD/SmrVZb+dI12qHDch2kaBBxDj22+nT84=;
        b=Dd6eZb3GbXpiQk0O/PLUk26LMYWcO3i/COI1p4/0It95FD35yxEAk6aFCV0mqCctPV
         kSEFvArGap9wmBRrtwh0wiqMSUb52UjmtjyuUoZBL7I5gPOeJXFjz/1Yl/x6D0DSfml2
         DOzhgNg3FnCHE/2ijK4x45FJ0teb2KPqP/Wtw88SudvyXQfFAx2Sw3Oo7JyhYaLkGYL6
         T6QjFMWfrhSlwwh85QSaPoOH4yQ2ShOr6QHvbcwfyGZYQebjhIscQt8APSJLnr5VAxhU
         gEP3NT4QK/XmQ5lit/U7nWUiP0Jmu1Cgy9K2zaANzvqvFmUJ/dfphrRo7SKhybZRfXpe
         Z+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112063; x=1793716863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bYUBF2rOkLD/SmrVZb+dI12qHDch2kaBBxDj22+nT84=;
        b=hzz8tF+2V8VSMket96N2NHGjtEgXJDwL1LYUZmZWS/thUez930RMWShNUVERUIra+K
         2NQGyeuy687bgJyW+BaUBfyB7co3HQjfYXT7fxry5R2AIIzy+6tmvKu7uMqo5QG7D8mC
         DgVVil59uYfZbvZoha7WxzYkVMzfsFt6DCJNk9N9DvrkpdHJlG/WdBFGc7gjRdQS+/N7
         pQS5dMSb3dc2e2QUEUPE/dVs8awmu8NCLYz68ZNM3l9bUAptGWwWbuN0keaqtf5pyK2O
         Z4apwXKzSegmFz3GsQ/p65MD1eqNmqmve9ZgK6qEyvhLXBbIC+x5Ua0QJLSOUlbdWNx3
         lklA==
X-Gm-Message-State: AFq9FYLx6AWejkN0Ww4WzgIcgRkLmxkX8YzeK34oDoh1nXh4Of2LqIjh
	4MnpH8vmsZYu3l9S1H6n+XOV2xEbXkQPhFMZLQ5YdCX6hlvtIou8X6RrtFa4iLZ2n3ultdZDeTv
	tfDDvNL1Ciud0kR7o5Osdea3HtOttVAFmiYiEGAB6K6JuUgu/EKF63zIDNxR5y7zpHebC63Q=
X-Gm-Gg: AYBFou17MATlEh5gRDRDV41dnqG1TRhbRlR4uk5Erd2gtNlLaM1mNxLLc0d4uQwb7M4
	DGs+NPDwlRsWEPUJ7JVVcff2t5LUE5XuE5qpGKZfj7gUVypw4zuK9j1R8OYMblM2vb3TDLBLCrb
	/I7HQNEl1Y+Flxd/++LYLw+obKxJmTWcwS0+vW1eURVaU3qE93GsBJavQrbpEwA3Ug2NWy2n/wA
	FniskHp+RH0HbM10NX33/zeOeyZtyLpQbjwZ0D2WUcfxvM7abtTn6Du0r80uUJPr8yx/D36Dneg
	eGsbNTsFTiWb7iQECY79LQ51P3IAl0/Brx2x78UKvh9N1IP5lCVeTCWIkn37BAqwJHcbEZaOMXX
	QRIhdH4u/QLQ2W1Xdqo6XXbJ8STnGl8/6/p2yNFohsFKBbiM6YVdFsXUafQ==
X-Received: by 2002:a05:620a:2b46:b0:93e:90e0:d2f2 with SMTP id af79cd13be357-940ef9402b0mr1493372585a.41.1793112063301;
        Tue, 27 Oct 2026 07:41:03 -0700 (PDT)
X-Received: by 2002:a05:620a:2b46:b0:93e:90e0:d2f2 with SMTP id af79cd13be357-940ef9402b0mr1493367785a.41.1793112062760;
        Tue, 27 Oct 2026 07:41:02 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66bd3asm468527766b.56.2026.10.27.07.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:41:01 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/6] mmc: core: Keep the card powered across suspend when firmware needs it live
Date: Tue, 27 Oct 2026 15:40:38 +0100
Message-ID: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX+B2GQgXSvZZs
 i80EZlAYtXfTzG27gch6vIZNdhB8x4tVGxAhEbf0sQ2SCT68CxKVGvSStgOa3w2z1WdQLcnEcwD
 WnXCRbQHZpuQQBjsk7R5Jr+JSEkU6nc=
X-Proofpoint-GUID: dxukVMxpbzagC1GcyFXGZo0uHg2JHmWs
X-Proofpoint-ORIG-GUID: dxukVMxpbzagC1GcyFXGZo0uHg2JHmWs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX3lvF5UYjmPJz
 4iHlge+IQbB2KwYAZTLy35pjqhXNZvQKccfNrMZehow7/Abw1K8u7OebTZE+TRDD/+zE80wEIPm
 Yn2Qatg36yO9YqPrgcJZt7ZE00qhq2QMAsdAeoFWKt0o5+gI/YxsZLyE5PWa/1lGiEe6zIzHeMV
 IYaygM2FKPHLYkLKyxU6cz8wHqdWDKKGFl8DaXPoRWIBnAlelpL5Hw2enwOwQItqsQWkz8Y7X8j
 KrH4kyZDiBup1W51TWlaE5mUEsTMtrEgHBltOGoPpQ+x8PWl3qtfCuyRFPtweezSztcJzooqlqW
 zat2REhN9bDT7UcJ7gvAY7WWOLEAEwv/jHDwjmFgyDqhwuHOi7I8IuwzYFMCsZ2SBnbl+mzzuNN
 a+ZFzRd+7k4CujrYKTcOy4u7Vz5O7nMsguIIVImTc+lY2mKl5impV1JDB8n39Bdnkb7DKbjQix6
 zg3jr5d08QIQo4QNkUQ==
X-Authority-Analysis: v=2.4 cv=SN/Xx+vH c=1 sm=1 tr=0 ts=6ae0b800 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=Hdwp21HFdB9ZbaJ7OW0A:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270058

Background: on brcmstb boards with a Kioxia 016G01 eMMC, firmware accesses the
card directly during resume from Suspend-to-DRAM, before the kernel's own
resume path runs, in order to load boot code using hard wired logic that is not
field updatable. The card needs to stay powered and responsive for that access
to succeed, and since it is never power-cycled, it also needs to be reset
before the kernel reuses it after resume.

Changes in v10:
	- To help out with the implementation I offered my help to try to move
	this forward.
	- The DT patches are good to go so I included them from the previous
	versions.
	- Patch 3 to 6 are new, but based on the work done by Kamal Dasu.
	- This is completely untested from my side, please help to test it.

Kind regards
Ulf Hansson


Kamal Dasu (2):
  dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
  dt-bindings: mmc: Add reset-card-at-resume property

Ulf Hansson (4):
  mmc: core: Add option to keep an eMMC powered on at system suspend
  mmc: core: Split sdio_set_host_pm_flags()
  mmc: core: Move reset functions for eMMC
  mmc: core: Add support for resetting an eMMC at system resume

 .../bindings/mmc/mmc-controller-common.yaml   | 10 +-
 drivers/mmc/core/core.c                       |  9 ++
 drivers/mmc/core/core.h                       |  1 +
 drivers/mmc/core/host.c                       | 10 ++
 drivers/mmc/core/mmc.c                        | 95 ++++++++++++-------
 drivers/mmc/core/sdio_io.c                    |  7 +-
 include/linux/mmc/host.h                      |  1 +
 7 files changed, 92 insertions(+), 41 deletions(-)

-- 
2.43.0

