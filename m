Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793586569;
	b=COUsOGBpFAAvaVRW2aFY7s0Uh+R78WJL73WLPhUsfePjSkF1Di8x1lyBLLvjPBizHj5x
	 JpYhNRSNVgYELJk1eUwoecZ8WFBcXuMyrga3dHRY4jWqT9yg/vcfzAcFv0XWOfYKjSAUC
	 +vUbB8clK6qZ9owef/23RR4PtJnMITApLpv/SZ/1sQ+87s5OMWu0yaUFxy8L9qm/U3pGV
	 jw+eNNkjlZqnnrhssTP7Axu1nTRNbffFDeEX2I1Vdp+D2jNdcePwPtMd0GOXa8l0++JS9
	 OK3SBExPiMYt2nBC621tGmKmiMZSrFUrcZ6t/Z9d8L9SmEjJcF6LfrWZ3+/6v14gFIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CNj2Qek4c4lAN/UKdLhSW4xMEvjSJqkN+NgM/ZlaTKY=;
	b=fUXRmEuzDW9ovriMuYJqRss9ciaxOyjiC+P8AB+jH6muLeGeb7hc3PsxUw0GQujfQqFF
	 VJPIIzmfAD6euaxXtdtAoGV/QJf3rdzBQHpijBSY68adwFDBAyP6SzXOC60bBF+DkWxO8
	 v7H1zJF+qYUkFySRQBWgQt8QUJxLSaySVljdbeiF/mquuGYIJ7vtuBuAZroXi0+yjxcZk
	 77+Rwd/BuwaS9YxTKPnQEo/2+XnmuPqlbiLKznSh//T4gfSUweodDe1U+V7nOv0FC5oLJ
	 TQ9JBPfzjROAPzhaOY7UJtz9cPHdsG9OIu4mK15DcUB65mqpOJtVQ7ybg9Po2hjA8kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y+nWQWh4;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4DB606A324
	for <linux-mmc@vger.kernel.org>; Mon,  2 Nov 2026 02:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B4DB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y+nWQWh4
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a070b3f44aso698869b3a.2
        for <linux-mmc@vger.kernel.org>; Sun, 01 Nov 2026 18:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793586569; x=1794191369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CNj2Qek4c4lAN/UKdLhSW4xMEvjSJqkN+NgM/ZlaTKY=;
        b=y+nWQWh4Ag+E4v1W1P0P5c2dvZYL37Y7egYC9FloiPZuyG19Kz7u3mxFdwAmq4khDM
         eF8HKV4T6CGa0NetbdoCY2WvrsjNRCOTHU0J7+lqXK4q69ZxwT9kKOWeuM5c+XdaRqKR
         FKoxwp4MIeoeqkeMWoUb7S7lFCCzMrFrSVxuPBrpZDm4YSHPzcWOtP/Iy4AInR2dWFFa
         zPM79/6lbeaH2JRpzexWp+J64EJBQdkbYP62JPr7/pCF84NkBd7dYnJJtUaCfK7qlBbK
         x+/iramOiP8KN9l7JWTZqrvqyB8zj/jM6UFkTN/ia+uVbV8Ft3T7gTs+0Q5d3Wh2jPic
         QX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793586569; x=1794191369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CNj2Qek4c4lAN/UKdLhSW4xMEvjSJqkN+NgM/ZlaTKY=;
        b=qB1BpHiguF1qJY6P3/401YSWf32iYf+QFjmFMpOOEPYbIfNGnBkhpkae/IK9M1gK6d
         e1gJ8CMbL7vOPfwOdaRmWTlc0FRP3mxrM/tGS4n0F3umgHyEqEInRMiNgszr5giJENnC
         oUJj+u5XY6/41s7ndtPKRr64aiQ55u/7dXVxYA9/9Q0RcVyDFlV/2DRpX/v9K5Ppmf6L
         1wWgeMnDysE/UI5yvY/r+p98iryLHFBAE5chxKH6bWxVPAtEAeKf5JPceXInHU0p9Zqw
         QwuZFW04yJ3YXB6LRG61hElLYwFBQO/g1hOyMwm7c4YTysVKcbhq6uZoMcsooANLcmGi
         eJsw==
