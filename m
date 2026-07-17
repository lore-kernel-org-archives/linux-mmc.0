Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6E391845
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784289463; cv=none; b=ncfQdDKfK8OOHQ3U6bRiRRXKNYM7Fdi+IN75t7Rk4KyiLgG9PZEswY4HStwaX3MvtPEI2Kx/7AtFxE8guyh3HM1la8KLEIALzc9kpBmLrP8VbTVnZNi/MA084e5F+dJGumcAuYkAOOMOAL4UeBOFOCtA8Uwr6528WVFRRgROTyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784289463; c=relaxed/simple;
	bh=XeSb32sBQpyJOUUjV6YdJsqeVtvUjxeLLOfepYkcKzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fgKlXyk3G2vW4+C2nV1EwUUxI+UPCCLCnyaTQMjzoneUWvwIYSspux7Q7gPVf5APC8GVFXPdAhkUCswkNs08TUzeHZ7Ifw7+ghyRi6t5yGYsySNy9YbvfL/fkv8baJ2AGHzYCiuTc61ZsOycP7oA1pqCv29F10amGqgm4Y6e/fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Szb6XLO7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kHPT033y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Szb6XLO7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kHPT033y"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HASjMd1323590
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 11:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=q1xpduM5K0lYBx9G280FXCLQwdRRNC/dqgi
	1kRoH7Zk=; b=Szb6XLO7j0/zxxlGRD7DO/e/cvvHsbs6FgmS7ARmDg3ufbCXoeG
	TZeciHrDiRCN7WxmWOvkr9L5EayFpGxDlmakZU9hOmIv8WTBsT4kx8JP4UquxnOi
	nucwWpMUtku0HW7rR792OrSVIM4wjOT+HMio7pG1gWmDRh8nrtl4ItfmE+i0QkMq
	XLOwwgwgiKG7IhRDJyfFA5//Z0V52unb+ocMm1PWYt9d0H6kKQ60j6aTFnllyr70
	JQc6B1oIvRADvzUB0YYUlNuIlUXMlWhOEErAT75O5lSjdrA8Vd5Z9+hAjj2a8Lf1
	Ju4KLnwo7y3N6jTuzxK0SGakbg+au+oynlw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u8kjsb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 11:57:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c21c01cf3so95088421cf.2
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784289452; x=1784894252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q1xpduM5K0lYBx9G280FXCLQwdRRNC/dqgi1kRoH7Zk=;
        b=kHPT033ys3k9rgQPWz/9Y2BDNP6npvjLgH3e6E3YT7dBGnRxlq/6llMvOiAXaaG+HR
         M4HIa8bVAAz/TroiTA8KB2RAii8GHqMfVu/QS6U4xWOEVgrLbnfxoVPZCLhC8Lcgwsrk
         YJ/qTGa1zoInsVqRiAcTFwihXRa97F49tUQgoYnV47sidNN1BFBnpLm9AGF4rQg3jniI
         ZqMR+DPkerg83ukgDNSqC5SPgj6yvejyYwbX9hdfNNcgWul7wE5e+RqfN0yadXUYTBs3
         lyefo/GTz19f/nr9HIf9v/3duj7I2C69g9Rsg2F7eWwlpxs2zbJ+nsqElJbq425sL8we
         wXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784289452; x=1784894252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q1xpduM5K0lYBx9G280FXCLQwdRRNC/dqgi1kRoH7Zk=;
        b=LD2ktCXZ2QGDep0Pa9PLIWcyM1rNYt4WwZY1DdsMbGtSAhPS4fTpv/3O88iZWIr7DS
         +2hJy5/7BOjJ17r7awBtUd+dLeOGDdejoTsbeMwRKLdkC2YrS5nDubyaHnjsHDnzfXfO
         I4LMuPDwprxA89sV+kwJl0MTeDTMk3dEMJUd3tEBuldTW2JbDJfKYPtpsKxqP8e/vUcG
         BhmgmrsCrIWvrvia+JRBrk3y3Rkq0+8ZGRvBtriUrlCjIIcs25tnIiD+9RZ0vbnK7lgx
         38AXU15VNb2ag19dbw4p5NytNiP8kAGs1vPzzSc3OnV909TVmU8lIY2hxtW73f2HWHcq
         cfMA==
