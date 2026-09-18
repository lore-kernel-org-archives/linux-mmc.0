Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654454B048F
	for <linux-mmc@vger.kernel.org>; Fri, 18 Sep 2026 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789732013; cv=none; b=mECQni8/qmlFJDgOY+LBh+WkiWZsjctk6fMiTRH0sAwo0kpbPrqieIVk6oFqjGu7ng/7YrT60XxVC+rEYdVCqZrvvjOlijtQ691KUsaJ8Leb+rTPrhunWAg4U2RRN09Qb8uuTzbUfjWfLO8qnjbZMGu3y49aee2HDsGkau2m3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789732013; c=relaxed/simple;
	bh=N0rm1SiBoXQyZwSBkei+mjB9grlxqYlYsoMGdzQcpq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vr2LC8+1KXaBvZ5b11sIWwutjoCLeUemNClwi48n5xYe7NN/NaMOoLrD81PRzK9RBir2iHtz95OaJTvoNa0hBiHKAgkClKpKXu93oVUrBSocQgWfnbxL8ilcOJ14Puip9Kc5iYapbHRvchuJ6ardplrmtWqukjBoHuPz7BZGJFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EUHVbaIg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hYWUufCn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EUHVbaIg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hYWUufCn"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I9dRx8860385
	for <linux-mmc@vger.kernel.org>; Fri, 18 Sep 2026 11:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xSkbYnZzSVkhxO/yj3SW3fACG21geoGWBj6
	0aYFtXII=; b=EUHVbaIgYMTZ1kamL5sbk7DVvvrOQTWDgp1oVjCy24UFfJViZ6V
	rCxqIDcv6QiuWPN4sIVWlmR8/M7gqiPvZP8n5w5fSsH76y24SL+ip/qCMKN3hObb
	aGXxHzGepblzPqVTvHp8PvTEpTYnn1vVjqDcbqaEShVWvY3Vj6ue3jXDmpJZq5uq
	DMJRPBbm1pEGUvCI1WkFkns6cyERyHAYvPAGEemdaNZSxem1kfzLnOaL0KUNylD/
	trdmV4WhI6W5GS4fzcDrqltXUFC0pqpAzg8l08zM8ogzoKiQg/H76r9dvkx69rjD
	X48C8xyoe0XTwao2JxvtvbMGPuih6d/9XIA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs2hv8htn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 18 Sep 2026 11:46:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-936aa34873bso112471085a.3
        for <linux-mmc@vger.kernel.org>; Fri, 18 Sep 2026 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789732010; x=1790336810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xSkbYnZzSVkhxO/yj3SW3fACG21geoGWBj60aYFtXII=;
        b=hYWUufCnAkNg+lqbDai5qFjrwdJ/87ACabc9WuHff4rqxFnEWSbzBe+ilfAOaBAGTq
         RceCvy+Z5FtQe5OwnD3uZqBQloeIifyYOCHVDJQXq952Nn9anki6JG/sTu3ZZiNtzC9a
         u27wGKE1ce1SC+aBC4c1t6UhrBBxSlSAY5aFHos+PRHurBCCDxuLWWo/GvzGbEEAuLjh
         +GYfWGKrAJWof/4BvP6TOdVFCOb/jpbpyxfeJkIMnKK53C6JW4u6wnvcQKOvoQ1FfYko
         2QBkCRra/N94yZCqIOI4TMQ6PjUyfvoVf77z7FAsiUgir3RxBnE62G3dzqCKxEySZS0f
         SCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789732010; x=1790336810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xSkbYnZzSVkhxO/yj3SW3fACG21geoGWBj60aYFtXII=;
        b=S2xxCcKAApY3zRabSypfWbiSctmqOscFWs0XwByZAHS4hav5thOj2w6unyWPAj/vg8
         ubVNRyi3q0JQU2Z2800m2UCTXd8qZS5ycxGPOzoUYxObXvyhF1JGZ4PZPvUvRxL2f4pI
         M62bgqVXyC6WTXSHkxE9OPrmY4YB08dBxRP6k+/DNXMGfkuFuCfOZQ15c1gPKMNODHV5
         DaLjefbW7oa35hC8r6qlzfpxR1H12XjiMZlvlpFjfmT9A9OosOLMIPytle1n88ZnKoRu
         ZkGLA915MBFyxow8WHka1i705FexGictgRNzn1ULrMKhgUjqkvsXhI4o8lNvKbuY9cez
         stPQ==
