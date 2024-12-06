Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE02279DC
	for <linux-mmc@vger.kernel.org>; Fri,  6 Dec 2024 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474939; cv=none; b=Jmm095EClhflefuGiKbiI0iYFw1bNdAGnM+kpDwVeEfHKP5L03CogQA/FPRklkz3gNcwt2Y1w1mPdQ/CgeRvSziNsINRGCG9IrKUzMPe0aVtzx6tfJvKyYkelHgTo79j0evysk7HTw5jFrUmGylIqnTZp/xK+2RyOVq9w6Spkqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474939; c=relaxed/simple;
	bh=utjkZbDeEMTthCs80VCBUvjS3enz36ctYpoj7DLBIEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MK42mCiDdfTObBNhmz36HW43yLDTXV8K7jKnjiY/Rx5HHd9/AOBY24wBEwk05kZ2dDYJ5J+ylFCa0m5NGC/eNE7I1/2arzbraAcrR0e6F/kRGdlDIXRdKGTJkVVDtINmYW1UuekGUTAVdU4HwJ4jRcO0UIBt1E34Ili0ih4LwPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AD+EvKMS; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AD+EvKMS"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30039432861so560921fa.2
        for <linux-mmc@vger.kernel.org>; Fri, 06 Dec 2024 00:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733474935; x=1734079735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1+KHZbWUUIbfPMrkQ0dg3yxh8EkZEBHyzYKLApYVQfA=;
        b=AD+EvKMSiOilJIqp62aW6ZPUUB1rC1LCIqSWSIjJ6rcEwtVc3TRLKj/NytlOS7mME7
         sidpkXc6eHIjY5eDC9ibYP+IZmxwR+RFMd0qAjh29kaWVWEmMlkjzDpY4cQHOx2rFwkQ
         i9dHIxkXc7UZTep/CtoaCIBENsbvTb5NLDPm57ozrKDlNWj4VhHeQXBZv+0DPMJAK4HO
         LCwj3IwayqoFmbHXvnsDIKUNIcqwpNbC1qSqqiu6520tsmZmpL50GBeKoUaqv1GqlSXh
         pqGZH+2eL0/wovW5TTwPV75SaOnOrda4PMwvGvl/yVNVPcTgW4ViHIjscH3YRjqyp59M
         CDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733474935; x=1734079735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+KHZbWUUIbfPMrkQ0dg3yxh8EkZEBHyzYKLApYVQfA=;
        b=n7rcuFqHtK/D/De9IHw3ZtyPOU7tSJQU2C/eVATNqkV0ZLHpD7AIw5C/WgmJmFBYC1
         Q9ivnM2T225bivBYfX3V9d67fNVtN4GViJi6duvURFyPNGa6pQUUyWI88aXAEE9D+8C9
         S4ha0GacpMP4YFPvsYzHZX+hEqGmGdub6qRXSqhuw3QLANIIC4oiMYmvlTJj3HWz9Q/f
         73BbPNeJOefH9By0wEDFIPvkNPSyI0gcSyhn7K4ECi9fJBGwvMx6p9X6KtgBNnjBezxY
         FmZSfFKZv8Z8EDOJVuq2y0hIVM9xm/zhmSXjRWVQSWQas8/gKhNuC84prF6U1y1rk6mO
         1RFw==
X-Forwarded-Encrypted: i=1; AJvYcCV6LWDDLJ6mP5um35UelwtGGXvXbu/g7ia1dW/iU9i3bPNV9PpjY3/IMS5OWnPFOQyNzE1+YHsxKz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7qafdHLKHc8mhKwIJzXDf7H9TTRR3izpGS0x2gH0LXbfmg2mf
	e+nrZ3Ymr54ujNroEYl54OqiLZ7dFP4up1PgUie9TtoGfeyCpw/vhcEhYcDjh0Sxz2EgkUFPHLV
	w
X-Gm-Gg: ASbGncuUsBc+scytGdm4rhzAwmj/uQTpEYEcg+Dgi0HhGEV83/dDFGStnGRPq22e3Ds
	QbnBvx2LZ+h/VxsVt16D4+/BNA7iH6GEcQzizGjSuUePyTVhwxS7E3qcr3+AMJZEMS4wLU4IiPK
	QEWGLR6NFzUsXQbuGgyORNegU5y7GmheRDjjM6DajIu93mWBc/xbz0BsikADMmbfuydDEUew3eH
	ZfJ2cQvAo+CFcGxLDGwsYzHP5vGtWQp98qoijQSHsamLuvPtX61jAW+JLrYoM7tuMPSToF/0DIk
	l4VzPut5KaXyGFfCmCFN2wBv
X-Google-Smtp-Source: AGHT+IFhY/F+2PQCWkWIZiH6/atvzrmubiERnGlL5oxg15r9QqhSnIsJkiSQjR3EzbfRECrt0dNZkw==
X-Received: by 2002:a05:651c:505:b0:300:2ddb:aaa5 with SMTP id 38308e7fff4ca-3002fc92a19mr6541821fa.30.1733474934985;
        Fri, 06 Dec 2024 00:48:54 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30030799f35sm1374041fa.93.2024.12.06.00.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 00:48:53 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.13-rc2
Date: Fri,  6 Dec 2024 09:48:52 +0100
Message-ID: <20241206084852.119710-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.13-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.13-rc1

for you to fetch changes up to 87a0d90fcd31c0f36da0332428c9e1a1e0f97432:

  mmc: core: Further prevent card detect during shutdown (2024-12-02 15:37:16 +0100)

----------------------------------------------------------------
MMC core:
 - Further prevent card detect during shutdown

MMC host:
 - sdhci-pci: Add DMI quirk for missing CD GPIO on Vexia Edu Atla 10 tablet

----------------------------------------------------------------
Hans de Goede (1):
      mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on Vexia Edu Atla 10 tablet

Ulf Hansson (1):
      mmc: core: Further prevent card detect during shutdown

 drivers/mmc/core/bus.c            |  2 ++
 drivers/mmc/core/core.c           |  3 ++
 drivers/mmc/host/sdhci-pci-core.c | 72 +++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |  1 +
 4 files changed, 78 insertions(+)
