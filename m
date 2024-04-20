Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FC1205E36
	for <linux-mmc@vger.kernel.org>; Sat, 20 Apr 2024 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713645502; cv=none; b=iDhP1qzj/SVzehz/iDvr6k9ZRF10UOMeLH68+IctHKPQXl+NlQltOnU8u9N0nmR+JTj09tpreJXtmuaFdNe0P+YQnVpD/0s38SbHR5uIBljR4mg1Tk82pexz0raZzLnXK3ALSrB5LgRdsH25BE6kOpIbUhzSCUpTn7hNd6+aWlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713645502; c=relaxed/simple;
	bh=AHfLW66CqPjdA1/cnkKtJpSA61CaiNOTFd7nXk6LAmg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=djLuBSJWxy5rCDlpiDKPhKNkQzdCgE8JX/9mVBikiZgUc3te7X2mVWWLhCXiu3zVSn0KzYmisOShGXJRJLoTlZHzSxBKadPqlciy6PRhgwXE7lfpX1ScWz+rOp0ojcRbJHDE8RUgbn0oRPqZztXQXNifppeCJxVYemmlsVgTVWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLvTOCBT; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLvTOCBT"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-571f2be37afso525071a12.3
        for <linux-mmc@vger.kernel.org>; Sat, 20 Apr 2024 13:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713645499; x=1714250299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GxN0pBW9QdmUyV23hDDdH4u1XfTPNYFh+93FzVwaWTs=;
        b=YLvTOCBTxEaZ/XjQATPbYyvsjRGl4zt4f1rGBZYn9zptUysJoJG+5fKER06kA4Ho6Z
         HyWTkIko49ncv6TkjdD/bux0ApgDmZoHhEIjFL6Br4yNXW/S0Dzq4/9CPcjKNCHtrMEI
         CIgyNBjjhOgZB6/0kspOZBLBh3hmXpV1UCZzrDlNJzs35aIJqctT4QdVl2oabXDsFIHj
         IigLSccF9xtmY2/e5Z2boa6FFz0A++2J7CcChPKdqX0+GKcEWRY0pAmZ8X7rC0vg6q4g
         fOjdWH1vDR7qPTiUkLyi1AF0UuzLiJV8Uo/3IRYLQErmOSN7IsMnGSgsQ4qNj++Rk51J
         7vAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713645499; x=1714250299;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GxN0pBW9QdmUyV23hDDdH4u1XfTPNYFh+93FzVwaWTs=;
        b=te/h0zjiWsWfQP3dVepTf/63OoHGMUtyNFRP8yN/UW9YiNGZSCH/WA+GLYHRFaeKj5
         SYEtgfL2rvZlUZa+nSa9Nnhr2O3dMGGJCUS6VglTMtLUqEOpdeAd775KqpLnCGK4i0fB
         CeGf3o2IimoG4aTMLKYPciH4jXuc5IMURAJ88sj46qefR7E0DBjQMdTOaUZu0HyDNdA4
         1mCB3ctw+EOOuHF1H4d/mktAS46liJ0HlfU0GXiCa+tNPlgm5hn/91Nt3jpKagtGUbWi
         DgjBNkPiKsVpLsFXWT4UJtKkma+QBq/U+QHZ3RAbICVWhU6Wl9NPkVA4ZRJOrDQvVPZn
         1wgQ==
X-Gm-Message-State: AOJu0YyUnGmtL0TYvZLCtXeSXgkd46/0vaIyVQLmmd8eAlxffDRSrTbf
	1J1j3prSxiU2cYg7O7SwTk1cKSv1LhYrXETaWsCRvRFEyxhHUybxEfbvGJcHP5FtqhnSSQcJlMH
	O3GkspHIJ2V419aYkGqYzgar7xvA=
X-Google-Smtp-Source: AGHT+IF/Ss/B+uyuRtGY4K9H9o7waL3tgFrOab/xz/yP60CRQxBl71eDy6OzRQKtkrae53VJEYO1fgydRx8vv6l7+Ac=
X-Received: by 2002:a50:d6c5:0:b0:56e:3175:6065 with SMTP id
 l5-20020a50d6c5000000b0056e31756065mr3508178edj.9.1713645498890; Sat, 20 Apr
 2024 13:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sergei Antonov <saproj@gmail.com>
Date: Sat, 20 Apr 2024 23:38:07 +0300
Message-ID: <CABikg9z9NqFwJ5VGtHhtZY9_gNAAoSbAfmAnTHcbp2=b0M3LcA@mail.gmail.com>
Subject: breaking commit: mmc: moxart-mmc: Use sg_miter for PIO
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hello, Linus!
I see that commit 3ee0e7c3e67cab83ffbbe7707b43df8d41c9fe47 (mmc:
moxart-mmc: Use sg_miter for PIO) leads to "BUG: scheduling while
atomic".

Can you suggest a way to rework the code and fix this problem? I can
probably make a patch then. The waiting part of this driver needs
improvement anyway. It calls
wait_for_completion_interruptible_timeout() without checking its
return value.

[    7.018270] BUG: scheduling while atomic: kworker/0:1/9/0x00000002
[    7.026701] 2 locks held by kworker/0:1/9:
[    7.031826]  #0: c1813ba4
((wq_completion)events_freezable){+.+.}-{0:0}, at:
process_scheduled_works+0x188/0x458
[    7.044182]  #1: c4831f28
((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at:
process_scheduled_works+0x188/0x458
[    7.057443] CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.8.0-rc4+ #225
[    7.064527] Hardware name: Generic DT based system
[    7.069677] Workqueue: events_freezable mmc_rescan
[    7.075121]  unwind_backtrace from show_stack+0x10/0x14
[    7.080930]  show_stack from dump_stack_lvl+0x34/0x44
[    7.086576]  dump_stack_lvl from __schedule_bug+0x64/0x84
[    7.092608]  __schedule_bug from __schedule+0x58/0x594
[    7.098320]  __schedule from schedule+0x74/0xa8
[    7.103368]  schedule from schedule_timeout+0xd4/0x108
[    7.109070]  schedule_timeout from __wait_for_common+0x94/0x120
[    7.115547]  __wait_for_common from moxart_request+0x278/0x468
[    7.121980]  moxart_request from mmc_start_request+0x94/0xa8
[    7.128213]  mmc_start_request from mmc_wait_for_req+0x60/0xa8
[    7.134590]  mmc_wait_for_req from mmc_app_send_scr+0xf8/0x150
[    7.140979]  mmc_app_send_scr from mmc_sd_setup_card+0x1c/0x420
[    7.147424]  mmc_sd_setup_card from mmc_sd_init_card+0x12c/0x4dc
[    7.153966]  mmc_sd_init_card from mmc_attach_sd+0xf0/0x16c
[    7.160057]  mmc_attach_sd from mmc_rescan+0x1e0/0x298
[    7.165739]  mmc_rescan from process_scheduled_works+0x2b0/0x458
[    7.172326]  process_scheduled_works from worker_thread+0x24c/0x2b0
[    7.179125]  worker_thread from kthread+0xd4/0xe0
[    7.184352]  kthread from ret_from_fork+0x14/0x38
[    7.189527] Exception stack(0xc4831fb0 to 0xc4831ff8)
[    7.194974] 1fa0:                                     00000000
00000000 00000000 00000000
[    7.203569] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    7.212157] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    7.244367] Segment Routing with IPv6
[    7.252512] In-situ OAM (IOAM) with IPv6
[    7.268736] NET: Registered PF_PACKET protocol family
[    8.121842] ------------[ cut here ]------------
