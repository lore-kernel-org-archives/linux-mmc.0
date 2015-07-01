From: Paul Mansfield <paul@mansfield.co.uk>
Subject: Re: mmc driver read/write detect problem with Baytrail tablet
Date: Wed, 1 Jul 2015 23:10:42 +0100
Message-ID: <CAGwpYof4CNqoQd+hKGLRNf=jfG63wz9751rdK4eLxww+2Y1Hqg@mail.gmail.com>
References: <CAGwpYodzn4TGiCp7L1+KQgb+JreMx2y07wgRmUsDHG-3fwetLg@mail.gmail.com>
 <CAOGqxeV7FXRJ033McE7YdO0ui-mXo58HZO+6nQdNCCPoagBktg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:34031 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbbGAWLD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jul 2015 18:11:03 -0400
Received: by wgqq4 with SMTP id q4so47977443wgq.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2015 15:11:02 -0700 (PDT)
In-Reply-To: <CAOGqxeV7FXRJ033McE7YdO0ui-mXo58HZO+6nQdNCCPoagBktg@mail.gmail.com>
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
