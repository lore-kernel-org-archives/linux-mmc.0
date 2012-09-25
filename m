From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/3] mmc: esdhc i.MX: Support 8bit mode
Date: Tue, 25 Sep 2012 04:00:18 -0400
Message-ID: <m3fw66legd.fsf@pullcord.laptop.org>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
	<1348471345-30785-4-git-send-email-s.hauer@pengutronix.de>
	<20120925071505.GG27291@S2101-09.ap.freescale.net>
	<20120925072714.GY1322@pengutronix.de>
	<20120925073317.GI27291@S2101-09.ap.freescale.net>
	<20120925073808.GZ1322@pengutronix.de>
	<m3k3vilety.fsf@pullcord.laptop.org>
	<20120925075309.GL27291@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46954 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753571Ab2IYH7Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 25 Sep 2012 03:59:25 -0400
In-Reply-To: <20120925075309.GL27291@S2101-09.ap.freescale.net> (Shawn Guo's
	message of "Tue, 25 Sep 2012 15:53:11 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, kernel@pengutronix.de

Hi,

On Tue, Sep 25 2012, Shawn Guo wrote:
> On Tue, Sep 25, 2012 at 03:52:09AM -0400, Chris Ball wrote:
>> We could also break the stalemate by just changing the common spec to
>> have bus-width become optional, default 4.  It's not going to break the
>> code of anyone who's been treating it as required.  I don't think there
>> there was a principled reason behind making it required.
>> 
> That would be the best :)

Ah, but sdhci-s3c and dw_mmc have been assuming that bus-width defaults
1 when it's not supplied.  That's going to make it complicated.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
