From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] mmc: sdhci-acpi: Fix Braswell eMMC timeout clock frequency
Date: Mon, 6 Oct 2014 15:14:16 +0200
Message-ID: <CAPDyKFptv2JourAMc2_bT-+23MtAqAupYtoSiVJQJ29mUZ40pA@mail.gmail.com>
References: <1412598187-5263-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:33873 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbaJFNOQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Oct 2014 09:14:16 -0400
Received: by mail-qg0-f53.google.com with SMTP id a108so3588182qge.26
        for <linux-mmc@vger.kernel.org>; Mon, 06 Oct 2014 06:14:16 -0700 (PDT)
In-Reply-To: <1412598187-5263-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 6 October 2014 14:23, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here are 3 patches that fix Fix Braswell eMMC timeout clock
> frequency.  A fix has already been done for sdhci-pci, so
> please consider these for 3.18 also.

Thanks! Applied for next.

Kind regards
Uffe

>
>
> Adrian Hunter (3):
>       mmc: sdhci-acpi: Get UID directly from acpi_device
>       mmc: sdhci-acpi: Pass HID and UID to probe_slot
>       mmc: sdhci-acpi: Fix Braswell eMMC timeout clock frequency
>
>  drivers/mmc/host/sdhci-acpi.c | 44 ++++++++++++++++++-------------------------
>  1 file changed, 18 insertions(+), 26 deletions(-)
>
>
> Regards
> Adrian
