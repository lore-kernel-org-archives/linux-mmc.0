Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA002BF002
	for <linux-mmc@vger.kernel.org>; Wed,  4 Feb 2026 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218318; cv=none; b=N9ibUcWer1V/QFWrEHxIO/sL8/iL7IEbgLxOuIA/dNjFodPuFllFt1J6VcoKxa9SbC/jwNylyMx8/ilLPCpLkfbCAhGKo25L9yJBvxqmJJJRfb6HNpCIsXUdB9UxvPjF5RPohovPYGZSKv4uWHf7mipQxkaGnN9UHmcrMXrVamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218318; c=relaxed/simple;
	bh=HeoDdrClK0JpMaaC6HkxsSXrArPgi2RboMnEzglTb3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ds/3fg96AuJB9ozcID7kfmdSzOtLgedBJUEcDKqBMzuRXZBg0m6U1HJCZrlxUbLFKZDdqkofe9DrGKF1iIJNzazp97aS+/0yEJ4/St++XftsySahB4gn2alG3PJjH4OsgLnVmmC/MYg1WP54WJrJij+RmJR5cEE+1aN/+uaKewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=iDTCb/I2; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="iDTCb/I2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=UTvz
	QkxlS44jgbjtA5jGWOWg4/op5k6r0cuc8aC+1cc=; b=iDTCb/I2Gmcs07H1qQX/
	5of6uGapHxgquGCuYUdd9Xoz0qaTOG3wMnisfrqf4GAkCA75/96n7mF63Qk9d7EZ
	OuqsLeATCF7ITmjCFKKmwD6/WLuJ/iyyY5HvCoio+OECQm1SJqfXGaTJEZ3AvTXK
	1jhnS2Gos45/HzB7Hv0XPyw0kdDRG3Vq6wZyO+Q+AkUR/JGKHWLdytKQ1i8bRixy
	aGrLhu/mzQSUW23MFhr1EFt41xxCnhIQkGg9lmdYxx/PuZnHn1CBGdMjh7sddHis
	+biMcvTPMOmRFKhbxJBGogh5S9l7UHBnYNVMs1kjWtPAGtsKftysMz2EiAFPm581
	Bw==
Received: (qmail 2407763 invoked from network); 4 Feb 2026 16:18:33 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Feb 2026 16:18:33 +0100
X-UD-Smtp-Session: l3s3148p1@IHW5EQFKto0qAAAQagvIAoH29ntsUY5F
Date: Wed, 4 Feb 2026 16:18:31 +0100
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
Subject: Re: [PATCH v8 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
Message-ID: <aYNjR6sHCzy49Ykj@shikoro>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-1-024ea405863e@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-rz-sdio-mux-v8-1-024ea405863e@solid-run.com>

On Tue, Feb 03, 2026 at 03:01:34PM +0200, Josua Mayer wrote:
> Rename the temporary devm_mux_state_get_optional function to avoid
> conflict with upcoming implementation in multiplexer subsystem.
> 
> Acked-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

