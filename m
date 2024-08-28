Received: from a7-45.smtp-out.eu-west-1.amazonses.com (a7-45.smtp-out.eu-west-1.amazonses.com [54.240.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6123B19E83D;
	Wed, 28 Aug 2024 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858697; cv=none; b=RPeR+6tvpDx2A9XDUMhawb+5t1dASuH24/VYxgau2BGVKKebp1LVHk2S3MNiikPWO+7862gQxdFOf+PMELEf4NBu298M3Cc1HQ9rc/ty//49uSYtzWHUWwvtrXl2vOJLBw5vnMHDbQAHb//xV6W6v0bRkVWUuNYD2N81HGPuWFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858697; c=relaxed/simple;
	bh=EpZHRzb5vxXqStDRMR2abxBBT9XwtEmAmcq/fLiwWyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Db+Qt7nEzsrr37PU1SyQSzz4IC5mpyVTzqaK4ofY/K5yNsVps9vw39LzvUYEbRIrf1dkXqMRcdPTmhlp1mghEyQsBk4iCGuxvlqUZ4CstvHWZJaVTgkhC/1OJ5ZdeuqhNxUMWI8YHWIixeE6rBz+4s1IRmKyywrS9A/5PD8jAvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RsD8UhDq; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=BEJhkJOV; arc=none smtp.client-ip=54.240.7.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RsD8UhDq";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="BEJhkJOV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1724858693;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EpZHRzb5vxXqStDRMR2abxBBT9XwtEmAmcq/fLiwWyw=;
	b=RsD8UhDqdmkZlThC6YlIbq4HN/sxjXVKJhjXoQMj6O7irjHS2wbmbnNDCSxVC0mu
	2JtguforWkU/pLTNPq+mBMSYjfthOi65r95YdBFUozro/6bUnHuNAtzgjSo+3LFmIhp
	xHPrMfvHgGT8tqB3Mp5oBUS6KfKVm2T1zZyRVK6RmXngkohT5HDX6wg6C68nCCb5a7V
	taDx7C7f0nDQFmBEzQw0S/JYC7gK2fS6qb6kRH5Ig64ybYu0j+E4w3ZH8Q9FotWSDJ3
	75ESR76FCW8EdePUswS1ge551iwRUHT1/lm0aMCmxo6VMksAPt94762JbYxo/NsVYTM
	0r82BbWbJQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1724858693;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=EpZHRzb5vxXqStDRMR2abxBBT9XwtEmAmcq/fLiwWyw=;
	b=BEJhkJOVjwWoEiVM/fsR/p2Nk8VPtzWgltasKsa8+jk+SueLJua7aMinItvqTfir
	e/AA/bNImD4rm/THrRSzqgBZjC/q8uy+xpwTMXxjqJ3WM8kGD4Kgn0DGwJ8wV83v3Ss
	KeUEM+hrb+oBor5L1YpiEY0FQTVa/hIJXM+TJR0A=
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, kernel@collabora.com, 
	Detlev Casanova <detlev.casanova@collabora.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: mmc: Add support for rk3576 dw-mshc
Date: Wed, 28 Aug 2024 15:24:53 +0000
Message-ID: <010201919996f687-08c1988a-f588-46fa-ad82-023068c316ba-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828152446.42896-1-detlev.casanova@collabora.com>
References: <20240828152446.42896-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.08.28-54.240.7.45

Add the compatible string for rockchip,rk3576-dw-mshc in its own new
block, for devices that have internal phase settings instead of external
clocks.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index 211cd0b0bc5f..06df1269f247 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -43,6 +43,8 @@ properties:
               - rockchip,rv1108-dw-mshc
               - rockchip,rv1126-dw-mshc
           - const: rockchip,rk3288-dw-mshc
+      # for Rockchip RK3576 with phase tuning inside the controller
+      - const: rockchip,rk3576-dw-mshc
 
   reg:
     maxItems: 1
-- 
2.46.0

