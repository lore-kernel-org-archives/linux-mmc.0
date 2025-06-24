Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D214C288C00
	for <linux-mmc@vger.kernel.org>; Tue, 24 Jun 2025 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763411; cv=none; b=pqH4hVDqQ8uI6JMv7Y4xmIoFDM43+UHmm07OxOBmi1ZtlWgDTTkd6oXqdc7ZJzjUk1M0Nj4/CFD1kTypMjcvQBSKYGX217T56mdjlRAGxC/vhxFS3VCmTk95Mr0nYmClMYR5sGfOFLle4p8Zfs5HAwlAC286NWlGGQmmKtaDu5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763411; c=relaxed/simple;
	bh=z4rJtnFF30lqR3jrDEtJ16ql7i973YYLkV6fm+6rt/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rz2q3gR+xhhKUtkrUrmlPXPlBbKwRqKSl3JElpm+0KW87KIQQF4hIOkJ+4eFRElusOOIEehLJekIur9XLtE80ioONGFTCRFf4bq7UqxX2vmLoK6W0cPdOecCwOaPe+Kysk4eSqwHim7GxviQjcpOlugFcNgCNx+caDAHuLZzmsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ITI77JqV; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ITI77JqV"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-551efd86048so289386e87.3
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jun 2025 04:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750763407; x=1751368207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5t54NOu9eJMfewpsFMkasSGMJUYUFumjVVb6dnB5QGU=;
        b=ITI77JqV+600vjMciOQiN59nbadMg1SrrkoLGwbKaTEuxwVDMEXD0X0NlnUAOPsr6F
         ccsJtIN0ECT50kl+PaypIgQKKLfIk8oX2DGXOuFZxnqwdL5kBSXS+rXl4UN5bkOK8qtu
         P3z+DmpWA+1PMdG+eEocV1oBGAZn0BOv64NcbBmgtFil8Xb0EMaWKy0JMuECzlcZvvxA
         xvxrFhRfR+srfDnTxWSOogsTDswMJP8Y3jcgYD/c2ppUh/teMi+k7lgdCZFyZafPyaty
         yGuVy062N4d1mmlPPL8x1dIk5USMdk47eZHnJJygOfigJ6lpfuKowdjtvCT3wRx555S2
         lp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750763407; x=1751368207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5t54NOu9eJMfewpsFMkasSGMJUYUFumjVVb6dnB5QGU=;
        b=WhDqUOG4CNXJm9p2dc9w3eKse89Zb87161DBOOiGKzmZqtYTRqGYirXOqVdR8Vwefh
         bqudjMPdKcrp/wIApMBDpUrZCXNlgMV/Ui8wD/w0NEsiVtbPwLQu0MBD/nMba7cKo2ml
         37zcDkA+ACmKEQlRkUHh7DvlUG6gLXKcGJVKa7921Qc3u6sMfYVS5ohZLcZuVWqUVxpT
         h2aFkwuqTYTWXzW8FZWrPVT0QtnDBn2qHuZVIoLZqyLpVYLU/X8zKFKR6P8ikoU1hzMN
         zwfjqfLS6wzzt9QI6onC8Y4jbbJuKl22D+LOmPuiuklY4iixpjHqUHIK8VXirdj4YYhr
         K5ZA==
X-Gm-Message-State: AOJu0YzsFx1hLLFs1f1KENa38mjHEuQ1hdPKJYM+QE2SAxV5/7Grnu9n
	46HPXrB9G+oIIahKF3vvta4jZRsTWUEvhI8RP2mBY1OxevFaMC/LP1Pfh3KGDdHRq8fzExCr55J
	cGwCp
X-Gm-Gg: ASbGncujEOghsu4NJxcGlrJM2ZS3Q6PTP/RAIdk2tIGUP9Usgt0Gl0P+n7uWG0YESJ3
	L1IDN/F3Mi3mu5syPeQeWopRnemXDE+QPi3LpaoE57ZzaRV3xn7leHQ3pe6iTH+4uYVsik0fGAl
	+mpa1VCDVV8VMRgcY+IreaLxdg31piqLiJqw4Y2nFnhAuYQ/5dkgLACjwp+SbH2ZNOZMTsaUDWD
	4vaBIGPFRxhLeXaH9cqhFpY0elZpH3aKaDL5jmPR3jjaY/9ezHyIO74XUABzDW6Q1M+uSh7viu5
	cyXy7Iq4PhcwxF+YeNsJvFIXoc3jR0Tkl+m6s4afkTE7+aHQ6ypnMHg3zq0yOCEkxXi4G6fDyhY
	SV3Cs/p9FG8c8D4Nq3MGxtxMCVNH0wPu+CkFg
X-Google-Smtp-Source: AGHT+IENbLN83OkH03hyG1yobNT45Foc2hr2LQyAWmtZ5swCAZoTpbyCfwqy+Q3f5C109deHitMiZA==
X-Received: by 2002:a05:6512:3e04:b0:553:30fc:cee4 with SMTP id 2adb3069b0e04-553e3d1d8bfmr4582281e87.49.1750763406612;
        Tue, 24 Jun 2025 04:10:06 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41bbd9dsm1791204e87.105.2025.06.24.04.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 04:10:05 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Erick Shepherd <erick.shepherd@ni.com>,
	stable@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jonathan Liu <net147@gmail.com>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] Revert "mmc: sdhci: Disable SD card clock before changing parameters"
Date: Tue, 24 Jun 2025 13:09:32 +0200
Message-ID: <20250624110932.176925-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has turned out the trying to strictly conform to the SDHCI specification
is causing problems. Let's revert and start over.

This reverts commit fb3bbc46c94f261b6156ee863c1b06c84cf157dc.

Cc: Erick Shepherd <erick.shepherd@ni.com>
Cc: stable@vger.kernel.org
Fixes: fb3bbc46c94f ("mmc: sdhci: Disable SD card clock before changing parameters")
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Reported-by: Jonathan Liu <net147@gmail.com>
Reported-by: Salvatore Bonaccorso <carnil@debian.org>
Closes: https://bugs.debian.org/1108065
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4c6c2cc93c41..3a17821efa5c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2065,15 +2065,10 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	host->mmc->actual_clock = 0;
 
-	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	if (clk & SDHCI_CLOCK_CARD_EN)
-		sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN,
-			SDHCI_CLOCK_CONTROL);
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
-	if (clock == 0) {
-		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+	if (clock == 0)
 		return;
-	}
 
 	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
 	sdhci_enable_clk(host, clk);
-- 
2.43.0

