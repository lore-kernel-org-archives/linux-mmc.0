From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: HIBERNATION: add resume_delay kernel param as well
 as resume_delay
Date: Mon, 10 Oct 2011 18:54:38 +0200
Message-ID: <20111010165437.GA11093@elf.ucw.cz>
References: <1318225452-10397-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55568 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab1JJQzn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Oct 2011 12:55:43 -0400
Content-Disposition: inline
In-Reply-To: <1318225452-10397-1-git-send-email-Barry.Song@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <Barry.Song@csr.com>
Cc: rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, workgroup.linux@csr.com, Barry Song <baohua.song@csr.com>

On Sun 2011-10-09 22:44:12, Barry Song wrote:
> From: Barry Song <baohua.song@csr.com>
> 
> patch "PM: HIBERNATION: add resume_wait param to support MMC-like devices
> as resume file" add resume_wait param. this patch adds resume_delay so that
> resume_wait/delay has the same model with root_wait/delay.
> 
> Signed-off-by: Barry Song <baohua.song@csr.com>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
