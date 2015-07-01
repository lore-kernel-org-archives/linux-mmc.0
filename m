From: Paul Mansfield <paul-kernel@mansfield.co.uk>
Subject: Re: mmc driver read/write detect problem with Baytrail tablet
Date: Wed, 1 Jul 2015 23:11:40 +0100
Message-ID: <CAGwpYoez+2DVLxs6Hd_zqoF7UZ8D_WvrKiPTwvdP-VYxQTnzBQ@mail.gmail.com>
References: <CAGwpYodzn4TGiCp7L1+KQgb+JreMx2y07wgRmUsDHG-3fwetLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34605 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbbGAWMB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jul 2015 18:12:01 -0400
Received: by wiar9 with SMTP id r9so82906521wia.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2015 15:12:00 -0700 (PDT)
In-Reply-To: <CAGwpYodzn4TGiCp7L1+KQgb+JreMx2y07wgRmUsDHG-3fwetLg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

On 1 July 2015 at 14:24, Alan Cooper <alcooperx@.......> wrote:
> There is a WRITE PROTECT signal from the card socket to the host
> controller that may not be connected. You can try booting the kernel
> with "sdhci.debug_quirks=0x10000". This tells the driver that the WP
> signal is inverted.

thanks.
won't that cause the dock's SD card slot to switch from being writable
whilst making the internal one writable?
