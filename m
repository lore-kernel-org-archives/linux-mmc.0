Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF238B7A1
	for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261174; cv=none; b=mWGvg7Haj3HE4GeRGigVYW0DJ2x44QFSMWgkHh448SXh5GPVIgga3vIjg7lOnm/zQEJOsVm86TEfPRVLRXL8lvVVoA6vdF7BXVDDDhLVqnrQuiVlDhrfs9YyASA/05bk9cQjiCNjaS7jClmZFM5rNz3wV3kwvhneI/QTogbk6qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261174; c=relaxed/simple;
	bh=qUA8SRWMHXak4DMGjiU5xSTobYDglxv6lNBrFgz1elQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YFOwkiQEhirCEHTUNW0BbcQ308jUG3oRfaeG5PELPydUluxeYvIuLMg6FGpzXV9qX5cH61w+xTlHOwt8yRn+7s2U6ptDfFEaWovZRCPhaus4QyRqE5w4aPS8SZCWKhSFxZf9kpsewcSQiYDE1F6jPgq3Xk34escAmh8E7+uiEmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ga6pgZT7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga6pgZT7"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486507134e4so49605495e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 03:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774261171; x=1774865971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvVWaFSwZuIIuqOAIjURBh3MX19UZqagVH7905iJLbY=;
        b=Ga6pgZT7b6ytinMbdIhxT7vM3/QrBQvXuef/X5KCzK6RVQt4HJVfTdjvxl1udNN5a9
         1Eo8Mi0SKCYZeZpDQhTNNJggRvm8QwIBoPvfJ4MGrJRnFTVJfAj/MlN5wH97geU6bnk2
         0rgHwl9bGK+wCW9sVkJWsIQKq3AKXoSu6g+E+7OqPuR/yecINcLhgTdEMviI+bk/pt+J
         SCpdRkItAxkCulKYi8QUmIyJojM2f5vkeTPHrpUNScKO94LIhHunDWNZMplw1UtXyi/v
         H4LmlDv1m8v1P8VlNhYQWvqsn+lx2os6Kdl8Wxjjrr0PLo6bXgMoIk46pn9QXW/z/GlP
         kTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774261171; x=1774865971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AvVWaFSwZuIIuqOAIjURBh3MX19UZqagVH7905iJLbY=;
        b=dwNZgv4tfQZ6zWdgyH8W4fdZU+6+8ZpTEz1JQ6jQlcThWcl4gdjiXUMdcV9yY8zmiu
         pG0PwyijfnuFBSTjG1n7OloKhuUfaAsepxWumPL2LVt1CbIFScI1dmq4DpaoqA4q7Hdi
         AUAiLwjzUz3Kng9ZIM41Vqg1cwraRhe32ncMd2DNQ0gIeXAabX5UoMDxzYrhAj2qzp0Q
         tPDO7eQsxCn1YyFt9tF3kWTsb+fNJYuAwVhSP/v8UEjFCPeniwDSMnVaP5unCCt/0vuY
         Xeeonj14dN9DY2zw0PprIFuKIIOe3dbpl5Iovznk2t9iKFCEehJ9FDjh4C8rO6HIEweu
         2nzg==
X-Forwarded-Encrypted: i=1; AJvYcCWcEptie2tSHKDLjE9+xt18tQqJv0AhB1pQnEUjI7DWzuBRlRzb4G4EO/JC0n5JlSaHwQbKP7CMogM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgqaEZdQJ9RDgxTUGGoRvRmy8NkiWAOv18CAIeh76Vw4/pqO6T
	6jl+D0OYBRmBZAQ0E8FDus9czwMA+Jhg4xog6MjZvmq1Jaq0OIHe6q78
