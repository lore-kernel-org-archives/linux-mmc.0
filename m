From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Wed, 22 Aug 2012 20:26:56 +0800
Message-ID: <20120822122655.GW24242@S2101-09.ap.freescale.net>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
 <CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
 <87k3ws5uhs.fsf@octavius.laptop.org>
 <201208211208.49987.arnd@arndb.de>
 <87393g5mic.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47064 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab2HVM03 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Aug 2012 08:26:29 -0400
Received: by pbbrr13 with SMTP id rr13so1410445pbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 22 Aug 2012 05:26:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87393g5mic.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, patches@linaro.org, Wolfram Sang <w.sang@pengutronix.de>

Hi Chris,

On Tue, Aug 21, 2012 at 10:48:43AM -0400, Chris Ball wrote:
> Aside: the bindings do not match the code.  The bindings document says
> to use "fsl,cd-internal", and imx51-babbage.dts does so -- but the code
> doesn't check for "fsl,cd-internal", it checks for "fsl,cd-controller":
> 
>         if (of_get_property(np, "fsl,cd-controller", NULL))
>                 boarddata->cd_type = ESDHC_CD_CONTROLLER;
> 
> The same confusion is present for fsl,wp-{controller,internal}.
> 
I'm trying to fix the mismatch between dts and code, but seeing that
the "controller" mode has been broken for quite a while.  I just ran
a bisect and was told as below.

30832ab56c80d96cfaf5a786524f0d8c57fadfa1 is the first bad commit
commit 30832ab56c80d96cfaf5a786524f0d8c57fadfa1
Author: Todd Poynor <toddpoynor@google.com>
Date:   Tue Dec 27 15:48:46 2011 +0200

    mmc: sdhci: Always pass clock request value zero to set_clock host op

    To allow the set_clock host op to disable the SDCLK source when not
    needed, always call the host op when the requested clock speed is
    zero.  Do this even if host->clock already equals zero, because
    the SDHCI driver may set that value (without calling the host op)
    to force an update at the next (non-zero-speed) call.

    Signed-off-by: Todd Poynor <toddpoynor@google.com>
    Acked-by: Adrian Hunter <adrian.hunter@intel.com>
    Signed-off-by: Chris Ball <cjb@laptop.org>

Reverting the commit will get "controller" mode back to work.

-- 
Regards,
Shawn
