Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC73BD649
	for <linux-mmc@vger.kernel.org>; Wed, 26 Aug 2026 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737948; cv=none; b=PwBCvbcjmW8NbJMlJ1vKgjREDaejD7YR4eQv8Y/D81z6lgCsvzD3fBWU0bvinwDZSgV2h0pSDTUUewk/Z9kLCw2GXQ358av5MnQjQmjI7nO8o9OfvcIe4DonWAH9IqaN8V8pSr+y23cYykl3E1lWMjmEamWmnW4U83LpLZHKoOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737948; c=relaxed/simple;
	bh=/QBOoKexHSv+6S9TnRfL7zK1e/8WkGNWuw8pdpfWHCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pRkegxMrWEjCg2OUU87z/ciLdSsSqRm7g1h+BnqUQJmux2FiE1z5KaLSv/FD+7bWBaYIGuQWZ2AbQQUsiMKPjXk/jrey936EBI5zxq2MHJXNwXh2rdbDImk+dTuAC7gJgTsUIFnZQdTf7StrSue3Dfff8nFXLbyUSL+CLtEfpYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TVxU6Us7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IUOCBC06; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TVxU6Us7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IUOCBC06"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q9CfVV500922
	for <linux-mmc@vger.kernel.org>; Wed, 26 Aug 2026 09:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=QQ/waY63tEphnRBtMLXJZh4HjD9raH3agUr
	MAEQION4=; b=TVxU6Us7NvoHcLct0Ciacik6N5LFLfI8mJ3jjIw8k4U1i8VXP/H
	WIx/ki8rCneyfQHeKd7A+8U6ubsN6QkAGS1x+fetBs/6fJ6pUhX4VflnXsrttwRE
	vZw8YLRijkS43XJPOa3hIS/xyh2q9nY1rcVJ/g6U4W6rqlBSmYKOYrs8IZJuaA0T
	lE040M+KviPAy1tC+TyRZYzvNocHF/gJcmKWP19ZH6ZFt71bKTkPUCrL0gHSabrQ
	lN+JYVcdEhsbkVE/59XMsqZJprUStEATVh/byhaiwZkGRwd10xc0Onz/GVzG1gCx
	zURkzgOu5Yw9xrWfyrhGvFKW5ynwEknx/sA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9g4mu2eu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 26 Aug 2026 09:52:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-381250979d5so1185396a91.0
        for <linux-mmc@vger.kernel.org>; Wed, 26 Aug 2026 02:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787737945; x=1788342745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QQ/waY63tEphnRBtMLXJZh4HjD9raH3agUrMAEQION4=;
        b=IUOCBC06OimnCHY+bb0dWH1uAhfqlGxCposbqI7wl4yJa+VKV5Nehji5Q0XhowpKRa
         ozBwQZNkZNVHK2d1zmyZsi/xV1jfki9D8HFWdhxRY9TdSGEC4nk3OXBIK+0ngFdk1GX5
         IAp1Ryab/ftZjykvCIvyqZjH4bBddWQaTc4XSHGEuJXb6qyPluhsJA+slbPAvT8kdX5b
         oQn9SkfY9PvQ52DLMMgTE+TuvE+tQfmWMyuhHVlF4qquHTGGvYmY2Re5aMGghR5775qX
         Hvz8j9K+obtP/OGtfIu1UrTDnRN/0O4rtKid3QKKW8Xe02S84DqWbzamqX67Wr1ojgL4
         EikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787737945; x=1788342745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QQ/waY63tEphnRBtMLXJZh4HjD9raH3agUrMAEQION4=;
        b=PD3IAIKYyEgBWo69k2qoU6+Xfqcj8Wqn2wIZG/V5miZl4m/IItOSn69De/HNdhiPgH
         Q4kN1PzDywQBxm3odUXXGD8IxXBNQYkEQ2f0ROQ0GXKXzePAl9BoFyjkiGFOlwtAM2gy
         rM0YrWbSjkkpRcHVuVgEzv0BUtXYn1NSmaZtukoFxLi9ELug+87bWd9I6WEsQKSRsg2+
         tDMJOCIjnXmSVHmkGWnDrHwyHygO7xsatFappvrgSSXAQkW5N4VLPIX04icotGS7wZGx
         Ww6amPmViQ7PqnOGViWKW+aDnvh6+og8GLiotveimTHuYj02AZ0Bn2eauhwvc94Ut7yS
         pnXg==
