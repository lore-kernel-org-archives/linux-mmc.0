Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91736E2BE;
	Thu, 25 Jan 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193498; cv=none; b=ZN+/7nwcFYBzzVxu7NE6VELQ0jjvy+XaiI0r5cgT7RHLv4HbIkZ6raTjMRoLtm4Mt8sleRbk9raiNLrJLUcghVpqfIlJk709qMm/BGnzMf1lB7lgSu7UHqeDwo2nODN/RK/4x1jahf9mmhgBc52R8ahiaV4IYBMXLj8NgMSkQAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193498; c=relaxed/simple;
	bh=36R4a1cpDD9CZFSuhJmCdy9kvUsCgq2k3R5Xx+Ct338=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8WEJJSuzRqieDurqWYBDTSD60/eb7cwtRTp/HdJA46QfcVvxFMWPIKZwqarK5LPWkj9g2Y3u3JoevC81aPXDPCwPjzCCx5JFHIlP0QY7psDHvFXJwFMUbDbX/rtqljEYKpl0z1N4uladnJRuYMZeG+l6JnS4b2y5QrayZ7pjbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1C67467373; Thu, 25 Jan 2024 15:38:13 +0100 (CET)
Date: Thu, 25 Jan 2024 15:38:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: core Drop BLK_BOUNCE_HIGH
Message-ID: <20240125143812.GA18556@lst.de>
References: <20240125-mmc-no-blk-bounce-high-v1-1-d0f92a30e085@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125-mmc-no-blk-bounce-high-v1-1-d0f92a30e085@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

From the block POV: awesome, 

Acked-by: Christoph Hellwig <hch@lst.de>

