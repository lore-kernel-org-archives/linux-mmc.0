Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3430D2DC77C
	for <linux-mmc@vger.kernel.org>; Thu, 11 Sep 2025 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623488; cv=pass; b=OLeJxxuWO5YPE0vfS3RgTT7geRphiR6+etgzZWyPreh097egURRG3JDBz4aSkvvGspWJTXb9fjGTLOKF/h/qbA0rfbBH9hkiOy6OHwxduW07Ydih0GLoO95CAQWpnu/l9Ewh/QRparqbJfam8mxI4+OwNRBj12gegwhW1upmtXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623488; c=relaxed/simple;
	bh=P0r/PBkGfkAhl4s3cWJwj6fhaOw4IUHsM9PBWxVo5DM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=h3Cckyg+j8WOoa6DOBLo6odpk/qs3H1Hy6LktXbUokvPsM6WvKK8ZHqgIL5xdyUsWxicvlYFqSwud2aAypG2hVy4rEA5CVgJK3bJIq7qxxjmRPd/OcLVse3Tcgy8CbhVsszZthO0OWEWTmUNn5yMuGBGlOMTPS75NIfUFqh2IhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=Rs44TMhL; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=D/BOLDXO; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="Rs44TMhL";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="D/BOLDXO"
ARC-Seal: i=1; a=rsa-sha256; t=1757623474; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EKCogv85fAcfSF3rbVDH3zQvgb8GKck2DpNm5U8stTRk9v0KEqkKOXjkTK7ImTc53Q
    76HEQvFQZGxahVlUZOP7k6fauzcugJ3mUR0LQLYIVj5y5rMCrGYhyK6uDpKoVRJkjfgd
    63aDv2xTI38+IAZs2ZFJeyUaZgQQdV5FBirNSVGvgBkxEK8Hu3CcIzv40IEaqAu53tUm
    LP553sStDMUC1yMXWC2CjOThWjEc1hQg/Yy6/KIWVYdGsefToAy/xpEMpXbjdWHr4id8
    1+r6e4ckD9gy2vcxEn6/WznB6nUvtUaeIhAIhfcWHhRe0yabgz7Eh/KgT/AL7QieJlZc
    0G3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757623474;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=J/vsMDbSKvqmjj+GfSxlv6VHplVEVEJwrg2KyBKcSBs=;
    b=c7Ti1TAOHibDmt4F7CQ6y1rNZyeCatMbs/13Bfc/nrCl+US/BzNYmH913qQaA7sHde
    E1n4dPYVaCBEZkMzkKQHnPDpQE296eULyWoB39H+JQX8bDV7od3YQuN1vqYlMRkSmb1z
    viQQ6RKe8TbIq4/cREFVurHMgYB8AvN3RyNH/7E7Exh7A5qGxBpd8Iv+VxccgK0ekxaF
    GO/Fy6e/SHZwxUOtyrYLw8IIMgZILhYkySRh2KWqhR4xvyADdBw5vw4JlQKrN81ha8R6
    PPQ5cx+sRqouu2Vu0+51TiKSZUQK3eexV9uVDho6n44MdVPnCV6HwpRZa/ieKGzzxwyX
    MQdQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757623474;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=J/vsMDbSKvqmjj+GfSxlv6VHplVEVEJwrg2KyBKcSBs=;
    b=Rs44TMhLfP4uiN+rVA01jkNjECSXGXYIFQ1T5sVIzWfUN113tpoeEJlGLkhPi4kCa+
    FxjCLMk9xOMkvhRfjLE4RxUykiwH/ido+03LhDT0TTlo2TMqZKllsVowdI3vQ9GY+ixE
    dypJOpRZZPSfWLqRKjW788IP2+MSGcdMf3n1D+9Mw9DP6iZBCV87Yf85vOg+YP8NCXv4
    iX9yHhjAlxPKBDtF77hNzEyH5ia2vM0ag0oKeNV1aFYlIe6JRQJwk97v4YlY7rNWhTX5
    BmFZIeR6nFf1gUwr2ZThOET6lUGZRgi4aFjiFDXFEsEBYZluFveE3Cy7Nxwe2S7Eq3QY
    LeGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757623474;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=J/vsMDbSKvqmjj+GfSxlv6VHplVEVEJwrg2KyBKcSBs=;
    b=D/BOLDXOoN11SNQawh/ozMAKBjdsa1DM6WRjYDb1bShP2georPNw53JRrpqFY+xicZ
    ndutbC7JhEjAASdIM2BA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RCg6IWQfI1ZDZOzYzKOl2SdacNvyFh1H/ghUw=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id z612c918BKiYhe9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 11 Sep 2025 22:44:34 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	jens.wiklander@linaro.org,
	Avri.Altman@sandisk.com
Cc: Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v2 0/2] mmc: core: RPMB code improvements
Date: Thu, 11 Sep 2025 22:44:24 +0200
Message-Id: <20250911204426.394260-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

This patch series improves the RPMB frame handling code in the MMC block
driver with several code quality enhancements.


v1--v2:
    1. Add fix tag
    2. Oncorporate Avri's suggestions

Bean Huo (2):
  mmc: core: Fix variable shadowing in mmc_route_rpmb_frames()
  mmc: core: Improve RPMB frame handling code

 drivers/mmc/core/block.c    |  34 +++---
 drivers/ufs/core/ufs-rpmb.c | 225 ++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufs-rpmb.h |  26 +++++
 3 files changed, 267 insertions(+), 18 deletions(-)
 create mode 100644 drivers/ufs/core/ufs-rpmb.c
 create mode 100644 drivers/ufs/core/ufs-rpmb.h

-- 
2.34.1

