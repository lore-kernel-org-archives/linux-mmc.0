Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE671DA55
	for <linux-mmc@vger.kernel.org>; Thu, 11 Sep 2025 21:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624957; cv=pass; b=dTchBNgOw3hmxV4DqIRLDH3OaxA79B0jhKSZNET+G1Xr7XKqP3E59wKYzIpIVyhTZl37zI3s+JaWvZ2NaIiDXWcjXHls9tjwiuSx3yzaak4GTHRCRiSk8NRPY6hPJt7ZxdkH+QO9bQztZClW4JM49GOoLBP9xGPlNP3UXZaoBaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624957; c=relaxed/simple;
	bh=nzCD6urvjRXO/z88OH5LPeJJjS3F6SYTUL0sxo2oMb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=t9YBR3mlKbz4jGiDOJNmmx54fBAVmdi05NpmKaRPVPjz7bwFm3gjp5rhvIQW82wvRyE2LffpN49rsrg34nilur+LLvlyIkpTZofa9wKWXitzIPQGHfomlQjq278da7U8Y3S+52Qlj1zhyltRJohy33fZ5M+l9betdSYpmBq9XDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=QRsdKFvW; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=ZdzdIrow; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="QRsdKFvW";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="ZdzdIrow"
ARC-Seal: i=1; a=rsa-sha256; t=1757624773; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DMRDbpkFE2zKJAjZpszjYqXaD1eKWA7J52gJhFt/xaDHjMABBnEltiq43T8rKYZP29
    StSNqCts62jZ/lfWnFEQoI0G73hyYMPr+6ot35qpUxz26zSrmtEv5hj3zLElU0s6ocF4
    gqGVi0HqmTZXBc9QfYODW7pTrDCqf13tHE4Sz5i4iIWfxycCgDcJnvbIhxL4bB4ipy5Z
    nVWn4r8AKTC1QLeOunnhs0NwNypHbeEp6dnDP9spu/2AC05Ly2GU8LWr8p0WJXodo1Dg
    UhKPMzIbSRWVwHdBd/5tqxqztYpACwL2zZYPfcNKx0N99DuUmDaLyHZquazMv1eehM2w
    /lIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757624773;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=AvVtKkTJRKNP0DHgsqZjqhB387TLZcgjl4byxrxiWd8=;
    b=NIhVsSYAQhbRd8E+UEZkS+fpHigzHsqwMxWVDtuIt7qIcL8HpUZoJLlsWb8PbZLoNg
    tsJW7DcYVNByCoT1qmVv+2Ufws+J3NN7sW8ffc6HuJeLptJcOW9dOmii/qo4A40W95Ar
    zTdzmCk08cQT6l/Zyk6h6uj/xj+D3FpYsdAojUOygYUmPT/Y/dRagbXHnlLxafV9qUll
    p8xY1cOgNMFTfy0WK6kqABMK4spwykvhnOl5Ldy372YRPCHIhyVWYGXmLt558921vB0U
    LPyzbiPY2rmT0fkV3C3MM6Mmga84a1fR6j0foOy/7DbCc2wxuTKUZIAnIdacU3U+ml2H
    o9gQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757624773;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=AvVtKkTJRKNP0DHgsqZjqhB387TLZcgjl4byxrxiWd8=;
    b=QRsdKFvW4WkVDdze2oudbVezkx3UH631WijBs7gz1n2tQd8MuiEe+gMckx9ob2rQYD
    WjveNsHzCRxYWxQFT4eByBfErduPY377tWe0MacNKrikWYrBusnpO6TWKxNymEVZPjUw
    4unD+BUDSncLdCpCAkal1uINuKirrGgA+RmPfwyEeGD1+uwnNhp8df+iDBm9b2BVGPPT
    MIgri1/QJRitgdr8y3nNOpvRRDc68dt+IB4mMdfPz9/Jswx/ieelQGhL6hGDFj/JOsBL
    owmbYQJZKH7BtlivVgO5gYV+CUP1IJJl+QzrsIvPREd3ALg2DsifS4dSntgQREmL05mt
    PGmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757624773;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=AvVtKkTJRKNP0DHgsqZjqhB387TLZcgjl4byxrxiWd8=;
    b=ZdzdIrowFH/ENcCIEG1e+JSS68e2Suq2mfKOoSMbvQllu0FBCaKfMu6UyaRNvKJGgJ
    Puhc0e4z405/GZ2DFhBg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O256fJ4HnWXON1RCg6IWQfI1ZDZOzYzKOl2SdacNvyFh1H/ghUw=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id z612c918BL6DhgJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 11 Sep 2025 23:06:13 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	jens.wiklander@linaro.org,
	Avri.Altman@sandisk.com
Cc: Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v3 0/2] mmc: core: RPMB code improvements
Date: Thu, 11 Sep 2025 23:06:04 +0200
Message-Id: <20250911210606.446355-1-beanhuo@iokpp.de>
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


v2--v3:
    1. Previous version was mistakenly mixed with other changes, dropped them from v3.

v1--v2:
    1. Add fix tag
    2. Incorporate Avri's suggestions

Bean Huo (2):
  mmc: core: Fix variable shadowing in mmc_route_rpmb_frames()
  mmc: core: Improve RPMB frame handling code

 drivers/mmc/core/block.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

-- 
2.34.1

