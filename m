From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/2] gen3: dts: enable on-board eMMC
Date: Fri, 16 Sep 2016 11:38:27 +0200
Message-ID: <20160916093827.GB14562@verge.net.au>
References: <20160914170943.1663-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160914170943.1663-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 14, 2016 at 07:09:41PM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa@the-dreams.de>
> 
> Here are the DTS changes to enable the on-board eMMC memory at 8 bit bus
> widths on R-Car Gen3 Salvator-X boards.
> 
> Note that 'non-removable' is not supported yet because of Runtime PM issues. It
> seems we need to overhaul Runtime PM handling for other reasons as well, so I
> suggest the basic support goes in like this and DTS do not use 'non-removable'
> for now.
> 
> Note also that I decided to use the pattern that pinctrl-0 is 3.3v and
> pinctrl-1 is 1.8v, although the eMMC is fixed at 1.8v. I tried a few ways to
> only use pinctrl-0 being 1.8v here, but they all ended up to be confusing for
> users IMO, so I sticked to the most consistent solution after all.
> 
> These patches are based on top of Simon's sdr104-v7 patches and the accompanied
> driver patches sent a minute ago. A branch can be found here:

Please ping me / repost once these patches are ready to be merged.
