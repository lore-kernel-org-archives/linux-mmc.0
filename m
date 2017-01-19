From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 3/3] mmc: tmio: discard obsolete SDIO irqs before enabling
 irqs
Date: Thu, 19 Jan 2017 20:42:02 +0100
Message-ID: <20170119194202.axqr6mz5d5m6xtaj@ninjato>
References: <20170105114326.12426-1-wsa+renesas@sang-engineering.com>
 <20170105114326.12426-4-wsa+renesas@sang-engineering.com>
 <20170110080919.GE25239@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170110080919.GE25239@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


> > +		if (host->pdata->flags & TMIO_MMC_SDIO_STATUS_SETBITS)
> > +			sdio_status |= 6;
> 
> Perhaps a #define would be an improvement over "6".

OK.
