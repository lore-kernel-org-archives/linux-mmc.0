From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/3] mmc: sdhci: support runtime PM for BYT SD cards
Date: Tue, 14 May 2013 10:10:10 +0200
Message-ID: <CACRpkdZp7pjT4be62_Mf1Evdrim7mOL2GcZxXf8CE2x_=XJS+w@mail.gmail.com>
References: <1367831854-31952-1-git-send-email-adrian.hunter@intel.com>
	<CACRpkdYsMwAZSw9McHQE4VSsS7wUWLm+mtR1yLzdPCaQzDUo3A@mail.gmail.com>
	<5188A6A0.3040603@intel.com>
	<20130507080455.GF20562@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33466 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab3ENIKK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 May 2013 04:10:10 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so430989iec.22
        for <linux-mmc@vger.kernel.org>; Tue, 14 May 2013 01:10:10 -0700 (PDT)
In-Reply-To: <20130507080455.GF20562@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Westerberg, Mika" <mika.westerberg@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Grant Likely <grant.likely@secretlab.ca>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Tue, May 7, 2013 at 10:04 AM, Westerberg, Mika
<mika.westerberg@intel.com> wrote:
> On Tue, May 07, 2013 at 10:00:48AM +0300, Adrian Hunter wrote:

>> It would be simpler if the above 2 ACPI GPIO patches made it to 3.10 or went via the mmc tree.
>> Adding Rafael in case he can still take them for 3.10.
>
> Looks like Linus pulled GPIO changes already. So they should be available
> for 3.10.

Yes it appears he (the other Linus) changed his mind, that's fine then...

Yours,
Linus Walleij
