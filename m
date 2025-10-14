Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228AE3009CE;
	Tue, 14 Oct 2025 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456494; cv=none; b=IPiMnhYKZ4+2qfLKxyda8GBReeA22629C+dcxpRG8/wlCFfioGr/KZ3aVEgUPyY+a2I+dc+nwQMe2dYu9v1zYmA4ixK3+p4NIJ+s9qig9Xb/F5rS4VQvFU8wKgo5ey5AcNsvl1vxwA96DDuWl+bpvP8NsQWXF0oByrCWkzEJi00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456494; c=relaxed/simple;
	bh=xNKlc7tVib9id/nLaOFp5eRTygy8Ayi18VAnakCYDc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fmRFYDTvPgvJHhXd8Oghyt93mmafzwtRpIw9ju7Q/Qep9+s95u2EUqAm9MmxHu19tDWZ0D/kM2kdCLFOdjkQyOsIAzipctgMtRGxr9FjsBhStH8u6aSj3b1US5hR1D49zAPCgcmkfFTbPhpePWe1v9nyI0c0GpAhFf7x/Gmt/5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oGJg/GqH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oGJg/GqH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760456490;
	bh=xNKlc7tVib9id/nLaOFp5eRTygy8Ayi18VAnakCYDc0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oGJg/GqHiVZWLfWPIaxJXTYIBFB5CgcY94GaIgiBTcLf53Rk4jAWxkmmIn7hxo4TJ
	 ZajrbmKC/5tvCDCptfuPWAuBvodSOFMSr7djye7xLFCcM/wU3NrWGHRhhynzEsOFMw
	 T6zZHlGF+8DnVvPx+ffw95KtGHM6/mxOkqeqK/n1pEjwPLD1M4EAarr+7T+fQ9b4oX
	 Rz2t3uwNBiYZqQGRBbQs6YayItMefWkrIXGv6pSvNGdxEBAbMKlit1qh6CW7QOp6VP
	 p3YDYnVP62PK0wDM4y6UHY03jHrhtNaF20OJvq+dyuFxrhOPPerDub6TRfV1FZIHZZ
	 pqlXOrrpzykjQ==
Received: from jupiter.universe (dyndsl-091-248-212-042.ewe-ip-backbone.de [91.248.212.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5483217E0456;
	Tue, 14 Oct 2025 17:41:30 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 0D102480048; Tue, 14 Oct 2025 17:41:30 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 14 Oct 2025 17:41:19 +0200
Subject: [PATCH 2/2] arm64: dts: rockchip: add eMMC CQE support for rk3588
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-rockchip-emmc-cqe-support-v1-2-918f03de0cb1@collabora.com>
References: <20251014-rockchip-emmc-cqe-support-v1-0-918f03de0cb1@collabora.com>
In-Reply-To: <20251014-rockchip-emmc-cqe-support-v1-0-918f03de0cb1@collabora.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=732;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=xNKlc7tVib9id/nLaOFp5eRTygy8Ayi18VAnakCYDc0=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGjubykcoRNXcE0GU0VpegldgNb3Ig4vh05iC
 vBVf7wreWlZYYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJo7m8pAAoJENju1/PI
 O/qajtAP/RU0L3fz1nD0qCD+UPrQAnYHY557abZNfwu/60lf2NSbIte+p83O4Tx/T2f+doxmhpn
 2J18skhpiM/S/FWJlgsswyKMDX4wQVzje9dWhRoJqxH53twIavz0XhhH7K6HQFdtGHeQF+1IcGW
 bkWrij5IH/iu4ADQYAPCjedg1wYGeGDTTjql8X0Bc858FSwRQ5xIcHTMAzMngI7Hiyps2IBkt7H
 ZLipTyXVyCQSE8vRflXsd1pawzibprRsVr2EI8zGrctIWH+dJ4qHbLFY8rGsvBTt/4gzkx8LTCX
 5ELln1wRoIY7ngpejMq0ZGx0bOB2coAuwuEwFfcCzkagzBOGTNDcqGPCxM6MgWSKcOJS+4N7qe+
 wc6gwcnTyIZ69IJby2gO9maaBbVzFZ0oPyIEkR+2wk8NlmmsZcb9VAVM+hFSWKEWteUdUCxLpUX
 DXrB3yjyGoltZ3OFVWZrt/FFndI/z4WsyFiqxOm2aFZwxFWKX2jyOv1dhjNYXf4rZ/+t4NLmFxi
 g9IdspwYBlEv630JhrcqL3Tyz9v4DNwszM+Yb7d0JGSlvf7BYo7gQ4EtA+PeZYmuEXMKi3amz+Q
 oXOM3gfpYD1ua+D1KuLMRjReoKIaqggYuXEqZK8jPQhrpohmkbE9NnILpgvclnjRcqe3GLkb0Kr
 sXPD5A2vBGqekks1GKJonlg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

The RK3588 eMMC controller supports CQE, so add the missing
DT flag.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index e2500e31c434..2a7921793020 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -2181,6 +2181,7 @@ sdhci: mmc@fe2e0000 {
 			 <&cru SRST_A_EMMC>, <&cru SRST_B_EMMC>,
 			 <&cru SRST_T_EMMC>;
 		reset-names = "core", "bus", "axi", "block", "timer";
+		supports-cqe;
 		status = "disabled";
 	};
 

-- 
2.51.0

