From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mmc: make dev_to_mmc_card() macro public
Date: Fri, 20 Aug 2010 00:23:32 -0700
Message-ID: <20100820002332.93b0c44d.akpm@linux-foundation.org>
References: <1282138278-22304-1-git-send-email-ext-andriy.shevchenko@nokia.com>
	<20100819144921.40d6765f.akpm@linux-foundation.org>
	<AANLkTi=ktmW4d1VQ2RBnVyJAQkpfRRXzrObkpAY0V0yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37094 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751102Ab0HTHUv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2010 03:20:51 -0400
In-Reply-To: <AANLkTi=ktmW4d1VQ2RBnVyJAQkpfRRXzrObkpAY0V0yw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org

On Fri, 20 Aug 2010 10:17:20 +0300 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Aug 20, 2010 at 12:49 AM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > nit: generally, subsystem-specific identifiers should use their
> > subsystem's identifier as a prefix. __So a better name for
> > dev_to_mmc_card() would be mmc_dev_to_card().
> Sounds reasonable.
> Would you like to get new version of patch or fix against patch?

Either is OK for me.  I'll turn a replacement patch into a delta so I
can see what changed, but that takes just a few seconds.