X-Gm-Gg: ATEYQzwdUHywivM+1l3Og9TCdaRekmnyz5wzZflL/JsaAF2X+3z72U0d6xg5fl5RzuO
	OZozBkwe4tfOpwKaKp8Sx5kex93OeSVrG1vBJ6/0HpOHctbbO5q0eBcLWNxYin34pdLMyEz8UgD
	yO8QTvOjXeltd/PK1ZpnkQv0eOJuq/t9yDUTASFYkI/qhkZ3B+AZHy38Y1QZIgOnJQ2C9TtR1bE
	65nlg8qhSHLAdvbltgHedGT+hBoYRyL0/E0Y2RX9YZPnTMg3ZVChfz9EkmNc02iBO6JfsndaSyT
	ZRSxpM6nHyuRBfNWsCCspVB+GPjxsqozBIQyJ3xEv4avJndXdCB9223cCJVcBq0+nE80tFq5L+D
	Tl0XSMTUbyqttFJwvHD9n3ekxzV89vxjwK7Z6uUpJ4lS4jzmPTx0bwqe0dXbKK2BJa+SN1HM3r4
	OpezyJJVrqUMbANDYOQ+M1bp41V9MNo/AbHeKrnaXFILIIhdZbQ2twr1ag8lZ8ue/4
X-Received: by 2002:a05:600c:474f:b0:485:3b34:2f62 with SMTP id 5b1f17b1804b1-486feddb659mr165327915e9.14.1774261170709;
        Mon, 23 Mar 2026 03:19:30 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.232.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe86acb0sm78755445e9.6.2026.03.23.03.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:19:30 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 23 Mar 2026 11:19:04 +0100
Subject: [PATCH v4 1/8] mmc: sdhci-of-k1: enable essential clock
 infrastructure for SD operation
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-orangepi-sd-card-uhs-v4-1-567c9775fd0e@gmail.com>
References: <20260323-orangepi-sd-card-uhs-v4-0-567c9775fd0e@gmail.com>
In-Reply-To: <20260323-orangepi-sd-card-uhs-v4-0-567c9775fd0e@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.2

Ensure SD card pins receive clock signals by enabling pad clock
generation and overriding automatic clock gating. Required for all SD
operation modes.

The SDHC_GEN_PAD_CLK_ON setting in LEGACY_CTRL_REG is safe for both SD
and eMMC operation as both protocols use the same physical MMC interface
pins and require proper clock signal generation at the hardware level
for signal integrity and timing.

Additional SD-specific clock overrides (SDHC_OVRRD_CLK_OEN and
SDHC_FORCE_CLK_ON) are conditionally applied only for SD-only
controllers to handle removable card scenarios.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/mmc/host/sdhci-of-k1.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 455656f9842df90c7a94a290aeec22157b378fc1..0dd06fc19b8574ae1b00f7e5d09b7d4c87d06770 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -21,6 +21,13 @@
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
 
+#define SPACEMIT_SDHC_OP_EXT_REG	0x108
+#define  SDHC_OVRRD_CLK_OEN		BIT(11)
+#define  SDHC_FORCE_CLK_ON		BIT(12)
+
+#define SPACEMIT_SDHC_LEGACY_CTRL_REG	0x10C
+#define  SDHC_GEN_PAD_CLK_ON		BIT(6)
+
 #define SPACEMIT_SDHC_MMC_CTRL_REG	0x114
 #define  SDHC_MISC_INT_EN		BIT(1)
 #define  SDHC_MISC_INT			BIT(2)
@@ -101,6 +108,12 @@ static void spacemit_sdhci_reset(struct sdhci_host *host, u8 mask)
 
 	if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC))
 		spacemit_sdhci_setbits(host, SDHC_MMC_CARD_MODE, SPACEMIT_SDHC_MMC_CTRL_REG);
+
+	spacemit_sdhci_setbits(host, SDHC_GEN_PAD_CLK_ON, SPACEMIT_SDHC_LEGACY_CTRL_REG);
+
+	if (host->mmc->caps2 & MMC_CAP2_NO_MMC)
+		spacemit_sdhci_setbits(host, SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_ON,
+				       SPACEMIT_SDHC_OP_EXT_REG);
 }
 
 static void spacemit_sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)

-- 
2.53.0

