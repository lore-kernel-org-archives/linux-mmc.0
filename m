From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH v3 1/3] mmc: mmci: Support any block sizes for ux500v2 and
 qcom variant
Date: Thu, 9 Jul 2015 14:40:23 -0700
Message-ID: <CAJAp7OiChqgX+x1TGzapzvQS2rJ7cUNSducCRbyqkbniTqo8NQ@mail.gmail.com>
References: <1408683219-7939-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1408683272-7984-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:34263 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272AbbGIVkZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jul 2015 17:40:25 -0400
Received: by lbnk3 with SMTP id k3so82371179lbn.1
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jul 2015 14:40:24 -0700 (PDT)
In-Reply-To: <1408683272-7984-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>

On Thu, Aug 21, 2014 at 9:54 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> For the ux500v2 variant of the PL18x block, any block sizes are
> supported. This will make it possible to decrease data overhead
> for SDIO transfers.
>
> This patch is based on Ulf Hansson patch
> http://www.spinics.net/lists/linux-mmc/msg12160.html
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>         enabled this support on qcom variant.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Srinivas,

Pulled this in to my tree today and got the bcm4339 in the Sony Xperia
Z3 to join the internet :)
So, did you pursue this further?

Regards,
Bjorn
