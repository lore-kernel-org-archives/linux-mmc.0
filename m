Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5293D7D82
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478467; cv=none; b=p8YCLjw4oQvlL948U0nwaUhp8kLwTcHIj92fJEHXvCP0Y5GGSFyCj4tmzXfwNDdsg+yQ0fi4SA1MajYVqaJrW+Z/megZr5e0IOymX0YWgwE/CUA6BygjD3EHJ0JzXu8Ytf1LQnyJ1HB51xSii/XHsgB5ixnxHwLk2xMJXmoheh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478467; c=relaxed/simple;
	bh=RZyAGUUgEq07uaFSWAqsn+EbU5vRhwxHjGRTw3KkD7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dAR3lFPGFW/24wcZHqys5T+M6w3zWExKygZ3xRSy99YgtTajgUOPU2PmU3VF2SxYXT8ceDicE+qdZnS/pt8ubz11uxN8DSiOesh/aZBvg9b1jElsXHruspsx4XxUPGVgjkXB4SGzKLh70GVtHk9RVeUEpHEJ70IBTG4qPptrIV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iTG+Ozzg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eXXOd+wG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iTG+Ozzg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eXXOd+wG"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FD04eT3112287
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 13:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=H6bjSXggPs6jDy8MWuWW1A+c4FcEG+O1QoC
	hVC14BIs=; b=iTG+OzzgVxXiHUkf5mHnLOSge9TvkUqh9k/6yGk3tZ00YYF2ovk
	vhJdLRbYSXBBV5cb8l9egqtpb3uTNMzez0yCF0oESmh5m0kEpKh5uETYBalZ0xbK
	06WFSkduwKKVmlMNnM2qXaCbRUqb/drNe9QLacLA83ZzqhtKxg4U1665mjSUP148
	kX3+csbjjB/Wxe2eKttqW79cSRtOlL2Gdu/JaWmPiUXdzduhBYpXG+C2rzOIYNaa
	qj/8w9UzWCJaSfpPGjhKVMYriGZAgcXURPSHL2lXIYoWmXv/rF6mYmeUiU1Zgbq1
	rVdtXzrCzsQSnCp8bEJmridIa1WpyVybIwA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpye721re-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 13:21:04 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9830f2a8195so220559241.1
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 06:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789478463; x=1790083263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H6bjSXggPs6jDy8MWuWW1A+c4FcEG+O1QoChVC14BIs=;
        b=eXXOd+wGYDcR3or+N0W2vARoX+iT5iHLMVtwF56yVVCezkIPS17F8TzGNxa3yXH9xW
         MwFxNiG064nseLdyoVBARa0eWhqkoRv7JRN/b0cHeqQh2N6E2zc9lX8PGl122MzJIiqg
         Zr9ZfpiuqtRJWSoahIsOV+7U1HSVb/GpzLCP7HWbQAEJeHH5/CDHAuaW6kGuhl0sL/+I
         1r5+Mu+loYu9JmXWcuJcmyG5eD6xalbHeDDTW8VBvHapQfoGWyX4tg7pGUJNiM6oVtn3
         8kuj41dcWyaC5a5iJpH58/YKpw1dkTpEgRd6QulUSkUZ7sfBTBliI6/NRHGQEaJ1bd3o
         yluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478463; x=1790083263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H6bjSXggPs6jDy8MWuWW1A+c4FcEG+O1QoChVC14BIs=;
        b=RxEJNhsiazAunZYpd7CHV8xavk6UCOtGilhL10NJXQ4iK7nk8mTpTrh6ZoU34VVzZ1
         UXRflr/9ZBhIUUSJ5fWEkaO/MciCnfqWMCt0VFiI/fGRfAp3lkXj4vUd2q6m73DJ7qpG
         rgkZv4Ja+38bUuLwWqFXKCzGyrMkonvxMvscJFNvaZqjlf5TXnt+6UjnKi+sIzwzuRw4
         uqqkZSusLBQ5zHO7y+J3cPbxUg2Sr3I1Qsrudp0WPnlWivadRSDrP3CcKYZ2o5dUQz/3
         nFIE0XNIvyxuJJmKbRocRExrg8W0p3cy4Dss2W5Bp48vl/3rIcmQZXhJhU+IImJ1FdJI
         FPMQ==
X-Gm-Message-State: AFuF++ltfBIVqr5gxY0hJ++e/LKmHMBB3BOZufVV6x3M9eQGnwkBTIPl
	Gskzgb4yBsQHLPS6VN0wvqsm2pYTRzzPlU/tI8VvzODQFluOewAlQqPE3mHDMcq0dq4WM4RU18R
	kqyVhLEuKPLE0+kxTcyf6rhYB1IJhWz9Ek1ygzW/wAMgD41wSEDLlYSmucVzKDqcElvuLOaM=
