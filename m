From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] mmc: Add some flags for Intel host controllers
Date: Tue, 2 Dec 2014 12:26:37 +0100
Message-ID: <CAPDyKFppztXuK50_eHW5fjDqnUS_kUML4N4fY8DiKb23UCNcyA@mail.gmail.com>
References: <1417441879-28058-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:60490 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbaLBL0i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Dec 2014 06:26:38 -0500
Received: by mail-qc0-f175.google.com with SMTP id b13so10008845qcw.20
        for <linux-mmc@vger.kernel.org>; Tue, 02 Dec 2014 03:26:37 -0800 (PST)
In-Reply-To: <1417441879-28058-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 1 December 2014 at 14:51, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here are some patches to add some flags for Intel
> host controllers.
>
>
> Adrian Hunter (4):
>       mmc: sdhci-pci: Add SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC to BYT
>       mmc: sdhci-acpi: Add SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
>       mmc: sdhci-pci: Add two host capabilities for BYT
>       mmc: sdhci-acpi: Add two host capabilities for Intel


Thanks! Applied for next.

Kind regards
Uffe
