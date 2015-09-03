From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/6] regulator: Fix pbias regulator enable
Date: Thu, 3 Sep 2015 08:04:53 -0700
Message-ID: <20150903150452.GT4215@atomide.com>
References: <1441263042-12942-1-git-send-email-kishon@ti.com>
 <CAPDyKFrVR+vvmxm43hGimjqo4pcFa1pfDuNNENXU-tk_qXo2=w@mail.gmail.com>
 <55E81117.2040900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:48399 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754586AbbICPE5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 3 Sep 2015 11:04:57 -0400
Content-Disposition: inline
In-Reply-To: <55E81117.2040900@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Olof Johansson <olof@lixom.net>, Mark Brown <broonie@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, =?utf-8?B?UGF3ZcWC?= Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sekhar Nori <nsekhar@ti.com>

* Kishon Vijay Abraham I <kishon@ti.com> [150903 02:25]:
> On Thursday 03 September 2015 01:09 PM, Ulf Hansson wrote:
> > 
> > Finally, perhaps it's better if we queue this through my mmc tree
> > since we would then be able to avoid the regression - if I put
> > $subject patchset before [1], right? Then I need an ack from Mark for
> > the regulator patch.
> > Please tell me if you guys prefer another way.

That works for me too. Or Mark can set up an immutable signed
branch that you can merge in, up to you guys.

It's still going to break git bisect for booting but
removes the regression when mergeing to mainline.

I'd squash all the one liner dts changes into a single
patch though when applying to cut down on the commit
noise.

Regards,

Tony
