From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 1/6] mmc: sdhci: add platfrom get_max_timeout hook
Date: Wed, 11 Dec 2013 12:59:55 +0800
Message-ID: <CAA+hA=TjhLKmLucm9R3fkiDQGCxTf_5WCMKbgyBXuuqC6Q0-RQ@mail.gmail.com>
References: <1386680168-5227-1-git-send-email-b29396@freescale.com>
	<1386680168-5227-2-git-send-email-b29396@freescale.com>
	<20131211015640.GA18380@S2101-09.ap.freescale.net>
	<CAA+hA=ST0fAa2__PaeJqxj2yDWUAr6iaNO4Dj7ABiEWqnYp6Vw@mail.gmail.com>
	<20131211031254.GF18380@S2101-09.ap.freescale.net>
	<CAA+hA=QrEiwg8+hmEONgP5u6C0_YwQhEeBfDoFQTv=aCaLhqkQ@mail.gmail.com>
	<20131211035654.GI18380@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:56788 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab3LKE7z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2013 23:59:55 -0500
Received: by mail-qa0-f53.google.com with SMTP id j5so264371qaq.12
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2013 20:59:55 -0800 (PST)
In-Reply-To: <20131211035654.GI18380@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Dong Aisheng <b29396@freescale.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ed Sutter <ed.sutter@alcatel-lucent.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, adrian.hunter@intel.com, vladimir_zapolskiy@mentor.com, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Dec 11, 2013 at 11:56 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Dec 11, 2013 at 11:20:59AM +0800, Dong Aisheng wrote:
>> No, the max_to is the max timeout counter value, you need to divide it
>> by the timeout clock
>> to get the timeout time.
>> The defined of this API is return the max timeout value in
>> miliseconds, so you need to
>> divide the clock by 1000.
>> None of these handles the detail bout discard_to.
>
> Let me start it over again.  Here is basically what your patch does.
>
> -     mmc->max_discard_to = (1 << 27) / host->timeout_clk;
> +     if (host->ops->get_max_timeout)
> +             mmc->max_discard_to = host->ops->get_max_timeout(host);
>
> The only thing that does not work for you in the existing code is the
> (1 << 27) part, right?
>
> If so, why not just create a platform hook to return the correct thing
> for you platform, i.e. (1 << 28)?
>
>         if (host->ops->get_max_timeout)
>                 mmc->max_discard_to = host->ops->hook_foo(host);
>
> unsigned int esdhc_hook_foo(struct sdhci_host *host)
> {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct pltfm_imx_data *imx_data = pltfm_host->priv;
>
>         return esdhc_is_usdhc(imx_data) ? 1 << 28 : 1 << 27;
> }
>
> Such patch will be ease to be understood and less offensive to the
> existing code, no?
>

The example you give is not correct here.
The max timeout counter returned by esdhc_hook_foo can not be simpled assigned
to max_discard_to which is timeout in miliseconds.

Actually what i did is like the way you said:
-       mmc->max_discard_to = (1 << 27) / host->timeout_clk;
+       if (host->ops->get_max_timeout)
+               mmc->max_discard_to = host->ops->get_max_timeout(host);
+       else
+               mmc->max_discard_to = (1 << 27) / host->timeout_clk;

+unsigned int esdhc_get_max_timeout(struct sdhci_host *host)
+{
+       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+       struct pltfm_imx_data *imx_data = pltfm_host->priv;
+       u32 max_to = esdhc_is_usdhc(imx_data) ? 1 << 28 : 1 << 27;
+
+       return max_to / (esdhc_pltfm_get_max_clock(host) / 1000);
+}

Regards
Dong Aisheng

> Shawn
>
