Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497072566D2
	for <linux-mmc@vger.kernel.org>; Tue,  9 Sep 2025 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452418; cv=pass; b=mSpCrdBXpJHaU9NRM5f3Qy1K08xEx9ikkX4SbyX2L2bCfBZaKLpghpHVdD6+kGNObnnAV27y7f8o6tQmiIKMJeEt1QHTekoLAUxi1yED85xxSFkQimfeTdAssPItGkBEJ/yE3z7ysVRJhNBXhj7qtNOjGMO+7D7GKVw06B5fQ7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452418; c=relaxed/simple;
	bh=nQ/JRUbf6h8oL3chjOuEaLCemxAqI8x4hpY+7rDjGuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PO+O+sNp5KbQa/hNYOfwmmX3tkUkfqevxVdxsDnWCveCLYY6to+orgs1owVdXE9Zdk1g3F3NNpy24dOH3TgZ7vqM0kJ3BdpKWtZjON7lgQH1LQ3Cb//8Yqy33VPvW06AQMTC97+qJk5cFl4JfGId2MtnL7NRG6lQoOn/gGFRcTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=JS9Jflq3; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=m7T8ZIBY; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="JS9Jflq3";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="m7T8ZIBY"
ARC-Seal: i=1; a=rsa-sha256; t=1757452407; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AtRY555j5AoKiFCkM/Y2u2ATRpG8aaiBrj70sh2uyZlk7r9Cw+0suWUpzoaVkN6/MQ
    YJNCCGjDI3k0sFzEUt2rqBGpNq10k7Y0LyxQARuL7Y00jJ0+Z3Mes/1A+kKsCxQwaHAJ
    x3AxfkIlNLsW8ww6+XFTjKdRHyYmsxSsDlooxsYEvblMJrub14m+8VXfq37kMfb7Ivo6
    BfiPPJPJIFsWwVYFabMqQ4gJZZ1dq+kzLz3SDGuXzLW2w6d7zJdmcuCjReaiF8b29ULs
    0YTE5bo8mX4vsyiQlbLSl6uZytZw3oVYw5sjKZ64WIUhE2fWrMn/L2KV25krPKM38VnX
    rg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757452407;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=acCecQhyw7Im6i+frAVEchQ+6cRnT28+ASwquTzU1N8=;
    b=LBGtGCDwmeuG9OkL+GBcx0UV7wLX+n6vFVPQuNQBm2/dmD9F7AlZjJz/3bUtqs1+hr
    oqvGSwMW3BJkcanlHnUrVtySYUeONQSMkq2eDgBG9KHFWuWHeJ1R3BeVWih4Retdes/7
    hQQEZ6dSLZ1i6KjM7eMJq/ShF57/c5hgvDOTobb6oyFTHuQNG4jQHWIEkFnmCLiw6BcJ
    OWG3U22zJ1a5IzgRFDtWOmUJPIuyACPzJnfTpdAyfSBhp0ngrFWZtTBqfMYGDOMXL8nr
    hcW6DLNuxhnKuKp2RZaQgOrERw+cuFiNWuYOyzg5p0AuEKeewGYJCsq1DlhcifVkvsa9
    mc0Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757452407;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=acCecQhyw7Im6i+frAVEchQ+6cRnT28+ASwquTzU1N8=;
    b=JS9Jflq3rhaPUFtApZpKcJXuatQARUrkmi8BkGo87O1vnNkUN+Gn1K2eYxdj2OXHQr
    vRn44GYLJb6l3R6M6qO7zldhKWtvbJxKeA32NL65W0/3rxwK6FuQwLYgOC3VDD5nvnDN
    4lQ6a/jFqi1u57N6qSeOL7ar7ZFupIJ6YuTpzvzqt+vIeq3A0vCZSaxlUXNaQU+zYdsr
    ku4Z2+uD/Ws+YFHDvHJ584L9iY7ZbbUlra85hb2j0nyHVzUFGv3ruUkmBZHBAWav8PGU
    H24BSuXsmPM3GsfT58sjm8MYfffE19O34LUw6E039XFAEFS0ococyAcmrKCt4FrduKgi
    urHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757452407;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=acCecQhyw7Im6i+frAVEchQ+6cRnT28+ASwquTzU1N8=;
    b=m7T8ZIBY753Mva1g+tbpIqsr9rS60oU6+ObsxvzlQQGEJeRG9p+Ezc9tkXxdOpHEAn
    qGZizXJ3orMePGu4WgBA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RCg6IWQL4pZWJy0MjKRoF1oCKjjkm13AGu0+zY="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id z612c9189LDRXSI
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 9 Sep 2025 23:13:27 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	jens.wiklander@linaro.org
Cc: Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v1 0/2] mmc: core: RPMB code improvements
Date: Tue,  9 Sep 2025 23:13:14 +0200
Message-Id: <20250909211316.1857198-1-beanhuo@iokpp.de>
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

Bean Huo (2):
  mmc: core: Fix variable shadowing in mmc_route_rpmb_frames()
  mmc: core: Improve RPMB frame handling code

 drivers/mmc/core/block.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

-- 
2.34.1

