From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: read all data in FIFO after Data transfer
 over interrupt in pio mode
Date: Mon, 21 Jan 2013 10:44:50 +0000
Message-ID: <CAFbHwiTKBUiEyRzwv=mtvfqXQToD62j8RQedAk13SH+WwvPWHg@mail.gmail.com>
References: <001701cdf7c0$bb3c5fd0$31b51f70$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:64527 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480Ab3AUKow (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jan 2013 05:44:52 -0500
Received: by mail-la0-f46.google.com with SMTP id fq12so3483753lab.19
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jan 2013 02:44:50 -0800 (PST)
In-Reply-To: <001701cdf7c0$bb3c5fd0$31b51f70$%kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyoungil Kim <ki0351.kim@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>

On Mon, Jan 21, 2013 at 10:19 AM, Kyoungil Kim <ki0351.kim@samsung.com> wrote:
> In dwc manual, the below contents are described.
> "During end of packet, interrupt is not generated if threshold
> programming is larger than any remaining data. It is responsibility
> of host to read remaining bytes on seeing Data Transfer Done
> interrupt"
> We also have seen the data cannot be read fully
> when "sg_miter->length" is less than FIFO size.
>
> Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 323c502..afcc0f4 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1430,7 +1430,7 @@ static void dw_mci_pull_data(struct dw_mci *host, void *buf, int cnt)
>         host->pull_data(host, buf, cnt);
>  }
>
> -static void dw_mci_read_data_pio(struct dw_mci *host)
> +static void dw_mci_read_data_pio(struct dw_mci *host, u8 int_data_over)

The data_over argument should probably be a bool.
