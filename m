Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D7331ED2
	for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461491; cv=none; b=Gd73UCx90OpsEdComt+QaLEUPDq9ve9fBBFHIlYf/A31/JSTH0Z+Jc0RlLE2ii8+yVzO1c5jK43ipxlZUQp88jkJlX48LExcdYrJ1YSz/xCi8TbxJ2rX3HRgA5BOOJWs96iPVfGDvZ5aqirn7ToCWHPlYO0cdEhHtNC+2JL2PgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461491; c=relaxed/simple;
	bh=Ivk9bdwrFWBJsQRPKaDdg6RQlD4bvDEo7EJ3b/WNZmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IMOQuKtc/j1qob33QjqSD7nTab/FDfQSEcjs99R1upH24W+T9lOj4Lbz6d0EMgJVz7Q+IK3oWtu2fi/jN+JY46uhzzzJNaOe+NJClYaQutWVcG/8dZDtRPDQj6TQaZSl8hYRPXMdfn5eIRYkzlmFr4+1bXFF4VYP9CF74votHOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FES9do1p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jwtQbEqA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FES9do1p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jwtQbEqA"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWtOR462116
	for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 15:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=25RqujybugoxWGv026BC8PH5+oKR5AsbHGH
	j5r1dQWU=; b=FES9do1pRzwYL+2gsCOZYfjWi0eg6GXvRjptrt/Rv0PjO99UWxg
	MMFtlERRv4do2rSJH+cxv4OPH33Atlm0KOzyiD7ca3VvtLOIYgN8wOlO4T3uwX7z
	v2QH23eRLJwMbbDwRHVrjSrigESdq+9Arf4AluphbveBLWzZbYC+fg6jqDEgD9Y6
	7rREoMHrxb6i9HoNlkfVt/ecBT5s7PPLkeUedYT8CAX/ORCGgp8SO0beWiI91GGM
	DgoaROPhJ9u/mYKWF40x1XcVpEDjwKkSpIXQftHkzfcFu9rN/nv80XvxIwZzf/ll
	kZR7UesW8qAuL1rcfKD1uYYYNs1Cuf7PbuA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049mgm1p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 15:18:09 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84885a4fcabso3361963b3a.3
        for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786461488; x=1787066288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=25RqujybugoxWGv026BC8PH5+oKR5AsbHGHj5r1dQWU=;
        b=jwtQbEqAzU9HYlZgCnocFnL95ociobL40kOr7njd7P7hrmbsvNw7Cs+4Rkqtc5ep+d
         LzKQILK7CvVyXEiHXzX21zt+OkkJkUJVClHtgG+mF77pCjlg/xUgBWeQ8VdrDAFe8uHO
         TYIqjq8x59NoscfIsAjzzJRCaV/34zB4gJckdtanvgs8gGdq7HBLkU7t0TWTdqmjB3Qy
         0UdXTqXnaxHYyK3ASG85NQ3I1fGnyssShBfTycFJCcRUWZVj6g0aB7xTooAGP0+ljQOg
         t5vgU+QyegSF1kGs03FRXPaNjpV5DxJ4N27nxiTzhR5x5tG6jQyu5Kdx72JODvQxTJam
         Gd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786461488; x=1787066288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=25RqujybugoxWGv026BC8PH5+oKR5AsbHGHj5r1dQWU=;
        b=PykQwWWI089aVd6jiKxawmjcbytyQnN3O0bS+xaNCMkbpD25j9SxZ75uTNptlCwvkF
         W/axv9zpPqYY8gxEhCPPnsTh7+OwsXzr0AgizdH57Y9nq9jLpe4wiYF3EukqJGU6lt33
         gCi3NMtVXK+8FozsXaRMNi+XLWqICD7ku64ly6GXsoiP5Wnq0B1He7v5R1zrzEVW3JSx
         Il0PeG92sjVQtfnwUw3xudyaOXObZg2xZgw4rMrrtj5SGCfyB5la8Lp+XqdIE04iWxXV
         e674J/f+HoIS+1HARM1BrW12uKHXYMdG2l6V6NJ/xfq/v/fkLD1XbH56zqzJqrhJhRKN
         X2jQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqi/b4K1RP2zGcXXmmwOc9UG+3tEBmsEtVqAUZWxgCVVDmZsM+D2Q9KQPVdnwJRDs1zXj3ADpDchnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2dCBhOJH6SZ2RoNHIRRpPfRJYfa+wOosQJeX9GZ0WLwYC6pBg
	ee0HabQeeqSoByWJMjzvJIXtP2pRJha2ZaycKS3R5ilPvoMDhOlqNrfoBfWKkgNMK4IGyQCY73D
	8XcO9nSF6oTFno6wWQ2M7691K7PiQMHxjH8AyZYKt3l1Y42IsXQEU/TbxZzGuDeI=
X-Gm-Gg: AR+sD13L1q6BQOBxMJu4BraxVF9KLR3IXx2wlGh/uZdCCxXeGOAT63rRgRSA2bzm0xP
	JfOmrULe+wD4TYQJ23/f+pp9AZ0G5C1+TuyeiE/hSSFmCZgy8UVnvyCXqXE6tM0XEpyo3j3jynr
	YN+GIElYn/UZDqxV1GDtUhQjHVp7bbx5WLhh00JRVle/cNRZKSe4ITfptI46n5IQLq1k3zCc9WR
	XcarQsTqIqjXL7+jeOBIia1kdrd3LZN4MomVkTzB89+FOxjm8Xuo0C0wGR+UbGKV9sm6lpHkQsX
	NebmoJ8DMYSFr2lqh6+IlX7d8AA9uOJr0iPmQA5dkzr3U1hAkw+6kX+y5U5i1P3IKUO1CQ/CX8b
	QATPvZDvD2yjgZUYNAA/NmS7jeJRlPuM=
