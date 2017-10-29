From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 3/3] arm64: renesas: salvator: set driver type for eMMC
Date: Sun, 29 Oct 2017 16:16:42 +0100
Message-ID: <20171029151642.a3p4m7z6lp5udi5k@verge.net.au>
References: <20171015124615.31391-1-wsa+renesas@sang-engineering.com>
 <20171015124615.31391-4-wsa+renesas@sang-engineering.com>
 <20171016074601.jrcvxxm6minuq7u3@verge.net.au>
 <CAPDyKFozG2m1HN5wn6hbnrxZO2jTXS12Z0V7+A_TTZGDLy2gPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFozG2m1HN5wn6hbnrxZO2jTXS12Z0V7+A_TTZGDLy2gPQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 20, 2017 at 12:03:16PM +0200, Ulf Hansson wrote:
> On 16 October 2017 at 09:46, Simon Horman <horms@verge.net.au> wrote:
> > On Sun, Oct 15, 2017 at 02:46:15PM +0200, Wolfram Sang wrote:
> >> These boards are known to have eMMC issues with the default driver type.
> >> Specify a working one.
> >>
> >> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > Hi,
> >
> > I have marked this as deferred pending acceptance of the bindings.
> > Please repost or otherwise ping me once that dependency has been accepted.
> 
> Simon, I have picked up the bindings, so you may now pick up $subject patch.

Thanks, and sorry for the delay, I have been on holidays.
I have applied this patch.
