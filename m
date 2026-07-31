Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8670B446821
	for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514914; cv=none; b=BxkH0nuhaYoQmGLL7i1h054sxXl1SyoXclMOE9+uioOxA4TpNuZOikOeLV2zC9sbYZITrfLUKf7l93zlVzidcuid3JPWJraS9I8CNrOxmW+XQuxvifxx/awqhewL0E8bddTjoIaJ3T2bfmfm4NxxwZ/LlCY3OMsaHEPxRGPoSD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514914; c=relaxed/simple;
	bh=XxPxlj15S9GHxpbr6kayVJohduiQuJOZXJICcGUo5pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iLOK33pdZ4yrgdv1B4R77nUbzhErDbnuOPXjFNuljyE40CFWKhA81n2xs5qaJvIjiWbI2bUTjKfvZIMciZGl/gNOhRNWzHqslwZVdxngNy2a6MoO6FdudfGS//WCdqyzSSeJAX1umutZxF+e5EJQA3DQrnI25CJmUcDGSobJ1XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=aI1guHNR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="aI1guHNR"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso775346f8f.1
        for <linux-mmc@vger.kernel.org>; Fri, 31 Jul 2026 09:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785514910; x=1786119710; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uJ1sTQDdzGH3L1I7c5cySgVgb/wH3f6ziWC+LNjIF5Y=;
        b=aI1guHNRJprcHVYaZDag0eJX7ZB+82dfKJCf7YgZ1k9pgdAzeK8oki9YG+2iegX+vp
         Smaq8mM0YfhbtQ8vUqdvwiO114sU76wpao2ffOSSaoIlLA/G0BwyVbtKuvbDgQWeepCs
         Lla+gKtU3yh3SIxBeA5DRz7vHp5sLdAR1Ps1L4lTmb+cWxHaFjH6/DiMEZnisV48AtcN
         DjLqYaD9drWuVde72grzdPRrNqb6d74xk++w8fpVx46dM8Lalr5jr5TwuWVhFF65y2sN
         lv7RTU8XVdWZFVsIn9+c5kDwV+WrJXTlcn6IJxQyhh+ayiVAbt3MMOYJr6aFj4IzpAe4
         +Hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514910; x=1786119710;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uJ1sTQDdzGH3L1I7c5cySgVgb/wH3f6ziWC+LNjIF5Y=;
        b=H2lcuNqRRHLxQh0ciWqHcTfBnll3yUDVMmLX02YU+2QbJjmnBxMj7y9gwBfVPvqnal
         ryRogUPQBYbchQvINSjCMTljwX6n7il5qXPKqC31ua+N31/0fHHyzHnyk3bvbDTElumJ
         aU0DKataoeHHmOYCf8pInJ6mhsPAxSjpgCW7qYH2SuuR3v2VDZAol8aZuIqJhxCMNPep
         EcLN4dk4cMV8piO3dYn+aagf0SCuPsDCq06iBI05N9xzj3TEqQ/OrB3BGDeLL3jWD3U+
         42/HbJnT1eRPVPu8WmyrrHP0ra2kquUCArNsDucHSfKONxzes8f7bwrTRYC59AA5b3Kz
         6RPQ==
X-Gm-Message-State: AOJu0Yz7+V5pmsbwc2zmHKYUin8AB2c4z/BnD/zBXeXe0RbYypls+GkU
	v/tXqKdMfQxvRyiDWAXd2zzN7DBY85TdqMyvMOrgSgEZjQxkovdHuRCoWEb3kNvH21U=
X-Gm-Gg: AR+sD11QZEclb5NaAuYPJNVgFOHCKR95CXgEftoyBgAGvp9YLoPwLFrkaChVkB+Bv+o
	d1rHvKhw6u+VK8Bv6l/wYfDS4GhfmXQEzs+s7srhBKG5/xwEhhT98ELe/WoJQqyJ+55Cfz0PwxI
	S4gqDp2vakBiz44kPiQnGZVH1NSTGTe/mgI1pyVq7MIzNayItQNZ+izIAuvR7F6OQ1amnDww2PE
	WsV1OC5xmo/r5e8CBX9JE+QAmDOMyKSLJLQq90e1h51abr0ZBz7u0AcOfivkKSNQm/y4IiuI8q+
	lSYH7rBSwdtdaaHXeegs4DjsejAlie2VciougmmoNGUFA+/oMWpG5eZ933JlPBI2lvNVBAuq6ZT
	5IsGe6N3vin2Ojl2FbOdwjSG6o1UU2BE22pPkn1oLVk29lRFrVL5siQ6NVhRgYbizG34CmmJLhm
	hsXZoJZA/+iZP9OxUKy3LB81lhNfSFCi6tB5e2QUuKf6nTvN/aZ2yNKtHND9T1t+UEtM0Y
