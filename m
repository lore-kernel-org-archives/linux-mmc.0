Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D92EFD89;
	Thu, 28 Aug 2025 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374705; cv=none; b=ZtZWkshRj5zqYKPoW0hFpzeypm1LlFk6BkdtvQ2pSt2rbQomy1MMRh8d2055ADHlL7uv+vrDeXuNFbe4ecyX1/fld4yKljQSEqTVuz+r19QTsTHWo/zg6NUF/+HJHu7t627TgRrRBEmwapi5dzRG1+Z9iXmbp9JlsdEpEg1fAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374705; c=relaxed/simple;
	bh=0j79ZBO8hhooBmUAdyajxr1xuXT2PU23IopDz0S5JnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVPnUMuF/wndPpWiTxggeiQ94ihQPX6XwFDIa7OWf3H0CvDUoaYVWMqcrdD2O9YaHVzRy6k5w2AKrZzNbLWsbUCDSFUKzRB9rzAdznFZIJb7Kc2UBc0VqO044lnD4B//ZymtROTY6SaJqbpkcSouZlgvZE6VB2uXJtB1xChSRjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=ZGQQ6g3s; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="ZGQQ6g3s"
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1756374648; x=1757674648;
	bh=K80fcFHY5a9NMiV6VDmMXpSYx0HJpChBee/Af1LV2E8=; h=From;
	b=ZGQQ6g3sXjY2uBDKqFvSj9DZUls+aYnNlAbu54TFVxWNN9wVpGMbzDp/fR9whOz0k
	 SaXW13W4DlWwJYiiLssjRjFhM5Hrr6DEpaRzdt299yujkq8RG0XtzEsdAn7aa6aGje
	 9PIgT5zHRk9xK/vv67jMGnct+XEkfgx2ZvnbBGVDXgQZB16pc4m0f4I7puo2HsWBoE
	 wyq7lUhD93T2wMjvbP8BHMghvRJDA1l0zBSBj2vZJ+vsKQ5H3jx9k4geyYTpmb49ub
	 Qtg36lRGUs5IuT7qKiLcTuUqM5+Ej2qaH6TfPtV/OOM2TWb4OSN4Od1r5GkH8DpLGC
	 KvXANzY0ZrBLg==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 57S9oh2W046271
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 11:50:44 +0200 (CEST)
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
Subject: [PATCH v2 0/3] samsung,coreprimevelte enhancements
Date: Thu, 28 Aug 2025 11:49:01 +0200
Message-ID: <20250828095028.24503-1-balejk@matfyz.cz>
X-Mailer: git-send-email 2.51.0
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

v2:
- Drop confusing patch prefix (thanks Krzysztof!).
- Link to v1: https://lore.kernel.org/r/20250824110039.28258-1-balejk@matfyz.cz/

Karel Balej (3):
  arm64: dts: samsung,coreprimevelte: add PMIC
  arm64: dts: samsung,coreprimevelte: add touchscreen
  arm64: dts: samsung,coreprimevelte: add SDIO

 .../mmp/pxa1908-samsung-coreprimevelte.dts    | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)

-- 
2.51.0

