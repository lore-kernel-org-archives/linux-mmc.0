From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH V2 07/15] doc: dt: fsl-imx-esdhc: add set tuning start
 point binding
Date: Wed, 13 Jul 2016 17:10:28 +0800
Message-ID: <20160713091028.GB27041@shlinux2>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
 <1468309584-3591-8-git-send-email-aisheng.dong@nxp.com>
 <20160712135907.GA30437@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:32979 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbcGMJSa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2016 05:18:30 -0400
Received: by mail-pa0-f65.google.com with SMTP id q2so2693184pap.0
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2016 02:18:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160712135907.GA30437@lunn.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, chris@printf.net, haibo.chen@nxp.com, adrian.hunter@intel.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org

Hi Andrew,

On Tue, Jul 12, 2016 at 03:59:07PM +0200, Andrew Lunn wrote:
> On Tue, Jul 12, 2016 at 03:46:16PM +0800, Dong Aisheng wrote:
> > add tuning start point binding
> > 
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > index dca56d6248f5..3e29050ec769 100644
> > --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > @@ -28,6 +28,8 @@ Optional properties:
> >    transparent level shifters on the outputs of the controller. Two cells are
> >    required, first cell specifies minimum slot voltage (mV), second cell
> >    specifies maximum slot voltage (mV). Several ranges could be specified.
> > +- fsl,tuning-start-tap: Specify the start dealy cell point when send first CMD19
> > +  in tuning procedure.
> >  - fsl,tuning-step: Specify the increasing delay cell steps in tuning procedure.
> >    The uSDHC use one delay cell as default increasing step to do tuning process.
> >    This property allows user to change the tuning step to more than one delay
> 
> Hi Dong
> 
> You say this is a patch which should be part of stable. How does it
> fulfil the requirements listed in
> 
> Linux/Documentation/stable_kernel_rules.txt
> 

Sorry i'm not so familiar with stable rules before the posting.

This patch is mainly to separate the binding doc changes from the driver
changes in patch 6.

Why we need add the tuning-start-tap is because we met some tuning problem
on boards like MX7D SDB RevC, the board timing slight difference may
cause the default tuning steps(2 cells) can't cover the required tuning
range, then tuning fail.

This patch allow users to bypass the first a few meaningless tuning ranges
if they meet the problem.

Since there's no users in tree currently, i'm not sure if it breaks the rule.
But indeed people may need it if they meet this problem.

Regards
Dong Aisheng

> Thanks
> 	Andrew
