From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Remove unused variables
Date: Thu, 17 Jan 2013 00:31:44 -0200
Message-ID: <CAOMZO5D__bQ_N+=c5XcgphegJe-kYMO8PF1R1bo0J3uMixrrtQ@mail.gmail.com>
References: <1358383916-23614-1-git-send-email-festevam@gmail.com>
	<20130117022546.GG26179@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:61305 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928Ab3AQCbp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jan 2013 21:31:45 -0500
Received: by mail-vc0-f177.google.com with SMTP id fo14so1773558vcb.8
        for <linux-mmc@vger.kernel.org>; Wed, 16 Jan 2013 18:31:45 -0800 (PST)
In-Reply-To: <20130117022546.GG26179@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Thu, Jan 17, 2013 at 12:25 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Jan 16, 2013 at 10:51:56PM -0200, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> commit 842afc02cf (mmc: sdhci-esdhc-imx: do not reference platform data after
>> probe) introduced the following build warnings:
>>
> My bad.  The warnings are introduced by my commit 78b2b04 (mmc:

I guess you meant 3f175a6e5 instead. Will fix it in v2.
