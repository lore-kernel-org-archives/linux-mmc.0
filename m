Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40E941C2FA
	for <linux-mmc@vger.kernel.org>; Wed,  4 Feb 2026 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218402; cv=none; b=SjSZRQaNH/4pPdX6V9lRfbz1GBqlxUEifhGP0xODjf8qkNx1whPrYSxgydMY1JwoDPUkbtPB9K8795jnZyuqDbWkcgxxS9Adnnwg3n8u239zoWCOwpoi+1qDzNqaafFOKkDSgRubFOstXWAd+fLGr+c7Gk39aOhKdJLwPf7c8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218402; c=relaxed/simple;
	bh=EPJA/uh8iTFDZsW7kgP1KlgwFkZNsETk3q8ogYxI8+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRQvyE0ebCIOUc0tf2k1E90eFun2Wp+2iGk/rFVK1GzAGMaOZltvClemOUBx7bsI+TTrOPOZd+rw+u7RHxXkBzbA4D7Gi4yzdqlKnfvjgP/ht0Lz+lzq6xhWkft70Kiq55Fl/KDaP6vlk1uNzKCyVgjl9wNGyWtUWkDv3cvl0/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=me/u1gQI; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="me/u1gQI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=RTl3
	4GdapOHrIFn2PsIr7Sa6lCunHmnETaAYG/rtoLw=; b=me/u1gQID+44jQjIesVI
	qxsadN9LfXybobPB9QcuFB8skQaPT+uIozPEagA/w+78A09XQP/zu3W07vGxYxNu
	R9DgZPmtDhZu/8vG/MA/U3QCizJ6h5rVTBV/XVv4Lgaq8n81m3swfOOhBs9+uwog
	seJ76VcdLcG1LqPz0toy0VR8+bsNUW+AcvokqjjeergnSxqvAFLMvUP6tofpPv6X
	QacoOUtIQ6/km4mduTorqF+DV44PFzt56fch+KJNRe72JaP05yGVSn9IBVae2Wu0
	hetMvSlaz7Qv2rp70r8IchiOtk2wUpMFESyLtXYmqlGyNSbMfYVYFntOAyu878kC
	ww==
Received: (qmail 2408564 invoked from network); 4 Feb 2026 16:19:58 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Feb 2026 16:19:58 +0100
X-UD-Smtp-Session: l3s3148p1@cTHPFgFKnLgqAAAQagvIAoH29ntsUY5F
Date: Wed, 4 Feb 2026 16:19:58 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Vignesh R <vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v8 4/7] phy: can-transceiver: drop temporary helper
 getting optional mux-state
Message-ID: <aYNjniyEZ355QE28@shikoro>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-4-024ea405863e@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-rz-sdio-mux-v8-4-024ea405863e@solid-run.com>

On Tue, Feb 03, 2026 at 03:01:37PM +0200, Josua Mayer wrote:
> Multiplexer subsystem has now added helpers for getting managed optional
> mux-state.
> 
> Switch to the new devm_mux_state_get_optional helper.
> 
> This change is only compile-tested.
> 
> Acked-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