X-Gm-Gg: AYBFou0R7etLmP2kL0KA9/YmgAbu513r5lK59AOoEd396kcPHWIHwqMPLITowLjp0hI
	/CfwEtP1Yg9c9+gWINXha43XXFg2q/Ncl5NRglXnrKjLrJC7PXN7kT16ZrgJgdODJIHKdPIV7ev
	rtHIGV3Vz5DzbrpPVPuqPjziiqj53YiQ1bugDLRpeXqoxsSUwbHNcl5rJ2XbDqJsCLsNXaXcxwQ
	+Q90lF4mU/05trx2ItFwozAU32xAMEk8AE655f0yh3CDQ+xUfWwlc56vlfN2LFegusQTgWAG49I
	LBZxCe+2qjQVpNKDdI+il1lr/QLJSpPhdoNKbBF43QqeFFT1G1J5dxhv7MiOjAqdpLYu09hNlwp
	VwpHJi+MQuwVYDeK5pc1eFBuiBkqkjAh/xmyIB+pYcSpxCv3XQ/joLI2R7A==
X-Received: by 2002:a05:6102:8641:20b0:79b:95ed:4689 with SMTP id ada2fe7eead31-79b95fc923cmr6657180137.3.1789478463671;
        Tue, 15 Sep 2026 06:21:03 -0700 (PDT)
X-Received: by 2002:a05:6102:8641:20b0:79b:95ed:4689 with SMTP id ada2fe7eead31-79b95fc923cmr6657088137.3.1789478463192;
        Tue, 15 Sep 2026 06:21:03 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296613c3ebsm582885466b.57.2026.09.15.06.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:21:02 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Cc: Rui Miguel Silva <rmfrfs@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: [PATCH 0/2] mmc: core: Avoid export of mmc_alloc|free_host()
Date: Tue, 15 Sep 2026 15:20:44 +0200
Message-ID: <20260915132052.273212-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE5NCBTYWx0ZWRfXw40nrWQkE+wt
 aPBCx1VBagr9vujf0jL7+Ow/h0Nar20tJcsNt8uckNsP6+D2Op4Ci6zGipQ76RfKK2HENp9OXZW
 OclVH1v1ucohz8YrzubHfPAZyn1BU91qn9j3rco3RVr77I4Wtkgasln7bXqxTsF5aTMsGvsnYTN
 xyQdtZAd1vEZ1RWJrHEYP2pNdCbopyPDNGIe336zvj6KexChplMkifCPkCc9LoTDnx0+WJB2T8g
 Eem99J+BhlNut2SWXXELVceUB5yCXhATdWMFbAurzSbxr9joDaDwZ0qMu6UfXPrFVJJaXjfE147
 IcftbVJTyx2WTZJjYp7uOjZU8QvT86yS6HzitCnwoC/johCb+zk+Z+/4vucEipdu2kXhIhhWu6n
 vbOlyLF+xdqb5/CbdwVaEVYwqNizcUiL4NvnQe1AK3IF5F3xpd6R2SK0V7/udvCkClg72d74QTy
 X9C3uFl4fVdh4DPTo0g==
X-Proofpoint-GUID: kGB60wvvckgAgSrg0z46apTYOicfV_Rw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE5NCBTYWx0ZWRfX8Ta4gFk4qS3o
 zqs8vupGY8YoxwYiInkcMcuCpmTvd6ljcD6PWAK0X6p0p9hYIToR/zQTRAKRySmDkUYW+7TylYP
 nsDc1IZ15NMEWvUsKkTqtvW102OZAVQ=
X-Authority-Analysis: v=2.4 cv=fck4WEQF c=1 sm=1 tr=0 ts=6aa94640 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=b1TzGBc5BZYSfGZGiFAA:9 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: kGB60wvvckgAgSrg0z46apTYOicfV_Rw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150194

From: Ulf Hansson <ulfh@kernel.org>

The only remaining user of mmc_alloc|free_host() is the greybus sdio driver.
Let's convert it into using the resource managed variant so we can drop the
export of mmc_alloc|free_host().

Ulf Hansson (2):
  staging: greybus: sdio: Convert to devm_mmc_alloc_host()
  mmc: core: Turn mmc_alloc|free_host() into static functions

 drivers/mmc/core/host.c        | 35 +++++++++-------------------------
 drivers/staging/greybus/sdio.c | 11 +++--------
 include/linux/mmc/host.h       |  2 --
 3 files changed, 12 insertions(+), 36 deletions(-)

-- 
2.43.0

