Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A7B13B787;
	Thu, 22 Aug 2024 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724361890; cv=pass; b=jytkarap2xOaUPK4oOpxkked2Mv5p9WBc1FxviFmqUU/JvsZ1bJZ0m0qAvdzisk3jLLfP+9WKbCSPkLCf+sxLRkn1zdaiZh4K2waNASgARx8X6nprjCXuSjEVtpydFRUIe9vU70Xj2rCCPsEq3hb6SzfTo5eeA8GE/Adcw3uZmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724361890; c=relaxed/simple;
	bh=ICrnL6rDq0KFDlmlNTnM4OhsZ7ZcyyXWbCLjl+lj6so=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dHRFJAcZvUKmqF8zM/k7/OCxXf3ZEOmazBfYSXqi9HkMz8nruyZFME9mRngYoEslOQ1VApnnRF2lyVdmu2LL03eSFYmt0bs0DW7AbEHHYRoRTITGtyzAVhne1UWEklxFI99TpJzMDoNqI8wftJGDO1NS3d+q9nwk3uXQRttCa18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=Ey+uSNBz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="Ey+uSNBz"
ARC-Seal: i=1; a=rsa-sha256; t=1724361874; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KsM/Aicte0O3wbRU8ZNhz2ZFlBGDMpKJoZX4khZuNwD3U/jw3hqtiL5dsaqXgsSiYmwjYHRahPcKdZojqK1sbYxPmKw1cMtAEE4a09PHFnkA82WQEc7el7muV53UALF0Tpf0fGMeRKsP0Ag73s50bU8wlbtUitp3Cg9ouGtGCFU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724361874; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=U3Q3VhQHQ/S9J4oJ9vFhburznxZd296yZsat0qO4gXc=; 
	b=UdIyT4Ou7NvPvreAmHMyM2rqqXPugld3M6IdgVBHvykuu6b1s71jLEsPmHj4U+mLXxsUtqmrLwF00aJYISHwoREXIwPbqDVSsHHfyaUxGB5h2Oq3UwEaTS8hEXNwHA7GfSPfPBmcJXjUDsyX8jafJZnQl9YlcWUmUbb/ePHntUI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724361874;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=U3Q3VhQHQ/S9J4oJ9vFhburznxZd296yZsat0qO4gXc=;
	b=Ey+uSNBzyRG7LwVYhuEFHyc4TMMzy4swFeKVLDMDya2BIPsJ6lXOe/wjNllwp8Nf
	NoKijpDz4SgS8nTvwDTQ+3jHXDSB/XPVcKJ8V3+RYdX6h5t5xYsEkrBM3YLuYHvy37F
	ngmt+04DTVWBRUDODPFnNmB5yle91ptvtdwRMEBs=
Received: by mx.zohomail.com with SMTPS id 1724361873146805.6918577651234;
	Thu, 22 Aug 2024 14:24:33 -0700 (PDT)
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
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v4 0/4] Add dw_mmc support for rk3576
Date: Thu, 22 Aug 2024 17:15:30 -0400
Message-ID: <20240822212418.982927-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The SD card controller on the rk3576 SoC stores the phase settings into
the dw_mmc controller, so the code has to be adapted to implement that.

Although the feature can be detected through the USRID register value, the
decision to use it is based on the compatible.

The compatible for rk3576 is added in its own group of compatible to mark
that all devices compatible with rk3576 have internal phase settings and
don't have the ciu-drive and ciu-sample clocks.

Changes since v3:
- Remove internal phase auto detection
- Set compatible in own block, with own dt_parse function
- Add internal_phase variable
- Use function to set clock parameters based on internal_phase variable
  instead of multiple ifs
- Use different commit for skipping phases higher than 270

Changes since v2:
- Drop rockchip,v2-tuning and use compatible-based detection
- Fix coding style

Changes since v1:
- Renamed use-v2-tuning to v2-tuning
- Rewrite v2-tuning description as the hardware feature

Detlev.

Detlev Casanova (2):
  dt-bindings: mmc: Add support for rk3576 dw-mshc
  mmc: dw_mmc-rockchip: Add support for rk3576 SoCs

Shawn Lin (2):
  mmc: dw_mmc-rockchip: Add internal phase support
  mmc: dw_mmc-rockchip: Skip all phases bigger than 270 degrees

 .../bindings/mmc/rockchip-dw-mshc.yaml        |   2 +
 drivers/mmc/host/dw_mmc-rockchip.c            | 220 ++++++++++++++++--
 2 files changed, 207 insertions(+), 15 deletions(-)

-- 
2.46.0

