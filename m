From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 13/14] mmc: mmci: add qcom specific clk control
Date: Fri, 23 May 2014 11:14:23 +0200
Message-ID: <CACRpkdYdvNeVh7tafCsZMtPrG5Q=iZs3tRJ5-fHoe1-kp-25Fg@mail.gmail.com>
References: <1400146447-29803-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1400146676-30343-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f169.google.com ([209.85.128.169]:64161 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbaEWJOY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 05:14:24 -0400
Received: by mail-ve0-f169.google.com with SMTP id jx11so6016454veb.28
        for <linux-mmc@vger.kernel.org>; Fri, 23 May 2014 02:14:23 -0700 (PDT)
In-Reply-To: <1400146676-30343-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

On Thu, May 15, 2014 at 11:37 AM,  <srinivas.kandagatla@linaro.org> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> On Qcom SD card controller, cclk is mclk and mclk should be directly
> controlled by the driver.
> This patch adds support to control mclk directly in the driver, and also
> adds explicit_mclk_control and cclk_is_mclk flags in variant structure giving
> more flexibility to the driver.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
(...)
> +       bool                    qcom_cclk_is_mclk;

I have no idea why you prefix that with "qcom" since it's an
abstract concept.

But it's a very minor issue, so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
