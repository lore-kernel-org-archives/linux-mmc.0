From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] mmc: sdhci: adding support for a new Fujitsu sdhci IP
Date: Mon, 24 Nov 2014 10:54:16 +0100
Message-ID: <CAPDyKFqZyUT+sARZQ2ncusttDWn31uQf_H2eTtHOSCs2c8yO4A@mail.gmail.com>
References: <1416531100-26707-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:57918 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbaKXJyQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Nov 2014 04:54:16 -0500
Received: by mail-qc0-f172.google.com with SMTP id m20so6478168qcx.17
        for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2014 01:54:16 -0800 (PST)
In-Reply-To: <1416531100-26707-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, Andy Green <andy.green@linaro.org>, Patch Tracking <patches@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, Vincent Yang <Vincent.Yang@tw.fujitsu.com>

On 21 November 2014 at 01:51, Vincent Yang
<vincent.yang.fujitsu@gmail.com> wrote:
> Hello,
>
>   Fujitsu have an sdhci IP which is implemented in a SoC we're
> adding to mainline, the most recent series for that was sent
> here:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304522.html
>
>   These patches are against v3.18-rc5 mainline and tested on
> v3.18-rc5 integration tree.
>
>   We welcome any comment and advice about how to make any
> improvements or better align them with upstream.

Apparently, there's a dependency between this patchset and the upper
one you refereed to. That's a problem.

Preferably, try to remove the dependency and send all mmc patches to
the mmc list. If that's not possible, you need to send these two
patchsets as one instead.

>
> Thanks.
>
> Vincent Yang (4):
>   mmc: sdhci: add a voltage switch callback function
>   mmc: sdhci: add a quirk for tuning work around
>   mmc: sdhci: add a quirk for single block transactions
>   mmc: core: hold SD Clock before CMD11 during Signal

The last one I consider as a separate fix for mmc core. I will apply
it to my mmc tree.

Thanks and kind regards
Uffe
