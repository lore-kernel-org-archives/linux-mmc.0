Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2F39E9BF;
	Fri, 21 Aug 2026 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306775; cv=none; b=VHGC/xbAKCL5lg9Sx1TIv3Oj3Hb26+J3A7MEpltsnvT0wDJWiD3thQy0xLP+3JUb6QfCuM/c/wkoGuijfbp6zoyMx0YMsRoU4Ic2EERlNm8rrwYeFxy+lwK16EVlcYV0f5cYIPEoPJJo6J7+/U3J7dA7pCuIGt1nWjBpb10yRPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306775; c=relaxed/simple;
	bh=sXmjqUPxzs8I77yS9D7f5nOcVbVoD6o+3ZUBRxa8ce0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FGjVriXjzNrURUkqBITRUTfeXfUqCJ42lR6V7TXbVjwXLXBVardq0Nw3ru1fqbJJuceE34HyD0aZHBiwmXGZDA6D9kLGm+puiE/Onag72X8kKm6/QI1q31/PHdjZoljXBF+Un3BQ80eGekNRtfscHm4EaXDfUg8nH4vw+9Y0nGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBC41F000E9;
	Fri, 21 Aug 2026 10:06:06 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulfh@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Michal Simek <michal.simek@amd.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] mmc: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 12:06:02 +0200
Message-ID: <cover.1787240090.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

The clk_init_data structure contains several mutually-exclusive members
for different methods to specify the possible parents of a clock,
prompting drivers to initialize only the members they need.  However,
not initializing all members may cause subtle issues, which are only
exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
enabled.

Hence this series aims to make sure all members are fully initialized,
to avoid such bugs, and to prevent future breakage when converting
drivers to a different method for specifying the parents.

Part One[1] fixed all cases that I identified to be real bugs, in
response to a crash I saw on BeagleBone Black.

This series is the MMC subpart of Part Two, which fixes remaining cases
that are currently harmless.  These are still fragile, and may cause
future breakage when converting drivers to a different method for
specifying the parents.

Thanks for your comments!

[1] "[PATCH treewide 0/5] clk: Make sure clk_init_data is fully
     initialized (part 1)"
    https://lore.kernel.org/cover.1787165329.git.geert+renesas@glider.be

Geert Uytterhoeven (2):
  mmc: meson-gx: FIXME: Make sure clk_init_data is fully initialized
  mmc: sdhci-of-arasan: Make sure clk_init_data is fully initialized

 drivers/mmc/host/meson-gx-mmc.c    | 2 +-
 drivers/mmc/host/sdhci-of-arasan.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
