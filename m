Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422DE3955DE
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469858; cv=none; b=J8PeTF6l3WhGg+DrBWtGyUKEeWFnKJy0O5ZQKGvGTcdmqe8o4cObamujX7SnYaUFdIoRvAUHrMkIGFFwy5S4FFPAgmkfoy2PGJFrBGbPjKECWYTDNaq0lOa49e5awh/JiL7fYQr3BgeiTDjuMWS/95GHTi0LkL1Ax3OO9B2pX9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469858; c=relaxed/simple;
	bh=AS2+INrOBStqK63O2/21Dt1E4foxVMxhwL58vr7lqhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TqkmFwHoQfjjDmM0xjPrKW6RSo6il8soBvc8MvupJ1odIeRHnROKEr3vPdnlt4I+rJzM/P1vcwKn80xJ+D9Jq7LX4N2N9BRd9lV7Q/oB6EamCAh8Q40Br9691eyDWHFau+UFTDpaKEuB4qQ74gvKQWKIumRyoB77gp5cNMEmsO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bah/5tO1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bah/5tO1"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso23373285e9.1
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 23:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780469856; x=1781074656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=obmKHwd9QvTYySNkKeobznebi3IouECClMxpBzhWwuI=;
        b=Bah/5tO1I0B6KxLxb+bfjwMwbCT7xdWkZTGK2ScfpW33Carj0UxrpaIj/D4OtXk2b5
         UIJXBfJnnrXSpWXl/o+NkwHMEK6xjpUcsWqCf3ayX5WHgPs0i3/KNNeAOD1X0LoEj3Z+
         y69UhHrpotHHJuIpkqxSPENx+D+9KDaKbLB1diePchFnJFq+JPb3zQD/qgr3XzvgDuWI
         /GGLsrQO+0qAlsP32enSHW94ZU3UkoDXTlJrMDz/rdLksfk13yMovhesuXfNsj0+BC8m
         9juFivT0/j0BBcoCljgTTETnPIPZDwAME6+TVrImUq/WAKyhpDVGxM1lRxG8tN3XNtfr
         axsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780469856; x=1781074656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obmKHwd9QvTYySNkKeobznebi3IouECClMxpBzhWwuI=;
        b=fiNK70QiFdjEOMRbV9/+0N2AeS75hAAlXUCtr7CfwBNvDMjm9PRratt6gA0yqxRd1A
         A8yos6WP33d38eyICZnJLDuXhytRi6XoarE9VTBotpPIFXNu/Cf79zE45UE8sKyj3qvR
         EvNFh4kloKeRP3neKpwEqN432/DFcykhDykv/jaYrGy0F25dJM5oatdNf4y7qMHF/yAo
         PbGYmsrR2ZGWzU8eY0T8wqn7akC3RSF6n+/Bv+ZAoWkq1WoFlqG5n2vbJC3zkyfRF+M/
         yAOozAASGMa2W6EJr2eNzi7ZoYY+qIDl+gWNKzu90jMCPEbrK9ljA3gUHI1PwIzlV1LC
         YUNg==
X-Forwarded-Encrypted: i=1; AFNElJ9mCHT7ixX06yL7go7wYeNY94mL/LrQxxBqKsOcBM1FefiQNAPCCnHGg492F89LUJ4WfVit+aORDA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbepZ10GyqJbGMdmWq3Uo1Q1jl2vl7Vmyfmw/wP6bqugg2qT7i
	yT0xJXaaGSPb77M6Pgqp7MX3bjgK5Jnc2iulue6ZRqaplCTWbnzB73EX