X-Received: by 2002:a05:6a00:1709:b0:847:926a:7ae3 with SMTP id d2e1a72fcca58-84fa887542fmr4069036b3a.20.1786461488182;
        Tue, 11 Aug 2026 08:18:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:1709:b0:847:926a:7ae3 with SMTP id d2e1a72fcca58-84fa887542fmr4068969b3a.20.1786461487581;
        Tue, 11 Aug 2026 08:18:07 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa95261b0sm983727b3a.36.2026.08.11.08.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:18:06 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ebiggers@kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
        quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v7 0/2] mmc: Avoid reprogram all keys to Inline Crypto Engine for MMC runtime suspend resume
Date: Tue, 11 Aug 2026 20:47:57 +0530
Message-Id: <20260811151759.1258525-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -fg-efO2srDXBjWo0mtYLNlGor7jI8x7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyOCBTYWx0ZWRfX27RLJDAldCpZ
 z4kc96XTnc8wwYmD2lM32WYLXGYkna4/FgVSwC6bRCgf7bkiSWFdES+PpYbAKNqszCkh+dR1A3Y
 j4i7bW/f1jpTYosp4uTNLakTSoAu7uoQv/JFNDUl4Dysj3T+TmUk9aF3ETlrvbslTiA5FvDyld4
 EusUWeFZUFyqdWFELq8zTuEFHcdbwj3qxFrRsteIZoUMlKv15HSwqOZHlmmyV8TDj9VwG34nBSE
 KxLbBA824vvgyMdydJYUYFuwuZ2L7JDS2oWC1c4N2WzoGGPO2wozawKvdbJwh2w1qXI74vB8S8M
 rp3fDf8Lv5X6ljPpdw3HR7fVcS2leIIqhhnp28oVu+1xd4ZK7OZVyTOd/gpV/QvVZPTY9SRkCQn
 oZYjCCnoxIM8b/azOfQXoRArx2R7PE76zVcN4IkYAHSUOovYWyDHroRRHmvC9jKS5ffgLMIqKUa
 TpTN47vt+YkN9Qdv15g==
X-Proofpoint-ORIG-GUID: -fg-efO2srDXBjWo0mtYLNlGor7jI8x7
X-Authority-Analysis: v=2.4 cv=FbkHAp+6 c=1 sm=1 tr=0 ts=6a7b3d31 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=bHz8KAZ3X1NNnLgrXMwA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyOCBTYWx0ZWRfXxzx219VnAqQw
 p2E2VU+zPC6MWrDu/+ePo+NpiyyJSww1l8Ku2XZPMIG8LyxVzojkUXpJoTOFfj2cQPOyB7bVkqQ
 +IvjsUC6dLz0KXhJU10OojDPRoGm9ys=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110128

Crypto reprogram all keys is called for each MMC runtime suspend/resume in
current upstream design. If this is implemented as a non-interruptible
call to TEE for security, the cpu core is blocked for execution while this
call executes although the crypto engine already has the keys.
For example, glitches in audio/video streaming applications have been
observed due to this.

Fix this by allowing host driver to control when to re-program the
crypto keys.

---
Changes in v7:
- Register pm ops using pm_sleep_ptr() to allow dead code elimination when
!CONFIG_PM_SLEEP.
- Added sdhci_msm_ice_restore() to restore crypto keys.

Changes in v6:
- Dropped the change, introduced in [PATCH v4] https://lore.kernel.org/linux-mmc/20260116121004.1829223-1-neeraj.soni@oss.qualcomm.com/,
which removed encapsulation of MMC_CAP2_CRYPTO with CONFIG_MMC_CRYPTO.
- Dropped the change to re-program crypto keys in sdhci_msm_ice_init().
- Merged [PATCH v5 2/4] https://lore.kernel.org/linux-mmc/20260730140822.1976635-3-neeraj.soni@oss.qualcomm.com/
and [PATCH v5 3/4] https://lore.kernel.org/linux-mmc/20260730140822.1976635-4-neeraj.soni@oss.qualcomm.com/
into [PATCH v6 2/2].
- Dropped the [PATCH v5 4/4] https://lore.kernel.org/linux-mmc/20260730140822.1976635-5-neeraj.soni@oss.qualcomm.com/.
- Link to v5 https://lore.kernel.org/linux-mmc/20260730140822.1976635-1-neeraj.soni@oss.qualcomm.com/.

Changes in v5:
- Split the v4 patch https://lore.kernel.org/linux-mmc/20260529092612.1749752-1-neeraj.soni@oss.qualcomm.com/
as suggested here https://lore.kernel.org/all/CAPx+jO8rUwYV6q1-RrA4aZ9XnomSf82fgf8Jh2fUC0fE03RFPw@mail.gmail.com/
into 2 logical patches [PATCH v5 1/4] and [PATCH v5 2/4].
- Introduced [PATCH v5 3/4] to specifically restore crypto keys during
hibernation exit.
- Introduced [PATCH v5 4/4] to fix crypto capability usage in mtk-sd as
suggested here https://lore.kernel.org/all/20260723230104.GA662946@google.com/.
- Dropped "Acked-by:" tag from v4 due to the split and introduction of
new changes.

Neeraj Soni (1):
  mmc: Allow host driver to control the re-programming of crypto keys

Ram Prakash Gupta (1):
  mmc: sdhci-msm: Use pm ops instead of macro to restore crypto keys

 drivers/mmc/core/crypto.c    |  2 +-
 drivers/mmc/host/sdhci-msm.c | 32 +++++++++++++++++++++++++++++++-
 include/linux/mmc/host.h     |  1 +
 3 files changed, 33 insertions(+), 2 deletions(-)

--
2.34.1

