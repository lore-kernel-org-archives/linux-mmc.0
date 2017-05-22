From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Check the return value from clk_prepare_enable()
Date: Mon, 22 May 2017 10:21:00 -0300
Message-ID: <CAOMZO5BA05dqc6uoGFJAoi3vvRjTBaiEC3yzSzRWyfa7-yhh=g@mail.gmail.com>
References: <1493409604-24716-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33009 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758040AbdEVNVB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2017 09:21:01 -0400
Received: by mail-oi0-f67.google.com with SMTP id h4so22643794oib.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 May 2017 06:21:01 -0700 (PDT)
In-Reply-To: <1493409604-24716-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Dong Aisheng <dongas86@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>

Hi Ulf,

On Fri, Apr 28, 2017 at 5:00 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> clk_prepare_enable() may fail, so we should better check its return value
> and propagate it in the case of error.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

A gentle ping.
