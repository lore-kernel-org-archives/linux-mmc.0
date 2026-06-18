Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE54311C07;
	Thu, 18 Jun 2026 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779720; cv=none; b=GO1m/qEXaA1Ynh6nkcT6PIGk+g62GDzRJSM4+rb0S4YTZS37d1Ks9lpYG9HTciyKkwow1yjp+7HeafeeSuYwUHg5dEv3MIzGkeQJJaCn+bnZ3cNDHwikof4BA/I+KUJ064VQse2ErfO7lkMN3goAhu62d60Wcu4DuOkjd7gr6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779720; c=relaxed/simple;
	bh=s5nZORTo3cCmccIdVd7XeD7Ss6mmoKBabnJ8WnUQW/8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Es4LGQNJg/SsHTnqOrClT1QbcFy1TozgLbX0ej5MHpjj4bb8PMTSTErqgLrk6My9eeGzvxzHEEk5wtNXlkWsfid97Kz5H6csKMQh8OD0/10BJGmFC26mlDNYuSsnhBG1QPUv1RlMrXARIlz0xa5eUXBugUWoU5q0tj6EYecewys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id F1B48200275;
	Thu, 18 Jun 2026 12:48:36 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1waAIW-003QIA-2w;
	Thu, 18 Jun 2026 12:48:36 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1waAIW-000000007Wy-3UQu;
	Thu, 18 Jun 2026 12:48:36 +0200
Message-ID: <82e1a34b5cdd4246213806088f260c7be99c854b.camel@pengutronix.de>
Subject: Re: [PATCH v1 1/9] dt-bindings: reset: altr: add COMBOPHY_RESET for
 Agilex5
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 18 Jun 2026 12:48:36 +0200
In-Reply-To: <20260511202132.5597-2-tanmay.kathpalia@altera.com>
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
	 <20260511202132.5597-2-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mo, 2026-05-11 at 13:21 -0700, Tanmay Kathpalia wrote:
> Add COMBOPHY_RESET definition at index 38 for the combo PHY reset
> control on Altera Agilex5 SoCs. This reset is used by peripherals
> such as the SD/eMMC controller that share the combo PHY.
>=20
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>  include/dt-bindings/reset/altr,rst-mgr-s10.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/dt-bindings/reset/altr,rst-mgr-s10.h b/include/dt-bi=
ndings/reset/altr,rst-mgr-s10.h
> index 04c4d0c6fd34..c2505b9eb63e 100644
> --- a/include/dt-bindings/reset/altr,rst-mgr-s10.h
> +++ b/include/dt-bindings/reset/altr,rst-mgr-s10.h
> @@ -22,7 +22,7 @@
>  #define USB0_RESET		35
>  #define USB1_RESET		36
>  #define NAND_RESET		37
> -/* 38 is empty */
> +#define COMBOPHY_RESET		38

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

I'll pick this up into reset/fixes after v7.2-rc1.

regards
Philipp