X-Forwarded-Encrypted: i=1; AHgh+RqcPPhh/TaLqorJg/I+vmpPR8B4QyjBnzf8iuzBXP+4sj/qwFScSpBzdXoPFIKzrMR72XxZVzwi2cU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxabmvB9Aos/JZjsyo07YhAwWmb6khv45xPbmW0gt1/WJCUImOr
	ywRmQjBeUhq6aO4ERjpZHtzT5/fPWbjW0G4/fpCDHVN28J6CS0gf/XkFuLmyU8+gwdDdhOsffRJ
	lxha9bqGGrARnHMUV01/PGClML16jBKiP3FAGbUtlYCysTN0+1lIOhLjiRt1aezU=
X-Gm-Gg: AfdE7clPs1z0p31I9I2ShI4RNx0WlCjIpVj8CNQB9y6h8nd52AWYaFEgY9znLqL6i+K
	Cl7MqL4afLULvw5d1JV+BUIviYtvAjhovMAjyLZrhr4VCQZn9qum0Fr154Jv4YSZ9SBZjPhc2pG
	5ZvYvjWMkeeIj88hvuaVxOtdMrex9rlJnCBTo+v66Dc3MK6gqV6zVuKGvdDVUGV/b9HWZ2IC7Kk
	w5mA81vHE8yQdXEIsBWHvnEvL4KHYB1iW4VKPyq/kzqyKVE2ZQ+S8SPLtkyHyGVsYhgovnKUAHX
	7jh9ts7nDdopaXZ8GlfA8VrGW0T/+KReMN1O1vRMdoAtLqmqeYjdi/h/vhnYM96a9WuGJ8HYhMJ
	ceaCQ6ZGgBxRHhQ/NmxcgXttY4YA7o7MrnEQ1iTd7giFigWzTMyOsthZKxg==
X-Received: by 2002:a05:622a:30b:b0:51c:51e:661c with SMTP id d75a77b69052e-5213d7b03a7mr18261381cf.25.1784289452222;
        Fri, 17 Jul 2026 04:57:32 -0700 (PDT)
X-Received: by 2002:a05:622a:30b:b0:51c:51e:661c with SMTP id d75a77b69052e-5213d7b03a7mr18261151cf.25.1784289451851;
        Fri, 17 Jul 2026 04:57:31 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39eb4e7ba52sm1423891fa.15.2026.07.17.04.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 04:57:30 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: [GIT PULL] MMC/MEMSTICK fixes for v7.2-rc4
Date: Fri, 17 Jul 2026 13:57:28 +0200
Message-ID: <20260717115728.70883-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cOuOAgxuY-tqxoX2unyXx3dCBMHv4fEZ
X-Proofpoint-ORIG-GUID: cOuOAgxuY-tqxoX2unyXx3dCBMHv4fEZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExOSBTYWx0ZWRfX5CUjVg0GLOwb
 w+m4Ss74qvwN7GUH28JwBHvZeLj2Qqiwz4U0sxVCVxMeFkp4rKGGS8FGc2vdyHncOOTUaOp4zkC
 R53J2Y12NqXNvg5ktPJY47H1Em9xhz0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExOSBTYWx0ZWRfX6OKcX1Iy98xG
 ggkL7IgUcqLL3BmYhlP3LLBIOt4LTF//zC8bYLxLxE4NepFGAzw3J+cfPnMnanufIlxEVl/NgzS
 LNlJXAblwxfKO8aEQCMQMYGdTqvDWv1CTHUOclnG1QQ9qbhNHfP2JaVOF+19Hs/dl2twicLUuNa
 8M8qgySKHsOv6fwQNaCH6JnqfZuVsXaHxsxR6w2NRkzvCSXRMxT3Knrpem7gBx6Ac2Q0gjID9gw
 rVzkSP0gwxP/Q/qtXM/1DJwVjWGONbfzPQ4stg33CaGNmZ+m4UKt5kk0kgkAgjrBEmcDyXswgzl
 brWw7+9SISd06bD6IEjagte5qhuehJKa6NgbNDW8TpjVhCVIRqS6/Thw/z+t815k998MxkBsh6Z
 wXEi37UeRmAWD/EdD1+UpMA7uVrb6joJdAXmvMY0ETlxAzCvfZOLymZ9xYTpkbBi3yo8cWUL5PP
 C6aWjv/jiSubWJ0/4sA==