X-Received: by 2002:a05:6000:110d:b0:47f:59ef:bbb2 with SMTP id ffacd0b85a97d-47fd72b904fmr539478f8f.17.1785514909845;
        Fri, 31 Jul 2026 09:21:49 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:d00b:bc94:65a:a73d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47fd41e296csm6440334f8f.12.2026.07.31.09.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:21:49 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 31 Jul 2026 18:21:45 +0200
Subject: [PATCH] dt-bindings: mmc: sunxi: add compatible string for
 Allwinner A733 MMC0/1/2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-allwinner-a733-mmc-support-v1-1-e9209e3f9761@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJjLbGoC/yXMSwrCQAwA0KuUrA3MByx6FXExjalG2umQtFUov
 bujLt/mbWCswgbnZgPlVUymXOEPDdAj5Tuj3KohuHB0bfSYhuElObNiamPEcSS0pZRJZ6ST8x1
 FH5h7qEFR7uX9yy/Xv23pnkzzd4R9/wAckiuRfgAAAA==
X-Change-ID: 20260731-allwinner-a733-mmc-support-c901bc312eef
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=XxPxlj15S9GHxpbr6kayVJohduiQuJOZXJICcGUo5pk=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqbMuaGBEtOXw6eyEAQdb4ueNcKXVnLyzMw+3Ow
 a8chhWa/IaJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCamzLmgAKCRDm/A8cN/La
 hR1PD/sEk5V/TmB+PixkJKTl+qwb33DuOqRp0owY1d0HZF7hDO+R6nDvpCaUe5T2Ggv5kjSICDO
 5oxaZsYafCk8FDT2kEjEMVEt8ip2q5IaCNCvU6wrOr8XntnbCJV7UAW7QDPEOxhuKET4J7lLL/k
 fdajXh53to6Jb7TnZUnws/ji73UQpptTVgcj2iowcc0/yzxYjENuvx4jh4FNKpvhjYLS+JwvL2w
 MJgvjIB3YVTHyHxFvhC+3rdf6XA47PuIuX1Njj2xn1hKoFsdRvISZedaOWqdENe2dPHcQsDw6BP
 8hJQb9pMAgorYFy53+c0SwdLz/2yS+272cUOGW4mkFY5zUfngSLFhCcA/ObOorfsTtG72l0MOi6
 Jdxe9ZOsWt77g/zNj6nNh+9L+o/Z2r6iIRv2BDJsEZe/JQkVev1vUIeoGQ7mQz1Gk1nv+Ug4vV+
 PCmxP4HikD+k3uaDOeN/tTYB5+GI7Nf4aEN5cwjt9VuXl8Q6474tnY99TqB5abiMt/zikW4vVhN
 ZT96Hz9gCkVJXSeCFxyMFimDrJb/WWhH9e5afLEsy0oPV3hRt+souELk+e/igMJfaqBNYmjgJGo
 EkeOqbsv+NOEiAHdV2BCYd/basqgQB/C27NOMLgF1N9AVz5A4EADDZdnHVBhN4vebI6e6obgoDR
 If7GJB/TYksUT/w==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The A733 MMC0/1/2 controllers are compatible with the D1 ones.
Add an A733-specific compatible string, with the D1 as fallback.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Like the A523, the A733 3 first MMC controllers share the same IP block.
The 4th is known to be incompatible with 3 first.

Unlike the A523, the A733 4th controller is not dedicated to eMMC.
This 4th controller access the memory through a different bus. This is not
supported (or tested) yet. It will require a different compatible when the
time comes.
---
 Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
index 9f3b1edacaa0..9e9610bb1eda 100644
--- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
@@ -56,7 +56,9 @@ properties:
           - const: allwinner,sun50i-h616-mmc
           - const: allwinner,sun50i-a100-mmc
       - items:
-          - const: allwinner,sun55i-a523-mmc
+          - enum:
+              - allwinner,sun55i-a523-mmc
+              - allwinner,sun60i-a733-mmc
           - const: allwinner,sun20i-d1-mmc
 
   reg:

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260731-allwinner-a733-mmc-support-c901bc312eef

Best regards,
--  
Jerome

