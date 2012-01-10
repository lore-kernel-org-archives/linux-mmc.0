From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: mmc: add runtime PM handlers
Date: Tue, 10 Jan 2012 08:46:28 +0200
Message-ID: <CAK=WgbZKDsLMUhHhnTPO8xTeDNtwrN4T6thAJHmsiUsBZRAODQ@mail.gmail.com>
References: <4D20BBFA02A8654DAC7599E4EA20A55605367F@039-SN2MPN1-011.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46531 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab2AJGqt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2012 01:46:49 -0500
Received: by dajs34 with SMTP id s34so2649106daj.19
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jan 2012 22:46:49 -0800 (PST)
In-Reply-To: <4D20BBFA02A8654DAC7599E4EA20A55605367F@039-SN2MPN1-011.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lin Tony-B19295 <B19295@freescale.com>
Cc: "luciano.coelho@nokia.com" <luciano.coelho@nokia.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Tony,

On Tue, Jan 10, 2012 at 7:44 AM, Lin Tony-B19295 <B19295@freescale.com> wrote:
> [Tony Lin]does it mean Runtime PM is not fully supported by SD/MMC stack?

SDIO runtime PM is fully supported (there were also some initial MMC
runtime PM patches circulating at some point, but they were not merged
afaik).

It isn't enabled by default though: you'd have to flip a cap flag in
order to enable it for your chip.

> I really saw some problems using Runtime PM, so I just want a confirmation.

The problems you saw are all related to the sd8686, with which it is
required to toggle an external gpio on some setups whenever power is
switched off and brought back again. This isn't implemented yet, so
we're not enabling SDIO runtime PM by default at this point, because
that would break those needy sd8686 setups.

Thanks,
Ohad.
