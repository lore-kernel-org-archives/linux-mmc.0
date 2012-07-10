From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v2] mmc: omap: add clk_prepare and clk_unprepare
Date: Tue, 10 Jul 2012 09:57:27 +0530
Message-ID: <CANfBPZ9=-CZ=-bKN80tAZmWDZAvWNLxDcCR6hjQQzZ4qhQvbEA@mail.gmail.com>
References: <1340786994-29565-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:43167 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751933Ab2GJE1u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jul 2012 00:27:50 -0400
Received: by bkcji2 with SMTP id ji2so6233820bkc.22
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jul 2012 21:27:48 -0700 (PDT)
In-Reply-To: <1340786994-29565-1-git-send-email-rnayak@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Chris Ball <cjb@laptop.org>, Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>

On Wed, Jun 27, 2012 at 2:19 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
> and clk_unprepare() for the hsmmc clocks.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Balaji T K <balajitk@ti.com>
> Cc: <linux-mmc@vger.kernel.org>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Mike Turquette <mturquette@linaro.org>

Thanks Rajendra.
Acked-by: Venkatraman S <svenkatr@ti.com>

> ---
>  drivers/mmc/host/omap_hsmmc.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
>
