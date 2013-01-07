From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH v3 3/3] mmc: core: Fixup signal voltage switch
Date: Mon, 7 Jan 2013 11:26:16 +0100
Message-ID: <CA+20K0CrYAkuCepiSo3EwMnv4we8b_RvBuVAh7HsgzPjipJYLQ@mail.gmail.com>
References: <1357219176-21892-1-git-send-email-johan.rudholm@stericsson.com>
	<1357219176-21892-4-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:46297 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab3AGK0S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jan 2013 05:26:18 -0500
Received: by mail-qc0-f169.google.com with SMTP id t2so12249172qcq.28
        for <linux-mmc@vger.kernel.org>; Mon, 07 Jan 2013 02:26:17 -0800 (PST)
In-Reply-To: <1357219176-21892-4-git-send-email-johan.rudholm@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@nvidia.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>, Subhash Jadavani <subhashj@codeaurora.org>, Kevin Liu <kliu5@marvell.com>

Hi,

2013/1/3 Johan Rudholm <johan.rudholm@stericsson.com>:

<snip>

> +               err = host->ops->start_signal_voltage_switch(host, &host->ios);
> +               if (err) {
> +                       /*
> +                        * Voltages may not been switched, but we've already
> +                        * sent CMD11, so a power cycle is required anyway
> +                        */
> +                       err = -EAGAIN;
> +                       goto power_cycle;
> +               } else
> +

yikes, sorry, this else is hanging loose, will be fixed in the next version.

Kind regards, Johan
