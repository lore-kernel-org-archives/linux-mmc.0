Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28813B6360;
	Fri, 21 Aug 2026 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306791; cv=none; b=Eq6Wao7Cz4z3mLd+gLuJ25V7u15f6dRdJyrcKOaJK6XCmUmhSeWYNXKPI18i6+cL/kVM058Mh9rFv2qembcxKe/bflU6vWbemeMvcpH9K5XnLMB92W5szJ3pAeTO5xWA/RhxYu5+WQRBgD+KfCeze/gR6hGiXRnQkXknmEKKjRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306791; c=relaxed/simple;
	bh=JUnYJH0KUYa+PueszJLkrTWZkM4IVGaaccIBbrmYjuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNt8fpCpJ+xXxDBxQ1zc2FH2wQDhnJFDDZudiSojmKmwjvMThyT6gQ2PljiqYVnK6XVEQ4hCDstCjdt4ihAo6LTfQPMDC6R2Pn7CD8Ad6/pZfPoj44ZwJvbHsyuNwPqLBTkQfIqXajBZ4k64uqaymRjsmmgZR7iVtmIC2vVDHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72171F00A3D;
	Fri, 21 Aug 2026 10:06:09 +0000 (UTC)
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
Subject: [PATCH 1/2] mmc: meson-gx: FIXME: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 12:06:03 +0200
Message-ID: <4b9a377a810b69a4eb885fc00cb34ef63e7fc1f1.1787240090.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787240090.git.geert+renesas@glider.be>
References: <cover.1787240090.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clk_init_data structure contains several mutually-exclusive members
for different methods to specify the possible parents of a clock,
prompting drivers to initialize only the members they need.  However,
not initializing all members may cause subtle issues, which are only
exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
enabled.

Make sure all members are fully initialized, to avoid such bugs, and to
prevent future breakage when converting drivers to a different method
for specifying the parents.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/mmc/host/meson-gx-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 694bb443d5f3febf..698febdcd498826c 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -418,7 +418,7 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long rate,
  */
 static int meson_mmc_clk_init(struct meson_host *host)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_mux *mux;
 	struct clk_divider *div;
 	char clk_name[32];
-- 
2.43.0

