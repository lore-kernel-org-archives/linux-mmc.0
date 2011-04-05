From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2 2/2] mmc: Check CAP_SYS_ADMIN for destructive ioctl
 ACMDs
Date: Tue, 5 Apr 2011 23:53:58 +0100
Message-ID: <20110405235358.2c5abb15@lxorguk.ukuu.org.uk>
References: <alpine.DEB.2.00.1104051458350.25803@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59009 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754012Ab1DEWxZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 18:53:25 -0400
In-Reply-To: <alpine.DEB.2.00.1104051458350.25803@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

On Tue, 5 Apr 2011 14:59:09 -0700 (PDT)
John Calixto <john.calixto@modsystems.com> wrote:

> Some ACMDs might actually damage the card.  This check ensures the
> caller has CAP_SYS_ADMIN before allowing such an activity.

CAP_SYS_RAWIO for "can damage stuff".

