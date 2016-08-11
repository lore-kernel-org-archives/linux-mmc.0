From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 0/4] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Thu, 11 Aug 2016 10:43:02 +0200
Message-ID: <20160811084301.GF30475@verge.net.au>
References: <1469592803-13842-1-git-send-email-horms+renesas@verge.net.au>
 <20160810131224.GB1741@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160810131224.GB1741@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 10, 2016 at 03:12:24PM +0200, Wolfram Sang wrote:
> Hi Simon,
> 
> > In this patchset I have attempted to address all review received
> > for the v3 patch-set. I also believe that I have resolved a problem
> > where tuning would timeout under some circumstances: this seems to
> > have been due to several bugs introduced between v1 and v3.
> 
> So, you didn't see timeouts anymore?

Yes, that is correct.

I have not seen them at all with this patchset.
I will extend my testing as I integrate these changes on other SoCs and boards.

> > * Currently I am seeing speeds of up to 48MB/s with these patches and
> >   30MB/s without using a SanDisk Extreme Pro 8Gb microSDHC UHS-1 card.
> > 
> > * I am also seeing 45MB/s with these patches and 34MB/s without using
> >   a SanDisk Ultra 64Gb microSDXC UHS-1 card.
> 
> I got similar numbers for my SanDisk and Samsung cards. While the SDR104
> speed is not that what I hoped for, it is still an improvement over
> SDR50. We are currently investigating if DMA causes a bottleneck
> somewhere perhaps. Except for a minor comment, I'd think these patches
> are good to go in and we could improve incrementally from here:
> 
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Maybe Ulf can have another high-level view on those. I guess he is more
> experienced with the tuning stuff?

Yes, of course such input would be welcome.
I'd like to work towards getting these changes merged.
