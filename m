Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F093D524E;
	Wed,  6 May 2026 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058217; cv=none; b=NGxvRhsUmkpLaCoSTBMcKgF0zRgJvwD4Ro4LwsW3KCs/imdBgeFRZOJ7VpJwSP9xktC6jYxYyT+zOQZidyh/FVgFPQm3DJbfGZxTFkYNGc69yV1q/xO3FLXt7SHxiA5cMS4IyjxWWSQePabNj5sJgPFSNGUksG0v7T0wWbTGivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058217; c=relaxed/simple;
	bh=R86z2z5X9Mizw0diYfbrN06l7sl3ZC0OUD+cdNlUl40=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lC7hLQsY6CJzcCmHxTcB6aHd9JG07f2G/H9DOM/QZB1HkX2lefTc685EuTuO0I0SJGklbALz36zenYUF1NdilXsQat7SmYORJL2hhaHiwc71Mk6nDRDoC4ZXJAU6VidVPTRiCh19cuMPVx5BGM5xrO6bMLNNcdY8UBtMcJQ0vzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xc3yKJf8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xc3yKJf8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6053AC2BCB8;
	Wed,  6 May 2026 09:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778058217;
	bh=R86z2z5X9Mizw0diYfbrN06l7sl3ZC0OUD+cdNlUl40=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Xc3yKJf82KgmUqTVpxsr21JoXF7vSnuO6igUrbZYdq5WJPwNJoPY+VmADwHIOGsdg
	 5hOKzD1LmUGKEVh5HYqfVevGjVTKINczX1dU5hzBhAG1+vs2Y94oaiyASg7igLPrmx
	 AhSqDv2yKdRa0xKQkNroLtvcLIej8rtBzGz+y2Q4NXEjI5IkquZYfrpL0BsBJ2Bs9Q
	 HXjGM7kZoKtqcy2usOocPnmJi8CpI4VniZu8/9ZAbLGact7axwin/ciFldaXvvU3gj
	 1+uPKenjhl4gQt5W0INI+Pv/zAFKbs6Xc1QEoZKXKXiFtS/tDNJMcbAJN5cP+1TAqz
	 WmQ09lIPVvUBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9B9CD3436;
	Wed,  6 May 2026 09:03:37 +0000 (UTC)
From: Rohan Joshi via B4 Relay <devnull+rohan1sj.cadence.com@kernel.org>
Subject: [PATCH v2 0/2] CQE support for cadence eMMC host controller
Date: Wed, 06 May 2026 14:34:45 +0530
Message-Id: <20260506-cdns_sdhci_cqe-support-v2-0-754fe4de8b65@cadence.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC0E+2kC/3WNyw6CMBBFf4XM2pq2UCSu+A9DCE4HqYktdoBoC
 P8uj7XLk9x7zgxM0RHDNZkh0uTYBb+CPiWAXeMfJJxdGbTUuTTSCLSea7YduhrfJHjs+xAHkRa
 FyXSLZA3Beu4jte6zi2/VwTzen4TDZtsWneMhxO9entS2OyKZvPyLTEpIoVJqURZK5qkqsbHkk
 c4YXlAty/IDq85a2NAAAAA=
X-Change-ID: 20260505-cdns_sdhci_cqe-support-388542fced5e
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mparab@cadence.com, pawell@cadence.com, 
 sjakhade@cadence.com, mpillai@cadence.com, rohan1sj@cadence.com
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778058298; l=1274;
 i=rohan1sj@cadence.com; s=20260406; h=from:subject:message-id;
 bh=R86z2z5X9Mizw0diYfbrN06l7sl3ZC0OUD+cdNlUl40=;
 b=r+1ZTkjKRPlzKq26xTqTJhOSdtEBKFton2eI/H8NdLS09Q9FRDEHItz5BF5U+lv+t/xDO7Vlf
 5Y3hPXw+WoUDraYZmxSx5oOgVm2MSLC8jIiFfW9YAGJ7KuSIMoo7zOb
X-Developer-Key: i=rohan1sj@cadence.com; a=ed25519;
 pk=YuwylizMVlVj8I4+VPMZ6xrFR2wyqJAWZyj90OVZgD0=
X-Endpoint-Received: by B4 Relay for rohan1sj@cadence.com/20260406 with
 auth_id=723
X-Original-From: Rohan Joshi <rohan1sj@cadence.com>
Reply-To: rohan1sj@cadence.com

Hi,

This series adds CQE (Command Queue Engine) support for cadence
eMMC host controller. The Cadence controller can support CQE which
is determined by reading a non standard capability register.
Updates to devicetree are also made to identify CQE register space
which may be used by the driver.

Signed-off-by: Rohan Joshi <rohan1sj@cadence.com>
---
Changes in v2:
- Use dev_err_probe() for error messages when in probe path
- Updated commit messages as per subsystem naming conventions
- Select MMC_CQHCI in Kconfig for MMC_SDHCI_CADENCE
- Drop new dt-binding example and corrected existing one
- Link to v1: https://patch.msgid.link/20260407-cdns_sdhci_cqe-support-v1-0-13efc0810631@cadence.com

---
Rohan Joshi (2):
      dt-bindings: mmc: cdns,sdhci: Add CQE support
      mmc: sdhci-cadence: add CQE support

 .../devicetree/bindings/mmc/cdns,sdhci.yaml        | 41 +++++++---------------
 drivers/mmc/host/Kconfig                           |  1 +
 drivers/mmc/host/sdhci-cadence.c                   | 13 +++----
 3 files changed, 17 insertions(+), 38 deletions(-)
---
base-commit: 6d32b7db25329b4492f35a79fed6b1eef48959d2
change-id: 20260505-cdns_sdhci_cqe-support-388542fced5e

Best regards,
--  
Rohan Joshi <rohan1sj@cadence.com>


