From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH (mmc-next) 1/3] mmc: add suspend/resume in the
 sdhci-pltfm driver
Date: Mon, 27 Sep 2010 16:25:56 +0200
Message-ID: <4CA0A974.3080503@st.com>
References: <1285233266-5039-1-git-send-email-peppe.cavallaro@st.com>
 <20100927103722.GC2664@pengutronix.de> <4CA094D7.7070101@st.com>
 <4CA09AF2.2030809@st.com> <20100927141549.GI2664@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:39391 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759387Ab0I0O0N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Sep 2010 10:26:13 -0400
In-Reply-To: <20100927141549.GI2664@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 09/27/2010 04:15 PM, Wolfram Sang wrote:
> 
> Better, but you still do not return the retval from the sdhci-functions.
> And please annotate the #endif with the define it depends on as a
> comment. And wait for more comments and respin the series as a whole,
> not every patch independently. That soon gets a mess.

Hi Wolfram,
Thanks for reviewing it. I'll modify the patch and send it again to you.

Regards,
Peppe
