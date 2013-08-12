From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] mmc: dw_mmc-exynos: Common bindings for dw-mshc timing
Date: Mon, 12 Aug 2013 17:15:01 -0600
Message-ID: <52096C75.1030305@wwwdotorg.org>
References: <1376002520-7461-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:52567 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755646Ab3HLXPF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Aug 2013 19:15:05 -0400
In-Reply-To: <1376002520-7461-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 08/08/2013 04:55 PM, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Remove the "samsung" in "samsung,dw-mshc-ciu-div", "samsung,dw-mshc-sdr-timing",
> and "samsung,dw-mshc-ddr-timing". These characteristics are not applicable to
> just Samsung platforms, but to any platform that uses the Synopsis SD/MMC IP.

But the properties aren't globally standard; they apply specifically
anywhere that this particular Synopsis IP is present. As such, I think
at least a "synopsis," prefix is warranted.

And the driver should probably support both the old and new property
names for backwards-compatibility?
