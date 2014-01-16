From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
Date: Thu, 16 Jan 2014 11:25:35 +0000
Message-ID: <20140116112535.GT15937@n2100.arm.linux.org.uk>
References: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org> <15344443.B6eHZOpkXH@wuerfel> <20140115162210.GP15937@n2100.arm.linux.org.uk> <201401161212.11246.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:38877 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752314AbaAPLZs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 06:25:48 -0500
Content-Disposition: inline
In-Reply-To: <201401161212.11246.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: zhangfei <zhangfei.gao@linaro.org>, 'Kevin Hilman' <khilman@linaro.org>, 'Mike Turquette' <mturquette@linaro.org>, patches@linaro.org, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Chris Ball' <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Thu, Jan 16, 2014 at 12:12:10PM +0100, Arnd Bergmann wrote:
> On Wednesday 15 January 2014, Russell King - ARM Linux wrote:
> > The issue here is that we'll potentially now end up with three
> > inversions.  One in the GPIO layers.  One in mmc_gpio_get_cd(), and
> > another in every driver which uses the GPIO layer inversion.  This
> > is hardly the right approach as it leads to multiple points where
> > confusion about the inverted status can occur.
> 
> I did not mean to suggest adding a third inversion. We already have
> to deal with the one in the GPIO layer and the one in mmc_gpio_get_cd(),
> which I absolutely agree is unfortunate. As was pointed out already,
> the gpio driver used in this system does not support the inversion
> in the DT binding, so the only proper solution is to use the
> inversion from mmc_gpio_get_cd if MMC_CAP2_CD_ACTIVE_HIGH is set
> in host->caps2. This flag gets set from mmc_of_parse based
> on the presence of the "cd-inverted" flag, in the absence of the
> gpio flags. The dw_mmc driver does not use mmc_of_parse() at the
> moment, and while it probably should use that in the future,
> it should definitely read the same DT properties with the
> same semantics already and not introduce new properties.

Arnd,

The issue I'm pointing out is that _if_ you use the GPIO layer to do
the inversion, then you end up with _three_ inversions of the signal,
which is excessive and confusing - and makes the sense of
mmc_gpio_get_cd() completely indeterminant without reading the DT
files and the code.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
