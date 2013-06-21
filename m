From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add a quirk for Security Management Unit
Date: Fri, 21 Jun 2013 16:48:08 -0700
Message-ID: <CAD=FV=VeH5k6d0LgEDg+k-xdgmPwagVygQ2VSMkm7rfXrZEqkA@mail.gmail.com>
References: <1369389873-15018-1-git-send-email-yuvaraj.cd@samsung.com>
	<1369389873-15018-3-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:39533 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161536Ab3FUXsJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jun 2013 19:48:09 -0400
Received: by mail-la0-f51.google.com with SMTP id fq12so8011526lab.38
        for <linux-mmc@vger.kernel.org>; Fri, 21 Jun 2013 16:48:08 -0700 (PDT)
In-Reply-To: <1369389873-15018-3-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Thomas P Abraham <thomas.ab@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Paul Taysom <taysom@chromium.org>

Yuvaraj,

On Fri, May 24, 2013 at 3:04 AM, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
> index bc3a1bc..a047ecf 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1959,6 +1959,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>                 mmc->caps |= MMC_CAP_4_BIT_DATA;
>         }
>
> +       if (host->pdata->quirks & DW_MCI_QUIRK_BYPASS_SMU)
> +               drv_data->cfg_smu(host);

Need to check that drv_data is not NULL, as discovered by Paul Taysom.
