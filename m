From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH v2 0/5] mmc: sdhci: a few fixes on timeout and max_discard_to
Date: Mon, 13 Jan 2014 18:55:10 +0800
Message-ID: <CAA+hA=QgPvTXWbKjpd9e0H3MacGqu8=zz_PpCRAB0NGu_drVtw@mail.gmail.com>
References: <1387268191-19859-1-git-send-email-b29396@freescale.com>
	<20131217143025.GX6691@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:57146 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaAMKzL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2014 05:55:11 -0500
Received: by mail-qc0-f177.google.com with SMTP id i8so2684006qcq.36
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2014 02:55:10 -0800 (PST)
In-Reply-To: <20131217143025.GX6691@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Dong Aisheng <b29396@freescale.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ed Sutter <ed.sutter@alcatel-lucent.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Chris,

On Tue, Dec 17, 2013 at 10:30 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Dec 17, 2013 at 04:16:26PM +0800, Dong Aisheng wrote:
>> Dong Aisheng (5):
>>   mmc: sdhci: add platfrom get_max_timeout_count hook
>>   mmc: sdhci-esdhc-imx: fix incorrect max_discard_to for uSDHC
>>   mmc: sdhci: add platform set_timeout hook
>>   mmc: sdhci-esdhc-imx: set the correct max timeout value for uSDHC
>>   mmc: sdhci: calculate max_discard_to dynamically for
>>     SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
>
> For all,
>
> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
>

Can you pick this series?

Regards
Dong Aisheng

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
