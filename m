From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 06/14] mmc: mmci: Qcomm: Add 3 clock cycle delay after
 register write
Date: Fri, 23 May 2014 11:03:38 +0200
Message-ID: <CACRpkdYN3fg9Qd0oMYd3ghx4+8dqh8WwF5Aa-VjRDaxcOBZoKg@mail.gmail.com>
References: <1400146447-29803-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1400146621-30056-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:57252 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbaEWJDi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 05:03:38 -0400
Received: by mail-vc0-f178.google.com with SMTP id ij19so2478847vcb.23
        for <linux-mmc@vger.kernel.org>; Fri, 23 May 2014 02:03:38 -0700 (PDT)
In-Reply-To: <1400146621-30056-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

On Thu, May 15, 2014 at 11:37 AM,  <srinivas.kandagatla@linaro.org> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> Most of the Qcomm SD card controller registers must be updated to the MCLK
> domain so subsequent writes to registers will be ignored until 3 clock cycles
> have passed.
>
> This patch adds a 3 clock cycle delay required after writing to controller
> registers on Qualcomm SOCs. Without this delay all the register writes are not
> successful, resulting in not detecting cards. The write clock delay is
> activated by setting up mclk_delayed_writes variable in variant data.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

OK this is looking good.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
