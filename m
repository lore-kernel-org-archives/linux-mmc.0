Received: from mail-m1973197.qiye.163.com (mail-m1973197.qiye.163.com [220.197.31.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CED3CB8E2;
	Thu, 27 Aug 2026 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818442; cv=none; b=SBJdXLqkixTtm6Bce1RmPo3cbtKdshVVOLFXWvwpQtEHPge6mNN7gCPuJydS8e72ZOXDtmLKdMTzjTTZEnAiJNt+Jsm4lxRMAnZPizqUjDtUmw41VRb5vRQ9Ra6ZfvbD6FqUaLr20cwW4diqVseiUjOdYrZCzKWChW8pNU21pZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818442; c=relaxed/simple;
	bh=cC6CrL1ZHz/aGBuEXuFsDL84mT2BzoW8k6+KzrRV5GM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qEgXYsKMw7J4Q3Td0DRtcL4gtqbF6o0DeTbI+f2zs3dpPvH1l4aVpUCxulvCcos15j2rwcLbvH79I6h+H85ppsPyRlJFR89Hl/7kL+Sag5G0uOjOvsXaTgksob4wHAwORtc+/LjAjIJag+w7muZNXtXO5SOW6CsmRHrjR2Nu744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=WSScQXsa; arc=none smtp.client-ip=220.197.31.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="WSScQXsa"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4b88a31a0;
	Thu, 27 Aug 2026 15:58:26 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/4] mmc: dw_mmc: replace three fallback timers with a single watchdog
Date: Thu, 27 Aug 2026 15:58:02 +0800
Message-Id: <1787817486-137277-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa0423a35cd03a4kunm6c47a0ea1fec0b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUJDHlZJQhhPTENOTE
	hJSBhWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=WSScQXsaFjXzMcoYl9Rq+B73FhCAWifaPQcMx0ICXYAuTtNtV1nuMh/1lXFRvbHfk0kUgagAFktN2jIoeb7fAY9dSKoXzgDn8T5ndw0Q8Mj6r5uoWsEssu0SRKAYogCoJOhB+///Fu/AXAxmrisVb7ZZFQ7x4cssjZErDBTL48c=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=bkxj+Aaw8GbXm1RPxI+LqoiZYCRob1bkxA3m0vbzVtQ=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>


The driver carries three fallback timers (cmd11_timer, cto_timer,
dto_timer) added piecemeal after the hardware failed in the field.
dto_timer exists because Synopsys confirmed that the DTO interrupt can
be lost entirely, leaving no hardware fallback and blocking the request
forever without software help (57e104864bc4); cto_timer came later,
when Rockchip's reworked sample circuit was root-caused to swallow both
CMD_DONE and response-timeout interrupts across their whole dwmmc
family (03de19212ea3); cmd11_timer papered over voltage-switch hangs
that reproduced reliably when ejecting/inserting UHS cards on rk3288
(5c935165da79).

Because each callback races against the very interrupt it supplements,
all three grew the same copy-pasted defenses: re-read MINTSTS in case
the interrupt is merely late, check whether pending_events has been set
meanwhile, validate host->state against the leg being guarded, and only
then synthesize the missed event -- with timer_delete_sync() calls from
softirq context eventually needed just to contain them.  Meanwhile the
special cases keep piling up: the EXTENDED_TMOUT quirk makes the DTO
story differ per platform, fault injection can post DATA_ERROR ahead of
any real completion, and every future change has to reason about up to
three timers at once.

The observation enabling the cleanup is that command, data and
voltage-switch legs run strictly serially within a request, so a single
hrtimer suffices.  Under irq_lock it records which pending_events bits
are awaited along with a snapshot of host->state (dw_mci_wd_arm()),
and producers clear that awaited mask instead of deleting any timer
(dw_mci_wd_deliver()).  On expiry the one callback classifies what
expired by comparing the awaited set against the named
DW_MCI_WD_{CMD,DATA}_EVENTS masks, keeps the old MINTSTS latency check
but re-arms instead of going passive so an interrupt lost for good
can no longer wedge the request forever, and only then synthesizes
exactly what its predecessor would have (RTO + command complete, or
DRTO + data error/complete).  The per-leg deadlines -- CTO formula,
DRTO formula, 500ms CMD11 budget -- are carried over unchanged.

Apart from three behavioral deltas called out in the individual commit
messages as well -- a single surviving watch during voltage switch
instead of two timers racing, a stuck CMD11 aborting after exactly
500ms instead of racing min(cto_ms, 500ms) with -ETIMEDOUT unchanged,
and bounded recovery from interrupt-latency peaks instead of an
unbounded hang -- no functional change is intended.

Tested on Rockchip platforms with SD card and eMMC (rv1126/rk3568/
rk3576 boards): normal IO, suspend/resume and card removal during
transfer.  Compile tested on every variant consuming dw_mmc.h.

Next steps: first split dw_mci_work_func() into per-state handlers to
make the transitions explicit, then go further in the sdhci direction:
shrink the eight-state machine, drop the redundant completed_events
bookkeeping, and end up where other host drivers already are: one state
machine, one timer, no separate event flags.



Shawn Lin (4):
  mmc: dw_mmc: add central watchdog and convert CTO onto it
  mmc: dw_mmc: convert DTO onto the central watchdog
  mmc: dw_mmc: absorb CMD11 timeout into the central watchdog
  mmc: dw_mmc: expose the watchdog state in debugfs

 drivers/mmc/host/dw_mmc.c | 316 +++++++++++++++++++++++-----------------------
 drivers/mmc/host/dw_mmc.h |  15 ++-
 2 files changed, 165 insertions(+), 166 deletions(-)

-- 
2.7.4

