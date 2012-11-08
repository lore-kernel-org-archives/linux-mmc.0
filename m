From: Daniel Drake <dsd@laptop.org>
Subject: Re: UHS-I voltage switching on OLPC XO-1.75
Date: Thu, 8 Nov 2012 12:52:55 -0600
Message-ID: <CAMLZHHSRhCvvkUXL9NQiwX6EsRWoijt5iJXqBy2UYHjDaNnqhg@mail.gmail.com>
References: <6CB855B4-CBBE-4AA1-8D07-E276160FCE8D@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:37606 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756521Ab2KHSw4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Nov 2012 13:52:56 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so1301660dak.19
        for <linux-mmc@vger.kernel.org>; Thu, 08 Nov 2012 10:52:55 -0800 (PST)
In-Reply-To: <6CB855B4-CBBE-4AA1-8D07-E276160FCE8D@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@nvidia.com>
Cc: Johan Rudholm <jrudholm@gmail.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, Nov 8, 2012 at 12:48 PM, Philip Rakity <prakity@nvidia.com> wrote:
> This is already there.  Use broken caps and in the board code clear out the
> nits in caps2.

There is no board code; we're working with device tree. So I'm still
not exactly clear on the best way to work this.

Maybe something like this: "sdhci,disable-1-8v" property in the device
tree, would trigger the sdhci-pxa2 code to:
1. sdhci_readl() to retrieve caps and caps1
2. Drop the 1.8v flag from caps1
3. Set the BROKEN_CAPS quirk

It would work but I'm not too fond of it, and I can't really think of
an approach I do like (except maybe having a specific "1.8v broken"
sdhci quirk).

Daniel
