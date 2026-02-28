Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459541E9919
	for <linux-mmc@vger.kernel.org>; Sat, 28 Feb 2026 03:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772248149; cv=none; b=nQlcWPQyTG9NrpvO0w7aWzIBUzbJRGf62d4B6sIU/dBzfXIhFj75oBE2dFzajvZR0GhiFNVanlXI95kpdSnlXWhHGGAFJwTjmH/ozK2IeUWbDypRT/SGY9GiPwhDkJVw1IKn+BytGA4fz0qEFvIAtgDHGBikNw55c/oXyNz6nQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772248149; c=relaxed/simple;
	bh=vF/M05bf2pJzD8Qmsp+h8o7tmLpGmketD+QQvZJn0BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Gp9is0HyDYezPvrUL7YvdIM8zd4GBFhWglZqoa/l7tiG6+lo7SuGlX0vp/Io6rjb8OuU/zpteYYscyLKXtaey3odKRT/dtyu9EO1m+7/RqoK+2mV1AEfeSwEKwSR+ddAXHOzpRJJRc3jwS+xKezxiegSNKV+PDeHeVCn+UzNhRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oh2CS4+b; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oh2CS4+b"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260228030904epoutp047f8fc7feff5d89dc85bf616075252198~YSkxLBxJ20858708587epoutp04N
	for <linux-mmc@vger.kernel.org>; Sat, 28 Feb 2026 03:09:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260228030904epoutp047f8fc7feff5d89dc85bf616075252198~YSkxLBxJ20858708587epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772248144;
	bh=vF/M05bf2pJzD8Qmsp+h8o7tmLpGmketD+QQvZJn0BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oh2CS4+bOC4keOEEPYbn7c77/v0tvNkDHWVyIZA50v+KZq8uQjcli5JdrZvFX7+hz
	 nwZPQFSDKa2k/m69CY4VPiEkIvY7/yDQ9Z+ATH6hnnJqS2iCRfeXvhf1GDn486SlC1
	 lLqND0HK6BQeADi67/W3XMB32VyfK27tpzynnHjo=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260228030904epcas5p1ddfdf408ba89d6a6eb4f5ec69e5c960e~YSkwaydj43111731117epcas5p1y;
	Sat, 28 Feb 2026 03:09:04 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fN9C40T9xz6B9m4; Sat, 28 Feb
	2026 03:09:04 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260228030903epcas5p10097b2037bdedbfbbd186ec64c9fa60d~YSkvaATG73111731117epcas5p1x;
	Sat, 28 Feb 2026 03:09:03 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20260228030902epsmtip12312448e74d15f27dcef8a4d8ce4fe51~YSkunxU1L2552525525epsmtip1r;
	Sat, 28 Feb 2026 03:09:02 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: krzk@kernel.org
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, robh@kernel.org, jh80.chung@samsung.com,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, hy50.seo@samsung.com, kwangwon.min@samsung.com,
	ping.gao@samsung.com
Subject: Re: [PATCH v3 3/3] dt-bindings: mmc: synopsys-dw-mshc: No need to
 enforce setting two clocks
Date: Sat, 28 Feb 2026 11:13:50 +0800
Message-ID: <20260228031350.3209721-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260228030903epcas5p10097b2037bdedbfbbd186ec64c9fa60d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260123085150epcas5p42f2cc04843ae7657380b2968261246cb
References: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>

Hi Krzysztof,

My apologies for the messy threading and duplicate postings. I had a
misconfiguration in my mail client settings.

I will slow down, re-evaluate the hardware requirements, fix the YAML
schema synchronization, and send a clean v4 as a brand-new thread.

Best regards,
Ping Gao
