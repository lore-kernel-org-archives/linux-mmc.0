From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] mmc: convert drivers/mmc/host/* to use
 module_platform_driver()
Date: Sat, 26 Nov 2011 16:19:53 +0400
Message-ID: <20111126121953.GA11865@oksana.dev.rtsoft.ru>
References: <1322283343.14278.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65310 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459Ab1KZMT7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 26 Nov 2011 07:19:59 -0500
Content-Disposition: inline
In-Reply-To: <1322283343.14278.2.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Micha <mirq-linux@rere.qmqm.pl>, David Brown <davidb@codeaurora.org>, Ben Dooks <ben-linux@fluff.org>, Viresh Kumar <viresh.kumar@st.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Sat, Nov 26, 2011 at 12:55:43PM +0800, Axel Lin wrote:
> This patch converts the drivers in drivers/mmc/host/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.

Personally I would prefer the macro name capitalized.

Other than that, it look OK.

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
