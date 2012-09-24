From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/2] mmc: Move mmc_delay() to include/linux/mmc/core.h
Date: Mon, 24 Sep 2012 13:17:32 +0000
Message-ID: <201209241317.32425.arnd@arndb.de>
References: <1344637513-29383-1-git-send-email-Chunhe.Lan@freescale.com> <201209211233.54545.arnd@arndb.de> <50607A5A.3060103@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51809 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754291Ab2IXNRk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Sep 2012 09:17:40 -0400
In-Reply-To: <50607A5A.3060103@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chunhe Lan <b25806@freescale.com>
Cc: Chunhe Lan <Chunhe.Lan@freescale.com>, linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kumar.gala@freescale.com, cjb@laptop.org, Kumar Gala <galak@kernel.crashing.org>

On Monday 24 September 2012, Chunhe Lan wrote:
>     OK. As you have mentioned, it would been modified to such:
> 
> static inline void mmc_delay(unsigned int ms)
> {
>          if (ms < 1000 / HZ) {
>                  cond_resched();
>                  msleep(ms);
>          } else {
>                  msleep(ms);
>          }
> }

This version would be rather broken, because it compares times
in two different units (ms and jiffies), and because it
does a cond_resched() directly before an msleep: both of which
end up calling schedule() and being away for some time,
cond_resched() for an unknown time, and msleep for a minimum
time on top of that.

> OR such:
> 
> static inline void mmc_delay(unsigned int ms)
> {
>           msleep(ms);
> }

That would be my preferred choice, unless someone has specific issues with this.

> OR other code?

Well, in principle, you could implement something like

static inline void mmc_delay(unsigned int ms)
{
	ktime_t end = ktime_add_us(ktime_get(), ms * 1000);

	while (1) {
		s64 remaining;

		cond_resched();

		remaining = ktime_to_us(ktime_sub(end, ktime_get()));

		if (remaining < 0)
			break;

		udelay(min_t(u32, remaining, 100));
	}
}

	Arnd
