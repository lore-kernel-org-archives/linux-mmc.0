From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 4/5] mmc: mmci: Add sdio enable mask in variant data
Date: Wed, 13 Aug 2014 10:55:55 +0200
Message-ID: <CACRpkda2qQ+3eG032Ln2hWYGJ3rkeCwqjvYc9hYBzQFGgGjiOg@mail.gmail.com>
References: <1407844950-8072-1-git-send-email-srinivas.kandadgatla@linaro.org>
	<1407845102-8402-1-git-send-email-srinivas.kandadgatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:47320 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbaHMIz4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Aug 2014 04:55:56 -0400
Received: by mail-oa0-f51.google.com with SMTP id o6so8298474oag.10
        for <linux-mmc@vger.kernel.org>; Wed, 13 Aug 2014 01:55:55 -0700 (PDT)
In-Reply-To: <1407845102-8402-1-git-send-email-srinivas.kandadgatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

On Tue, Aug 12, 2014 at 2:05 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds sdio enable mask in variant data, SOCs like ST have
> special bits in datactrl register to enable sdio. Unconditionally setting
> this bit in this driver breaks other SOCs like Qualcomm which maps this
> bits to something else, so making this enable bit to come from variant
> data solves the issue.
>
> Originally the issue is detected while testing WLAN ath6kl on Qualcomm
> APQ8064.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
