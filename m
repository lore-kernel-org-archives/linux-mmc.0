Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83160B96;
	Wed, 14 Aug 2024 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723674887; cv=pass; b=TdV67dN3HjnV74zIQ3ztbzKxsaiGwJewn/UsE5SXIBzP5AEVFdm9SqqQCVMHq1fVtDfxnkqaYICupuZdO0KjO1M0Z9nXV5xOYmPExxjgfm8BI+GAB3GRrHCB0UpKxBoX1VTaA0pxbWWJBPDxzkUCYGlJ51whi0O3VSrf1uxHQfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723674887; c=relaxed/simple;
	bh=FWLva3aRTZNj7MlWI9ZJEDAu58FOUJ2236jpSIlGI7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2TcA9omo6PWBbEu3T3vIf/Ck6jNRkhS7P9liWT0c3nDXBQYpmdnT4gnJ3gj85iqdQLeM8SbbSFAUQNnID78aJ8XIASwP+h70aVm6kpoAcczUNJvBfbq+uG+IpBaVqYYzkw6qAXKip8wQm2PtBEfXHBViSZBdX67n2oD7nYxs4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=jJwyKaEw; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="jJwyKaEw"
ARC-Seal: i=1; a=rsa-sha256; t=1723674871; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B3igkjGkFCiG8ZRPLd/sYczbZe6udIzJg4Q+svlG0zeqr4NrDw2Plh3y92QAulVAcpgbzFvrG1dfR6dOMqojIden11YWeH6oldXgkM0xzVV/vtp3UXyycV5tizcDg9Ld/uc7pPh4iRW38G3iOceCfm/9MJMa/YFZu8BRKouhUfY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723674871; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=T5j2mX2K8VlgWP3DiWylg5b8+GjtR3qTPMyXZoH4GN0=; 
	b=Vs4iW/qnSSCaS3fpY4xixfk9GcQ7tcgvzuAQWf90sWOOyHx3/OnLGvuJtl5GdWeSlESwKox1gkXWQEikk4w0ssVrO8z8D9TBx40L4rKt1nHDPIeBoO4/VUugp+LVdVaRaBjVSiHiM8LH6uQBFCqsZrTRlutcOFT2HPvFd/eB74Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723674871;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=T5j2mX2K8VlgWP3DiWylg5b8+GjtR3qTPMyXZoH4GN0=;
	b=jJwyKaEwXbpELnu9eEcJQGNyfkcFblT79sKAnL6CXAWORFHABM83coIwp8XfPG+s
	Y6oGbNClmevH0Qju4cPIifAi6y2IHcZGR7p6TH4hMH2v22Geg10Dg4jIQRHCeTp2lIl
	vyl2EZ4QFhRbbe9FdqJxZVJwcUFGmuvpEYfG5McM=
Received: by mx.zohomail.com with SMTPS id 172367486998921.762079577096642;
	Wed, 14 Aug 2024 15:34:29 -0700 (PDT)
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
Subject: [PATCH v3 0/3] Add dw_mmc support for rk3576
Date: Wed, 14 Aug 2024 18:33:59 -0400
Message-ID: <20240814223555.3695-1-detlev.casanova@collabora.com>
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

Changes since v2:
- Drop rockchip,v2-tuning and use compatible-based detection
- Fix coding style

Changes since v1:
- Renamed use-v2-tuning to v2-tuning
- Rewrite v2-tuning description as the hardware feature

Detlev.

Detlev Casanova (1):
  dt-bindings: mmc: Add support for rk3576 dw-mshc

Shawn Lin (2):
  mmc: dw_mmc-rockchip: Add v2 tuning support
  mmc: dw_mmc-rockchip: Add internal phase support

 .../bindings/mmc/rockchip-dw-mshc.yaml        |   1 +
 drivers/mmc/host/dw_mmc-rockchip.c            | 227 +++++++++++++++++-
 2 files changed, 217 insertions(+), 11 deletions(-)

-- 
2.46.0

