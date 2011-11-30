From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH] mmc: convert drivers/mmc/host/* to use
 module_platform_driver()
Date: Wed, 30 Nov 2011 15:40:46 -0800
Message-ID: <20111130234046.GA27107@huya.qualcomm.com>
References: <1322283343.14278.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:16421 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659Ab1K3Xks (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2011 18:40:48 -0500
Content-Disposition: inline
In-Reply-To: <1322283343.14278.2.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Micha <mirq-linux@rere.qmqm.pl>, David Brown <davidb@codeaurora.org>, Ben Dooks <ben-linux@fluff.org>, Viresh Kumar <viresh.kumar@st.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Grant Likely <grant.likely@secretlab.ca>, Anton Vorontsov <cbouatmailru@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Sat, Nov 26, 2011 at 12:55:43PM +0800, Axel Lin wrote:
> This patch converts the drivers in drivers/mmc/host/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.

>  drivers/mmc/host/msm_sdcc.c        |   13 +------------

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
