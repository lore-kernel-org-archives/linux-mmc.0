From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] mmc: sdhci: Conditionalize regulator_get() on CONFIG_REGULATOR
Date: Sat, 30 Apr 2011 17:06:46 +0200
Message-ID: <4DBC2586.1080201@metafoo.de>
References: <m3r58k1hlc.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out-171.synserver.de ([212.40.185.171]:1036 "HELO
	smtp-out-170.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1750918Ab1D3PNe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 30 Apr 2011 11:13:34 -0400
In-Reply-To: <m3r58k1hlc.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>

On 04/30/2011 06:35 AM, Chris Ball wrote:
> The regulator subsystem provides stubbed out versions of its calls that
> are always present (so that they can be used without needing #ifdefs).
> But the regulator_get() stub always returns an error value according
> to IS_ERR(), which leads sdhci to print messages like "mmc0: no vmmc
> regulator found" on every boot, even if CONFIG_REGULATOR is not set.
> 
> This patch fixes that (and removes the unwanted message) by having
> the regulator_get() call occur inside an #ifdef CONFIG_REGULATOR.

Shouldn't the stubbed version of regulator_get return NULL, which is not
treated as an error by IS_ERR?

- Lars
