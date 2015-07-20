From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] adds quirk SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
Date: Mon, 20 Jul 2015 13:18:59 +0200
Message-ID: <CAPDyKFoe2YsAhNSG=kVcscLUesXPUAiKH4ffOMHjGBCJU41s_A@mail.gmail.com>
References: <1433835111-32522-1-git-send-email-suneel.garapati@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33974 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbbGTLTA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2015 07:19:00 -0400
Received: by qkfc129 with SMTP id c129so66703596qkf.1
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jul 2015 04:18:59 -0700 (PDT)
In-Reply-To: <1433835111-32522-1-git-send-email-suneel.garapati@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Suneel Garapati <suneel.garapati@xilinx.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, michals@xilinx.com, sorenb@xilinx.com, Adrian Hunter <adrian.hunter@intel.com>, Aisheng Dong <b29396@freescale.com>, Haibo Chen <haibo.chen@freescale.com>, Tim Kryger <tim.kryger@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Yi Sun <yi.y.sun@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Suman Tripathi <stripathi@apm.com>

On 9 June 2015 at 09:31, Suneel Garapati <suneel.garapati@xilinx.com> wrote:
> This quirk will support controllers whose clock divider zero is broken
> and if the calculation results to zero, forcing the divider to next value.
> This is tested on zynq ep108 and enables support for UHS cards where formatting
> cards fail. Added few quirks to arasan platform driver as the base clock reported in
> registers is broken and preset values are broken too and tested on zynq ep108
> platform. max-frequency devicetree parameter is alternative to get upper limit .
>
> Suneel Garapati (2):
>   drivers: mmc: add quirk SDHCI_QUIRK_CLOCK_DIV_ZERO_BROKEN
>   drivers: mmc: add quirks for broken clock base
>
>  drivers/mmc/host/sdhci-of-arasan.c | 3 +++
>  drivers/mmc/host/sdhci.c           | 4 ++++
>  drivers/mmc/host/sdhci.h           | 2 ++
>  3 files changed, 9 insertions(+)
>
> --
> 2.1.2

Thanks, applied!

Do note that both patches had checkpatch errors, which complained
about the patch format.
I decided to fix them, but next time please make sure to run checkpatch.

Also, I changed the prefix of patch1 to "mmc: sdhci: and for patch 2
to "mmc: sdhci-of-arasan".

Kind regards
Uffe
