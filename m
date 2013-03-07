From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: let device core setup the default pin configuration
Date: Thu, 7 Mar 2013 09:09:58 +0100
Message-ID: <CACRpkdY-RVAXxc2TqDcczhCLGDC8d401ucuCCDzRb+Ha9apr8g@mail.gmail.com>
References: <1362569776-13932-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:55183 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879Ab3CGIJ6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Mar 2013 03:09:58 -0500
Received: by mail-ia0-f173.google.com with SMTP id h37so173552iak.4
        for <linux-mmc@vger.kernel.org>; Thu, 07 Mar 2013 00:09:58 -0800 (PST)
In-Reply-To: <1362569776-13932-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, ben-linux@fluff.org, jh80.chung@samsung.com, tgih.jun@samsung.com, girish.shivananjappa@linaro.org, patches@linaro.org

On Wed, Mar 6, 2013 at 12:36 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> With device core now able to setup the default pin configuration,
> the call to devm_pinctrl_get_select_default can be removed. And
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is also removed.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
