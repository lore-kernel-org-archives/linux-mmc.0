Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B33009DD;
	Tue, 14 Oct 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456494; cv=none; b=n14ZNvKWiGstWMpPf5J3TlwGP7KgeUh851kjOD0rB4m6ID7VeZSQEEvbPDtxeNAkmx0m/+fWbenJf16BK4e/tWXd6QDg6rPhe2Oe2gEGHeYDT5wKtOE1D2ZZvPiBFpTEeVcYVeMKhb98gqJGexwF5WO+7VJbM+YQFLqsGX7fhRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456494; c=relaxed/simple;
	bh=yt07u+0NUCcqdY1LR4Mje/e/VBZvQgx13+AxxYZ7hkI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jHeD0IzdrfZmkLCjPjbAR5U9pPs4CVV4smYDxDF+YjagGoX2qC79zb32abt8Vqd+FlYTTqVggb3ormesiuYIldJ3coM4GUXA6FvluIqMZCCn9hbl8wYMHoFGqDh/vKhY231bPell1I16ZzY1N1js6OcpFYsc2IbmRtDKrz6JNhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E6crkLSw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E6crkLSw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760456490;
	bh=yt07u+0NUCcqdY1LR4Mje/e/VBZvQgx13+AxxYZ7hkI=;
	h=From:Subject:Date:To:Cc:From;
	b=E6crkLSw8oYUZtPK36HPD7D5DKmHJDoweQRHfHlbcke2HeReIDqpQMpUtSMwfDyac
	 ANXhKM66b2NzhXBNJacAApyjHTjCxaui6gBQgofv/k/4rSJ6Z1xF1bYtGMl19LpFbJ
	 oONR4ci78ljqut5BvkQquwVP2DqZol4BJ2Mdx9qIDL1Ym5oKTthIeYx5fHTyo3Z+zN
	 J0RMVORI3W0kmNvfEEhFYrM6p8xF3qONghaIsqcsb6DeIgGzs/ZQ2FoEbVbKZE/Ezo
	 tBpr696b9OE/8vrioKaINGvV6iMlS6ZnZSSfOADzNj01wLCu306CHkgvlGvUuTMGRl
	 JUi43e+Esl11w==
Received: from jupiter.universe (dyndsl-091-248-212-042.ewe-ip-backbone.de [91.248.212.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6615317E136C;
	Tue, 14 Oct 2025 17:41:30 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 0B271480044; Tue, 14 Oct 2025 17:41:30 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 0/2] mmc: sdhci-of-dwcmshc: Add command queue support for
 Rockchip SOCs
Date: Tue, 14 Oct 2025 17:41:17 +0200
Message-Id: <20251014-rockchip-emmc-cqe-support-v1-0-918f03de0cb1@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB1v7mgC/x3MQQqEMAxA0atI1gbaqiN4FXGhMWoYtDXVYUC8u
 8XlW/x/QWQVjtBkFyj/JIrfEmyeAS39NjPKmAzOuMoaW6J6+tIiAXldCWlnjGcIXg8sajMO/eD
 sxxWQ+qA8yf99t919P2zKbXRrAAAA
X-Change-ID: 20251014-rockchip-emmc-cqe-support-370dbab21623
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Yifeng Zhao <yifeng.zhao@rock-chips.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1660;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=yt07u+0NUCcqdY1LR4Mje/e/VBZvQgx13+AxxYZ7hkI=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGjubymL1rrccQnGTcYPFLn6+anTlCNGlsNK9
 i5R+5tX7k/TkYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJo7m8pAAoJENju1/PI
 O/qaxc8P/RKFdIYJpCOvbeUtPfFzJOb+4gKvudUx4kKlxkmPWTfrgjxHYLtW/VGE5IBRjxXiXVk
 VzIu0pr2XPKzCBYXpw/b7jtad6xcFwuX97hy+Qz56t8eFwBzFVZoENPQtYOCfSM4qMgIsOSpBmy
 vNUx8W+6TvOgzTVVP+EtvE0HgmygpX8PVBzLDCJh/r0bbvvpEwJ5sIsT1RAtPx/oB2O+cxlLaKh
 1HHkoZJlt8hSitA6lKn4LR1ZY1so/WoyDn/9Dv/TeIbKiH4HRSfUhU2n1GdLykvDYhbep4OtVKU
 OXs1AxF0EeMyhOSU4IUAaOf7q9FzVVas86p1UDiS+joFYs4o54n5TZ+YYcntyGqXBeE9b1jzRX1
 EZY5CgeMb9qFJuld57+AIcPz6EAyli8eJBFXcBgBMKBvlQng4C2WenOQmzsx2+Z0rygsmkJUAEK
 zhLFlRFJoUPvSlLI6NjRcb5I9LXqZR8PJrj2NEfyzq4h8fggradPr1lkgwZPqFA2juOd7fH3P81
 zJmW4oiu0RddQjirfU7rcS382KkkrO+cIyyd9TF8s/wUK/ifHUgl9ooJTXnleix4tGL8Ipt9eze
 XpFBcrx+skGSwOW7C5Pseoj9rafeSBKU/aSKMDlyKlwvDVFXayV+V1zxFIZ0yz9OReXDZd4r49m
 o1F7UM/HWGwUcOlQtyr42/g==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Right now at least the recent Rockchip SoCs do not support system
suspend with the mainline kernel. I'm currently looking into
improving support for the RK3576 platform.

On the Sige5 one of the issues is the eMMC controller, which fails
to suspend when trying to disable CQE support. While investigating
I found a missing Rockchip quirk in the Rockchip kernel, which is
needed for CQE. Since the RK3576 DT has been upstreamed with the
'supports-cqe' property (RK3588 does not yet have it), we run into
this problem for that platform.

A simple workaround would be to drop the 'supports-cqe' property,
but DT is supposed to describe hardware and the hardware does
support CQE. Thus let's add proper support instead, which also
allows adding the flag for RK3588. IMHO the patch seems a bit
intrusive for backporting, so it might be sensible to drop
'supports-cqe' there instead. Thus I have not added any stable
tags.

Note, that there are more suspend related problems on the platform,
this is just fixing some parts :)

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Sebastian Reichel (2):
      mmc: sdhci-of-dwcmshc: Add command queue support for rockchip SOCs
      arm64: dts: rockchip: add eMMC CQE support for rk3588

 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 85 ++++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 3 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251014-rockchip-emmc-cqe-support-370dbab21623

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

