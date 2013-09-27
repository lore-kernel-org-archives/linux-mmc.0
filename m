From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1] mmc: sdhci-of-esdhc: fix building error
Date: Fri, 27 Sep 2013 15:35:36 +0100
Message-ID: <86eh8acoxz.fsf@void.printf.net>
References: <1380254414-12045-1-git-send-email-b29396@freescale.com>
	<20130927052041.GH25146@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41885 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab3I0Ofl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Sep 2013 10:35:41 -0400
In-Reply-To: <20130927052041.GH25146@S2101-09.ap.freescale.net> (Shawn Guo's
	message of "Fri, 27 Sep 2013 13:20:43 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Dong Aisheng <b29396@freescale.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fengguang.wu@intel.com

Hi,

On Fri, Sep 27 2013, Shawn Guo wrote:
> I just compile-tested it with powerpc toolchain, so
>
> Tested-by: Shawn Guo <shawn.guo@linaro.org>
>
> Hi Chris,
>
> It's your call to apply it as a fix patch or amend it to the offending
> one.  We're fine with either way.

Thanks, I've amended and pushed out to mmc-next now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
