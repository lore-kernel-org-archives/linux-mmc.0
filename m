From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/3] mmc: esdhc i.MX: Support 8bit mode
Date: Tue, 25 Sep 2012 16:50:52 +0800
Message-ID: <20120925085040.GA14216@S2101-09.ap.freescale.net>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-4-git-send-email-s.hauer@pengutronix.de>
 <20120925071505.GG27291@S2101-09.ap.freescale.net>
 <20120925072714.GY1322@pengutronix.de>
 <20120925073317.GI27291@S2101-09.ap.freescale.net>
 <20120925073808.GZ1322@pengutronix.de>
 <20120925074548.GJ27291@S2101-09.ap.freescale.net>
 <20120925080525.GA1322@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37039 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab2IYIul (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 04:50:41 -0400
Received: by pbbrr4 with SMTP id rr4so8707451pbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 25 Sep 2012 01:50:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120925080525.GA1322@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, kernel@pengutronix.de

On Tue, Sep 25, 2012 at 10:05:25AM +0200, Sascha Hauer wrote:
> Ok, how about this:
> 
> - I add a bus-width = <4> property to all i.MX dtsi files
> - we merge the patch adding bus-width as an optional property
> - Make the bus-width option mandatory in the next step.
> 
> This way we can merge the mmc related patches through the mmc tree and
> the dts changes through arm-soc.
> 
Sounds good to me.  How the last step should be done will depend
on the common spec.  Per Chris, there are already two drivers
implementing the property as optional.  Not sure if Chris will change
spec to have the property defined as optional (probably default to 1?).

Shawn
