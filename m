Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514637A82C
	for <linux-mmc@vger.kernel.org>; Mon,  3 Aug 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774695; cv=none; b=qYqIUO9HD/FddUR8pIbJQR0b8eu+AIy/3HSeuqyp9sLoQP34fAK4KtTR0FfxI89ud7dEtHjQd5x6qTaEvpo56sXoCLbGS+Zd2pSLe2DOReUYHDTdEZmpY5YgS6Ys9TNt9puDilwcL4dIIMGkha3n6B9QkwqFEpwzHGEo63RBkkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774695; c=relaxed/simple;
	bh=Xrh9H/8na5FEdQyt2QeFiU8h+ZM9XUWmQwe1k5te3C8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HqPZVRFk9e0K0sMf8T/ITPV838SbaJqffySS97AzDIw3EY5PZzEC1TXotr8dXNilNM+LUr0NINqw7gLTQdGumzryOI1L0FY3iKf4hhoFrXTW50FNU81h32621WRdKGGsscaiW5JJQcZbKocT0gDA2WkM951ijpD3JTMv2s36kao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qs9gu7T4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h3Ym+v3h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qs9gu7T4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h3Ym+v3h"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EBtsZ841869
	for <linux-mmc@vger.kernel.org>; Mon, 3 Aug 2026 16:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=YAvrFt7UxnAdItPH2CXdS0z4Yb63m8btV5Q
	OaILKwHw=; b=Qs9gu7T4KqGSNJUquKEGiP2GEoRSRc7niEv5a35qyf8Zt4EOx8h
	+2rXv7sa4/qsSA1O4EpKDmvj7R9mXWeb6QqPd1eKbxW5al4pZ0d5Ns5ehgZCmmTa
	dXNAAjYi2nMOzgJPlVoIaA+Vh1YkDXnB7MRlIVmYSycNe1tBXVWmZZQZWEw0h5Mi
	nqfITZY5yb3tP33S8Ir1RfQQJKPfavCCimm0NYllcKI1LDqIYi9t3QqsDCzUv9xX
	myEPO0vNk9NGdJzvvf6LRefR1LZ8GmqEOaF5Bl9YXb0S5g/pnYx0d+L7EEzRgrTx
	2WotfUAxrJV6pnoCtW3WsC88rym6jKx07Ww==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnvnjhdf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 03 Aug 2026 16:31:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so2793101a91.2
        for <linux-mmc@vger.kernel.org>; Mon, 03 Aug 2026 09:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785774691; x=1786379491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YAvrFt7UxnAdItPH2CXdS0z4Yb63m8btV5QOaILKwHw=;
        b=h3Ym+v3hioPlBPyqvd04mtalkkHWG7kER6Kxvtk/tUWNL5H7u4B45OScXrzgn25Phn
         rt2Me62ctwWv7TBGNIgmk7Vp7zxndIKkJAdm8FupXZJlt1Sm74BRQnXF5r/yICnr7xIS
         5IW9rpa1419F9upo3lpZDdR7NvPDBmzalW7PAXq2hfUl2cOw8UXGSpwjHfUj46Atn2kA
         8hqCJRuwXB9uUngbiRSANrQ6jWNW42NDcbPyAN9m9+kQkssJd5ZNFDWbzQ2yFvQh2irx
         /Qmq8WUzI2G5B32nl3VZNJKV30NAuEk9KJhaWnASJWuAIKFOrzVFCGvsXHWQ2+CVem2S
         DZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785774691; x=1786379491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YAvrFt7UxnAdItPH2CXdS0z4Yb63m8btV5QOaILKwHw=;
        b=gj0PDD1M3meZTgVGrdRb49ooT5MlSS7YC4uxa094ZlHmX2Ktgb8wH+ZNjHgpZ1l+zg
         99yT4qYw1QZo1dmDq6jfCHZXAwUys17qe0p0qWXHxs6YeeJmV/BvRSXEylAUuR3D3kGs
         vfbMQLGmAJkW0yVJBRlJg0AWjRD3biA9IXtB/+i90+Ii5a0P1cvGYl8nWZAPnlg8YkP4
         DZB90pstyjxoog44djmu2fCStyPxC9aatJ4eo7D/NTuymiWdDCRJ4DNVM7psjjXUcoQ6
         s218kCNAA7/6gOcbdVuHcozz8Cd3dDECzMNUOLAwQNGBGkTMqXBXNW+6kYYDbjELTXuv
         7JYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3APvUrsmDVbb+G8h3QDT9HG491pCgN0Xc0GBMW2rRnc7Y0NU+Fd1acH1ewgfwujbQY8sqD6jJahs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG9RwKHBwHUhjXME9hk/r2AE5C2HoD5qjIuEW7ej5OaxZ3oRy7
	BhEJOPqzs7EPWeF6La0SQk49nPgdKKqZKWo4jYxo/ZkEM4S7KGzFksTJqMoO+8fkZ9haU2KZabZ
	pn8/5wkWvhxookFuWNhzoHf1fOuwkI4mwByxqBZayMtNMJGaA+UzW4Alf2eP3TB8=
