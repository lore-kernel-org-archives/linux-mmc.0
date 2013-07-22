From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: kernel panic in sg_complete
Date: Sun, 21 Jul 2013 17:23:14 -0700
Message-ID: <20130722002314.GA990@kroah.com>
References: <CA+GA0_sAqCz8BzCr8_6iaAzd+1U91WviuAPag7rGCCzDFK1HYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:39056 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab3GVAXB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Jul 2013 20:23:01 -0400
Content-Disposition: inline
In-Reply-To: <CA+GA0_sAqCz8BzCr8_6iaAzd+1U91WviuAPag7rGCCzDFK1HYg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marcin =?utf-8?Q?=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Chris Ball <cjb@laptop.org>

On Mon, Jul 22, 2013 at 01:00:41AM +0200, Marcin =C5=9Alusarz wrote:
> If you want me to test some patches, just shout ;)

Interesting patch, it makes sense to have this applied.  Can you resend
it with a "Signed-off-by:" line so that I can add it to the tree?

thanks,

greg k-h
