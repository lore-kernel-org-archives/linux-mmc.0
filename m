Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9107A4EE867
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787607; cv=none; b=GZLkE6dTt40ieqMM7VSGFS8Lu6ZQtWF1zchIrnShtxxQjBE7/OwAAAWOu7lX7v7UUcBa/3jQiQ9bJIlaEqHt/4DbYH0E7AVgkiFgE1aePrbxo2J/X2CI0H1yVoMFhYzhRhSZxtMEIj/FUmFwgJ61MRd4MHut8Mdl1dzvEBBiiZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787607; c=relaxed/simple;
	bh=vDebz4UsJmjORwt2efyOGqFPF9BjJ2eSha3yv6WZhk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXEjed6QRzCKLRveabCX8b3Cg/gqLnEuitCtuUt+/LNCxye42aoDTNayoTlQ76cf3B5JbhlB2757vxLvlLT7iDBlwnEsXfyZVidCLnHn0h3g345DC3XmWCMKRTIAjjrBQ12DL06pdI6i1Bj8SW039qAtl5FJjmj4ENe79H3hyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=uMH5bmbq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="uMH5bmbq"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2530cabcf4so542995566b.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2026 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1788787599; x=1789392399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1f+YXy7SbvRq8mPftGLFWh+1zroaa0JiAwnQyBtt98g=;
        b=uMH5bmbqe/Ac2Ie1Oy7U4c3dDiCIq2c3isL+VBJbrZfQU7VSC66VVNOPpLWWdRzCGh
         o/1C3iFVgvrNVzZpm0irIbzZ32fdu23n08bR7S7pljQ4/kaTwit1m8nOIt7G0V91JuU0
         Zgpyn/Bx9fQhtT0lpMAL3QPZ5LZi892+kwXYMMX2jaMnfD2dfYoV1glgr9sa48gpYVsL
         T4uw+lqsvfbgbuopoVY6oPflJsBQH3svP9DDcQSOHxYJu1sKrOxKDKCqm6MqeZ6kWVVA
         dDUHNUD2hQKhgo9PTbWs8dNZ2xpvKiP+DneBC19yugA804c1WAr7ivjOL1SmmCAlxWmC
         gIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788787599; x=1789392399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1f+YXy7SbvRq8mPftGLFWh+1zroaa0JiAwnQyBtt98g=;
        b=he6PTU9FYD70DPSvvL2TB2B4slGgTYbG6XIPhcJOIGQyYFU13eGWSICnkyLjm3dLs6
         SUm4olSPBFbdUvNzknxLETwvbyv06/vE74caEbnUxXvaZ8gADsNAG6NEdzdRqbbFVaSP
         WqZ2FoZLE8ooUwrqE7cT6VCiYAQsY2gb6v+Xah5/Swoloc3rQVSBRTA9mMgzvKlx/S/I
         M0xvon5xSW29OVdfZgM1vsvNOcr9/0GyGOKspxUtfv5FkM/IdeBndHBcREIbVUt5ICkL
         SdOP41CzMdfltUPJgSQDEhd8z3jUojdzJe0tpEMUmF0rFoK0UQfsqyIDHvnZ44lt6vFn
         f01A==
X-Forwarded-Encrypted: i=1; AKwUvBwiMVKP4Bh4Brie38zybYr3JgkGTNE1uiBBJqB6kFuxCXGkxKOpusBMtrft5m95P0hGczB7dVBpjtI=@vger.kernel.org
X-Gm-Message-State: AFuF++kdGwHVU8M/JzA3zRywzgD4Y8aGe2botT4SeR63A/1rFwbJ1WFe
	28ABUKwfOTqjQDziZ15HyvAO9SCyDDGcmjIPzaITMKx1gLJhaZNQU5WylTeRaUQC1EZNeJh8kfu
	NMRPH
X-Gm-Gg: AYBFou2yjplAUbB72blsmabjGk52OclonR8R5MZt4yMowfOCa1zFWv1zOUMgdRyXoso
	E1usMRmsCfYQjX7Zj6kBQoPgeu9MgaLBo1qBUNFTKTXSGtNwRhyQ/44r/vJIWYaG7xkp5rU6TxW
	ATpSgomUx81tt2oYY87Nq38Lcen9/YzPebogyzKfXigNe4dT24ERmIt4X/mKAcm9ZqfAg1DB9GG
	24jS/T9/IjHwK901CAJsuTSxdZNUx+9sSRb8S7LG5sV0/JegkSTOiI07mMt+eJXRK4H2yrQTS0N
	n1PYUWJ5/1xq8xcVekggRTr44TGzsaroXCPUklKFNQjSKY7eDsRRs7C/zB/QmfeOn7DDTf18/Bt
	3iEqA4R55yuvRrXgf7kZ7bXvEQekhSN9lpRf9cs9xE+u2uSs4NmVypatZjJnREeuY/54lbRhIyO
	K+aQ7lFUzNDCuONXLHFvYzBFwlN86PVsEe5UYcP+nQUQd2JJ9BCM2Z+lH0Hp1EDsaHwAnvgCMX8
	pL7/0zdRoGxbyRpvTdYqIJWpe4380+SNONqHbuY4eH7JSHRW5L++GF693WrkqmVrNHqLyhX7MB8
	nO3M7JdA1UWBuVpc+NSsvpXUE+K74AeI9iA6CA==
X-Received: by 2002:a17:907:3f24:b0:c25:58e:83ff with SMTP id a640c23a62f3a-c260c9f0348mr1521074566b.10.1788787598895;
        Mon, 07 Sep 2026 06:26:38 -0700 (PDT)
Received: from threadripper-fedora-workstation (cpe-94-253-164-142.zg.cable.xnet.hr. [94.253.164.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2622a7c677sm366362766b.9.2026.09.07.06.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:26:38 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: ulfh@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	adrian.hunter@intel.com,
	aubin.constans@microchip.com,
	ehristev@kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 6/6] arm64: dts: microchip: ev23x71a: enable eMMC
Date: Mon,  7 Sep 2026 15:25:34 +0200
Message-ID: <20260907132617.1198548-7-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907132617.1198548-1-robert.marko@sartura.hr>
References: <20260907132617.1198548-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the non-removable eMMC connected to SDMMC0. Configure its 8-bit bus
for 1.8 V DDR operation.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Remove the unnecessary maximum-frequency property.
* Expand the commit description.

 arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts b/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
index 985ca31e74e7..89a161b87d6f 100644
--- a/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
+++ b/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
@@ -478,6 +478,16 @@ flash@0 {
 	};
 };
 
+&sdmmc0 {
+	pinctrl-0 = <&emmc_sd_pins>;
+	pinctrl-names = "default";
+	bus-width = <8>;
+	mmc-ddr-1_8v;
+	non-removable;
+	disable-wp;
+	status = "okay";
+};
+
 &serdes {
 	status = "okay";
 };
-- 
2.55.0
