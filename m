Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B848B1DC9BE;
	Sun, 26 Jan 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903641; cv=none; b=ktOrjHyh1rCyFUn/mcB+9FQeY23UgdyxBvgqdwZepfcSZABxUmCIQe5BPdrGQZjCGlcatDrp/m4CaYz/LUNPKTqdV8lorDc3bSzz6ndzEspJ5cdEHFdbj7tvxijQdVaKOqgdJLWGHx5B/J+YlS9QxA1SHMKR6Y80w7HTsPTFJLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903641; c=relaxed/simple;
	bh=c8exVOBjJ1zKy1TuOi7YVMJaavVriuMSFje+Synkb7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ud5cNuLeChH/09BSstu6wVs4/b5vWziHQNeX2wIq3fJCtJ+KvlYq3AQYKiPy7JXlQCFEVbxYMeU4lcqfLQBxoegXOpnFHrBAMQJeExEf0YjH2ao4Pl0h1JuRq1nP17+n+U8VcA29iJs10yhGbBfwsDb/D7cWVsJCp70+qHGjq+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3LrJawZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3LrJawZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFACDC4CEE2;
	Sun, 26 Jan 2025 15:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903641;
	bh=c8exVOBjJ1zKy1TuOi7YVMJaavVriuMSFje+Synkb7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j3LrJawZGPOYjjwVfbIKkujqMa/03zDzmF/vl54QajncbLlXymOUBSuZmJGwIcwVh
	 h9U18eGCH23K/55VxyRoVHAYFu8Exq5XT7ddJFd9zSRRklwTZSMboYWm70Pu3U04EH
	 avO/q8+m4G8hmvnE9aV0UelAigvNxlTWzbK/TIysOJfrSmgJMDZvVSSx8AbTFv4fEL
	 2tiVhnyJsUVdm3hh3MjHFPXfp42hMlRX3MKFHx5/6ahQRlfsjj7PxXy+YQE4F13XxY
	 x+zfXQsiV/UXAMEnidF4MKcoef8HQTr50w31XPtDhsUiQYGBwTB6Uo400gou2mTxVu
	 Hd6umhRI7IAJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	shawnguo@kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 06/35] mmc: sdhci-esdhc-imx: enable 'SDHCI_QUIRK_NO_LED' quirk for S32G
Date: Sun, 26 Jan 2025 10:00:00 -0500
Message-Id: <20250126150029.953021-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150029.953021-1-sashal@kernel.org>
References: <20250126150029.953021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

[ Upstream commit 0202dfbdc5dea70e213205aa42ab49a1a08aad3a ]

Enable SDHCI_QUIRK_NO_LED quirk for S32G2/S32G3 variants as the controller
does not have a LED signal line.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Message-ID: <20241125083357.1041949-1-ciprianmarian.costea@oss.nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index d55d045ef2363..e23177ea9d916 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -304,6 +304,7 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
 			| ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE,
+	.quirks = SDHCI_QUIRK_NO_LED,
 };
 
 static struct esdhc_soc_data usdhc_imx7ulp_data = {
-- 
2.39.5

