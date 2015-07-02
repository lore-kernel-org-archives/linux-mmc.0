From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH] mmc: core: Set load on vmmc and vqmmc
Date: Thu, 2 Jul 2015 11:10:36 -0700
Message-ID: <20150702181036.GF9633@sonymobile.com>
References: <1435725525-4367-1-git-send-email-bjorn.andersson@sonymobile.com>
 <20150701105925.GT11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([37.139.156.2]:8215 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753149AbbGBSKw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Jul 2015 14:10:52 -0400
Content-Disposition: inline
In-Reply-To: <20150701105925.GT11162@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

On Wed 01 Jul 03:59 PDT 2015, Mark Brown wrote:

> On Tue, Jun 30, 2015 at 09:38:45PM -0700, Bjorn Andersson wrote:
> 
> > +- vmmc-load: requested load for the vmmc regulator, in mA
> > +- vqmmc-load: requested load for the vqmmc regulator, in mA
> 
> Isn't this something that should have default values from the spec?  The
> binding also ought to say what a "requested load" is.

It sounds reasonable that these values should simply come from the card
specification; I don't know if there's any sane way for us to list them
though (other than just stating them in dt).

I'll have to do some more investigation on the subject...


And I get your point that it's not "requested load", it's the power
requirements of the card...so it should be rephrased.

Thanks,
Bjorn
