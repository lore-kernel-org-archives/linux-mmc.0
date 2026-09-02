Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5435377545;
	Wed,  2 Sep 2026 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336303; cv=none; b=I7x4USVLMxyWrNcWH9R6mTpOgpvsPbY6sx79IUaIBvWvdcyIlNvLI69AE8XqXhGJQ0NuHCign95018nDDMq+Eotei9Xc/5r/J4fTb2V9o+U3F3wjLU307+pUw8yYVHzh4UsODCvI6LPJK8scRSPUpw6yD6/SUFVqNl8reaZeBdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336303; c=relaxed/simple;
	bh=682mhaKsS9r1G6I55d/fTpJ6+mwgJO/hgJ1+o1H1sR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UdYWvqZAuSBS0tD56bp96TAd+2hK4M8MwKNaIg1Sisx52CUip088Jd6TDzt11EdCS2P4zwgLzbT+7U8S5DOoR8J7+O5vOIPGn/w3cEyT9+I9MMThA163+iBA1ESME6TX4Fo2azaac32ZNi9wGkXVk9RLQh3po5cXHbAvAu1yFuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSoy0kAe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSoy0kAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE2A1F00A3A;
	Wed,  2 Sep 2026 08:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788336302;
	bh=VSy3rEZxd/1rqE63G1l3UhTJKsxc97wUjHaQ0rElp7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hSoy0kAeXB15yJsA1GMGHjlgG0APpaepUDyJh4wr+q1raYeaum5d+r2fMfYNKQ2xG
	 FpyRP4FdPL5LFauT4FQBJJ4Z5V5F2unfnRKOY5YyHFDiSZ8DcDrThWFRoa3ehGmS9N
	 Oy3FNt/Z5DGraNXKqO2UZGelZW9oalJNMfzjtFAm/olo7Ew8077OsPU0lTMtQwlHsK
	 WWiVrOIBOiKwxGSg99kvbNCThpEEeFN5viFjqs73wi2Z3R8M+UpyhqppTxx3dSUbG+
	 kv/xmgGped65bHQyOEbS2csT1R/lOnJy98SdHPy/1oQ/Y1V0xpL94kBoEyDZUPz4FF
	 x2FhsTtj0LlBw==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 02 Sep 2026 08:04:22 +0000
Subject: [PATCH 1/7] mmc: sdhci-of-k1: no pinctrl state switching
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-07-k3-sdhci-fix-v1-1-b15c5d0f64fd@kernel.org>
References: <20260902-07-k3-sdhci-fix-v1-0-b15c5d0f64fd@kernel.org>
In-Reply-To: <20260902-07-k3-sdhci-fix-v1-0-b15c5d0f64fd@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Long Wan <long.wan@linux.spacemit.com>, linux-mmc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1042; i=dlan@kernel.org;
 h=from:subject:message-id; bh=48HJXbKiYAzT2GXhaKjL8LaaHoDQcdGr+unV8bXxKB8=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBql9iU0tJjEvGw1f3/YZtGzzw/tnFP17dfMSTas
 TIbsoScW8OJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCapfYlBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+2Anw/8CePzgKC8BR7xIncocdkKlVSJTddj5vKjgl2vd870lujK+7faRGlmL
 Ko/txe1Dwct9cX9otxmrTGAloztuW3tQbL9OCYL4PlDqHmIZpdzeQmCK+Bs5u5na2VlUrZgMVDe
 DRlEJrQ6xuJMRPJ4/ytvK564mB5fVYfMjkmKRHmTxHedTdcKVZ4Eu7NPl2XcO3higrZcRyfX6qZ
 0yNv68Z5gW9ETotgF7BHO3PuGYDVOoHhlmE9TGgqiMnKBfhv58ELWc7Q0BMuSjhdqv1mlSIQ0aM
 D/HGv84xSEgzu48thBvKhR0eHp5eW1FAc5PyZnMJ9xSkMWpJRG7sqIgQELRxdtiCuIHlsV/1TFu
 qglA+Tgo9FSdPbELLfLdwvC5mQG0hwJbEXLFwKx4dHeL/3jBJ3D1UWn2vuzS7t8G+KpU5vFitIx
 +jV8R5EDUvNTZJRTe8pSqgWnVMjH1tbssLtGDj9QVRvK1IPjobzYN2bKuZ/Kz4j8QWH2/STFFZa
 7aPRSjPYYL4BTz9wPTewFXnohOojioqAN0/Xsd1yxeWnSgw+E+1abhHLkFrvvQQ9nlVHINMN7zl
 0H3p96WHwkYYkzbuEjlSS299f1aO3UwNU2VJC1jZg3BnmpchE/1edvPr29vyPx6yHQTBeMBHNub
 WKRz7vP19H/48phaL7f6nZ3qUfJdwo=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Long Wan <long.wan@linux.spacemit.com>

No need to switch pinctrl state if the SDHCI controller only support 1.8v
IO voltage which DT will only provide a "default" pinctrl state, otherwise
function pinctrl_select_state() will trigger a NULL pointer error.

Fixes: 00a97fc57c09 ("mmc: sdhci-of-k1: add regulator and pinctrl voltage switching support")
Signed-off-by: Long Wan <long.wan@linux.spacemit.com>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/mmc/host/sdhci-of-k1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 37b0911e7cf2..0916340d3265 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -407,7 +407,8 @@ static int spacemit_sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 	if (ret)
 		return ret;
 
-	if (!sdhst->pinctrl)
+	/* No pinctrl or no "uhs" state */
+	if (!sdhst->pinctrl || !sdhst->pinctrl_uhs)
 		return 0;
 
 	/* Select appropriate pinctrl state based on signal voltage */

-- 
2.55.0

