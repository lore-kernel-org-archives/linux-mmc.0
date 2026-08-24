Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB8F40963F
	for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569493; cv=none; b=pMtSD5IyJJqBMo/VzTy94NeNhbrwTSHefP6/MGezOVLgLi5AGzxiaWnrmffHpAY9RipeFliw6KDu7iS7eFb5nbNbC5ksVaflaAsudKerU3cLXY6En81lQjXKhc2pq8BI0zF2flvTcaz/Yy2sXFcyLNI9Jgs8Kyt7EL9KAzBSrNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569493; c=relaxed/simple;
	bh=bn4q5LJKmckPAghAM5nPmWfmj9VUGItp3IL8CzHs43w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/oNAKnaUb8JfIjRIh+BOZlTW+IU/AYpptehsTqzDTRltMsnDCB4FKsfErMmYzfr/u6pJvUkoLNiwYXr7VLSIC4gm1Y8X02hW8DK/dVfgEHT4VUoclUJGFOT7ajQv1SSPJhiX0hagd2aejDTQdA3UhUKVY72ZELvpeggTsom3jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=XUE2E7AF; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="XUE2E7AF"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a41191c9a9so6589043a12.3
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 04:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1787569489; x=1788174289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sEqNGNEN3QI8hqb6DA/beDgL/pDDkQRhTHMi91Qgs5M=;
        b=XUE2E7AFpO2q6LVghpxYB4UUL5/P7isDy0kEXCfdOiJOM8vphYIyz6aY+tJ1emJ8ar
         kVpnB7/o2t4d6ZAJ7va3B0HSXtv3A2Dk4mWSiDWGLZX7O7J5ltIXFpHfjuHF2KIFjv6M
         yoqTpOJFHqlT4ja01LF49G5FUgt4xcT7jJp3t1ktx0BWGMbVvMefzKzpwAIsKd5ZCW7+
         R3jho/zmicaV2KIbYXTtzOk6G3/LmY1st/tIVWmFkJABE/k/GbayBlp5HQ1HqFDg9MPR
         yf8jqEdXpLv7QOGHAzT+LJ8YknH0flHtNSIf7JL43wnaWFydsDV9qsvdEbYCsrAM5wjs
         ijpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787569489; x=1788174289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sEqNGNEN3QI8hqb6DA/beDgL/pDDkQRhTHMi91Qgs5M=;
        b=dGDIlzGwIsFnnVSh+ZDBM+f5hDpUxgrQ8pJ+njgBmpDSKx35rKmIhkKcNSgnWCpb0a
         mTL0r4SLgmxLXmaAzvzGI/DiDE3RzTwgt9bHVnZcYkAGCvLdx2sE60v+fAvnQEHt4iMJ
         Dz3hJnOnn2uw6WpSu2ezRCb+UD0ho6ruSaFGNpKaj8cTONEbe8lu2oJZncmu8IJcMnQx
         e23vWECvI51r910GHe7BcPl+z0De3CJQesuTZ6KHxtPlKeM6rUcKIdL9FxwQnPBlN/BS
         ZEPshhNPY7ZE9ePjj79N8ECleAveE2hcqIdAFkQqGJOjuGbIrI6mvayOEJajoUVWDt6r
         kfRw==
X-Forwarded-Encrypted: i=1; AHgh+RqxemXmq9YUb4Sf76V47gk1qa4NO2cu1kATFk92zo3nzAWHGX4BioHpYxAOV/83FUbaEE525W1GHSo=@vger.kernel.org
X-Gm-Message-State: AFuF++loTZwWdy4fY48HztNvrRfGE9COogc5nDJq2QpmQ/VPxG5jCHJi
	tlNv7K13NHsorNm8n2jTJ5QPW7It8Tb3mp49uZAPZPpi7ASwuAEWI9gipZjKh/H778A=
X-Gm-Gg: AR+sD12A/LVGXzvbERhXbNbZtGUpNM/yAcYmQLi1qOtuAW+7mnHU95yhxVYaN0VKGfo
	S1EKykhceANEwnLoJCdkMimiZ/rKNra3ichj+Szu8rvjC2rUlm3mQ7usmEGAEpGOXTrOdSL7N8q
	KAuukv3fL8rM1EsT+fO2Kds96C0X2/wMo4ncQf3K+t8vRbeTA7L99SY/NT94UyMrniJBAbkd5Rx
	Ed1lcthQWw24z2IKV3TRipW/Bm4BPQYEAdWZwilGI5a0KrbsirKUKrNLKiIr04qg+8Q7tgWFT/B
	igUfAuccNJU/oWS0oH9UY1rt2iPHkh36ur+WqT1UyK3OLCAskVMdf3cHlqGAFMQXzSV/IiDHh6D
	W87HKoHR9plZ50dBMehL4nwnE4aHu9ZwWyFWwiVGu9wPp748KUV1DwuD5uqHqTnvF9tkBy6r7se
	lPiNswgzYPP/E9POIhXswSeaVhmDcrDCNeo+j+HjTMqXxOYeOqRoJ2a1YYIuzf09RNw3BCtcRLe
	ZL54LQh5EKBodKGwF9VQf4Owsg8wGAFLLpxsxbOOrvOHzjk0wCYGv2DKQvIqnVc9EWp8W6cEcn5
	URkaN6xCg9FI9TPpM+2VqE2F6w9pHCs7av2xow==
X-Received: by 2002:a17:906:f246:b0:c21:61a6:8821 with SMTP id a640c23a62f3a-c246a6cd384mr2330091566b.23.1787569489516;
        Mon, 24 Aug 2026 04:04:49 -0700 (PDT)
Received: from threadripper-fedora-workstation (cpe-109-60-82-103.zg3.cable.xnet.hr. [109.60.82.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496738e7esm1331954166b.46.2026.08.24.04.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:04:48 -0700 (PDT)
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
Subject: [PATCH 4/4] arm64: dts: microchip: ev23x71a: enable eMMC
Date: Mon, 24 Aug 2026 12:56:52 +0200
Message-ID: <20260824110432.1074136-4-robert.marko@sartura.hr>
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

Enable the eMMC connected to SDMMC0 in 8-bit DDR mode.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
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

