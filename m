Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B513D21A420;
	Sun, 24 Aug 2025 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756033342; cv=none; b=N7cjcMpZAv59+ogPZefqoekDRS3aKlCC3nxRx3c3Ut+DpvsOr9juWJQg3Fazliph3KjywnXvd2JbW/Whftf6ILsBEVSgqCVdnMd46Ea81LMwi5U7vb8ETllB8TEA5nauaHkoXvq2Tui9voNF/7xaugP3oxN4LxL13q79eh72NbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756033342; c=relaxed/simple;
	bh=EixpysKAIvvREIFmvNs0d6fAR4lvmNdRaNvlYIy4tIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HiOn4BzdbFIrx1M2ys2sOwLKWljevZvYW7r3uhvyMwgGkxRQGVxqoxfPd40HgVS6G+JPSCSzdsvn6Hgsj59uq/mUBaGLvsQFT1Tr+/IE70ZXu/XF56OTUptPmAGR2/GajG7WMxLXaF7qrxMZHz32e9Zr8X4r/acWHxNhkTRUvP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=cc2Z++b4; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="cc2Z++b4"
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1756033280; x=1757333280;
	bh=OGnQkPRlH98mt9wQWfSE8wUVZ07wp60aIMEzez2gDUI=; h=From;
	b=cc2Z++b4tC2PdEcsyBBvzTrrvTVj6TFMbX1+hZSM+c6Zrd8lPpAKa2ye3AR8DRCfv
	 ff4sqtFeT05XJ3i87t6DFmtLpwcRlx4XfLGASv0M1ur40CI+iPmKyg/rBS6olNLJdX
	 iQn6O4er3Wql4Odf8UbjHEfrOSCckC8Snx5l0LaQ5a18mNo7rMByf4vsroip16yl5n
	 LFXldcORgLRr67oLNiyYIbXw33Sv2JfjRKcBPzCRk/YFSnGb4BHHGhtlbmynGhYw0G
	 NInib4mqILE1vLI2l/83jhpCAeDN3HZplxP+wBPCZiELNm99WklG+auV+4ykDJcDls
	 hJg8uwy93Iyxw==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 57OB1HZD083627
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 24 Aug 2025 13:01:18 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>
Subject: [PATCH mmc/next 0/3] samsung,coreprimevelte enhacements
Date: Sun, 24 Aug 2025 12:53:42 +0200
Message-ID: <20250824110039.28258-1-balejk@matfyz.cz>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

here are a few patches adding some of the stuff that have accumulated
since the support for the samsung,coreprimevelte smartphone was first
introduced and before it made it into the mainline tree.

The patches are based on mmc/next because it contains the new support
for state_uhs in the sdhci-pxav3 driver.

Thank you for having a look!
K. B.

Karel Balej (3):
  arm64: dts: samsung,coreprimevelte: add PMIC
  arm64: dts: samsung,coreprimevelte: add touchscreen
  arm64: dts: samsung,coreprimevelte: add SDIO

 .../mmp/pxa1908-samsung-coreprimevelte.dts    | 185 ++++++++++++++++++
 1 file changed, 185 insertions(+)

-- 
2.50.1

