Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D07E2C2374
	for <linux-mmc@vger.kernel.org>; Sat, 28 Feb 2026 06:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772259626; cv=none; b=ptFqJm8JrWYzzMNBi6H/QTqJS/8kab4Py6ddt1AA50gYU7Bj6PAs0V9AzaL9Lf/PBlpipKj8rYSKWWZ5m7hkSgkB+jBH3N4mQkRUR6WMIlnwlCnuspo+Yee9GGljEthTtaCQuaaipgD0K3Oi0P89OZNVlXcwJSDfRm94vDJj9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772259626; c=relaxed/simple;
	bh=7vI9eDljzpd4xF7mzvxWo5Y+GYjIVz5Mvsv/9sj0ow8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=rdwRXbu3tIGQKWuqLIn3NHAboxUYf37FELAcawnOOu6y6RQP3KC5+t7dIvqcAFxLpc1MQWLYywyWheGvOmZIzBi/DqX+W2v/Scf3a8Mz7AVS/PsUcecEvxf1cYwcgXHyLvYP3ymV2ZDXU+UHhfB0iL5EhE/gaoCULKpwiu6eMmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kHNAuG4B; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kHNAuG4B"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260228062022epoutp03ec70daf01ad4868b2c831302ff121199~YVLyJcqOB0219602196epoutp03l
	for <linux-mmc@vger.kernel.org>; Sat, 28 Feb 2026 06:20:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260228062022epoutp03ec70daf01ad4868b2c831302ff121199~YVLyJcqOB0219602196epoutp03l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772259622;
	bh=dM4SHzunTo/THQK+Z1EC0t7qGcosVZxyRA0PjYfrSRI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=kHNAuG4BV4m8K8CoIW+pjRs4o9ENBO3GkB/UJxfYd6lUo3MzlNnNLlJzWwmRgyrSh
	 +XzrwBerXN327Q4pdGGk2LVbh35neCoQs69ve0O+FCO0uZb45QZ8Z2ED+o505beNpP
	 3nhcj4/85hidy+ost7PiFWbEbvOMznjyNacI36Y0=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260228062021epcas5p454f81d8860c7527d8ff90d792201e408~YVLxL4GAe0907009070epcas5p46;
	Sat, 28 Feb 2026 06:20:21 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fNFRn0JVnz6B9m4; Sat, 28 Feb
	2026 06:20:21 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260228062020epcas5p1e498c4fc67f590f4243645288c492f01~YVLwlP8CB2603826038epcas5p14;
	Sat, 28 Feb 2026 06:20:20 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260228062019epsmtip26bd7c90b7d25ad614119120827d29c27~YVLv2PreU1943819438epsmtip2f;
	Sat, 28 Feb 2026 06:20:19 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: ulf.hansson@linaro.org, jh80.chung@samsung.com
Cc: shawn.lin@rock-chips.com, krzk@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kwangwon.min@samsung.com, hy50.seo@samsung.com, Ping Gao
	<ping.gao@samsung.com>
Subject: [PATCH v4 0/3] mmc: dw_mmc: Support optional BIU clock
Date: Sat, 28 Feb 2026 14:24:54 +0800
Message-ID: <20260228062457.3210099-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260228062020epcas5p1e498c4fc67f590f4243645288c492f01
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260228062020epcas5p1e498c4fc67f590f4243645288c492f01
References: <CGME20260228062020epcas5p1e498c4fc67f590f4243645288c492f01@epcas5p1.samsung.com>

From: Ping Gao <ping.gao@samsung.com>

This series relaxes the BIU clock constraint in the dt-bindings and
updates the dw_mmc driver to treat it as optional. This is necessary
for SoC designs where BIU and CIU share a single clock source.

The entire series is resent as v4 to fix previous threading issues and
address feedback on the YAML schema and commit formatting.

v4:
 - Resend as a new standalone thread to fix the threading mess.
 - dt-bindings: sync clock-names with clocks using oneOf.
 - dt-bindings: remove redundant description text.
 - Update commit messages with hardware-level justification.
 - Fix Signed-off-by name format and missing blank lines.

Ping Gao (3):
  dt-bindings: mmc: synopsys-dw-mshc: relax clocks constraint
  mmc: dw_mmc-k3: before set biu_clk rate, check biu_clk available or
    not
  mmc: dw_mmc: Using devm_clk_get_optional() for biu_clk

 .../devicetree/bindings/mmc/synopsys-dw-mshc.yaml   | 13 +++++++++----
 drivers/mmc/host/dw_mmc-k3.c                        |  5 +++++
 drivers/mmc/host/dw_mmc.c                           |  2 +-
 3 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.50.1

