From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: sdhci-pci: Use ACPI to set max frequency of sdio host
Date: Tue, 22 Nov 2016 09:27:29 +0100
Message-ID: <CAPDyKFrbfiTuU6zvQ8RR9pcO+x+9AZUejHrw396+Xsn2gCMsGA@mail.gmail.com>
References: <1479769446-8490-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34945 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755578AbcKVI1g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2016 03:27:36 -0500
Received: by mail-wm0-f48.google.com with SMTP id a197so11774360wmd.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2016 00:27:31 -0800 (PST)
In-Reply-To: <1479769446-8490-1-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 22 November 2016 at 00:04, Zach Brown <zach.brown@ni.com> wrote:
> On some boards, max SDIO frequency is limited by trace lengths and other layout
> choices. We would like a way to specify this limitation so the driver can
> behave accordingly.
>
> This patch set assumes that the limitation has been reported in an ACPI table
> which the driver can check to get the max frequency.
>
> The first patch creates a PCI ID and support for the Intel byt sdio where NI is
> the subvendor.
>
> The second patch uses the ACPI table to set f_max during the new
> ni_byt_sdio_probe_slot.
>
>
> Zach Brown (2):
>   mmc: sdhci-pci: Add PCI ID for Intel byt sdio host controller
>     sub-vended by NI
>   mmc: sdhci-pci: Use ACPI to get max frequency for Intel byt sdio
>     controller sub-vended by NI
>
>  drivers/mmc/host/sdhci-pci-core.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> --
> 2.7.4
>

Please try to not forget to bump the version number and to provide a
history of the what changes between revisions. It makes life easier
when reviewing and when I am about to apply patches.

Kind regards
Uffe
