From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v5 10/11] arm64: dts: r8a7795: salvator-x: Enable UHS-I
 SDR-104
Date: Thu, 1 Sep 2016 16:37:52 +0200
Message-ID: <20160901143752.GM14300@verge.net.au>
References: <1472591399-13907-1-git-send-email-horms+renesas@verge.net.au>
 <1472591399-13907-11-git-send-email-horms+renesas@verge.net.au>
 <20160901072354.GA2893@katana>
 <20160901142539.GI14300@verge.net.au>
 <20160901142943.GC4824@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:52991 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbcIAOh6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Sep 2016 10:37:58 -0400
Content-Disposition: inline
In-Reply-To: <20160901142943.GC4824@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Thu, Sep 01, 2016 at 04:29:43PM +0200, Wolfram Sang wrote:
> On Thu, Sep 01, 2016 at 04:25:40PM +0200, Simon Horman wrote:
> > On Thu, Sep 01, 2016 at 09:23:54AM +0200, Wolfram Sang wrote:
> > > On Tue, Aug 30, 2016 at 11:09:58PM +0200, Simon Horman wrote:
> > > > Add the sd-uhs-sdr104 property to SDHI0 and SDHI1.
> > > > 
> > > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > 
> > > After removing a SDR104 card from the slot, the interface is stalled
> > > here. No new cards (even non-SDR104) can be detected anymore, sadly.
> > > Happens for both slots on my H3 Salvator-X.
> > 
> > Bother. That is rather difficult for me to exercise.
> > Does this occur without sdr104 enabled (e.g. in DT)?
> 
> No, then it works fine.
> 
> I'll try to get you more information. Might be not before Monday,
> though.

Thanks. I'd be grateful if we could coordinate some way to get to the
bottom of this.