X-Gm-Gg: AR+sD10cuYYnksdcjAUTxXOSSJ3ARackkPTPoZOYgQrvtmv5Rbh8YIRX4RqsdxZxVQC
	kW7xW9GHQ03xC/zUDYp1NQXiMmxzZxPvPBw9D2QnNuW8Fem3c856mcZAo1s9ex+97kXUP8jQcxK
	6FdVrRVm3z0PLgzIdR1+DSGvv6kwmIBfHesdm65VUW6VOob7FBakKurW+6IgrK8v0hlpJUopGZN
	Z/fmcgzpEaEXCCLdlRiPLoBdjk9cLSrrNdx2m8PDdquRxnKSvasT2lgCfj3/Fqg7K7ipvJyl8oc
	tEcYv9BwBFqXY61s5Y2TxseBXkt4RCdpFsVzxSEQtmdotJwULCU+bl0cRSO1LPYO7CMmBTHLsXR
	QYlqfP4Oex+oQDuP64axwt0nYEdOHh04=
X-Received: by 2002:a17:90b:53c7:b0:38d:a150:ee04 with SMTP id 98e67ed59e1d1-38fbc4ef153mr9166263a91.30.1785774691420;
        Mon, 03 Aug 2026 09:31:31 -0700 (PDT)
X-Received: by 2002:a17:90b:53c7:b0:38d:a150:ee04 with SMTP id 98e67ed59e1d1-38fbc4ef153mr9166242a91.30.1785774691002;
        Mon, 03 Aug 2026 09:31:31 -0700 (PDT)
Received: from hu-neersoni-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4cb50dsm54592761c88.10.2026.08.03.09.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:31:30 -0700 (PDT)
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
To: ebiggers@kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
        quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, neeraj.soni@oss.qualcomm.com
Subject: [PATCH v6 0/2] mmc: Avoid reprogram all keys to Inline Crypto Engine for MMC runtime suspend resume
Date: Mon,  3 Aug 2026 22:01:21 +0530
Message-Id: <20260803163123.1802005-1-neeraj.soni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aoaCzyZV c=1 sm=1 tr=0 ts=6a70c264 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=bHz8KAZ3X1NNnLgrXMwA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: hHwe3H2AlP8UX7b7A_sX6qGov63nMNPM
X-Proofpoint-ORIG-GUID: hHwe3H2AlP8UX7b7A_sX6qGov63nMNPM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0NyBTYWx0ZWRfX6cyVTBBjxHMj
 yxzR1SSqKVlryD3cvU+8Rspp9jORAdNan44iN/lIHpZYyV39qtPAyfoI2XUB3LSvDkdpCYHNOuC
 VeMBCsUFHuuwOeO4XYhjrfpLqGmfftsxQXeOhNXbXOoZG5+LbXdgCMZAnADddzjfJJj1ItK+Swz
 t392jCw746l4Caq7JFpUYCNwf4VgGWmcVImucgurCQwdr3PAOrioSplRiePJjkdaZlh9IIxHp9s
 A36vpTXvvLtHYqBWC6m1/xlFIDuDI1Ct0FSzN7/uUtNDVKJAeMAdVL9xmZTt2z/3KfCV8UcErTC
 iPqx4YG/T7j5xfDfJllt2rXPQwj9IGbfV3cDwCu95vGlh2HWYK7q+ApOpbiKjeGE36/adBJXXh1
 VXurbD5ddIWgKhrFCBcdNmFpxxbHjkc0+rBWxgtaMVV89QF6RbYXHKgNyP2UHqsj015RN0+UgxB
 FOS06gSKcQwJKCxb9Tg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0NyBTYWx0ZWRfX1bt6bQWNB8ob
 pD4GK6SVLVR/RMMDdYwL1e2ZrI9NZFJpBcDhpX+8AtO3L7RMLlTy2x94h735xoO/rnDWR/y/GV8
 fU/h8sq6uArJ6O2pAPtZ7k1EGZE3KSM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030147

Crypto reprogram all keys is called for each MMC runtime suspend/resume in
current upstream design. If this is implemented as a non-interruptible
call to TEE for security, the cpu core is blocked for execution while this
call executes although the crypto engine already has the keys.
For example, glitches in audio/video streaming applications have been
observed due to this.

Fix this by allowing host driver to control when to re-program the
crypto keys.

---
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
 drivers/mmc/host/sdhci-msm.c | 23 ++++++++++++++++++++++-
 include/linux/mmc/host.h     |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

--
2.34.1

