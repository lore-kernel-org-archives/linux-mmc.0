Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE3140860D
	for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569490; cv=none; b=E+pLMnGo1WS8T8zLTqF1giE/9J8Qgvg8FF7cEAuEYI+KHddsq8tC+CMkFTJC5l2GT1U2Q015lXlfIn+6s6EyjbW08BnJhiDcHkEyRrgCCU0vjwN9r3yudE/kW8DIOnakF+WYqgahpLyBnZ8662xo/SAe/fdsbl9MYJmuwMHCPlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569490; c=relaxed/simple;
	bh=6sOjX178g9suBGxYcRFc9I5M5RJoMeqIT2nUal1phc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7pMoLzihQrJMmX1U/bJPO/OQowTrOq/kFSoZ9P/j6LlECPXUYvZ8lGUUTTRRomJpOP/W4JQOANQP4aBpEVJ4n0MV2Mic/WiS6s7cW6tiW2H5mrp490ff7yBCJS//mjOeWx/09XDY7A2UW9BQbtvv5Y8CbviwR+zyAVaBa50USo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=cXAeUfGR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="cXAeUfGR"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2055f5a993so372114866b.2
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 04:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1787569488; x=1788174288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0j4qmzLAQl+sVGlmTA0IeZm9e3K6ICC0PLOlup5PmHM=;
        b=cXAeUfGR8yPcNwONp8GiDOdKtPoQ0EycGYz3lKM/8wEDwS0XWAQ480G/e0qU7hMmKq
         XYto+omCHdRHVITcA1JRN01dWGVq2r0Ij7XrAL/mINjx3ciX0mPSA4wWkscQJjs6TDQt
         J04V/qCMmafoQHzs/ynJhVDEZ7ifhVQr3fbLjIhJ+QF4kIZ8p/3MbOvpZqr9z/yBnlkA
         v3grBbbX3KsBAxwVxQkN8QJ0+HzMDObDzcfvtbqHb0lmvDtTW2xMdVz/YvvRATyrlLUx
         f//hak68Y3mbFy7tIYkH8Lqku0K5DiY3tPrqS1JQSdcsMUJMfhyJV/eE7mNxrARblouj
         id7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787569488; x=1788174288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0j4qmzLAQl+sVGlmTA0IeZm9e3K6ICC0PLOlup5PmHM=;
        b=J/G2mgg+Qh87CFO25QkbB2w808axSvRj57ccxoTyHgCJoaBGouQ5qRZ4zfjYW5Wm45
         ZR2sOT6KP6h0heUvhWHat7Pgpun6yw/kvjDevEHTtG45J23giKn0tOH+OF66YQG1+AH+
         Emk7qHVcMpIunCFkemNetrV1zBlrMWj5XjMrbU2USpFoXVZ0PnYaMUnNI5QM5qDbtn2h
         PRMmbU/xmcPTsWdGi8TA4/GtXeyJJTR95SD5H2yQUn45Af8u9PfWs82PCobIx1m7U9V8
         cY1yQATkvbYbqZSLU87ch7j59CrwG4aL3ryovc9dRksp0g/Mio+E08lkji7Tl+tm18m4
         2ypw==
X-Forwarded-Encrypted: i=1; AHgh+Rpmf58A00mwse41jM/JKNKx0WRUx1uu6CkYzdBfPMDy+zGdRMeiaLMtt68tucNzWiSwTQxMdnKXG0k=@vger.kernel.org
X-Gm-Message-State: AFuF++keuM/LIwLZlEoDMb2jq7L+waM/PEFdjVvXevEhsxm9xV20C874
	AAYs+evD3vwnDRsLbYeWRsKG8eMDj6yEfQ0gV1vHF9mGtBQvI4D9sR5HXeKF+GsEeIw=
X-Gm-Gg: AR+sD11vTgzfzqU6H2OKCIsWFAL1rCFyzYNc6OvGeaEWxk8Rk9xLp7+JAX74ltHixO6
	Kn4SN/mfEk5XZyyzjWI2yxWMWYlWoO9Pr3AWCruG0rSPVfp5hbYzETv3mAXze/5ixW5anoe9Vmj
	LvgbcKs+O9p8pnEjLvBdsAeII2yz0z/jzcSVA/H+qGrLDULwFFe2B2VgkCSggxCvygkJniJ3u02
	+oov+11hUt7zcMMrT6iDlslruCIxuxB/9Qny1G1BAs53OkYH7byeZNrj2AP114Y1NGXZQ94QgrA
	6Yqcd46GukdtnBnN4Cx+yxQyt09nBa/er4JV7K4Mks45Ds7cXFfV9DmtuwD51D5ZkiMaBjf+9kn
	2rxArukqr9gJ9h1A+MWd4kHW49Y6MYDS7Yp0svIBQzOuFZlXtUZuKls0RdLWVPVRkd3V4yUoxiW
	qIyy1Yr+FdO93qbEjBBeOdLtIbBYXsWejeT/8rkM6mhatKdR7qxZ5RPgEV86K1U/Rl1wsvvKFFB
	oBphGJ7ZG8iVVJuBSoRogy3ZEaIMln0xaxJoHcJ00Yu0AX6+jIj6FeKUEfwwq7f4tpbfGItS3EG
	18sRcbFrNTaB2apQO2efz6rrVdVlzwPtQ4M0Ag==
X-Received: by 2002:a17:906:f049:b0:c24:6045:2a94 with SMTP id a640c23a62f3a-c246a39f420mr2623291966b.4.1787569487786;
        Mon, 24 Aug 2026 04:04:47 -0700 (PDT)
Received: from threadripper-fedora-workstation (cpe-109-60-82-103.zg3.cable.xnet.hr. [109.60.82.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496738e7esm1331954166b.46.2026.08.24.04.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:04:46 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: ulfh@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	aubin.constans@microchip.com,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 3/4] arm64: dts: microchip: ev23x71a: enable QSPI
Date: Mon, 24 Aug 2026 12:56:51 +0200
Message-ID: <20260824110432.1074136-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824110432.1074136-1-robert.marko@sartura.hr>
References: <20260824110432.1074136-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the QSPI controller and describe the onboard SPI NOR flash.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../arm64/boot/dts/microchip/lan9696-ev23x71a.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts b/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
index 4012ea7d07bb..985ca31e74e7 100644
--- a/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
+++ b/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
@@ -463,6 +463,21 @@ phy27: phy@27 {
 	};
 };
 
+&qspi0 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+		m25p,fast-read;
+	};
+};
+
 &serdes {
 	status = "okay";
 };
-- 
2.55.0

