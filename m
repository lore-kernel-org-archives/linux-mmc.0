From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] mmc: core: skip mmc_power_up call from start host
Date: Tue, 17 Jul 2012 16:22:26 +0530
Message-ID: <CANfBPZ8dR7mzQpYKqCoqqRBwa8dCJD9JZ_tWDr+PVOMp0Ew-qw@mail.gmail.com>
References: <1342184235-6912-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:34561 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753632Ab2GQKws (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jul 2012 06:52:48 -0400
Received: by bkcik5 with SMTP id ik5so162493bkc.34
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jul 2012 03:52:46 -0700 (PDT)
In-Reply-To: <1342184235-6912-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On Fri, Jul 13, 2012 at 6:27 PM, Girish K S
<girish.shivananjappa@linaro.org> wrote:
> The call to the mmc_power_up during the mmc_start_host breaks the card
> detection in design-ware host controller. This patch removes the call to
> mmc_power_up function during host start.
>
Please explain why. Which commit introduced it ?

> This fix works fine with sdhci (sdhci compatilble host controller)
> and dw_mmc (design-ware host controller). and has no side effect due to
> this removal.
>
How can you be sure ? What about other hosts ?
