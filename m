From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 13/14] mmc: meson-gx: work around clk-stop issue
Date: Mon, 07 Aug 2017 14:41:57 -0700
Message-ID: <7hzibbnjh6.fsf@baylibre.com>
References: <20170804174353.16486-1-jbrunet@baylibre.com>
        <20170804174353.16486-14-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35277 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbdHGVmF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2017 17:42:05 -0400
Received: by mail-pg0-f50.google.com with SMTP id v189so6462087pgd.2
        for <linux-mmc@vger.kernel.org>; Mon, 07 Aug 2017 14:42:05 -0700 (PDT)
In-Reply-To: <20170804174353.16486-14-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Fri, 4 Aug 2017 19:43:52 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> It seems that the signal clock is also used and required, somehow, by
> the controller it self.
>
> It is shown during init, when writing to CFG while the divider is set
> to 0 will crash the SoC. During voltage switch, the controller may crash
> and the card may then fail to exit busy state if the clock is stopped.
>
> To avoid this, it is best to keep the clock running for the controller,
> except during rate change. However, we still need to be able to gate
> the clock out of the SoC. Let's use the pinmux for this, and fallback
> to gpio mode (pulled-down) when we need to gate the clock
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Curious "feature" of the IP, but the solution looks good to me.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