X-Authority-Analysis: v=2.4 cv=TL11jVla c=1 sm=1 tr=0 ts=6a5a18ad cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=vC6-8p7R4q0FMFtJktkA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170119

Hi Linus,

Here's a pull-request with a bunch of MMC/MEMSTICK fixes intended for v7.2-rc4.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:

  Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.2-rc2

for you to fetch changes up to e27c946b589c53520409a0956b33d52ef7a0898f:

  mmc: sdhci-esdhc-imx: fix resume error handling (2026-07-15 11:00:02 +0200)

----------------------------------------------------------------
MMC core:
 - Fix RPMB device unregister ordering
 - Fix __counted_by handling in mmc_test

MMC host:
 - mtk-sd: Document missing clocks for MT8189
 - sdhci-esdhc-imx: Fix the support for system suspend/resume for SDIO
 - sdhci-of-dwcmshc: Fix error handling for clock prepare/enable
 - vub300: Fix lockdep issue for the cmd_mutex
 - vub300: Fix use-after-free on probe failure

MEMSTICK:
 - Reject a card that reports too many blocks

----------------------------------------------------------------
Ao Sun (1):
      mmc: block: fix RPMB device unregister ordering

Guangshuo Li (1):
      mmc: vub300: fix use-after-free on probe failure

Lad Prabhakar (1):
      mmc: mmc_test: Fix __counted_by handling after kzalloc_flex() conversion

Louis-Alexis Eyraud (1):
      dt-bindings: mmc: mtk-sd: Document extra clocks for MT8189

Luke Wang (8):
      mmc: sdhci-esdhc-imx: remove unnecessary mmc_card_wake_sdio_irq check for tuning save/restore
      mmc: sdhci-esdhc-imx: restore DLL override for DDR modes on resume
      mmc: sdhci-esdhc-imx: fix esdhc_change_pinstate() to allow default state restore
      mmc: sdhci-esdhc-imx: restore pinctrl before restoring ios timing on resume
      mmc: sdhci-esdhc-imx: disable irq during suspend to fix unhandled interrupt
      mmc: sdhci-esdhc-imx: use pm_runtime_resume_and_get() in suspend
      mmc: sdhci-esdhc-imx: make non-fatal errors non-blocking in suspend
      mmc: sdhci-esdhc-imx: fix resume error handling

Maoyi Xie (1):
      memstick: ms_block: reject a card that reports too many blocks

Runyu Xiao (1):
      mmc: vub300: defer reset until cmd_mutex is unlocked

Sergey Shtylyov (1):
      mmc: sdhci-of-dwcmshc: check bus clock enable result in the probe() method

 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 29 +++++++-
 drivers/memstick/core/ms_block.c                  |  4 +
 drivers/mmc/core/block.c                          |  3 +-
 drivers/mmc/core/mmc_test.c                       | 18 +++--
 drivers/mmc/host/sdhci-esdhc-imx.c                | 91 +++++++++++++++--------
 drivers/mmc/host/sdhci-of-dwcmshc.c               | 14 ++--
 drivers/mmc/host/vub300.c                         | 36 ++++++---
 7 files changed, 135 insertions(+), 60 deletions(-)
