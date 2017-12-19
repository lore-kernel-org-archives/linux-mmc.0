From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4] mmc: sdhci-xenon: wait 5ms after set 1.8V signal enable
Date: Tue, 19 Dec 2017 08:54:59 +0100
Message-ID: <CAPDyKFoDFz5u+KeMoAYmZME_boRpAvRyiizzo1NbKUBSVN6c=w@mail.gmail.com>
References: <1513636727-4503-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:47028 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935916AbdLSHzA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Dec 2017 02:55:00 -0500
Received: by mail-io0-f195.google.com with SMTP id x129so12646216iod.13
        for <linux-mmc@vger.kernel.org>; Mon, 18 Dec 2017 23:55:00 -0800 (PST)
In-Reply-To: <1513636727-4503-1-git-send-email-zjwu@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, xswang@marvell.com, Wilson Ding <dingwei@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, hongd@marvell.com, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On 18 December 2017 at 23:38, Zhoujie Wu <zjwu@marvell.com> wrote:
> According to SD spec 3.00 3.6.1 signal voltage switch
> procedure step 6~8,
> (6) Set 1.8V Signal Enable in the Host Control 2 register.
> (7) Wait 5ms. 1.8V voltage regulator shall be stable within this period.
> (8) If 1.8V Signal Enable is cleared by Host Controller, go to step (12).
> Host should wait 5ms after set 1.8V signal enable bit in
> Host Control 2 register and check if 1.8V is stable or not.
>
> But current code checks this bit right after set it.
> On some platforms with xenon controller found the bit is
> cleared right away and host reports "1.8V regulator output
> did not became stable" and 5ms delay can help.
>
> Implement voltage_switch callback for xenon controller to add 5ms
> delay to make sure the 1.8V signal enable bit is set by controller.
>
> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> v4: move the 5ms delay from sdhci.c to xenon driver.
> v3: give more details in comments.
> v2: remove undeliverable cc list email.
>
>  drivers/mmc/host/sdhci-xenon.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 0842bbc..4d0791f 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -230,7 +230,14 @@ static void xenon_set_power(struct sdhci_host *host, unsigned char mode,
>                 mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>  }
>
> +static void xenon_voltage_switch(struct sdhci_host *host)
> +{
> +       /* Wait for 5ms after set 1.8V signal enable bit */
> +       usleep_range(5000, 5500);
> +}
> +
>  static const struct sdhci_ops sdhci_xenon_ops = {
> +       .voltage_switch         = xenon_voltage_switch,
>         .set_clock              = sdhci_set_clock,
>         .set_power              = xenon_set_power,
>         .set_bus_width          = sdhci_set_bus_width,
> --
> 1.9.1
>