X-Forwarded-Encrypted: i=1; AKwUvByRplz95MIr926ghnuQa49/y+wqHs18MRsRkVU3nOFgVAlgBfiUqRhQbNPoiD68PoWgowEWydha2ZQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mYVh6WCvK5kuFyFTRwbjVZeOM+dW7ZkRG4EUzVNc6J+UDQiMX+
	6p8gxs78OcuKHeyGfL5As9k4LxjxzwafM+iM1oGNS/tnp+kQhNixqrr/f1GY+6y+8qo/Dt4eBsI
	34o/jHM6nj8ACwgTnYpZVZPbR4VGZcSGEKnnDEgcd3/stiuUT7jrODe+9dB4KOR8=
X-Gm-Gg: AYBFou3EmJvoIEZHJN6HM9fahCARjZjAnRzfgkbVbFBemGaSbAs5GDuxp+vCQIJwn2k
	VBLkzoieMXK8yW/+vmQf0EhTI0/qcQ8CPqKReWnQq71RYKxOWXsqTJfcVcHgKxQsnVEGz6w/shg
	mkiXXyASPmsWuccXV0sxTTvuGKXAFQ1H6qLTnMAJ8S6jouH/5yL1GE3jnMKENFeiva4B9cObP8T
	1jdcnEEsnLtHt0eY8l6CSkoTQ9zgu9AD2RpHEp1+PtFUE5tBEncE0d0vLT2EiGZDGuNpwJ3pn7x
	nT2IxDgEXEAqvWbQYXGAfoJDXjo5zGdhdSrEQN4gHV9SBOZugPYxijgUKf1D0S7wQ1D455pI4S2
	/KAb5Oyz9vYBTi+D3vFro/q9YirUSeItf+2CWxO1/sf/9BXBmIe4w8pvU2Q==
X-Received: by 2002:a05:620a:2607:b0:93a:9298:1b80 with SMTP id af79cd13be357-93bdc8c7ad3mr284404485a.40.1789732010504;
        Fri, 18 Sep 2026 04:46:50 -0700 (PDT)
X-Received: by 2002:a05:620a:2607:b0:93a:9298:1b80 with SMTP id af79cd13be357-93bdc8c7ad3mr284390985a.40.1789732008680;
        Fri, 18 Sep 2026 04:46:48 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a1bbc6a06sm46794566b.53.2026.09.18.04.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:46:47 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: [GIT PULL] MMC/MEMSTICK fixes for v7.3-rc4
Date: Fri, 18 Sep 2026 13:46:45 +0200
Message-ID: <20260918114646.74669-1-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE2NSBTYWx0ZWRfXxRsoa5poD/nW
 g9R63tUVVDqNP9dw4rT9PRDmbVud+SHmE6BlSLpWN1PUWT4kSNGSuLLNXD+BlcdJSkwJa7mroE+
 rDnUiSnPhJIFPD1L71EkbVA+5YhAsDY=
X-Authority-Analysis: v=2.4 cv=IOWXmQvG c=1 sm=1 tr=0 ts=6aad24ab cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=troJrSmf7mxZy0xkckcA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE2NSBTYWx0ZWRfX50O+q4AEfG75
 QsDC/6MUA0yh21EFqVmVb3/hRiatV3jJOwvhHlKI43yS6b4WPiqfrT+nOsOx29F1Q8NOoEkUgXJ
 7y2nun/a+qv0qcZlQ/9hXMd0AsFlBbeL9SkQzuVdcl1FSs9iaSbYAMSxNpz4QAC7RxQ2+Rlz5MY
 jpW6oR0o4HkL5AubSR1YkuSZHfYsEPcG67kmqsZpuNAwLtBenJ7f455V7Ru4TTBu7fqsZ7wIVIz
 PVym2OP6HzbM8BjBqOepXGp0vMbWs12+CvHZwYobrLtsdxUAwy+joYHiTgLqhJ2IohTVbfu9+yH
 pxdVshSfm9vpXN1VYxWuH8cO8hVf3XCvpmTi7n7wgshDtizHxxVCrltDxnmFnpzqi7NQSG7S6UA
 RTZ0jftdIBGyNo1V5LR67FX3ilpaxa+7qIJhDACGDcHaejBMAP4R27CZOWdUv3uSbFwiYOTmJNf
 gf3bhCxtUs4jTE+mvZA==
