Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCB223D7F7;
	Tue,  9 Dec 2025 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765273593; cv=none; b=DjO6fiEsKmgUV3q2zQGwJvZPFzqj1ZmvoTgt7C0vlHUmZhDizhX4CRq0Y0AHzYZ8eVxst0wa/WkzEyMNITkGClG0O2kaOCjTyHA3GAi3ygRYfurrsnXtJ++iL1VGRKVFrmKAsLUUrFnSfDht/O7uVpXeKWS+6kBGTP2Enxdz/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765273593; c=relaxed/simple;
	bh=ZL8tJvTroeaicQsEwsWRjdAWh8h/IeWiA549xNc5g34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvbCKyEIW9mdXRM6uCymLy/Q/uCA4OfB8rRwg3FxG0NTIar1y2PE2CHUZZmVKsII1sIosYpuIJaNxGuwODYz026sAUV7xOEHT/uKXh74pWBmWC+c682qjj6uBFipAHvUyqKiPwTHfNWeddmrlkjx5o2Hm7ao7FfKboBP2MoxlIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WluX6nuZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WluX6nuZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZL8tJvTroeaicQsEwsWRjdAWh8h/IeWiA549xNc5g34=; b=WluX6nuZFzefEme5MlebHs4ASs
	2j6d8KerfsNXmcqYpTggDSu1q3oFQReClu5271ZJ1oehuSIq1vPaYYm+cyXQFmNX6wjZ9WnKst77o
	bVKVglJl3+cvVNsH3pm9aNMYkD1Pm6Rv5fvreUmXIoU+OhIZoAno+e6sXu5hvxLXOxgl99Hz9IGFP
	9k92UDMeQwbfjTDWa9M1mdnFah6/o1Yqd8MQ76Ht3jnyteT5CDRcuaYXvlVlHv/jKkmHTHrrgbK/g
	1VYeA5W9rCHf/0GJZ9eQJEL7ogMg0UrrBtUQ3egwVbGu5G34YTkVTfQ24Svn8MfUcnDydXs18hCX8
	1EWz/0Xg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSuIa-0000000E4Ob-2ttr;
	Tue, 09 Dec 2025 09:46:24 +0000
Date: Tue, 9 Dec 2025 01:46:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "ping.gao" <ping.gao@samsung.com>
Cc: jh80.chung@samsung.com, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: dw_mmc: Use pre_request & post_request_end helper
Message-ID: <aTfv8Mu0ZTFjayHn@infradead.org>
References: <CGME20251209064525epcas5p4904259a2a7fb971c077bfa03acce8c79@epcas5p4.samsung.com>
 <20251209064910.3643039-1-ping.gao@samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209064910.3643039-1-ping.gao@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 09, 2025 at 02:49:10PM +0800, ping.gao wrote:
> Use vendor drv function to let other vendor can add some vendor function

Why would the vendor matter?

And where is the user of this?

