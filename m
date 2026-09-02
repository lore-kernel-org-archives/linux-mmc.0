Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA8239936D;
	Wed,  2 Sep 2026 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336312; cv=none; b=ACkRIM8MxCAYJb+Y4Zb4Uq3UhYfEh7ClSN6VcuOrCDTJmb9oJrV1RdJGkA1pW1J2cnQJa2RIXdiCE2Dzxsj43yUgucMTO+hQq07HSQnZDGUgOkp7Kb3zO286fe6EmD6Y+Ma1kMRA7UIIDptbLktrv714hM6+V+p9Wqey8umluuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336312; c=relaxed/simple;
	bh=lq9JgEOgUjRFqITnZEyhYKUAqfLwFlGsgTZt+Dslitw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FjxKnUIu5u1NCN8SBEtKCcINBzuQ/LygPu6qpL/7XsT0/ZcPTJ3rhtGqbJYY6aCJW3k/fWBxEBSa6gxIT6LrJSoZojcdMH/lVjpKrdvtwxivwTp2tIQbk83zSyNml7pKo93Pu5Mc4d6LGCA075xfcwcA8Svu8PjM12NNhECcBbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ5KONVc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ5KONVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965D81F00A3A;
	Wed,  2 Sep 2026 08:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788336311;
	bh=G/IFPDyfzhIoZFct3RGPm8HsjSQA2NovYHhqihlRERM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HJ5KONVceE9WDdEl13snx/1ss5v26p0c90/Uyspgg39/l3AnJVD74qKMvPxTPO0RK
	 f2hSpEoUmq/LS4jl4FWxc5NezuprOt1lZFzOfAkkIdm1Fwujx1tmHg6WF7mcUi/ycC
	 ccEyHML+cCiZGC118eACYi0zu3PyYkjJimitAVpra+G7T99XzWcKC7nbQV6Om5O7yL
	 knWWJGplwNJHsNasXzJlRX51b/qgn19KMail3KWB3BzaSYaymVz+HRbKGgEcSh5Bu+
	 pLbvn2wHzpK5fwGQvyhAIhxhEedDKFFcICbhKTpar82OENxd9f47GT35ULMKY0U2bX
	 4TQYLKc7EOYjQ==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 02 Sep 2026 08:04:26 +0000
Subject: [PATCH 5/7] mmc: sdhci-of-k1: Use finest delay granularity for RX
 tuning
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-07-k3-sdhci-fix-v1-5-b15c5d0f64fd@kernel.org>
References: <20260902-07-k3-sdhci-fix-v1-0-b15c5d0f64fd@kernel.org>
In-Reply-To: <20260902-07-k3-sdhci-fix-v1-0-b15c5d0f64fd@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Long Wan <long.wan@linux.spacemit.com>, linux-mmc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=dlan@kernel.org;
 h=from:subject:message-id; bh=Qc6WE/5RPjDixK1mUhV9vvXFCMN4SYq/CXesrgV9Q1I=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBql9ihfSPbM8z87ZD5AM1H264Ay5pIZvFam/itK
 zID5CTkEECJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCapfYoRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1G+BAAgpTS/M0HkvRKnO1EfRhtp88v9Dd2D0E0eHhWTINBKK3fhiO9DvBKb
 ApPMdK3PNMQIItxwU5/ieJZR5fMdqafc9x1zxVO0yMJOWeLOl14YnvpAnkdcGMxywnQLkQJ2Z+L
 A6lH9mroEHe0RA60Lq/eCi/7cqtdf2t1EN3dXGdHUrgof9ZQ3tI595+9DVOjBvZkZq3RKH9vr5N
 mORakmF5dfyj+GuGZegw7qz+4ncvibN8QVRdC2dpStHdzlMt0F1UnrXkaVaDT76ojVspljRb/9t
 M3MvnkIkLe1SULqSDuy9EsyRQKCDUWuhIIuE47GrCHq4wDs9ut5taN5K2nOX3845UylsQcq1PMC
 x8cEkXtnyTux1zykVjaIfZV6kP1X8kC6Cx75MMCofn5gqjV56eRkLFZlEOuNcUN7lTM3w8xVU29
 goucnrs2fgyHInfDzgXLXzIxTg2be40HKKEhTDyvyUhEc3k94tPjy9N8BkAppj7hr//fGsr4HFP
 HFj0er/4wYYoest7EEKmeGcQGCSVAc+Bp+/WUZvR1uYjvRVXDZvfNumfgYO4L/3NXiMzjJGOVy4
 LThqRSNTT0TuIEwkv7Gq7Lojsvg291gFh5SElyx+vzo1J+/c7aCVVNCReikeFryuj8xeV4ywmWB
 Z4Y5Ofchn54RiHIeAqjquJ6Rtz2S4Y=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Long Wan <long.wan@linux.spacemit.com>

Initialize the RX delay line to 0 (finest step size) instead of 9.
This improves tuning precision by allowing smaller delay increments
when searching for the optimal sampling point.

Fixes: e9cb83c10071 ("mmc: sdhci-of-k1: add comprehensive SDR tuning support")
Signed-off-by: Long Wan <long.wan@linux.spacemit.com>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/mmc/host/sdhci-of-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index be770e8a9884..257c954ce587 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -84,7 +84,7 @@
 #define  SDHC_RX_DLINE_GAIN             BIT(8)
 #define  SDHC_TX_DLINE_REG_MASK         GENMASK(23, 16)
 
-#define SPACEMIT_RX_DLINE_REG		9
+#define SPACEMIT_RX_DLINE_REG		0
 #define SPACEMIT_RX_TUNE_DELAY_MIN	0x0
 #define SPACEMIT_RX_TUNE_DELAY_MAX	0xFF
 

-- 
2.55.0

