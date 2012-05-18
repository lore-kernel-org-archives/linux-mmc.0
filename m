From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 3/6] mmc: dw_mmc: lookup for optional biu and ciu
	clocks
Date: Fri, 18 May 2012 08:49:01 +0100
Message-ID: <20120518074901.GA843@n2100.arm.linux.org.uk>
References: <1337267411-28226-1-git-send-email-thomas.abraham@linaro.org> <1337267411-28226-4-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47616 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760891Ab2ERHtQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 May 2012 03:49:16 -0400
Content-Disposition: inline
In-Reply-To: <1337267411-28226-4-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, kgene.kim@samsung.com, cjb@laptop.org, linux-arm-kernel@lists.infradead.org

On Thu, May 17, 2012 at 08:40:08PM +0530, Thomas Abraham wrote:
> +err_clk:
> +	if (!IS_ERR(host->ciu_clk))
> +		clk_disable_unprepare(host->ciu_clk);
> +	if (!IS_ERR(host->biu_clk))
> +		clk_disable_unprepare(host->biu_clk);
> +	clk_put(host->ciu_clk);
> +	clk_put(host->biu_clk);

+	if (!IS_ERR(host->ciu_clk)) {
+		clk_disable_unprepare(host->ciu_clk);
+		clk_put(host->ciu_clk);
+	}
+	if (!IS_ERR(host->biu_clk)) {
+		clk_disable_unprepare(host->biu_clk);
+		clk_put(host->biu_clk);
+	}

And the same in the other occurrence.
