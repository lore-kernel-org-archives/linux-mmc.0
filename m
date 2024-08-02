Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65F175D20;
	Fri,  2 Aug 2024 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612908; cv=none; b=mlXKK5DOaBLJk6CcK+hTzVTfqRWYnO2Epm1nEFm18h3eLvyu1/zc7DuuNv46coTgt2aKCGNCcDRVA63EqQlPsbb7uIZgnYBbZEQhZIoE/ZH99YGhnGo/aRVVeF4ok0FsT44tyU0DerlRFcJZNhqQVjrKmUNLpSS2zkdhK7CRbvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612908; c=relaxed/simple;
	bh=k5rIFuap9u09uK4DFf3V6w/o37SuG4BJxHIP00dzT/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ceeK2xfB50hsN2G2/uZU4TtVAaAivdBMtL2VTRQFNYDV9uAIK1uprHw0rqUHVIIPFVNpiRFM6ZL59Tl+hQe0VraSLMxF3p3UWPFT3t6N4+FvG1RYzVLm8QnONcUYxpvOxIhf2eyn9zvNTWQw2zTTAhBksSVWfOxQ7ZK+3t6FU6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=15wWideh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="15wWideh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722612904;
	bh=k5rIFuap9u09uK4DFf3V6w/o37SuG4BJxHIP00dzT/o=;
	h=From:To:Cc:Subject:Date:From;
	b=15wWidehvvP1d0fUCgwMWS5h4SN6RPQUX90ZDvRIaSEhKdErdn8heH8glxWkbYSWA
	 WdamB47lPsOz2Ze+lvi2mV/lm8b3ywNWUiLRPI+iWoHuG/uYjZvxj4qRKLUAr3AFwd
	 +of/UK1AaZ8agJgWpiQWPpTchQcGA/h99F6bjsTPFX8OfoVxjfB/OJYmTWCQIBFS8h
	 u3qIe5NNJByDhxzgJbEPhvEA/DVr4D+ysR39ESExInRVeb1Mpz/q3SAMEKUWI2JKfF
	 guKr7AKPwW9JWHfhMup4IseDQ+r+hI0N9N4VWMe5BUB8+5vEfNmzS8UbcwFUkHltJK
	 UVTUhaJCHL4Yg==
Received: from trenzalore.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0D4BC3782212;
	Fri,  2 Aug 2024 15:35:02 +0000 (UTC)
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
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 0/3] Add dw_mmc support for rk3576
Date: Fri,  2 Aug 2024 11:31:26 -0400
Message-ID: <20240802153609.296197-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SD card controller on the rk3576 SoC uses a new tuning version that is
capable of using pre-boot tuning information.

Also, it stores the phase settings into the dw_mmc controller, so the code
has to be adapted to implement that.

Detlev Casanova (1):
  dt-bindings: pinctrl: Add rk3576 dw-mshc bindings

Shawn Lin (2):
  mmc: dw_mmc-rockchip: Add v2 tuning support
  mmc: dw_mmc-rockchip: Add internal phase support

 .../bindings/mmc/rockchip-dw-mshc.yaml        |  11 +
 drivers/mmc/host/dw_mmc-rockchip.c            | 224 +++++++++++++++++-
 2 files changed, 226 insertions(+), 9 deletions(-)

-- 
2.46.0

