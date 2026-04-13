Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF84E555
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 11:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080558; cv=none; b=OefajLq49zXj6DBmQq7sHwppjHAmfJuMqGlMNmL5Y2eIZWO60e0iIemjNM18rYNTFPxlXnLQSXd2l3xUuNFxoTxB2eCgLS37AHg/2E33PsFVR2YX4BDQ/VDZZBpX0wvN4GH/OI36LPqMrZ0Zo8oAzfVtkegzYJeXHuSd3V5zvUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080558; c=relaxed/simple;
	bh=NLXHhPcIGMdge6o1caxWBwb7uAty/542sLjb35QkF88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QiARNdQxoqnVYKz7twlkzkhrw1UY33Kx6Co32WCWC6ANWsk1+49Ll9DT0VMir3CVbbBMtK7ZZjYyMPsLurwLYMDGHMrJaTfII7+OeKiugkCNuzPOkWvuTRXq+qfyLIdJ7ZsRIF5Oy2DIj+I0bLj2MaqX+SW8tvZR3SN8W2i2zHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=kGfM2OQm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="kGfM2OQm"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so69051365e9.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 04:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1776080554; x=1776685354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IeQMeY8LdNwnUo62ZTj/KNq/NGfRGEOBpJ7zKrUgHkw=;
        b=kGfM2OQmC8kce2e8/yUmlj4txrzQbwFGnU4dMo2N8LqsGf14SK1Y/XYe0sVJScSNIj
         0ANBXPS2vyS3YW37wAjTRF81UxSApIuPMtlvIpHbUBebrbLuZuoyzownp44xLLJqWRg/
         2TLKqtOeDscG1FRPxIdpKXhpd72nKNuFzkomCfM5GrzE0bK2S1Qwr+6XmZE3MpyTuBXw
         cnL1WNCzfLGO7QZm5w77+6w8K3Md2s7RWS6VHatkMD+yw5rZA2qwczY6hvgOGiEwj/hR
         NDcEalm9lY/Bnxcw3IKwlAazQhRQARO6IqNY4NlSqt6rthdQgWM0KPjlbZyJT03Nd8Ai
         nbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776080554; x=1776685354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeQMeY8LdNwnUo62ZTj/KNq/NGfRGEOBpJ7zKrUgHkw=;
        b=qElA7AyBptzO2oGDdmZ/sRQZKLDpwrdk3DQ19LJB4MNQYh0F4gXAJ7eUJWhHo2BbMH
         +q021s9WmfU7gzIlwE7iSs7OCaSUIY851PkX7hc/DMbM0Ew4ZeEQMIUjeoMC9HKe33sU
         9qu9Jcv3JTrda2TRUcAK8aD7qwhY8IlpBoNKRjDimdUiqkVyJBOetel59oKDw2/EUYlK
         MfFMHFKEzJyLwCwSa22lTYUoVDyWvlK+K+hO9A6Wfd4EabOZoydjlCtNm5nafcLlcpAe
         Mi2p7stKnjz0L11rIcTZ/pDcykGpWyB9CwNzXXAmtJs+ftgS6TRAGY7yjH6KlBuBUbN0
         qCuQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ML+OMLdaxqJ6dZ5a3Dm90rW8KEGMBOrt0xb7S/bgSTNdBr8LpvO2eJsa0327Zx2xJPfyL1ABNdIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxvrzC7aCqyMNwWCOFomUlhC7zbmvwTuoUn7cIcqgB+tldaSO/
	eMooBR2Qyh5Tb14l9Vx+IqiANZhNeeSDaLJp8yzCougtRZWVq/QnJLEY27ADzkqfAnmNnu7/e7m
	r/9wWnQ==
X-Gm-Gg: AeBDiev0vltwZgtLDfEuEi/IjjFWFSqbMj3wblDSBeifm+IaYSfZLmaNgrPdHF6hfnj
	0xRPLe4EK80MTAlTcaN2saJNRy2oBJGSirbxH7ga/J23Y7bDktfnyalbRNzBZWsI2XVr0lGvTIW
	XyynXIMTs98pccwW1Jq/Or9yoFDttqRK1KMUR0pEQ1UgFpw/TpC7QenFMt8mBMN1rNdWm6ZTCMA
	oqlu6wmX3bRDjTrBlHgtWLy+AGq7S6ZBysIITOArpfku5dZLaCFjEVi0JvnFVSU9FjSAewGTAa1
	pE9q3awFVAIDyR3J6D5CjwRrDb2byK3Zt/AQpSGq4aEUlhzebBZCwEH/Mo7bWc6BOJphwZFB4Vi
	9BmnxTWbKCLsA0yuZMrfAQ7s1G/bK+eF9QRfSj159eG8b94+RURhRuXi4gGkZbjx2piQimQmRSm
	8n5D1O0Dz97kg2VHjQuv66NhQ4NbWtlDFWaeI7mf1hxzC/V5KrGWqd+NFCvj5PYRXMBpuviSOoo
	DpcvlE=
X-Received: by 2002:a05:600c:4f95:b0:488:be58:bb5b with SMTP id 5b1f17b1804b1-488d686c443mr182009275e9.24.1776080553975;
        Mon, 13 Apr 2026 04:42:33 -0700 (PDT)
Received: from horizon.localdomain ([212.105.128.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b46ffsm126301165e9.6.2026.04.13.04.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:42:33 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Rhodes <sean@starlabs.systems>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Ricky Wu <ricky_wu@realtek.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-usb@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [RFC PATCH 0/2] rtsx_usb: runtime PM fixes before tray-reader detect rework
Date: Mon, 13 Apr 2026 12:42:29 +0100
Message-ID: <cover.1776080528.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an RFC for the USB/cardreader side of the rtsx tray-reader issue.

Assuming the separate resume-reset fix has landed, this is the next step:
clean up runtime PM handling in the USB/cardreader layer before attempting
any further MMC-side detect changes.

Patch 1 holds a runtime PM reference across transfers and marks the device
busy afterwards.

Patch 2 avoids issuing USB register I/O from the runtime autosuspend path,
which can deadlock runtime PM and leave the device stuck in a suspending
state.

The remaining tray-reader false-detect problem likely needs event
qualification on the USB/cardreader side rather than MMC command probing
from ->get_cd(). Guidance on the right place for that logic would be
useful.

Sean Rhodes (2):
  rtsx_usb: hold runtime PM during transfers
  rtsx_usb: avoid USB I/O in runtime autosuspend

 drivers/misc/cardreader/rtsx_usb.c | 49 +++++++++++++++++++++++-------
 include/linux/rtsx_usb.h           |  3 ++
 2 files changed, 41 insertions(+), 11 deletions(-)

