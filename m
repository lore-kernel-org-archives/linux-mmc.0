Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C40F4E8DED
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787606; cv=none; b=r85oJncqLQYnpwpcE2pAufQqXZCpVI745xU/7y376ON1BblsSfEPenAzmZXSoJlHtHmssh08sCbXfFOC/Xe296sLwifllay52HBcaDIhtgMeXrD5EO8keNMTJiWVi8J5Okd5unV2osQDXZ3sI2Fcw9V6xqF/hWqRzYKfFOdR7sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787606; c=relaxed/simple;
	bh=xb8hi4uuW3KBK62XY1yYI5XdCz67rzTPXQ/r+H7c1GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7ZzgejS219zRajdjhKq16d2juNlEXaFtI5K8Zh+mjnhKS6pyIKXLB1DI0rvNn4SNIDTcDUlOKnLgoLkc/51fbXu+FBD+vRqJG+iWWuiHBZk8bTG7iayflB6f+1s5AE14Zn14brh6NQ/DxM9Zx+L3yLmVaI/bK4QZXKO+mnIkVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=UgrvRRAT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="UgrvRRAT"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c28fde3bbd2so84329266b.3
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2026 06:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1788787597; x=1789392397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4soDR+0gZiqt37Lbe4DFFhbgclQyHpPTsvSalKhA+JQ=;
        b=UgrvRRATI/dMOrr9BHAIcGsFGYw38dnHEJoJEDjj/kP2pgZlxqL/8kDZfnW+jUPe5U
         FkA6ENYCxXD+NcgA1NbbU+zDAH7+Gk92w2+P+8JnMpYd2ASsDRZW7cnp/CHR5H+iUGxr
         CeFXkI9InwuPFG/OcxZgrnK8C14uDC/pD/ZQ1HThJv4K0vvTysNS7CS9Tv3TOeNVvTio
         99Ph0nuADUTIVaPamcBCMEDhC09gHuj/4k+hu/KgEVmKJobLsNqCA9/fwBeNK7rzsrY/
         q3Jgx4KQf67bUdn6F2NrfEAbIdkAbNW2tKvOLNBV4/JwtncNvuuqEHWPn6E2LNwBTD+K
         aGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788787597; x=1789392397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4soDR+0gZiqt37Lbe4DFFhbgclQyHpPTsvSalKhA+JQ=;
        b=Emx7jR4m8ZW53NPPFKJLWnbWTkz537lzkuiFTZ8W5zRW/Rj3XFE+9X7i83E4bv2nD7
         oivwWVBC1i46uPFiXGh9G7eHZa6W4cvG+bf5Q6zEk56C5gCXcOMKGIQgmVtErA1cD/2H
         LcsthVhkUjx+hOpAzNXhK49CjM+kN7zHW+PDzsnLCABLfI0Sd5PR3pF5YTUzzcPMwLlp
         zZhb8G3rJy4r1qBqRApk/ke6HzDO6MhJkGerDg0uybOnzRUwWM7JTj0aM5OfsVXU8Y0k
         jVrqmOxgsiirAClm+TQvo5gjRGB2VehxeUVjSSkD6tcVSGFYMtL8jRzzTusby1DRAIZm
         KNGA==
X-Forwarded-Encrypted: i=1; AKwUvBxFElxMlJLHlTLf2PYTsDHUfFWZZkjHcaY8pI9KvpEKtXb7N6YeLqutWDPapemo6WBk1ahzwbOGSZ0=@vger.kernel.org
X-Gm-Message-State: AFuF++kr33A3xHZ9ahup3LBqBCIzJSPjAv7eo5gyU8f3CUa+daWACg/a
	+VPiWUvdx4X2A8eEAPAos5/GUzbqwZGQO+fudPado1eFAfhsGj44FwZMa0A9GvHiYTc=
X-Gm-Gg: AYBFou3h3FJ9khT29BTBwx0XUQB+8NDSCEoT500mZCMdvchyiv8oBHjZ7RFvSgEfRrZ
	c93dvdJmyYCIGu5PzXP9v/13A8O9psbH8pkkW2clbuDKivxulq7C9cuLJmWor5O/KOvmqy7suCV
	3N1tadg/yZvOMv2qwIr+//6EJ2c28UvcPEIH68njewT8FuzFpaDU5IFjKxVgx/4nxmfzM1FHeLi
	+x6xB7Kkb3ReIfXTWQ1tdeKuhMso0F7lqVq3rxDX/YEfEn63rXdyO2m1sPzi2HzH+bSOfbkCd82
	3WtX9A/c0oOPFe4gjHEdfR1gfegoHZF0lsAhYS1y+e6i8SFYcJ31/s5ZO67J+RMiMxuz2TQllvC
	owJnJXm/qA+SjQT75UbzonvB52RXzHjXCu27N+Y1IXxlTF/tm1HlrvuYGfHCK6qowLfywLCy/9M
	11et++dYjIgvc50kmadigXq602njsruQrouYVTo+dMwi6VlCOwZJbhXVbLC3Ef9XcwCwCgTLWlH
	I3uEYohziORqPAdt1KEX8lAuK6hEKHHLg3h6p4HVcv/RcwWr3p7boDkAxn/LuXWfRoq0By8WGTm
	Ib1pqMjpHVV3OvgrebOsKrGx1HEHBBe6yFNUNw==
X-Received: by 2002:a17:907:3f8b:b0:c28:e01d:1d10 with SMTP id a640c23a62f3a-c28e01d2ae8mr393259566b.49.1788787597442;
        Mon, 07 Sep 2026 06:26:37 -0700 (PDT)
Received: from threadripper-fedora-workstation (cpe-94-253-164-142.zg.cable.xnet.hr. [94.253.164.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2622a7c677sm366362766b.9.2026.09.07.06.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:26:36 -0700 (PDT)
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
Subject: [PATCH v2 5/6] arm64: dts: microchip: ev23x71a: enable QSPI
Date: Mon,  7 Sep 2026 15:25:33 +0200
Message-ID: <20260907132617.1198548-6-robert.marko@sartura.hr>
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

Enable the QSPI controller and describe the onboard SPI NOR flash.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>

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
