Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C71934CFDA;
	Wed,  2 Sep 2026 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332615; cv=none; b=toxaszJmPndOeDkm4KzXsRM1qduiubMQjdWZHrOuLKDZa3wvl9aKXB0ZqzJq82N0KYxzboNT+WbYY0zzqipv2EkwPdlsAUIVq0znNZJ6b55w70Jhnyrgk9uaoQ2Urus+zS2BBOexm12BqxMr+qDqj1u5OzjtUdGR9MTfxiNVWiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332615; c=relaxed/simple;
	bh=VL6VYZQvVN1Rx0nbvAwo07EnHRT3sy/Ukl3Opf/6Pao=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IbTypMMBX1KJEpghHCmyxWs2m+fo/mzMzYcmjksJIqh9dK0xVzn1mNTKRcFLrV45cETyXhMUjUeM2ex3AQYL+RAFlbiEGcovXkvA9X0aOEOheCRswr61c8A4TtKAe3TiGj1R71h/4l/wdiXYPpyLCbXa2IP0UMvkf/TAKOXYh9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/k6UNWd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/k6UNWd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EF01F000E9;
	Wed,  2 Sep 2026 07:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788332613;
	bh=xt8WntKHLQ3WUOjFrFUe90sMpWS4lqT9nni8qFU1Oh8=;
	h=From:Subject:Date:To:Cc;
	b=R/k6UNWdUKt6HBj9p+QFK7SBLTvF+kfnpA38Lxvads7WS5D91RtTpgpWOo3toCZBF
	 qSPNkJde3WPy8aMCYA74Ch5XLhjFFDdAKHga0PS8cQMaQTlm6XuH9LbrfQ87A8jFTo
	 Pp/euS0HDLqerrsbP5Fxkl6bsvIfuJaXdVvq6uEKoUbdQpOclenxQjctC5atks4iTu
	 4Yfhs4jK/4RVsJhBaWeL5XJxOLrCDrVjuYLvrQjyLv/5r9/qEADPuzwDAQLMiY0KzL
	 K9M5GqnMxhhi7IrrLMvxPxnk50QSZBD7FD2E2dfB7YT6f5ul7/zJuQNX/3oR2h/gh9
	 qyyl0wCU9btWg==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH 0/4] mmc: spacemit: Introduce two DT properties
Date: Wed, 02 Sep 2026 07:03:11 +0000
Message-Id: <20260902-07-k3-sdhci-dts-v1-0-4e7909cf4233@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC/Kl2oC/yXMQQqDMBBA0avIrDswiWiwV5EummTUsWAlY0UQ7
 26qy7f4fwflJKzwLHZIvIrKd8owjwLC8J56RonZYMnW1JBBcvgpUeMQBOOiWLnGG+cNW6ogV3P
 iTrbr2L5u68+PHJb/Bo7jBMRQ7QtzAAAA
X-Change-ID: 20260901-07-k3-sdhci-dts-579b17b1e205
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Long Wan <long.wan@linux.spacemit.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016; i=dlan@kernel.org;
 h=from:subject:message-id; bh=VL6VYZQvVN1Rx0nbvAwo07EnHRT3sy/Ukl3Opf/6Pao=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBql8ozDg9JZh2sq/hcbhdopOPA0ckF6RcPklq8p
 DltZwtyBKmJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCapfKMxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1FYhAAhO1sjhIn1puoTCeol/AWdDzobbGCxj0q4HwDcZe8YZ/fgEQ9JJjMU
 8iCnvrr7p+/GnupEUIcuO6nt8MuUnFvuu3vQdkogAOLmOj8m8wxisMXYMYKuC89QIxIdeomGIaO
 tjvxll7ch7dkd5sZnA0oRak4g6sNr9PBgbTv2KPLF5jH59CefZ7BIfNH1MFPY/SO+yHMRI0w44X
 Ntw/Ia/TsnLIThCoH7oZEER4jhzY+EgLkpEd49mslnw5aqhaenTZjo3c6qaoUzEzKJSaykmQVuL
 0IUjYu1QXwxVFlTyYC8SV2FpTzW1hL5RWrU9hcBz41n+WA+Q8BehRjC680n2DVRN/voWbR6FXID
 XU+wBR66aCkJKRTMMHJPf/ZImpYHsvYJsIGScBxu3U2O2rmLf24kSH6javpooni1gMf0arHVMaM
 eQ95daQMWX+PHqZ0kQnXesmm6bczgrtrdzL6xSuKHRMYCP2hp33Ir9OABBidJSKZqrDvsukwFYO
 tKJrYgN8PkTFKZ+yilmhqbEcXBCI7lgabROlWUUle2zbBI129+ipz6PGrZXWDBr46OU7J7xqEdr
 v4RZ7FQjJV0NjH9wigEFCaqP50Mgar86KiKTViQkCvhvZIWw9fMYIf5W1R6zwfCzlEO0yuGPOxg
 O/ExpfRPemf68SwYza8N3+jXbd8bA8=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

In this series, we try to introduce two DT properties for SpacemiT
SDHCI driver, A clock-frequency property to configure the rate
of io clock, which needed to configure for SDIO mode. The tx delay
property is used to configure the step count of TX delay line,
which is needed due to varous hardware layout has different
tuning settings.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Long Wan (4):
      dt-bindings: mmc: spacemit-sdhci: Add clock-frequency property
      dt-bindings: mmc: spacemit,sdhci: Add tx delay property
      mmc: sdhci-of-k1: Set clock-frequency of io clock
      mmc: sdhci-of-k1: Add TX tuning parameter

 .../devicetree/bindings/mmc/spacemit,sdhci.yaml    | 17 ++++++++++++
 drivers/mmc/host/sdhci-of-k1.c                     | 30 ++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260901-07-k3-sdhci-dts-579b17b1e205

Best regards,
--  
Yixun Lan <dlan@kernel.org>

