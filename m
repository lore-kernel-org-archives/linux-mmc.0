Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544994;
	b=5PanVMO2F24E9Pw0cvl4nply1+/CD6TlIskW79XUMyyjPOG/SiUgivp+JyBtW5B53xvY
	 C6eVsQue66PQV4EzvlHZNdws3P1FK22aKOujXnoQplOFkuKy/fR80lTCVEIJLY6e47PaS
	 azv0eAUwvPgRTr80SNDojhCUcl3uJ5o/0jKoyZjbtMNOCih50anxeuUz1GKtTsLYNo+Wd
	 KaNGtV30XPiq5vOU5stChDcSApBHTs9bMtGhqf/FmAZlGjrKQaen7/LnnoSDr1/YRLw65
	 E+ghzhFNf2anSutgGgILYDSsSGAB4P5ht+mZtOTERD4YM/BmMsdVN762Oe9PxLucUsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Ittty37viKI0N4A2/brVrgd6thQXFltnKt3K27elQic=;
	b=FllBYjd0xVcPJjQ/jZulryyBeU6194Zwr9l2yVFigUiNj2nHlB0FQXufv8a3y9bIi6FN
	 Q0kKRmLruTB910rHOwW75OyLhjoq8SgDb+s6sbivFqOeyKA41ulQ9g6EndI4ZQ8TD2AsU
	 mQK0NKkOD/UzbIs7eoIPXXH5GJ8L7mz2Z6OvEDfq7l7gIcw1pYS2me5HHu1E1J9YIeZNK
	 fu4zPJxsvAw+WoQyQ4pmWUXxI6tdDgksNdJ++zl+IVBWMGk1HwM7WANCeHkPlLm/wFAKz
	 OEXWtCN+i72LUMRervCg5hCyOLgvMEY8DyUSppJ+Owker7nBNJB8/XhSo70HeZ5pBGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l7eXsifa;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBDB606A32C
	for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2026 18:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CBDB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l7eXsifa
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b55f4f3bb8so2639320c88.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2026 10:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795544993; x=1796149793; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ittty37viKI0N4A2/brVrgd6thQXFltnKt3K27elQic=;
        b=l7eXsifaia6FAU1KA7wQcNQQpdIszADjZWQHgPLYJZWS/GeLMhNXGzMQFixmreno4k
         CbEWt6Nr+9nS4+ydsn/c+tj6csV0lq3HJ6Z0q+ZYCeFb/M4R398EvEwef2GknRxiAD3G
         DG7tKBBgv35NMerGWjX4p5n4g/gxnx7UMx8uqv0tgw6XpmSW8cQpTimWQ0PbGw2rDMoR
         neq2agFQO+hOMte9ryVH8Ead1WAFdjXCngqWN5MHoN8fNFlK/w/iYpwRhFlZGHRDYTgi
         LHWZ+LMVVYEg5KRmll1SzGPgrG3y19e0SmDib7Nuh9pQRjSUk7lk/fXxeFtHSawHRttN
         vnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795544993; x=1796149793;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ittty37viKI0N4A2/brVrgd6thQXFltnKt3K27elQic=;
        b=mKI9do8nn6y9z8vw7HKyUiZSBiNlQPPKNv0P4fGP0rRSfOarphPXU1jh3W01ZW6ckd
         YxV4nyBPesytqZqklJwugsVcAuCg4v9SuvXlu6LqZ0weiCUTFtjlcGGw0kOKWOBOyP80
         PsPru9WiDvh/+BCMprc5isosEYx+2NOF1jN0UloAdE+iqiQkuApjADDqzgGZMc2Z0PvN
         s3aWYGJFDjjZXVDXN+e2XqpY59WIchQGyclLCstxR3dtRDW+9DgZ4UbPEKGUiBKhL7uL
         OG0Q1ytq8zyHzzFESuhRjOSWaKrbyRp6hK2uEhOZqJ/o/lKU/DNgE4yTkf+6OFXM9Hyd
         4ayw==
X-Forwarded-Encrypted: i=1; AL+hErGGhAjThcsIiMnXKk1JrA2BWbEHB7lxl5h3ie4GKVbUuLL3JzP20jyN0eh9lVLr8zg3Al3QAcB/J1Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VecqacFd1JSvqdUo547sfzaxiiH72oKUY87xZDBWs8wPbGrcL
	gth11yfctPIYEiPDZpwCuLVv4zPx8qhpvxYi39MgoSY7d4JhpRmuK4MpNYC7vH6G/vsAGXoKvrh
	hf0A8Q+HUM1xnlQ==
X-Received: from dlbrd6.prod.google.com ([2002:a05:7022:f106:b0:1b5:330f:621d])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7023:a41:b0:1a3:87c8:7efc with SMTP id a92af1059eb24-1b5569026dcmr13385596c88.39.1795544992423;
 Tue, 24 Nov 2026 10:29:52 -0800 (PST)
Date: Tue, 24 Nov 2026 10:29:11 -0800
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124182911.3886897-5-wusamuel@google.com>
Subject: [PATCH 0/3] mmc: sdio: avoid waking idle host during suspend/resume
From: Samuel Wu <wusamuel@google.com>
To: Ulf Hansson <ulfh@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Ben Dooks <ben-linux@fluff.org>, 
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

mmc_sdio_suspend() and mmc_sdio_resume() always claim the host, which
runtime-resumes it. If the card keeps power, uses no SDIO IRQs, and
nobody holds the host, neither function does bus I/O, so an idle host is
woken for nothing.

Skip the host claim in that case, saving cycles and reducing suspend and
resume latency.

Patch 1/3 and 2/3 are setup patches for patch 3/3. They remove the hidden
dependency that relied on the SDIO core always waking the host during
suspend and resume. Patch 3/3 ensures that the host is woken only when it
needs to be.

Comparing with and without this patchseries on a Pixel Watch 4:
  - mmc1 suspend + resume: 11.59 ms -> 0.01 ms
  - sdhci suspend: 3.75 ms -> 0.002 ms
  - dpm_suspend median: 38.79 ms -> 32.51 ms

Samuel Wu (3):
  mmc: sdhci-s3c: runtime-resume host before system suspend
  mmc: dw_mmc: restore IOS on runtime resume whenever card power is on
  mmc: sdio: avoid waking idle host on keep-power suspend/resume

 drivers/mmc/core/sdio.c      | 36 ++++++++++++++++++++++++++++++++----
 drivers/mmc/host/dw_mmc.c    |  2 +-
 drivers/mmc/host/sdhci-s3c.c |  2 ++
 3 files changed, 35 insertions(+), 5 deletions(-)

-- 
2.56.1.831.g720f3f5937-goog

