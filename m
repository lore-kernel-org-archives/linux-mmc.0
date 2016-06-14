From: Alan Cooper <alcooperx@gmail.com>
Subject: Re: [RESEND PATCH V5 1/2] mmc: sdhci-brcmstb: Add driver for Broadcom
 BRCMSTB SoCs
Date: Tue, 14 Jun 2016 11:21:02 -0400
Message-ID: <CAOGqxeVNSxiT2sP+XMLoseFJ84MevhDJQ1kPBFg4Tryopt1zgw@mail.gmail.com>
References: <1465820340-16722-1-git-send-email-alcooperx@gmail.com>
 <1465820340-16722-2-git-send-email-alcooperx@gmail.com> <575FBC03.4060704@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35335 "EHLO
	mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbcFNPVF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2016 11:21:05 -0400
Received: by mail-qt0-f193.google.com with SMTP id 37so6560189qtc.2
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jun 2016 08:21:04 -0700 (PDT)
In-Reply-To: <575FBC03.4060704@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com

On Tue, Jun 14, 2016 at 4:10 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> The absence of a commit message is a red flag to some people.  You could
> write, for example, whether the driver is missing any features that still
> need to be added.

I'll improve my commit messages.

> Don't you need clk_disable_unprepare(clk) here.

Yes, I'll add this to the error paths that need it.

Thanks Adrian
Al
