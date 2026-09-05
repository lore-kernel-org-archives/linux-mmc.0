Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9044B147C
	for <linux-mmc@vger.kernel.org>; Sat,  5 Sep 2026 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788622364; cv=none; b=fTUZlQEBHTUySvaBgR1JvGNkd6qnAzqZ5ns4aJcaFMYvEHboM/sP8M4jtuafDP8eNiDRVZoXuFqY0wgNnnJAEB2JY/nqVDUldevScEdBmxJ5udsIpvi6PoeokGO/Z7V9X0FLX/rpCLE1z6zqYfLTchF4CWdh96erk8FnN1RrnrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788622364; c=relaxed/simple;
	bh=HlStx7vx3piFzayiVi0TqGQGaEyIJNcVSIFbgAKrR84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCkE5+Rgf4rZw9GDzXjSB30cwbR25fqzmP9O8HIDeS8o7aoTWOqAsOAZrCG0pgbDQW5mOTCnBowyYmORrfFEvFVkahNIg4bgVXMlu9p302q11ykfaX/AwgkuKrarTnT83vUQMfWOokWZsuWByojDk/An4G74OJTv79pLW++LRIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-482dd6ee390so2236976f8f.3
        for <linux-mmc@vger.kernel.org>; Sat, 05 Sep 2026 08:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788622360; x=1789227160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rBqYYCS5py1zvvdbPLcK4Z1TQdgdHGp93LoH6od28Gw=;
        b=eNtCJI5VrS6fRFCVs28nUsZEkv1T4NpzLRq2BmdL6R3+ghIypoFHgYjmLIF+/PHXZF
         lBAxlpAeQHYwN7H380sOxweS0T5lk6KXqE15RTqaaBWPJTo9xQc+ms1py0tMvkFMJyb0
         vqu1BtuZVd2LbdDd1DNwg2wUK7Hz0+Prki/k6BBnDaoMlOR1fQgwSY69bg9+32fCA9ke
         iKWYadgXI6uI77CmD9QfvnBdMPHWcaDhcquO2GZwQlDf2fv8B2rL+2n0saHF0auBbkQ2
         dPMbD9CFzUbYgpbwhlvspVBdKIisGrPCq8gGXkespfpVW7BTPtCIkAdBL1DnTy3+KIRy
         d0AQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5et1odmGDZ1w0U2nspsqGoH1eKndLapi5MZJlH2ESJ+K34J9rMie08c/tEK0cEl4mrUC5I1KvN4A=@vger.kernel.org
X-Gm-Message-State: AFuF++lG3wXY9HjDDc3LfyOyAF1AgPF861BiqmCiV5ljP6o9n7hhr7mu
	SgnEiWpL6WqahGhUf79AL7dtvRbs8ma7/mGMUwmPs0EJf5nyik/CP4/I
X-Gm-Gg: AYBFou0qCxPBu3haRDY6kNESPije6aZq58Pcs0Q3QGWsGcJT5cZ8/InF6XL4+D3A3eH
	5iPslmqLq6Q9GYFV5G8XtVXQ/gFCRMSmD8daJYm9hRNbOWhsHRXp4X9ZX11ozo3JmG6AyUJPNrF
	bMaUyCwCqifAiaOabjpdk7dLHO6If6cL6hfVax2uUv22+d+eD0fouIvbS5vKtzSE3itHNYTdcg5
	sqK8JcRkeyuZZoUKudbjqhKkpEC6XD7t5NCXiS5rAC+XRxHpQ+aYEANKwDr7+KXKztS5eMuCq18
	H29d0xY7a18QPuBeFVySlrIpZyZiOBCkUciWZlCNfmLNlneltlx7Lu6WVkwTrJYjOuZToZwN+l6
	Nh5PS40pez4KNrq91McdsQRGvUyv9N1Iy1JtFxPr806M/mHe8W/92kA8JAJv5d66RAeVitGSD2l
	+TyQK4GaabmHFfhgiuYcO1j1u9E8TmuaKEChf0kuc1n1lDkn9LK37k158Eqy1dTtQIrdYkeZPKJ
	Jm3qTwv/XLPL5UyytnBSd05GA==