X-Gm-Gg: Acq92OFuqihLcd0h/VOwMtpUqZ+4ettWEUyc65kdcqer4j0z6WuoJnsTkkjsk0zsrMR
	AgBXnvbTdc/N27KyA0yqS0Nurt+B/H79RfNvGo9cogIsDX+0s6CJrkT/M6SW8U0MI9hUOFQACaa
	VUVdSeI7SRy71AonfjLn6cekkUP92mPGtcypGOlQ5UAbv/WZmrWXpZxNY5cdYX9wCjGxTJ3yKbn
	aOhak6ezMMgWdeUx9NALf0x2Dgy4WxzUl3PNMXFxbbf4NyWz4wgtexyo5fF1i4bMXyvuCJh5U48
	6rXgB/CtXo9dlkHIOIMQCiHxTY/np/SsEtvJfOOAtZRzS9v/wXhhJDFX5vvF83bJMb8T5DAqZxC
	SOQZKoQpeHZlGyP2HDsquwIH1dAawSPdozPCEeMyKAGwAmW1OXziHzn3IwqZSbKqrJhOXmKB+UI
	Xy754JtjnvzxU9eiQ3F8/wAQb5fEFHoSbDUjzedMI0+lBNX7PJTsKjQ2FgDTU=
X-Received: by 2002:a05:600c:c174:b0:490:b2a6:8c2b with SMTP id 5b1f17b1804b1-490b5eb82b2mr32533675e9.10.1780469855535;
        Tue, 02 Jun 2026 23:57:35 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:179c:89ab:19f6:9ba4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b79d90bdsm9001855e9.0.2026.06.02.23.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:57:35 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v17 00/17] Add Renesas RZ/G3L SD/eMMC support
Date: Wed,  3 Jun 2026 07:57:00 +0100
Message-ID: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3L SoC has:

Channel 0 supports SD and eMMC (including HS400/HS400ES).
Channel 1 supports SD and eMMC (except for HS400).
Channel 2 supports SD.

The SoC supports a maximum frequency of 150 MHz. The SD0 interface does
not support IOVS and PWEN in the SDHI register (no internal regulator),
unlike SD1 and SD2. It has an internal divider for all modes except HS400.
It also has a 2048-bit divider compared to 512 on others. Moreover
RZ/G3L supports HS400 enhanced strobe mode.

v1->v2:
 * Collected tag for binding patch.
 * Resending the series as there is an issue with patch threading from
   patch #14.

Biju Das (17):
  dt-bindings: mmc: renesas,sdhi: Document RZ/G3L (r9a08g046) SoC
  clk: renesas: r9a08g046: Add clock and reset entries for SDHI
  pinctrl: renesas: rzg2l: Add SD channel POC support for RZ/G3L
  mmc: renesas_sdhi: Fix whitespace alignment in struct
    renesas_sdhi_of_data
  mmc: renesas_sdhi_internal_dmac: Fix whitespace alignment in struct
    initializer
  mmc: renesas_sdhi: Introduce renesas_sdhi_hw_info to abstract clock
    mask
  mmc: renesas_sdhi: Add max_divider to renesas_sdhi_hw_info
  mmc: renesas_sdhi: Add tuning_delay hw_info flag
  mmc: renesas_sdhi: Add internal_divider hw_info flag for clk rate
    adjustment
  mmc: renesas_sdhi: Add optional axis/axim reset controls
  mmc: renesas_sdhi: Add RZ/G3L SDHI support
  mmc: renesas_sdhi: Save and restore IOVS across suspend/resume
  mmc: renesas_sdhi: Add RZ/G3L HS400 support
  mmc: renesas_sdhi: Add HS400 enhanced strobe support for RZ/G3L
  arm64: dts: renesas: r9a08g046: Add SDHI nodes for RZ/G3L SoC and
    SDHI1 pincontrol on SMARC EVK
  arm64: dts: renesas: rzg3l-smarc-som: Enable SD/eMMC on SDHI0
  arm64: dts: renesas: rzg3l-smarc-som: Enable SDHI2

 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 101 ++++++--
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    |  73 +++++-
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   |  89 +++++++
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     | 199 +++++++++++++++
 drivers/clk/renesas/r9a08g046-cpg.c           |  92 +++++++
 drivers/mmc/host/renesas_sdhi.h               |  25 +-
 drivers/mmc/host/renesas_sdhi_core.c          | 226 +++++++++++++-----
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  71 +++++-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  67 ++++--
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |  74 ++++--
 10 files changed, 889 insertions(+), 128 deletions(-)

-- 
2.43.0

