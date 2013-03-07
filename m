From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: dwmmc: let device core setup the default pin configuration
Date: Thu, 7 Mar 2013 09:13:44 +0100
Message-ID: <CACRpkdaDLn3mQHhf3iUwFaEXyT1DJc8JzgR2UteQhZqjaPA0xQ@mail.gmail.com>
References: <1362571461-14570-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:51064 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784Ab3CGINp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Mar 2013 03:13:45 -0500
Received: by mail-ie0-f173.google.com with SMTP id 9so215864iec.18
        for <linux-mmc@vger.kernel.org>; Thu, 07 Mar 2013 00:13:45 -0800 (PST)
In-Reply-To: <1362571461-14570-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, linux-arm-kernel@lists.infradead.org, t.figa@samsung.com, heiko@sntech.de, patches@linaro.org

On Wed, Mar 6, 2013 at 1:04 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> With device core now able to setup the default pin configuration,
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is removed.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
