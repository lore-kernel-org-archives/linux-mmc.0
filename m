From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH mmc/next] mmc: renesas-sdhi: provide a whitelist for Gen3
 SoC ES versions
Date: Thu, 3 Aug 2017 09:41:14 +0200
Message-ID: <20170803074114.GB19671@verge.net.au>
References: <1501678122-13956-1-git-send-email-horms+renesas@verge.net.au>
 <20170802195129.5vf6xc7q7dfaphgx@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170802195129.5vf6xc7q7dfaphgx@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 02, 2017 at 09:51:29PM +0200, Wolfram Sang wrote:
> On Wed, Aug 02, 2017 at 02:48:42PM +0200, Simon Horman wrote:
> > Provide a whitelist for Gen3 SoC ES versions for both the SYS DMAC and
> > internal DMAC variants of the SDHI driver.  This is to allow drivers to
> > only initialise for Gen3 SoC ES versions for which they are the appropriate
> > DMAC implementation.  Currently internal DMAC is the appropriate
> > implementation for all supported Gen3 SoC ES versions.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> > +/*
> > + * Whitelist of specific R-Car Gen3 SoC ES versions to use this DMAC
> > + * implementation. Currently empty as all supported ES versions use
> > + * the internal DMAC.
> > + */
> > +static const struct soc_device_attribute gen3_soc_whitelist[] = {
> > +        { /* sentinel */ }
> > +};
> 
> It may look strange to add an empty list, but I think it is worth it. We
> have good reasons to believe the soc_device_match distinction is
> necessary and I think it is good to be clear from the beginning how we
> want to deal with the differences.

Hi Wolfram,

thanks for adding some colour to the motivation for this change.
I agree with your statements above.
