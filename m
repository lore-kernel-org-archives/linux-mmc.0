Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.98.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798102;
	b=r6Nh7+zll4H4OC2XQWQ1srW7/peVMe5B+WGoKBwGwJFupa2dALtm8PrpW7o6+xQYrrVp
	 T86Id8PFonXQH+4ulUDFdc+8tcylcqismKs6j2kCqMR6O4AskFl//GhBCx6gPNE+ELTAu
	 pjzpCPFiA/4cnaFqxSs9NlD99InezEsiJh+3cRAB2dMfClIIE2B7MSP1p7HGXfOt4XdrX
	 ps9YPq0iP9dCD50QBvmagq80IYsx8tJh65y8dY3DUcyLz9q7SaSCx7dleDzFs2wzj5Z1s
	 oyhYFMv/sX/CdEs3CJ94bgUlIPHVt3aprD7swYhFKv6t+jV5uvbchUlWmEuxBdXrtwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798102;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2oDtGQeFWEGW+Erv6ydtyhxWcHVaF087OwMHXZsQHbo=;
	b=qJet02+ZCPuf/zVSdtyAKUc4ReyXQrtHQFkcN4LpRFBHIsPO0r+oCrov5ejF+fwIuBRB
	 qV+nmi/bMyrzpXxWuaZCrJkvX+cuhwm4G7PcC5ldrRibGWduO0Sz9HXtmSEOmL+0za8eP
	 J8nwKe0dQSsDzugsQ4iSHcWnzAEt0s6FYTuAdbYZaACp/YmFv+ihAJNV77wW5PWvL5gby
	 jfJSzJhlGNyn2bvhG658d/YOCAXYq6ZYkrrZRQ+fKxdX+9bl+EXtgwi53SEg0F2fr0GbD
	 YSmPBiRk7le0ngjE87r+5kmoyYyJpX2gVUgcpDIDhiHN84rOmOj9mfpKv4glUnMduCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=rojer.me;
	spf=pass smtp.mailfrom=rojer.me;
	dkim=pass header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b="hGBrJ/FU";
	arc=none smtp.remote-ip=144.76.98.110
Received: from mail1.rojer.cloud (mail1.rojer.cloud [144.76.98.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80222606A31A;
	Fri, 23 Oct 2026 23:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80222606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rojer.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rojer.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=hGBrJ/FU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rojer.me; s=main;
	t=1792798094; bh=ooy2sH7yBbGaaQdzqtuTjYua3SzGrESVaCclDTeDifg=;
	h=From:To:Cc:Subject:Date:From;
	b=hGBrJ/FUccx0fpset+x/woKXcpFpdpfAFQZtKjtNlEj6fT0KiUc56PTJIhlUUYR87
	 tA5WT80Re8mwrommqJAExDMakIit7HhRNfz5+WY6LOEgEtkZBKzIGP1lpqd1Y6pH8o
	 XTqH7+nTc4UULgNDLVhBYpdW7jeLWVSpMzOHS+MUF6885hqoC0VDfZhVJEuRnKM9LO
	 2HEFvFBnqDszLEhzW1ZJ2GqrYDt2qTZ6Z8Drdt2gLkT2lR2SZ5xXqxbXF7KisRvyOn
	 znRUA6jYm6wfDcUO6h86EzPZVKN+17wwv6EKq9hlru1PQKv8quEamxNOO8Q1LNT86c
	 cUGqcmyKdMl9w==
Received: from nbf.lan (212-5-142-134.ip.btc-net.bg [212.5.142.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail1.rojer.cloud (Postfix) with ESMTPSA id 30660126B27;
	Fri, 23 Oct 2026 23:28:14 +0000 (UTC)
From: Deomid rojer Ryabkov <rojer@rojer.me>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jensen Huang <jensenhuang@friendlyarm.com>,
	Deomid rojer Ryabkov <rojer@rojer.me>
Subject: [PATCH 0/2] mmc: core: sdio: fix UHS init with fixed 1.8V vqmmc
Date: Sat, 24 Oct 2026 02:28:11 +0300
Message-ID: <20261023232813.2983368-1-rojer@rojer.me>
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
50 MHz high-speed instead of SDR104.

Patch 1 makes SDIO init fall back to high-speed mode if UHS init fails
(e.g. tuning), instead of failing the card altogether.

Patch 2 fixes the RTL8822CS case. There are two ways to do it, and I'd
like your preference:

  2/2      skips CMD11 when the host is already at 1.8V. Simple and per
           spec, but a non-compliant card that needs CMD11 anyway would
           drop to high-speed mode (it keeps working thanks to patch 1).

  2/2 alt  (sent as a reply to 2/2) keeps sending CMD11 and only retries
           without it if it fails while still at 1.8V. No change for any
           card that works today; costs ~0.85s of boot time on affected
           boards.

Tested on a NanoPi R2S Plus (OpenWrt 25.12, Linux 6.12.112 with these
patches; applies to mainline as of 2026-10-22): both variants reach
SDR104 at 150 MHz; iperf as a 5 GHz VHT80 station goes from 70/29 to
123/125 Mbit/s (rx/tx). eMMC (HS200) and SD card on the same SoC are
unaffected.

The device tree part for the R2S Plus is sent separately to
linux-rockchip.

Deomid rojer Ryabkov (2):
  mmc: core: sdio: retry without UHS if UHS init fails
  mmc: core: sdio: skip CMD11 if signalling is already 1.8V

 drivers/mmc/core/sdio.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

-- 
2.53.0