X-Forwarded-Encrypted: i=1; AHgh+RrA1eoG9gAUjDAhkXwbItgnV12WyXg5dCgOtG+v9Gs1k4dp61Hb4flEyLE8fyE5U+GRVWeynDGgt7w=@vger.kernel.org
X-Gm-Message-State: AFuF++lweKj3jKXsdo3A50Wlc6Z7PbvqeVndqR0aVX+n1eQPKJ7te2ZB
	XJHQbYvol4aBuEMPP9mfEns1QyL0WeAfY7HaBFze00cciceJFayn85KMO3I6/OY1rfQPuj8JClu
	zRg6IUJBEvCarqDrGIi4pXMhzSKP48L3aDjgjwbBgRrTZwNGvU6wbBWvODDqpi18=
X-Gm-Gg: AR+sD10lN0KbBOsbKqaeq2Wm2wQujSf0kZil2shfW6bKRqdcZ+22dd0SQkNUy/18hNs
	kE3qbO2auc2tkXqXWvPVUEzkABCGOvztD86YOJoO+/2i77JyfH9qGrIcD5tMdbt8HEjndiosAyM
	Vh4NdElMCmSFqWj5IYC6OF0Vw7lD8xcgU3zk5buUPUBHUIg+XrnINXesVFck1nVjl77cgTok748
	QjW7DNwsJG+joQNT/GTXaQ9U4oNM/Scs3y8w6wdY7Z32Pytp6FhILLi3PUiuiGRkjQleLT5tOL3
	J3wRLcySBOt9h6v5aesR24TNHfGh6o7TrebCVfKl8DapvD5jU79ccAVCU7siP2mvF/lSfdWPJga
	LWtZx4rM6J4hk3287+dlH/445nege1GQ=
X-Received: by 2002:a17:90a:d2c6:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-3966d3dafb9mr12538722a91.11.1787737945071;
        Wed, 26 Aug 2026 02:52:25 -0700 (PDT)
X-Received: by 2002:a17:90a:d2c6:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-3966d3dafb9mr12538627a91.11.1787737944494;
        Wed, 26 Aug 2026 02:52:24 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eefd98sm12587158c88.3.2026.08.26.02.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 02:52:23 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ebiggers@kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
        quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v8 0/2] mmc: Avoid reprogram all keys to Inline Crypto Engine for MMC runtime suspend resume
Date: Wed, 26 Aug 2026 15:22:15 +0530
Message-Id: <20260826095217.2885229-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA4MSBTYWx0ZWRfX3AT++gVhnE1N
 pJCGQJpD1NnuimfMrK+sVskAiEnM5pwXQUHdwfGS3ImuDkDoU5qM3fHQfHXh/iQ/aUfDBQqliqk
 hVSnTBmqlKoQJjOSgCTYbsthoYFb9RI=
X-Proofpoint-ORIG-GUID: U2AJkpA8WwoUt5e_hv10DpEebudn3cun
X-Authority-Analysis: v=2.4 cv=eYgNubEH c=1 sm=1 tr=0 ts=6a8eb75a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=bHz8KAZ3X1NNnLgrXMwA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA4MSBTYWx0ZWRfX52bz6sIWCs0R
 3BcUfjwsIH+DfgfjRUTgDmZheAwcNsDE8oViljMkWv0PbXiPGaoCKXsBbfM4paXn+UN5x4G1KNj
 ZkVIti0nM3wPor/1ChDTNVOSsbzFyXC+Pdlez2nIAN59m7o7Xg6aqf2hbKvM1cBQh61GZ7EUlLq
 8Wb7TykogY8SF6OgqGOoTO65dEQzuY+O78duiqAwlplqBd63iIz+TMh84y32goKWP+DcsvGycQE
 kmR+/KH6RLkBQqehnenX6uOHOqdUAQBBhJ82c/+J+aN3YysaAL5gIkBNvK7L7mYM7EHDl2EVp6g
 MNzH032Ori5CW5w8GvxJOFMUbpCoEkgku08ejM0on0EkAkXgWHLauNoV2WGPVnnvLro6YZN2uV6
 1+T0bkPXjPb1f34KKvQ403gEiC2sDH2cU6GsAarexEcQm9sHIQ54jPa2waPtBuK5jbsmlLKOGmO
 H4SeC5o0aXV+V3MqWLQ==
X-Proofpoint-GUID: U2AJkpA8WwoUt5e_hv10DpEebudn3cun
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260081

Crypto reprogram all keys is called for each MMC runtime suspend/resume in
current upstream design. If this is implemented as a non-interruptible
call to TEE for security, the cpu core is blocked for execution while this
call executes although the crypto engine already has the keys.
For example, glitches in audio/video streaming applications have been
observed due to this.

Fix this by allowing host driver to control when to re-program the
crypto keys.

---
Changes in v8:
- Update the commit message for [PATCH 2/2] to clarify the expected key
reprogramming behavior following hibernation image creation failures,
suspend-to-RAM transitions and CQE recovery events.

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

