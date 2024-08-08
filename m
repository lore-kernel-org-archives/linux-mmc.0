Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9650518EFD6;
	Thu,  8 Aug 2024 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135681; cv=pass; b=gv8qipXd/7eE17GxmLbP4gm7o84W4WAH4LzMEEsAf9Stx5dXjhs6OjSQMV9eVBw4brnQUpOHUahqs7Dd8bGjO7it7i4ZSWPCQ+SrhFPLZrg3FV4VmIqa6Npy2/GyQNeu7Zt45+av0aotkuN4XTV+VEo4AlbmbdI2AGD61eSONK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135681; c=relaxed/simple;
	bh=frUZPk+B2vgCA2rLrhBB2n8oaGmWQIXH0lILLOdcisQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i5pLzfVkiEppzrUYU4YPhLgBpwcVLJs/puRMCaO+tGnJt5ze8eZoFLwF9hIGLTpbsRetQtmLR8MoC0HfliVo6HaNBefrT1R5M66U5b/bNr6iXbxdDYlvEoU/thbiEsH862gvt5KQOZyord+0670RzuJ722klMyCND8BzQc63cqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=fhNcmvx8; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="fhNcmvx8"
ARC-Seal: i=1; a=rsa-sha256; t=1723135666; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T4CheQP98x1J/GRIK4TVxWW7ISh+nqFhR5HbccTenGP+4+gxyzk5x509DIoaZGG4p39rkYWggev+8ljv8FP32JMKycTH8qX8Xe2IWA6tcyvliu6BEnIEoe4j5Iy3zDTAP4TaT/jsP7S8fEHyrkvuuQo+pmDzf8U8MK6UhVeFJ5g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723135666; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZwmA6pYY7lb1UZC0zMf+XG75uOTiFKSeg5YeTK0yBSM=; 
	b=IIcJUgHqx2e53e5wNkzRlSRN9aksWSaxYCLNJ+RzorbWmlNrPHk1PEC0ppCFzXc3piX6Hm6xF7doUXgGrg5r6qTJijTIUQM1PpBQYag+lWbMHKuIiAWVF2Nr749CXpnG5qgeBOW6wfZy45f8XQJuTOG/7XHeOX8GbT4XnFoUCwg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723135666;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZwmA6pYY7lb1UZC0zMf+XG75uOTiFKSeg5YeTK0yBSM=;
	b=fhNcmvx8xApl/RsaHpwA5L2ZzJjDfOX2FWVSwJtmUBNipDR5hV0uEHgKq05kTsdb
	+91n2EmJvHxloxwaKw/1tblAYwiVomzzgV4SD0B/YQAPeSfH50di4LkR3OMRm4jpoCb
	Lj0Ct9rx6NvILd13gNjRg5wBpRg0cQVNv+b75If4=
Received: by mx.zohomail.com with SMTPS id 1723135664294528.0946501054501;
	Thu, 8 Aug 2024 09:47:44 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Add dw_mmc support for rk3576
Date: Thu,  8 Aug 2024 12:47:14 -0400
Message-ID: <20240808164900.81871-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The SD card controller on the rk3576 SoC uses a new tuning version that is
capable of using pre-boot tuning information.

Also, it stores the phase settings into the dw_mmc controller, so the code
has to be adapted to implement that.

Changes since v1:
- Renamed use-v2-tuning to v2-tuning
- Rewrite v2-tuning description as the hardware feature

Detlev Casanova (1):
  dt-bindings: mmc: Add support for rk3576 dw-mshc

Shawn Lin (2):
  mmc: dw_mmc-rockchip: Add v2 tuning support
  mmc: dw_mmc-rockchip: Add internal phase support

 .../bindings/mmc/rockchip-dw-mshc.yaml        |   7 +
 drivers/mmc/host/dw_mmc-rockchip.c            | 223 +++++++++++++++++-
 2 files changed, 221 insertions(+), 9 deletions(-)

-- 
2.46.0