X-Received: by 2002:a5d:5f09:0:b0:484:3332:d1ce with SMTP id ffacd0b85a97d-48586bf9cfdmr14652908f8f.0.1788622359412;
        Sat, 05 Sep 2026 08:32:39 -0700 (PDT)
Received: from threads.localdomain ([84.68.179.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm16691913f8f.25.2026.09.05.08.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 08:32:39 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Brian Masney <bmasney+clk@redhat.com>,
	Chuan Liu <chuan.liu@amlogic.com>,
	Jian Hu <jian.hu@amlogic.com>,
	Ronald Claveau <linux-kernel-dev@aliel.fr>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] clk: meson: t7: don't mark sys_ampipe_nand as critical
Date: Sat,  5 Sep 2026 16:32:34 +0100
Message-ID: <20260905153234.133217-5-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905153234.133217-1-tanure@linux.com>
References: <20260905153234.133217-1-tanure@linux.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sys_ampipe_nand clocks the pipeline stage inserted in the bus path
between the SD/eMMC controllers and the NIC_MATRIX fabric. It does have
identifiable consumers - the three MMC controllers - so marking it
critical was the wrong tool: the clock should be referenced from the
consumer nodes and claimed by the mmc driver instead.

Drop the CLK_IS_CRITICAL flag and update the comment accordingly.
sys_am2axi0..2 remain critical as they clock the AXI DMA bus itself and
have no single identifiable consumer.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
This patch depends on the MMC controllers actually referencing the clock:
the dt-bindings, mmc driver and t7 DTS changes adding the "pipeline"
clock must land before this patch, otherwise the boot hangs and memory
corruption this clock caused are reintroduced.

 drivers/clk/meson/t7-peripherals.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/meson/t7-peripherals.c b/drivers/clk/meson/t7-peripherals.c
index 55d09e78593b..2f429ea86796 100644
--- a/drivers/clk/meson/t7-peripherals.c
+++ b/drivers/clk/meson/t7-peripherals.c
@@ -945,13 +945,13 @@ static T7_SYS_PCLK(sys_aucpu,		SYS_CLK_EN0_REG0, 14,	0);
 static T7_SYS_PCLK(sys_cec,		SYS_CLK_EN0_REG0, 16,	0);
 static T7_SYS_PCLK(sys_gdc,		SYS_CLK_EN0_REG0, 17,	0);
 static T7_SYS_PCLK(sys_deswarp,		SYS_CLK_EN0_REG0, 18,	0);
+static T7_SYS_PCLK(sys_ampipe_nand,	SYS_CLK_EN0_REG0, 19,	0);
+static T7_SYS_PCLK(sys_ampipe_eth,	SYS_CLK_EN0_REG0, 20,	0);
 /*
- * NOTE: sys_ampipe_nand and sys_am2axi0..2 provide the clock to the AXI bus
- * used for DMA between the peripherals and the DRAM. After the clocks are
- * disabled, a device that starts a transfer cannot complete it.
+ * NOTE: sys_am2axi0..2 provide the clock to the AXI bus used for DMA between
+ * the peripherals and the DRAM. After the clocks are disabled, a device that
+ * starts a transfer cannot complete it.
  */
-static T7_SYS_PCLK(sys_ampipe_nand,	SYS_CLK_EN0_REG0, 19,	CLK_IS_CRITICAL);
-static T7_SYS_PCLK(sys_ampipe_eth,	SYS_CLK_EN0_REG0, 20,	0);
 static T7_SYS_PCLK(sys_am2axi0,		SYS_CLK_EN0_REG0, 21,	CLK_IS_CRITICAL);
 static T7_SYS_PCLK(sys_am2axi1,		SYS_CLK_EN0_REG0, 22,	CLK_IS_CRITICAL);
 static T7_SYS_PCLK(sys_am2axi2,		SYS_CLK_EN0_REG0, 23,	CLK_IS_CRITICAL);
-- 
2.55.0

