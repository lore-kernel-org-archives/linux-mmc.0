Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9803D1A2630;
	Mon, 14 Apr 2025 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613886; cv=none; b=F3YN/t86ZXcwOzX3uiLCO1FJJLMSFtKU5/EAxdJj379OdlxuPiwN+U0mQFptgz/A2zSTj8fKsH2s+BdsNd2LmbUuMXCf23D5xSkkaLZiEl3OK8uHbcSALOUlTNES55Wp3LIsmohIcHeYNhBp0f7Xcx4b0bjWwL+2eft/s7M+HDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613886; c=relaxed/simple;
	bh=n/t0T2LD5+XE1o61sPRLxFj1AQFQPjSbWtSxyYjEU+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgnOg+TOT/YJ+8puUE35bX/MvdI31EjMIgWtY1GJU5JrlnlfImdcsTPE0xCWujKBTgsXzgZHweDBns8DQlCuOqUmQazooxoLWAd6Yd+bhx+VQvczDa/kJdgNy2mrTxG+V+caSyyY1VcVABXLZV5WG3uDGcGbEZQAeQIHn8q8kTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=OJPJRWC5; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="OJPJRWC5"
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 22FC81F94A;
	Mon, 14 Apr 2025 08:51:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744613483;
	bh=Vuh+3+SJ1qs6GhiS50X+moaRPA+EOviYLwPNQVAmHdc=; h=From:To:Subject;
	b=OJPJRWC5BlqANEjpu7kZUnFlGtt9qWHUKn9XvpGOeupNB3gJC0vBWkB3vFpainj9K
	 KPj8yvoX8/7UP6YAd1xobbwfPKAvx6i7q+vhRsGyUBZ5ok9F+ttHwVvGGsLqH6hciA
	 DgTIr7uQoZr2QXL9gCBe6MDCUXgoxRU9JwK3A/S6JPHF82LzlyuiWpspKh1sk9g8wr
	 DcCGFaK3WeLAgA6oANNYpfW4zTdcrNmRgEd3ejYBSomJF/HZxoUOmAsShJpPZXdWXT
	 +bdIm5j53jczYEwY186PZx19U3wNqPrWdDnudsXBwLm8B0s/ec+BW9w+cps4e2v+wU
	 yIuNe2ycnAVjQ==
Date: Mon, 14 Apr 2025 08:51:19 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Judith Mendez <jm@ti.com>
Cc: Hiago De Franco <hiagofranco@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Josua Mayer <josua@solid-run.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Moteen Shah <m-shah@ti.com>,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH 0/2] Fix V1P8_SIGNAL_ENA and HIGH_SPEED_ENA
Message-ID: <20250414065119.GA6309@francesco-nb>
References: <20250407222702.2199047-1-jm@ti.com>
 <20250411130354.dc3sv3e7ruekkhkp@hiago-nb>
 <d8e45e50-f0eb-41d0-9c50-56147eaf262a@ti.com>
 <20250411194813.c4ft2uxgdiuza5cm@hiago-nb>
 <5f36ec5d-bb31-4b6c-aa4e-4ec48cb1d067@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f36ec5d-bb31-4b6c-aa4e-4ec48cb1d067@ti.com>

Hello Judith

On Fri, Apr 11, 2025 at 04:55:39PM -0500, Judith Mendez wrote:
> My understanding was that we do not like adding new DT properties if
> we can find a way to apply the quirk in the driver.
...

> If this implementation flies with the maintainers, then we can go back to DT
> property implementation.

Not sure if this is clear, but this patch is NOT working according to
our tests, we would need to fix it in a different way.

Francesco

> 
> 
> 
> 
> 
> 
