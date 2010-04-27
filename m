From: Matt Fleming <matt@console-pimps.org>
Subject: Re: mmc: sdhci.h compile error
Date: Tue, 27 Apr 2010 06:53:23 +0100
Message-ID: <87k4rtzbjg.fsf@linux-g6p1.site>
References: <m2w309424b61004210443x612468b3n3caabe87e9717165@mail.gmail.com>
	<87zl0rb20u.fsf@linux-g6p1.site>
	<g2g309424b61004260046hc2773535o2885383daf414b4b@mail.gmail.com>
	<87mxwqzcl6.fsf@linux-g6p1.site>
	<s2x309424b61004262045q2cf453bay7b2fa62571947e5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:45152 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab0D0Fx2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Apr 2010 01:53:28 -0400
In-Reply-To: <s2x309424b61004262045q2cf453bay7b2fa62571947e5a@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <avorontsov@ru.mvista.com>, Andrew Morton <akpm@linux-foundation.org>

On Tue, 27 Apr 2010 11:45:28 +0800, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> 
> Fortunately, the typo does not impact the stability.
> We found the typo when debugging our silicon issue, however, nothing
> impove after the fix :)

OK, thanks. In that case it probably doesn't need to go to -stable. You
can add Reviewed-by: Matt Fleming <matt@console-pimps.org> to your
patch.
