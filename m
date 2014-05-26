From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 06/13] mmc: mmci: Qcomm: Add 3 clock cycle delay after
 register write
Date: Mon, 26 May 2014 18:04:31 +0100
Message-ID: <5383741F.8010205@linaro.org>
References: <1400849362-7007-1-git-send-email-srinivas.kandagatla@linaro.org>	<1400849504-7302-1-git-send-email-srinivas.kandagatla@linaro.org> <CAPDyKFoSjXy8ptyrk_wN3N4Ovvy==HpX9S0n0endsh0Ca2kMtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:61668 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbaEZREg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 May 2014 13:04:36 -0400
Received: by mail-wg0-f42.google.com with SMTP id y10so8121082wgg.25
        for <linux-mmc@vger.kernel.org>; Mon, 26 May 2014 10:04:35 -0700 (PDT)
In-Reply-To: <CAPDyKFoSjXy8ptyrk_wN3N4Ovvy==HpX9S0n0endsh0Ca2kMtA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>


>
> I am not sure I like this approach. For each and every writel
> (including pio_writes) you will add a few cpu cycles, since you need
> to  check for "mclk_delayed_writes" no matter of variant.
>

> How about, adding a new function pointer in the struct mmci_host, for
> "writel operations" which you could set up in probe phase instead?
>

Yes, this is an additional check for other variants. I will try the 
function pointer method that you suggested.

Thanks,
srini


> Kind regards
> Ulf Hansson
>
