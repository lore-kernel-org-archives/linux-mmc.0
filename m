From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 01/11] ARM: amba: Add Qualcomm vendor ID.
Date: Tue, 13 May 2014 09:16:33 +0200
Message-ID: <CACRpkdZyEAkJUGC5x6CY65-g97jfyg-TMDoe8JxDMexVx5usSA@mail.gmail.com>
References: <1398759492-12970-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1398759542-13017-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:44726 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829AbaEMHQd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 May 2014 03:16:33 -0400
Received: by mail-oa0-f54.google.com with SMTP id j17so9534233oag.13
        for <linux-mmc@vger.kernel.org>; Tue, 13 May 2014 00:16:33 -0700 (PDT)
In-Reply-To: <1398759542-13017-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, agross@quicinc.com, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

On Tue, Apr 29, 2014 at 10:19 AM,  <srinivas.kandagatla@linaro.org> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds Qualcomm amba vendor Id to the list. This ID is used in mmci
> driver.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
(...)
> +       AMBA_VENDOR_QCOM = 0x51,

Yeah it's a "Q", like 0x41 is "A" for ARM. You could as well mention
this in the commit message.

And you can probably just put this patch into Russell's patch tracker
already.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
