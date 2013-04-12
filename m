From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v5] mmc: dw_mmc: let device core setup the default pin configuration
Date: Fri, 12 Apr 2013 14:19:15 -0400
Message-ID: <87y5cnehng.fsf@octavius.laptop.org>
References: <1365683047-8829-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47903 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752884Ab3DLSTY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 12 Apr 2013 14:19:24 -0400
In-Reply-To: <1365683047-8829-1-git-send-email-thomas.abraham@linaro.org>
	(Thomas Abraham's message of "Thu, 11 Apr 2013 17:54:07 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, linux-arm-kernel@lists.infradead.org, t.figa@samsung.com, heiko@sntech.de, linus.walleij@linaro.org, dianders@chromium.org, patches@linaro.org

Hi,

On Thu, Apr 11 2013, Thomas Abraham wrote:
> With device core now able to setup the default pin configuration,
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is removed.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> Changes since v4:
> - Fixed the incorrecr return path after error in enabling vmmc regulator
>   as pointed out by Doug.

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
