Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C08192B87;
	Thu, 29 Aug 2024 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931898; cv=none; b=LdTh/255X/BK4WS6KuVtjK0mRIF9FTtJSV8dbas/CVrzSZKpIxiVjCbSfmPfz20pRtSPzQCI0aCUetteGLYtrr2/N2ITdEgRzuy3MtwwMROteEsqJ4eiTZl8Wg3TU2O7wFFgeAXxSGXtiLONlrddlL2ouV6SLS93f5AfE60+UIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931898; c=relaxed/simple;
	bh=PU6EoO/cywcvoq8pFgC1LBSwNERId/PFl6Tp7ZtFy04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THIrxoREIIRLrNf1wgZsB2FujeXpZd/BP+RIqvZSABU3ipLE6ayyvt2T0sOY37as0Cf9IG3lFoG9UXeAk1wi1ysZD9L+oVe5/6yMBtrmkjNfHAVNFT2ClKxxHhlbUXPGUveBvf83yH+8anwDoZx/RWzu5elydV6KoZIXCqS/LtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=aZPie9rt; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="aZPie9rt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gdByyqrCMFgvacml27hDR8W7NQ3IgtrPsJfsE4eZigg=; b=aZPie9rtcXdbXkwle6SCZTKH7r
	jJT9vHeo6ufTOb1p87fdlh9GnlmJmfJQI1B4ArG1rXnUzTum91aV8Ur01xRSGJPXjnP6eth1G0dDi
	qj4psiqCE1Cr6konc/etNLycu97bJarFiCRn5CVnrauoWpeqm9uTh0kUJmw/a4kHf4A343vtoS3ma
	EtWuwVFrBrhc116dWH2P9zzZQgQOkJGjXZ/nOruMiPwmrGOCW/grHGSo63VFQ19ENf74G+w0oYOs0
	OW22AEU+YQgCezC4fe48VeGsT62KxmcYODOStqBnU+Fh/ceHxgpfJmoCYZS8ZbiZWeH1S1ib1WDaR
	LkbqeonA==;
Received: from i5e861916.versanet.de ([94.134.25.22] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjda7-0003a1-7p; Thu, 29 Aug 2024 13:44:51 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH v5 3/3] mmc: dw_mmc-rockchip: Add support for rk3576 SoCs
Date: Thu, 29 Aug 2024 13:46:05 +0200
Message-ID: <1746696.izSxrag8PF@diego>
In-Reply-To:
 <010201919997044d-c3a008d1-afbc-462f-a928-fc1ece785bdb-000000@eu-west-1.amazonses.com>
References:
 <20240828152446.42896-1-detlev.casanova@collabora.com>
 <010201919997044d-c3a008d1-afbc-462f-a928-fc1ece785bdb-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 28. August 2024, 17:24:56 CEST schrieb Detlev Casanova:
> On rk3576 the tunable clocks are inside the controller itself, removing
> the need for the "ciu-drive" and "ciu-sample" clocks.
> 
> That makes it a new type of controller that has its own dt_parse function.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


