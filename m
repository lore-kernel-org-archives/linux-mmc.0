Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DBC25C71F
	for <linux-mmc@vger.kernel.org>; Wed,  5 Mar 2025 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210893; cv=none; b=u2/tX6z30WgfIfnYtk8PcP7MN7MfqUxJ24MEI1m8Fjyz8d2rz3L+BkCVA+uibv7PBRmvs5xRFEHJmw/Lh/LoFRqpFENrr2lG4zsCZsI3mocfad50oO/OLLTxK/NzHGW1y+tGEnea4VOUY8/ZFHmD2RIbCDMs4CifUzYoQRT7/wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210893; c=relaxed/simple;
	bh=gpaeu0tUxQ2w4OgfcPYCDp9NVi+VNcPLQfeSN8MIcPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkHDWpTRdfbD3ohsawz7KognOZxVJfnq4dyEbv5xJGN/dSdCgWF71piquPAhWHjdFGYCQPHpy5fPw/1AWeYK5oQAW/vAmYCa+8aCO8urzPLifH37HvwmNgi6azS9HnAsp316s9qvKbS+9mRT14gyKEWMn/eHCAUr1sdAS+347r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=wtzHAwpH; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="wtzHAwpH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741210889; bh=WqE1n99NX7sDOMxvh/YQ7fTw02JcT3CgFfPo9BuRBnY=;
 b=wtzHAwpHgwuX4JMrh+kU8cgAHomqBz93uu5HUzeExNyFs6wyxFzcZP/8+D/utDbZuqURaF5kT
 e/oRwLIx0k8xbEd+pbbGrQ1j9oN+mg5s+I1F8TjfuZyIWfQJJir3QkYeOMDsOVjiiPFC5vsfq8z
 1hcBh7+P4jtUasrg0vvHOoA8Bx9zjsMWZz5RFHCSordJrzFajx/VRdfAPOpLcQnjC2cMz4pwJu5
 4Z03EXwFeqIFnOibbObQZ6j+CzxryxcjFMJphBuSY5JxH8pZZo987yxUBacoYPQcjXtzaaX5U6y
 IyDwcdDe8zWJZLznxJaQ9mNdOqp6f30Vhb002GOsdO+w==
X-Forward-Email-ID: 67c8c50588fb7bbab4530f6f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/3] arm64: dts: rockchip: Enable onboard eMMC on Radxa E20C
Date: Wed,  5 Mar 2025 21:41:04 +0000
Message-ID: <20250305214108.1327208-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305214108.1327208-1-jonas@kwiboo.se>
References: <20250305214108.1327208-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Radxa E20C may come with an onboard eMMC (8GB / 16GB / 32GB / 64GB).

Enable support for the onboard eMMC on Radxa E20C.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
index a52a7924bb75..a511e2a2d4a5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
@@ -16,6 +16,7 @@ / {
 	compatible = "radxa,e20c", "rockchip,rk3528";
 
 	aliases {
+		mmc0 = &sdhci;
 		mmc1 = &sdmmc;
 	};
 
@@ -155,6 +156,17 @@ &saradc {
 	status = "okay";
 };
 
+&sdhci {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	no-sd;
+	no-sdio;
+	non-removable;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
-- 
2.48.1

