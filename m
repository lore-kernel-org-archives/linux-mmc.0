From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 2/3] mmc: host: tmio: SDIO_STATUS_QUIRK is rather
 SDIO_STATUS_SETBITS
Date: Thu, 19 Jan 2017 20:40:35 +0100
Message-ID: <20170119194035.2n2upfxnjfrylena@ninjato>
References: <20170105114326.12426-1-wsa+renesas@sang-engineering.com>
 <20170105114326.12426-3-wsa+renesas@sang-engineering.com>
 <20170110080740.GD25239@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170110080740.GD25239@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

> > --- a/include/linux/mfd/tmio.h
> > +++ b/include/linux/mfd/tmio.h
> > @@ -97,7 +97,7 @@
> >  /*
> >   * Some controllers needs to set 1 on SDIO status reserved bits
> >   */
> 
> Is the following update to the above appropriate?
> In particular, is it some or all?

Some.

>     * Controllers need to set 1 on SDIO status reserved bits

I updated this and the other comment to be more precise. Thanks!
