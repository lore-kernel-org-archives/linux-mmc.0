From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH RFT] mmc: sdhci-spear: Convert to use sdhci_pltfm_* APIs
Date: Mon, 2 Sep 2013 11:12:05 +0530
Message-ID: <CAOh2x=npxq-yk4gFZJTathX1xCsV8tc7=6YQdjFm-P7kXdbj+Q@mail.gmail.com>
References: <1377931319.10324.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:55473 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439Ab3IBFmH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Sep 2013 01:42:07 -0400
Received: by mail-vc0-f176.google.com with SMTP id ha11so2738478vcb.35
        for <linux-mmc@vger.kernel.org>; Sun, 01 Sep 2013 22:42:06 -0700 (PDT)
In-Reply-To: <1377931319.10324.1.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, spear-devel <spear-devel@list.st.com>

On Sat, Aug 31, 2013 at 12:11 PM, Axel Lin <axel.lin@ingics.com> wrote:
> This patch refactors the code to use sdhci_pltfm_* APIs instead of open-coded.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi Viresh,
> Looks like this driver can be converted to use sdhci_pltfm_* APIs instead of
> open-coded. I don't have this hardware, any chance to test if this patch works?

I can't, don't have that hardware anymore :(
