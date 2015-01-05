From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: Add support for Intel SPT
Date: Mon, 5 Jan 2015 16:23:06 +0100
Message-ID: <CAPDyKFpis7i_-0X1t75TqABYL=5xyRuJGK3j=cRd0Qc-F7sLmg@mail.gmail.com>
References: <1420462078-28868-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:41510 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbbAEPXH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jan 2015 10:23:07 -0500
Received: by mail-qg0-f50.google.com with SMTP id z60so15644826qgd.9
        for <linux-mmc@vger.kernel.org>; Mon, 05 Jan 2015 07:23:06 -0800 (PST)
In-Reply-To: <1420462078-28868-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 5 January 2015 at 13:47, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here are a couple of patches to add some IDs.
>
> Please queue them as fixes.
>
>
> Adrian Hunter (2):
>       mmc: sdhci-acpi: Add ACPI HID INT344D
>       mmc: sdhci-pci: Add support for Intel SPT
>
>  drivers/mmc/host/sdhci-acpi.c |  2 ++
>  drivers/mmc/host/sdhci-pci.c  | 25 +++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci.h  |  3 +++
>  3 files changed, 30 insertions(+)
>
>
> Regards
> Adrian

Thanks! Applied for fixes.

Kind regards
Uffe
