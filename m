From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v5] mmc: Add ioctl to let userspace apps send ACMDs
Date: Tue, 12 Apr 2011 16:13:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104121611410.8483@peruna>
References: <alpine.DEB.2.00.1104121544380.8483@peruna> <alpine.DEB.2.00.1104121555150.8483@peruna>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:58875 "EHLO
	elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756324Ab1DLXNX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 19:13:23 -0400
In-Reply-To: <alpine.DEB.2.00.1104121555150.8483@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>, Andrei Warkentin <andreiw@motorola.com>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

Please ignore v5.  The fix for the compiler warning is not appropriate
for all endians/archs.

John
