Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8CC38E5FF;
	Tue,  7 Apr 2026 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775560606; cv=none; b=A+KUT64d6MsCHOIVeJu34/iBh8WNT/20H10ltGQvEOiJomxYnjEK8XW+x/v0Yl/iIUwczo2CBux2lH1JanOM8ywrQUlHTKFJ2yhkzD0ZNVo6VfzhkMs/0WtcT/hYR+8FLyFyk3KkWJpzIk/bFUW2XU2Bz2Zl2tDlK2btWLLWoy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775560606; c=relaxed/simple;
	bh=f9rJgEDeBXdkiLlUJYzj5FIGQ7eAGGBKP3aOjp3S/LU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y91BokfpVPY/53UgM2DRh8R00QQDLfpl4LY86RU1lhZSggnvS/6IR0I9eGJJyfL4PYGHCjhPa2Vqzt21FGtCObsQycEi762HB2lP113hhAKwXvNX1JmYgUA7RsGrkSm05K3hdYciIXmPmWGfsWaTLXsiUJNIBDrD1rDsVqYYfX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC3ZO9UO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC3ZO9UO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D25A2C116C6;
	Tue,  7 Apr 2026 11:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775560605;
	bh=f9rJgEDeBXdkiLlUJYzj5FIGQ7eAGGBKP3aOjp3S/LU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mC3ZO9UOyH5u/OHAevUC740KNVmPbGSs4bFlpHtQhTRnVmYqpjqskCvWkq4auZOFi
	 /gcRKWs/RjUt0aCMaSiBeNKENiltG2jTGNLH7IIrMtVE0Xax79WMv6GJ8LuF7hYty3
	 me8yuUngn5tqsZLMHhnmiAMbvBTN/aJoEIQ9lb0RkwoDAVe8INCQ1SbmkPMnjS1HOS
	 kE0s4jaqlcmrK8sC4CwAjryRkHsnQhcauyfnYitC9dWZxjB9nXYZShvNWbg7TYL3s5
	 acUR5c5fM4kouGq60cfqoBxp2GR3p0A8n71b8MADnzwLEuczfP2uAzFqjB37r326je
	 cWdsmCdSinFXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C949AF46C7F;
	Tue,  7 Apr 2026 11:16:45 +0000 (UTC)
From: rohan1sj via B4 Relay <devnull+rohan1sj.cadence.com@kernel.org>
Subject: [PATCH 0/2] CQE support for cadence eMMC host controller
Date: Tue, 07 Apr 2026 16:48:19 +0530
Message-Id: <20260407-cdns_sdhci_cqe-support-v1-0-13efc0810631@cadence.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPzn1GkC/yXMQQqDMBBA0avIrBtIokTsVUqRdmas00VMM1oE8
 e6NdvkW/2+gnIUVrtUGmb+iMsUCd6kAx0d8sREqBm99sI0NBilqrzSi9Phho0tKU55N42rfWhe
 oowFKnDIPsp7j2/1vXZ5vxvm4wb7/AIwmb3J6AAAA
X-Change-ID: 20260406-cdns_sdhci_cqe-support-41327016d9df
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Milind Parab <mparab@cadence.com>, 
 Swapnil Jakhade <sjakhade@cadence.com>, 
 Manikandan Pillai <mpillai@cadence.com>, rohan1sj <rohan1sj@cadence.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775560710; l=683;
 i=rohan1sj@cadence.com; s=20260406; h=from:subject:message-id;
 bh=f9rJgEDeBXdkiLlUJYzj5FIGQ7eAGGBKP3aOjp3S/LU=;
 b=432Rs2W5eB5m41kztGx+gFDsAfvIwUFnaqjxxkMe+OVIhO8ftsmmauRwYMEFfG82VRMrtc6si
 QM+qaStNeoMC7fNrm62sMkgDkf6heFcsBpCeE++xwYDY5CtWIEe/IxA
X-Developer-Key: i=rohan1sj@cadence.com; a=ed25519;
 pk=YuwylizMVlVj8I4+VPMZ6xrFR2wyqJAWZyj90OVZgD0=
X-Endpoint-Received: by B4 Relay for rohan1sj@cadence.com/20260406 with
 auth_id=723
X-Original-From: rohan1sj <rohan1sj@cadence.com>
Reply-To: rohan1sj@cadence.com

Add support for Command Queuing Engine(CQE) feature. Supported in
cadence controller but driver lacks the support for it

Signed-off-by: rohan1sj <rohan1sj@cadence.com>
---
rohan1sj (2):
      mmc: cqe: Add CQE DT support for cadence controller
      mmc: cqe: Add CQE support for cadence mmc driver

 .../devicetree/bindings/mmc/cdns,sdhci.yaml        |  32 +++++-
 drivers/mmc/host/sdhci-cadence.c                   | 118 ++++++++++++++++++++-
 2 files changed, 146 insertions(+), 4 deletions(-)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260406-cdns_sdhci_cqe-support-41327016d9df

Best regards,
--  
rohan1sj <rohan1sj@cadence.com>


