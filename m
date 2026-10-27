Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.98.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103863;
	b=MR4P0DYLbgItTC4yWEffai1PEtFHzoi5TW6sAsAW2Tkacr9DbOjvtp46rs80FgcsD8CS
	 4K6/yYMTslzODNCcu7EoYJtpF+WOmwALWlalop4bTAF1katSkk1MINr3pWvk/o3modXqL
	 lbXeHgGvKdzimkDqIxFj55v14sXN3MANLcBTOi34SYbk+q8/V+SQxzCZpWeNlSaqiPZgC
	 vygd40G5PZoXduy5jZvH3WfU1Ad4vhdaiHmyjzK4SxE6Ezvf7+0AItHGTu1wnvZfH0g47
	 re07hG1Ur7TdzjEheeOXzhiCx7ljKa6RJJo9Mx22rShwdgp+v7EIhNwUGrWQwHJEvXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103863;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=IABBLZ2MuXH1VDlPsfrOgFYgNPbo03Fju+v8Q1KHRoY=;
	b=vxjMGJp7ZxYoH6lkUwbtCDiCR4CM0SSyxKXNrOhFvsPgOzeKqVmgrEfmh6hTfnUPsGYf
	 xpHj/yE2+gymGfn2+say7i0OYfeKyUNa1Q48kNSkhNj0qkLqtib6wSMeOKyXXHLMMm04F
	 OFlcMg8VYN31E/PgMNcBX5WPQTiTq9Hcn3maBlNUph5ytnFCqlNnKZRzTv1hL/3by14G3
	 FcmE1bEpH1rPibRUe5epbd4uFL6jlyQX6b60cs65IrgN2GDxX14UxIN3BYtKfFMKziYLH
	 E+CkHoHoKO6K/dsVAtH89AVKjNZKPBgHyEliqQn009Rn6MVjtkAGvayMgig+ZtNB1Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=rojer.me;
	spf=pass smtp.mailfrom=rojer.me;
	dkim=pass header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=h9DQmv0U;
	arc=none smtp.remote-ip=144.76.98.110
Received: from mail1.rojer.cloud (mail1.rojer.cloud [144.76.98.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24836606A31A;
	Tue, 27 Oct 2026 12:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24836606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rojer.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rojer.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=h9DQmv0U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rojer.me; s=main;
	t=1793103859; bh=SBqYKrX22EfzC4b6zLP07G/ly6L6eXuWm9fXjlpGnSU=;
	h=From:To:Cc:Subject:Date:From;
	b=h9DQmv0Uepr9wNBoK454wCrAb7OoyyKhPOMGTuBMcYScd0soPNrbWe/qyBklT1W88
	 4O/US5vsm0gisMbLffBuVVnvS5vioHj5wJyR8P2dq2vp7oCgG34NTHBgaOD3cqWtdm
	 p/RyFvsRiu6/LhUPCb4b75U8AQWGhP+V8AVdpGSodn9PEHuGyxCIWrA/qUiUWJiPif
	 4S+KNUnl4NJaWzfyDVFIBxl7cCtf7pjxXrZv7Im2q/sRANvF63V63ey8GUshlSf9bY
	 VPx1XQQnm0GslBaEDB/6h5sWorO/XFsUgse5SBRkmRtD68h9+UprlznazLfVb+3lfX
	 EvZhJ13cJOXqw==
Received: from nbf.lan (unknown [31.216.115.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail1.rojer.cloud (Postfix) with ESMTPSA id 2FEE21202E1;
	Tue, 27 Oct 2026 12:24:19 +0000 (UTC)
From: Deomid rojer Ryabkov <rojer@rojer.me>
To: ulfh@kernel.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawn.lin@rock-chips.com,
	llj@rock-chips.com,
	Deomid rojer Ryabkov <rojer@rojer.me>
Subject: [PATCH v2 0/2] mmc: core: sdio: fix UHS init with fixed 1.8V vqmmc
Date: Tue, 27 Oct 2026 14:24:15 +0200
Message-ID: <20261027122417.954133-1-rojer@rojer.me>
X-Mailer: git-send-email 2.53.0
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

The Realtek RTL8822CS SDIO Wi-Fi module on the FriendlyElec NanoPi R2S
Plus (fixed 1.8V vqmmc) reports S18A = 1 in its R4 response although the
bus is already at 1.8V, contrary to the SDIO Simplified Specification
3.00, section 3.1.2. CMD11 then times out and the module ends up at
50 MHz high-speed instead of SDR104. The SWT6621S behaves the same way
and, without patch 2, doesn't come up at all.

Patch 1 makes SDIO init fall back to high-speed mode if UHS init fails
(e.g. tuning), instead of failing the card altogether.

Patch 2 skips CMD11 when the host is already at 1.8V.

Tested on a NanoPi R2S Plus (OpenWrt 25.12, Linux 6.12.112 with these
patches; applies to mainline as of 2026-10-22): SDR104 at 150 MHz; iperf
as a 5 GHz VHT80 station goes from 70/29 to 123/125 Mbit/s (rx/tx). eMMC
(HS200) and SD card on the same SoC are unaffected. Longjian tested
patch 2 with an SWT6621S.

The device tree part for the R2S Plus is sent separately to
linux-rockchip.

Changes in v2:
- 1/2: the existing CCCR fallback resets the card, it doesn't
  power-cycle it (Shawn).
- 2/2: note in the commit message that this relies on the fixed 1.8V
  supply being described as vqmmc-supply (Shawn).
- Dropped "2/2 alt", the alternative to 2/2 that kept sending CMD11.
- Collected Reviewed-by (Shawn) and Tested-by (Longjian, 2/2; his
  reply didn't reach the list, it was HTML).

v1: https://lore.kernel.org/linux-mmc/20261023232813.2983368-1-rojer@rojer.me/

Deomid rojer Ryabkov (2):
  mmc: core: sdio: retry without UHS if UHS init fails
  mmc: core: sdio: skip CMD11 if signalling is already 1.8V

 drivers/mmc/core/sdio.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.53.0

