From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v5 08/11] arm64: r8a7795: Set maximum frequencies for
 SDHI clocks
Date: Thu, 1 Sep 2016 16:24:34 +0200
Message-ID: <20160901142434.GH14300@verge.net.au>
References: <1472591399-13907-1-git-send-email-horms+renesas@verge.net.au>
 <1472591399-13907-9-git-send-email-horms+renesas@verge.net.au>
 <20160831084449.GB1609@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160831084449.GB1609@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 31, 2016 at 10:44:49AM +0200, Wolfram Sang wrote:
> On Tue, Aug 30, 2016 at 11:09:56PM +0200, Simon Horman wrote:
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > v5
> > * New patch
> 
> Huh? There is already 721e9a08aa514c ("arm64: dts: r8a7795: set maximum
> frequency for SDHI clocks") in renesas/drivers? Why didn't you pick this
> one?

Sorry, I was working aganst mmc/next and forgot to check
against the renesas tree for the patches that should go/be there.
