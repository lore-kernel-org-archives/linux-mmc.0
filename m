From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: sdhci-sirf: let device core setup the default pin configuration
Date: Thu, 27 Jun 2013 10:32:08 -0400
Message-ID: <87obarsjyv.fsf@octavius.laptop.org>
References: <1368522511-26491-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41966 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753647Ab3F0OcN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 10:32:13 -0400
In-Reply-To: <1368522511-26491-1-git-send-email-Baohua.Song@csr.com> (Barry
	Song's message of "Tue, 14 May 2013 17:08:31 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <Baohua.Song@csr.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com

Hi,

On Tue, May 14 2013, Barry Song wrote:
> With device core now able to setup the default pin configuration, the call
> to devm_pinctrl_get_select_default can be removed. And the pin configuration
> code based on the deprecated Samsung specific gpio bindings is also removed.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
