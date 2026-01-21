Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F1D466B4D;
	Wed, 21 Jan 2026 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768992130; cv=none; b=DPDjxoz/g+SSLpZNLdpvT7+GVWBb0gsX4eGHvd/vNr4pUeBtIk99R0jQxfS0b+6WWoc7VjMKnXGOWUSV8Ou+qOWW7e1tciDYP04uBz0eMr8RkxNVHjwc5OTyxu+kZ+5vhIxBynYILGbDs8UN6BGDlZ2XQnCZ6T7fBDEltgOTljA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768992130; c=relaxed/simple;
	bh=6Mm+8vvI82qWANtr0924YRHfmaPBHTkKc0qZ79hky3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uA/yZtkctUJ0tmSUNJEjkVBn3TWq4mAZONvHraf1TUcl/WACkDLdHVj0s5d7W0F7dxNqGwtPvNVQQ2rK2vEhkeeAx4TWwCqZdZu515ZNHXgM7RPC9cp4qJFY5FHBIPGPnaGcs4qXOwniIIWp+dz2RDHMoB6RVMJCXT6HuNa8Yuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=dz7OEZuA; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="dz7OEZuA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zscoPbAmvaBIRYYbo4mpG1SqTAb008m2Pl3AR9bRiGQ=; b=dz7OEZuASZtsmaiXkF8jYgXP9a
	w3cJUYrWcpA7PBV9qalUgu2ggp/lw9eEeLq/yQ10tZxqa6+dKqBxX8zFtKQJF4ov9bCKHNZS0mckw
	08Wrc+FQfGmYpoeUar0EoVjZAhlMx1c2KhemQRwK1e6paEcxhmt4CJKneVPqHv3O3Asgh8x+igIYr
	NquodIvuh4+iBo4qN8fMpXZu1WlQmYRS3/qHc5Sp+oh3yIqNlHRTPdETZfP/yAi+s+JBmAMmlaLXh
	aqGGUWxUhpQVk4c6rB63PLMXq40LMY9yrD4MeYgvJ6XZKCRUGWr4wM0LW3n72nCn2PA41+BhcdDzD
	R6GWy8Rw==;
Date: Wed, 21 Jan 2026 11:39:41 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik
 <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, Andi Shyti
 <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Yazan Shhady
 <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, Mikhail
 Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 5/7] i2c: omap: switch to new generic helper for
 getting selected mux-state
Message-ID: <20260121113941.68328962@kemnade.info>
In-Reply-To: <20260121-rz-sdio-mux-v6-5-38aa39527928@solid-run.com>
References: <20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com>
	<20260121-rz-sdio-mux-v6-5-38aa39527928@solid-run.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 11:20:42 +0200
Josua Mayer <josua@solid-run.com> wrote:

> Multiplexer subsystem has added generic helper functions for getting an
> already selected mux-state object.
> 
> Replace existing logic in probe with the equivalent helper function.
> 
> There is a functional difference in that the mux is now automatically
> deselected on release, replacing the explicit mux_state_deselect call.
> 
> This change is only compile-tested.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
