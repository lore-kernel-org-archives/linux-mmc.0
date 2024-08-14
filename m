Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFB660B96;
	Wed, 14 Aug 2024 22:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723674894; cv=pass; b=Mx6iETJQl5BxKccdLpQfqro+d5BMqIh2UePMkU9GDOHDUPXSfaY7wPsXsZbHVOyxnW4pWYTo6yfe693rLdUZ/t3lR4dqdYxFruAw6yaeA/kne7YfTRaT8RhVi9OmPMYOBSkZ/qqKDgZpO5EUprbqb3er508znYOrBuWy+Va6yEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723674894; c=relaxed/simple;
	bh=d14Tch+RLtJ9XEDzk8LjIiFQb1SIJJ2KbiJkxTMkftM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ok3cbHeMbD/DR8MBmXZbRWK9CH9zsncHD0IdeBNiMH5uk8YpvChcqLaLwuMiAHXMPMmv5tmcRq1bZiltScXCKLI29165lE8p14XZg9PBADwXwEEDRZV1yiBw8CLtnGWsmp6+FueJxhTRjhVUzNs7M/aKjcfFHmatKq2HGPXG4Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=jCX0mOKl; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="jCX0mOKl"
ARC-Seal: i=1; a=rsa-sha256; t=1723674873; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=m+gxuBxL93V2w2FaeUDTNPqOW67udRhfp13f7QDLVZgO3OvLZMdgJ3ZAcpVaN9ZRAHmmYDjQmYnpWHPqKz//7Ae3+ZiDalDSQzA/gcJ+jDt81XXAZxJEPhPLr5WUgcVOK3/enFhzeBPqULLoDa4uPC8/+Amr9NBHdA6aCxdHkcg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723674873; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uPjIlCVjNS1SPYz3xZ15gnUbSmsTQcJDu97RCeUrTJc=; 
	b=jBpooI16vFUVjCiOd27Ak6yHID24vINzebbpFz3t1/R93rFeOHnmM2Qgb3zVne1XoUJetdRBchaDwyxlyAmnI4mblYQmZMCuYFOyJHaMvN/6TxKfBzpVTj35Y3k7FmURuqaqat5IWI4TF62oJa+cqvBSMYheJMIFD5AsBlBPbTg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723674873;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=uPjIlCVjNS1SPYz3xZ15gnUbSmsTQcJDu97RCeUrTJc=;
	b=jCX0mOKl1LCnbqr7VXuiOpyQmqHIcCwltYwJlIjk1Nt0XPNL5SqDXUifOIKenQkc
	yeq+hepHVneX7mgYtgjF3hfn0A2Y/B4d/5BBu0qiyRUp9vyEBEHMYE9uqy6AEcuNJgV
	4+imI+Og7Xm9i/BYgK0prPVb/sb0DIe7J4tnxaWY=
Received: by mx.zohomail.com with SMTPS id 1723674871779907.7332155073681;
	Wed, 14 Aug 2024 15:34:31 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 1/3] dt-bindings: mmc: Add support for rk3576 dw-mshc
Date: Wed, 14 Aug 2024 18:34:00 -0400
Message-ID: <20240814223555.3695-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814223555.3695-1-detlev.casanova@collabora.com>
References: <20240814223555.3695-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add the compatible string for rockchip,rk3576-dw-mshc and add support
for the rockchip,v2-tuning flag, a new feature of this core.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index 211cd0b0bc5f3..0543cdb51c657 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -39,6 +39,7 @@ properties:
               - rockchip,rk3368-dw-mshc
               - rockchip,rk3399-dw-mshc
               - rockchip,rk3568-dw-mshc
+              - rockchip,rk3576-dw-mshc
               - rockchip,rk3588-dw-mshc
               - rockchip,rv1108-dw-mshc
               - rockchip,rv1126-dw-mshc
-- 
2.46.0