X-Proofpoint-ORIG-GUID: NLzKXFAHGhlnPDU3aHyCI7564-JG8tWC
X-Proofpoint-GUID: NLzKXFAHGhlnPDU3aHyCI7564-JG8tWC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180165

Hi Linus,

Here's a pull-request with some MMC fixes intended for v7.3-rc4. Details about
the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.3-rc1

for you to fetch changes up to 4396d70bb7fec531bcf934fed016b2f3300c670b:

  mmc: sdhci-of-aspeed: Remove children before releasing SDC resources (2026-09-14 12:04:29 +0200)

----------------------------------------------------------------
MMC core:
 - Prevent potential use-after-free for SDIO IRQ work
 - Fix OF node reference leak on card add failure
 - Fix memory lea when the port table is full for sdio_uart

MMC host:
 - hsq: Fix use-after-free in retry work
 - mmci: Fix use-after-free in busy-timeout work
 - mmc_spi: Reset bytes_xfered before retrying CRC failures
 - mxcmmc: Cancel data work and watchdog on remove
 - rtsx_pci_sdmmc: Ignore broken write-protect on ThinkPad X260
 - sdhci_am654: A couple of fixes for the tuning sequence
 - sdhci-of-aspeed: Remove children before releasing SDC resources
 - sh_mmcif: Initialize IRQ-thread mutex before requesting interrupt

MEMSTICK:
 - ms_block: Destroy io_queue workqueue on removal

----------------------------------------------------------------
Diogo Ivo (Schneider Electric) (4):
      mmc: sdhci_am654: Move tuning_loop to local variable
      mmc: sdhci_am654: Reset command and data lines on failed tuning
      mmc: sdhci_am654: Clear ITAPDLY on tuning failure
      mmc: sdhci_am654: Fallback to DT-provided itap delay on DDR50 tuning failure

Fan Wu (4):
      mmc: core: Cancel SDIO IRQ work before freeing host
      mmc: mmci: Fix use-after-free in busy-timeout work
      mmc: mxcmmc: cancel data work and watchdog on remove
      mmc: hsq: Fix use-after-free in retry work

Felix Gu (1):
      mmc: sdio_uart: fix xmit_fifo leak when the port table is full

Florian Maillard (1):
      mmc: rtsx_pci_sdmmc: ignore broken write-protect on ThinkPad X260

Myeonghun Pak (1):
      mmc: sdhci-of-aspeed: Remove children before releasing SDC resources

Runyu Xiao (1):
      mmc: sh_mmcif: initialize IRQ-thread mutex before requesting interrupt

Xu Rao (1):
      mmc: spi: reset bytes_xfered before retrying CRC failures

Yifei Gao (1):
      memstick: ms_block: destroy io_queue workqueue on removal

Zhu Ling (1):
      mmc: core: Fix OF node reference leak on card add failure

 drivers/memstick/core/ms_block.c   |  2 ++
 drivers/mmc/core/bus.c             |  2 +-
 drivers/mmc/core/host.c            |  1 +
 drivers/mmc/core/sdio_uart.c       |  3 +++
 drivers/mmc/host/mmc_hsq.c         |  8 ++++++-
 drivers/mmc/host/mmc_spi.c         |  1 +
 drivers/mmc/host/mmci.c            |  3 +++
 drivers/mmc/host/mxcmmc.c          |  4 ++++
 drivers/mmc/host/rtsx_pci_sdmmc.c  |  5 +++++
 drivers/mmc/host/sdhci-of-aspeed.c |  5 ++++-
 drivers/mmc/host/sdhci_am654.c     | 43 +++++++++++++++++++++++++-------------
 drivers/mmc/host/sh_mmcif.c        |  3 +--
 12 files changed, 60 insertions(+), 20 deletions(-)
