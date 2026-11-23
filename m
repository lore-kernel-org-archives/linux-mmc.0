Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433324;
	b=uWROAEA6yVikLY18egWKnTpIynQP4gXdZ5lzeK5pL2TTzWZ3BI8x+DmLxG+Pcy8NCzFb
	 NLUG7ePnHmlrur8tN/7hM/Jrz1RIO43G9CoTmKHEkAE9S/ZeO9U9lLQUglRGvkiLTKqVN
	 dcI5H4ymehtOZOSwXGf769y15k1eRrvxlb/+WKrxwpL0C5DAYiGpBI7DZSSQPvkcyE6u7
	 gqzJTC5YwCjK/YNd74eGtdh5kifkfX5DY6W713mheeLUyH5JYFCmFRKNEDV2We+2VMCKV
	 tvewj3NYRtvCv0aJyK4X5aywD10Jq3sBaykLf8bFdNaRbGGVz8dMupnaDhSSldhkFxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433324;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=WkpqttVEIBaMSa9UY7eLmUB8mOCbvmxmx8PkXKxMIOs=;
	b=e7AfWQ0pJfM7ryI/mkrUEOkV7BHDOvwEb85Ke1jDq41v/OrPAd85p6pOBK5CDEA6ZTrw
	 cyNyLiq/F+V19hbASs+QHRn8i2cTVivTQmCiysWpXoxB0z+HY3rnGsIMoIKGtVs+KiSqi
	 o67cITL/jcLco1OtHqU7y4/E2EydSR4ybV5jP2TKH1nTgK7cZz9ODu6oGcIR3ELk8JsOv
	 Bly2qx4SIWqvngKXfemm56ljmUyb0tj/WKxbl+t/TtRf1uON/DgP8xFT1AXxrixNyIfvb
	 ZoHUy/MmR3GWSeJc9bB95e96pBwRhyRB5HgGMd0U6BkfcwqgfAwMO39I+4htUdd/mnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=LrxwVMkf;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2558D606A31E
	for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2026 11:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2558D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=LrxwVMkf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Wkpq
	ttVEIBaMSa9UY7eLmUB8mOCbvmxmx8PkXKxMIOs=; b=LrxwVMkfEaZxfz8eLLQc
	Ddd9sY/0rF6aUBbb/BgH9O+u3XL4UQ+jhVJ5Cdkfw06y7Zxmq8SYdC+IUKuC2owk
	si6dlR6uF8S6oUukMNh3uoUimSw+WdDTUptU9Q4tTVcP/iDwQW+iwBKdHIsVkwg3
	GyLbgEsYaXOJQJxGkFwv9zAWhFP2s2DhNt6Vfe7KrIjq0c61+Fh9S7meRzdKltYV
	7HNlgaTsWaJeB7G1h59T+ZwDkENWDJ39NJOiBZiURYvnN8VhfLVBojrXYtGh2afx
	3jAgIVjtk+7j9kGcvhad7F4UtObwS1PA8wEFkN7hxP0eYrBcNFI55ExvaY8GTuWf
	kg==
Received: (qmail 2692048 invoked from network); 23 Nov 2026 12:28:38 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Nov 2026 12:28:38 +0100
X-UD-Smtp-Session: l3s3148p1@8jQt5e9get4ujnsu
Date: Mon, 23 Nov 2026 12:28:38 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>, Runyu Xiao <runyu.xiao@seu.edu.cn>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Pan Chuang <panchuang@vivo.com>,
	Samarth Narang <samarth.colleges@gmail.com>,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH] [v3] mmc: sh_mmcif: rework sg_miter handling
Message-ID: <awQjZnsCKLzUKUey@ninjato>
References: <20261119152559.3051943-1-arnd@kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119152559.3051943-1-arnd@kernel.org>

On Thu, Nov 19, 2026 at 04:23:24PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This driver is the only one that uses sg_miter_next() to get a persistent
> mapping across interrupts, which prevents us from converting the internal
> kmap() to a local mapping using SG_MITER_LOCAL flag.
> 
> Linus previously attempted to use atomic mappings here, which failed
> for the same reason. I gave it another try, with a mapping that is only
> active during a single sh_mmcif_mread_block()/sh_mmcif_mwrite_block() call.
> 
> This is mainly a revert of the patch that fixed the command 18 timeout,
> but tries to solve the problem by updating and checking data->bytes_xfered
> to keep track of when the transfer is finished.
> 
> Instead of calling sg_miter_stop() on error or completion, this now
> always stops the iterator after the data transfer and restarts it during
> the following interrupt.
> 
> As sashiko-bot comments, there is an inconsistency with the size of
> each transfer: The mmc core expects a transfer of size data->blksz, but
> the actual transfer is host->blocksize, which is read from a hardware
> register. To keep the behavior as close as possible to what it was before,
> I still advance the data->bytes_xfered and sgm->consumed values by
> the requested transfer size for single-block read/write, but advance
> them by the actually copied number of bytes for the partial transfers
> in the multi-block requests.
> 
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Fixes: 4d4a2c71b862 ("mmc: sh_mmcif: Advance sg_miter before reading blocks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Moved some large files around, checksummed them, double checked across
reboots. All on these boards:

Lager (R-Car H2, 2GB RAM, eMMC)
Genmai (RZ/A1, 128MB RAM, MMC card (yes, I still have some))

Anything else I could do? Otherwise:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I trust Linus' review. I'll be around for more testing in case a
regression shows up.

