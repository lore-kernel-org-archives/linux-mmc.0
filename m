From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: sdhci-pxav3: set_uhs_signaling is initialized
	twice differently
Date: Fri, 15 Aug 2014 10:47:08 +0100
Message-ID: <20140815094707.GW30401@n2100.arm.linux.org.uk>
References: <1408093958-26058-1-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1408093958-26058-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, zhangfei.gao@marvell.com, prakity@marvell.com, patches@linaro.org, lee.jones@linaro.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 15, 2014 at 10:12:38AM +0100, Peter Griffin wrote:
> .set_uhs_signaling field is currently initialised twice once to the
> arch specific callback pxav3_set_uhs_signaling, and also to the generic
> sdhci_set_uhs_signaling callback.
> 
> This means that uhs is currently broken for this platform currently, as pxav3
> has some special constriants which means it can't use the generic callback.
> 
> This happened in
> commit 96d7b78cfc2f ("mmc: sdhci: convert sdhci_set_uhs_signaling() into a library function")
> commit a702c8abb2a9 ("mmc: host: split up sdhci-pxa, create sdhci-pxav3.c")'

This is exactly why named initialisers should always follow the
declaration order in the structure definition.

It also helps avoid git merge to properly resolve two additions of
the same member (possibly with a conflict) rather than just adding
both.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
