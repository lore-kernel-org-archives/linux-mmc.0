From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: HIBERNATION: add resume_delay kernel param as well as resume_delay
Date: Mon, 10 Oct 2011 23:46:41 +0200
Message-ID: <201110102346.41331.rjw@sisk.pl>
References: <1318225452-10397-1-git-send-email-Barry.Song@csr.com> <20111010165437.GA11093@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60015 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752937Ab1JJVoX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Oct 2011 17:44:23 -0400
In-Reply-To: <20111010165437.GA11093@elf.ucw.cz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Barry Song <Barry.Song@csr.com>, linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, workgroup.linux@csr.com, Barry Song <baohua.song@csr.com>

On Monday, October 10, 2011, Pavel Machek wrote:
> On Sun 2011-10-09 22:44:12, Barry Song wrote:
> > From: Barry Song <baohua.song@csr.com>
> > 
> > patch "PM: HIBERNATION: add resume_wait param to support MMC-like devices
> > as resume file" add resume_wait param. this patch adds resume_delay so that
> > resume_wait/delay has the same model with root_wait/delay.
> > 
> > Signed-off-by: Barry Song <baohua.song@csr.com>
> 
> ACK.

Applied to linux-pm/linux-next.

Thanks,
Rafael
