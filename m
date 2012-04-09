From: Chris Ball <cjb@laptop.org>
Subject: Re: [GIT PULL] MMC fixes for 3.4-rc2
Date: Mon, 09 Apr 2012 01:55:56 -0400
Message-ID: <87d37hzbwz.fsf@laptop.org>
References: <87mx6o3b7d.fsf@laptop.org>
	<1BAFE6F6C881BF42822005164F1491C331827827@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42417 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab2DIF4M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 Apr 2012 01:56:12 -0400
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C331827827@DBDE01.ent.ti.com>
	(Gururaja Hebbar's message of "Mon, 9 Apr 2012 05:36:18 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "chuanxiao.dong@intel.com" <chuanxiao.dong@intel.com>, "rjw@sisk.pl" <rjw@sisk.pl>

Hi,

On Mon, Apr 09 2012, Hebbar, Gururaja wrote:
> Hi,
>
> Is the pull already completed?

Yes, and -rc2 has already been released.

> If not can you add the recent mmc suspend/resume fix patch .
>
> http://www.spinics.net/lists/linux-pm/msg27090.html
>
> This is actually a fix (for bug) in mmc/sd suspend/resume path.
> This fixed a hard-to-find MMC suspend/resume while cp in progress race 
> condition reported at below link. It was on AM335x Platform.
>
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg65425.html

Okay, thanks for testing.  I'll send the fix to Linus once it's finished
review and further testing.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
