From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [RFT][PATCH 08/12] mmc: change cb710-mmc platform power
 management to use dev_pm_ops
Date: Tue, 11 Feb 2014 00:49:04 +0100
Message-ID: <20140210234904.GA542@rere.qmqm.pl>
References: <cover.1392040064.git.shuah.kh@samsung.com>
 <5393e4bd34e5667b7d00fa09c9d5bee0f68d659f.1392040068.git.shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:37500 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752362AbaBJX5S (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Feb 2014 18:57:18 -0500
Content-Disposition: inline
In-Reply-To: <5393e4bd34e5667b7d00fa09c9d5bee0f68d659f.1392040068.git.shuah.kh@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: rjw@rjwysocki.net, chris@printf.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, shuahkhan@gmail.com

On Mon, Feb 10, 2014 at 09:12:31AM -0700, Shuah Khan wrote:
> Change cb710-mmc platform driver to register pm ops using dev_pm_ops =
instead
> of legacy pm_ops. .pm hooks call existing legacy suspend and resume i=
nterfaces
> by passing in the right pm state.
[all the patch cut]

Aaah, a bit mechanical - this change, isn't it?

The suspend/resume callbacks just clears IRQ mask in the device in case=
 it
got undefined during sleep state. So the proper change here is to squas=
h all
the functions in one, and point all of the hooks to it.

With the change you have my ack.

BTW, you could move cb710_mmc_suspend() (or whatever you'll call it) to=
 one
ifdef block with cb710_mmc_dev_pm_ops.

Best Regards,
Micha=B3 Miros=B3aw
