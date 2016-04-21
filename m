From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/3] mmc: usdhi6rol0: add support for UHS modes
Date: Thu, 21 Apr 2016 11:52:40 +0200
Message-ID: <14935418.cYIzx5HmZZ@wuerfel>
References: <cover.1461163234.git.larper@axis.com> <4129305.Ka9B8YpEaI@wuerfel> <57188ECF.70101@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:62394 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbcDUJw6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2016 05:52:58 -0400
In-Reply-To: <57188ECF.70101@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars Persson <lars.persson@axis.com>
Cc: Lars Persson <larper@axis.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, g.liakhovetski@gmx.de, ulf.hansson@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org

On Thursday 21 April 2016 10:26:55 Lars Persson wrote:
> 
> It is a common pattern in all upstream mmc drivers to not make the call 
> to mmc_regulator_set_vqmmc() when a regulator is missing. We basically 
> want to log errors except for the EINVAL returned in case of a missing 
> regulator.
> 
> 

I see what you mean here: two out of four drivers calling
mmc_regulator_set_vqmmc() log errors to the console.

If we want all drivers to behave consistently here, how about
moving that error output into the mmc_regulator_set_vqmmc() function
itself?

	Arnd
