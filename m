Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53198341057;
	Fri,  9 Oct 2026 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565402; cv=none; b=goV+pwWijBtIvv+N59ZzZfZtxtRaeCb4AkRMraLMt6BCC+PUgVWgFQiLVN1UZ80PYOqJstTLBuZOA/L76sqQnKr0/mLR85eZCsFrshAV1K8ELkqkdYV3D5+7SWm+b89spybsLR63lxYwCxxBHafwqAFLTRyq+l24Eu7htw7lkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565402; c=relaxed/simple;
	bh=sLav8eVPxAn6w8jYJTPMsF+9TZLNLRgeAX9kWkuT/Pk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c9A2aE0A3R7M1n2BhpqzTBgt5xuOnY4Vml4eoKvOK1BhKnNf+q99RizvMneMQ/SmNf+ZezowyBVDdOXNLtJ7kzaqIshQFEyUMFQl/OpMna2Sew8pSWZEbDCuzfBqiOnjh4BGkC2jKp1GCASUoeJnb3vPRDAqXX/digwS1iIO3jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tP9aM3nT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tP9aM3nT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F16DCC2BCF4;
	Fri,  9 Oct 2026 17:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791565402;
	bh=sLav8eVPxAn6w8jYJTPMsF+9TZLNLRgeAX9kWkuT/Pk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tP9aM3nTPaiAMpsUMrLLUazJoaiKDtWUXYsHyDlaWUFlN6MB4qN8vAqiGgvBSpy3+
	 dxD6cpiWW7n/gFCA1Z7UHec/poM0fnkB159uZ0tFaVOPAl9qPDGV3WT0l/xrJOuAOs
	 Qzii4RILLXc8K+9kx0bSWFlqYxFGk0ug7K86Y1zsNg582eEYJZaxfIh3FCU3i1yo9L
	 SuM2DTYharxz/q4g/9/gOE2IwfGlpyVQS7HmqNEVO1K89fT9GF+7Yc29yNqgYQZLGa
	 G8QeBrBe9ozHe0KgnBpG3tRdonGJTtZ7Lzm0iB82QTWpm9SWkgw/pMgU9IADJ0eteu
	 qmvpowWhQZIuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D39CA9EBD;
	Fri,  9 Oct 2026 17:03:21 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Subject: [PATCH v3 0/4] mmc: meson-gx: honour the busy timeout for R1b
 commands
Date: Fri, 09 Oct 2026 17:02:56 +0000
Message-Id: <20261009-meson-gx-busy-timeout-v3-0-67d0db3a8328@iav.lv>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEAeyWoC/43NTQqDMBCG4atI1p2SH7Wxq96jdGGSUQPVlESDI
 t69UWh3hS7fD+aZlQT0FgO5ZivxGG2wbkghThnRXT20CNakJpzyklFaQI/BDdDOoKawwGh7dNM
 IF5QoGqOVQEHS7ctjY+fDvT9SdzaMzi/Hm8j29SPKH2JkwMBUvBG6lDqn1c3W8fyMZOci/4vgQ
 EEqg6w2jSpU/iW2bXsD4Tt9U/oAAAA=
To: Ulf Hansson <ulfh@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2782; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=sLav8eVPxAn6w8jYJTPMsF+9TZLNLRgeAX9kWkuT/Pk=;
 b=kA0DAAoWMpeVi+pfeQMByyZiAGrJHlagWzI7bo5Nt+cNtDkGkwDWm1o1hF1//qB+AOiI7bqty
 4h1BAAWCgAdFiEEkMIo2mik1f1PSDfgMpeVi+pfeQMFAmrJHlYACgkQMpeVi+pfeQM10AD9Fk2Q
 i6ybpTs0fXmxG8U7wBgxv6DUPPE5GlAwmmM+/bMBAOGy8JM66cY7bKUQyOqzIcqUuHnAR9YJDra
 33NnskfwG
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv

For a command without data the driver programs a fixed 1024 ms into the
CMD_CFG timeout field and does not tell the core how long the controller
can wait for busy. Erase and cache flush then fail with -110 on eMMC.
Patch 3 fixes card_busy, which reported a busy card free; patch 4 makes
the core rely on it.

Tested on ODROID-N2+ (S922X), 256 GB eMMC, btrfs root with discard=async,
Armbian builds in docker as load. Without the series (7.3-rc6): 262
errors in 3 h and 68 in 2.5 h in two runs; the first came 4 and 43 min
into the build. With v1 (7.3-rc6): 0 in 16 h, 2.4 h of it under the
build. With v3: 0 in a 37 min kernel build and in a 20 GiB write +
fstrim; a sanitize went out as R1 and the core polled DAT0 for 523 ms
until the card was back in TRAN. On 7.1 with the previous eMMC module
a synthetic test (20 GiB write + fstrim) gave 48 errors without the
patches, 0 and 0 with them.

ODROID-N2 (S922X), 128 GB Kingston eMMC, 20 GiB write + fstrim:
without the series an erase hit the 1024 ms limit and failed with -110
in 3 of 3 runs. With v3, in 3 such runs and a fill of the card to 85 %
with rm + fstrim, 5 erases took over 1024 ms, up to 1219 ms, and
completed; 0 errors.

ODROID-HC4, SD card in SDR104 at 1.8 V: 0 errors in 5 boots.

The timeout is rounded up to a power of two: the field holds powers of
two only, and the timeout is a lower bound. MMC_CAP_WAIT_WHILE_BUSY is
not set: I have not checked that the controller waits for busy on every
R1b command, HS400 switches included.

---
Changes in v3:
- Clamp cmd->busy_timeout to the range of the field before rounding it
  up to a power of two: the rounding of a value above 2^31 overflowed
  unsigned int (Sashiko).
- New patch 3: card_busy reports busy from DAT0 alone. It required
  DAT0..3 all low and reported a busy card free (Sashiko).
- Link to v2: https://lore.kernel.org/r/20261008-meson-gx-busy-timeout-v2-0-8bde1adfb5b4@iav.lv

Changes in v2:
- Split into three patches, as Neil asked: name the limit of the
  timeout field, program the R1b timeout from cmd->busy_timeout, report
  max_busy_timeout.
- Link to v1: https://lore.kernel.org/r/20261008-meson-gx-busy-timeout-v1-1-d92f3c68c409@iav.lv

---
Igor Velkov (4):
      mmc: meson-gx: name the limit of the CMD_CFG timeout field
      mmc: meson-gx: honour the busy timeout for R1b commands
      mmc: meson-gx: report busy from DAT0 alone
      mmc: meson-gx: report the longest busy wait the controller can do

 drivers/mmc/host/meson-gx-mmc.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)
---
base-commit: fd9af27f6c2319713bb23832066585f8a59a1771
change-id: 20261005-meson-gx-busy-timeout-7e8e3fdcb3e3

Best regards,
-- 
Igor Velkov <iav@iav.lv>


