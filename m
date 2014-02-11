From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [RFT][PATCH 08/12] mmc: change cb710-mmc platform power management
 to use dev_pm_ops
Date: Tue, 11 Feb 2014 08:38:39 -0700
Message-ID: <52FA43FF.8030303@samsung.com>
References: <cover.1392040064.git.shuah.kh@samsung.com>
 <5393e4bd34e5667b7d00fa09c9d5bee0f68d659f.1392040068.git.shuah.kh@samsung.com>
 <20140210234904.GA542@rere.qmqm.pl>
Reply-To: shuah.kh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]:60867 "EHLO
	usmailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbaBKPit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Feb 2014 10:38:49 -0500
In-reply-to: <20140210234904.GA542@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Cc: rjw@rjwysocki.net, chris@printf.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, shuahkhan@gmail.com, Shuah Khan <shuah.kh@samsung.com>

On 02/10/2014 04:49 PM, Micha=B3 Miros=B3aw wrote:
> On Mon, Feb 10, 2014 at 09:12:31AM -0700, Shuah Khan wrote:
>> Change cb710-mmc platform driver to register pm ops using dev_pm_ops=
 instead
>> of legacy pm_ops. .pm hooks call existing legacy suspend and resume =
interfaces
>> by passing in the right pm state.
> [all the patch cut]
>
> Aaah, a bit mechanical - this change, isn't it?

Yes :)

>
> The suspend/resume callbacks just clears IRQ mask in the device in ca=
se it
> got undefined during sleep state. So the proper change here is to squ=
ash all
> the functions in one, and point all of the hooks to it.
>
> With the change you have my ack.
>
> BTW, you could move cb710_mmc_suspend() (or whatever you'll call it) =
to one
> ifdef block with cb710_mmc_dev_pm_ops.
>

It makes perfect sense to squash suspend and resume. Thanks for the=20
review. Code looks lot simpler now. Will send v2 patch shortly.

-- Shuah

--=20
Shuah Khan
Senior Linux Kernel Developer - Open Source Group
Samsung Research America(Silicon Valley)
shuah.kh@samsung.com | (970) 672-0658
