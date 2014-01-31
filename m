From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH v7 2/2] mmc: sdhci-msm: Initial support for MSM chipsets
Date: Fri, 31 Jan 2014 09:31:03 -0800
Message-ID: <20140131173102.GE19653@sonymobile.com>
References: <1383753405-23631-1-git-send-email-gdjakov@mm-sol.com>
 <1383753405-23631-3-git-send-email-gdjakov@mm-sol.com>
 <20131209170002.GA15223@sonymobile.com>
 <52EA8A07.6080008@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52EA8A07.6080008@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Georgi Djakov <gdjakov@mm-sol.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "rob@landley.net" <rob@landley.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jan 30, 2014 at 06:21:11PM +0100, Georgi Djakov wrote:
> Hi,
> 
> Apologies for the delayed reply.
> 
> On 12/09/2013 07:00 PM, Courtney Cavin wrote:
> > On Wed, Nov 06, 2013 at 04:56:45PM +0100, Georgi Djakov wrote:
> >> This platform driver adds the initial support of Secure
> >> Digital Host Controller Interface compliant controller
> >> found in Qualcomm MSM chipsets.
> >>
> >> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
[...]
> >
> > I couldn't get v6 running without the 5 quirks you submitted in [1].
> > Aren't these also attributes of the controller itself? If so, shouldn't they
> > be part of this patch series, and included here?
> >
> 
> Most of the quirks are for older hardware revisions. On what board/chip 
> are you trying to run it? I will post v8 shortly. Could you try with it 
> please?

I see.  This was initially checked on a Rev 1 SoC.  I will test v8 on a
Rev 2.

-Courtney