X-Gm-Message-State: AFq9FYK/Jn27BKrdomxA3pjkBT1cxTfb/YqR6l083GDfgLpgIAZtQQEV
	bWSXpmRDO2lkN1QRiiszMPvH9X+zwm7blqOIqfb37n+8tvBYQCxLtzc4
X-Gm-Gg: AYBFou3YAfLeW7npJx4bowlzaWGMicLcMp4dPrPN6NxwbMXF/OIKnNzSWSk4qN/qudD
	zanA0nT+domKUqqwJChT0bEpLOjj6OilaWBsxvE32bJy36oskOHOcQMl/yQr1lIytDyQBBQnLfJ
	0M8TpSdbXegCvnZtjUT0ibVcXAXcDSsuQJgQnY/pMNoT3MgAXypni8xQgs/6veCpr7Vb4T1QLgd
	R0wc9vE6rkxqh10L1JD/552ft9x4GR2JOK1crBlyM5RJJI5PZa+fO/RatA4YfEAOGJNHsu5hm+H
	Cg9oxICwLAJ+j2zniM0tmVf4ltkGpApGHj8wSerUIpFvlA5FrkXfkcUsMkXAHCDKfqMcZOLwOeO
	35mSdDzz89ESu9B3egu1d/nYhB3yp8LIMj441yz/lx+JOczzU9t6wwyijpJLd8B2dbtZd2jonbk
	Zs4mt2LgeCDH1vr1R2kmatJhHA20/M5m2UlDW51hFPWizJMSH524+6NgdGVV4sdqgIodVdC88uN
	aREiO5t6SglrBePJxYHokjdJ6WD6WF3zQmkRa3N56TAuazJv1PzV+XqM5OaN2WL3ihIeWWbnqp7
	bDc8nLIG41F9HyrWS+gLleHmVPWeymIz5oN3qc2Bq6lrScXc
X-Received: by 2002:a05:6a21:6f0d:b0:3e8:b7fd:628f with SMTP id adf61e73a8af0-3e928c8d3d8mr7174182637.22.1793586568889;
        Sun, 01 Nov 2026 18:29:28 -0800 (PST)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb09814cb9sm2441382a12.24.2026.11.01.18.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:29:28 -0800 (PST)
From: BeaCox <0xbeac@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	BeaCox <0xbeac@gmail.com>
Subject: [RFC PATCH v2 0/2] mmc: dw_mmc: fix teardown races on remove
Date: Mon,  2 Nov 2026 10:29:22 +0800
Message-ID: <20261102022924.51343-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101063719.88570-1-0xbeac@gmail.com>
References: <20261101063719.88570-1-0xbeac@gmail.com>
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

This splits the dw_mci_remove() teardown fix in two, because the two
objects have different lifetimes.

1/2 drains bh_work.  The race predates the BH workqueue conversion: the
tasklet that it replaced was never killed in dw_mci_remove() either,
going back to the original driver, and commit 921c87ba3893 ("mmc:
Convert from tasklet to BH workqueue") only replaced tasklet_schedule()
with queue_work().  The patch therefore applies to 6.11 and later,
where the bh_work form exists.

2/2 cancels the central watchdog timer, which is new in 7.4
(ce0043b9a302), after the work has been disabled so that a work item
that is still running cannot rearm it.

v1 incorrectly used 921c87ba3893 as the Fixes tag; thanks to Shawn Lin
for pointing out that it did not introduce the race.  The code is
otherwise unchanged.

Testing is still limited to W=1 object builds and a userspace lifecycle
model; no hardware was available.

BeaCox (2):
  mmc: dw_mmc: drain bh_work on host removal
  mmc: dw_mmc: cancel the watchdog timer on remove

 drivers/mmc/host/dw_mmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.43.0

