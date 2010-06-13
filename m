From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH v2] MMC: fix all hangs related to mmc/sd card
 insert/removal during suspend/resume.
Date: Sun, 13 Jun 2010 14:27:29 +0300
Message-ID: <1276428449.16701.0.camel@maxim-laptop>
References: <1276283791.8557.29.camel@maxim-laptop>
	 <1276283995-10812-1-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:36762 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925Ab0FML1d (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Jun 2010 07:27:33 -0400
In-Reply-To: <1276283995-10812-1-git-send-email-maximlevitsky@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Philip Langdale <philipl@overt.org>

On Fri, 2010-06-11 at 22:19 +0300, Maxim Levitsky wrote: 
> If you don't use CONFIG_MMC_UNSAFE_RESUME, card will now be removed
> in pm notified while userspace is still running.
> Thus it will be possible to sync it propely.
> 
> Card detect workqueue is now freezeable, therefore a card insert/removal event will
> wait till userspace is unfrozen.
> 
> Tested with and without CONFIG_MMC_UNSAFE_RESUME with suspend and hibernate.
And I say it is now well tested.
All attempts to hang the system failed.

Best regards,
Maxim Levitsky

