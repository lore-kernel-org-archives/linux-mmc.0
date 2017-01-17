From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/3] mmc: sh_mobile_sdhi: add support for 2 clocks
Date: Tue, 17 Jan 2017 21:30:18 +0100
Message-ID: <20170117203017.r3g43scvrkwpe6kt@ninjato>
References: <20170117195940.25092-1-chris.brandt@renesas.com>
 <20170117195940.25092-2-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34210 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbdAQUj5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Jan 2017 15:39:57 -0500
Content-Disposition: inline
In-Reply-To: <20170117195940.25092-2-chris.brandt@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hi Chris,

> +	struct clk *clk2;

I'd vote for 'clk_cd' since we are explicitly requesting that clock for
it.

> +	ret = clk_prepare_enable(priv->clk2);
> +	if (ret < 0)
> +		return ret;

You need to disable clk when failing.

Regards,

   Wolfram

