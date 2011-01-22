From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v1 1/3]mmc: implemented runtime pm for mmc host
Date: Sat, 22 Jan 2011 23:24:11 +0200
Message-ID: <AANLkTi=oOzU0fb+yGkKDkjviGWO8fq=k68+Syp+dWn5B@mail.gmail.com>
References: <20110114082310.GB27523@intel.com> <8250E4885F9967469CAC3FB5CBA2CE69934E7AA2FE@irsmsx501.ger.corp.intel.com>
 <5D8008F58939784290FAB48F54975198351D4FA654@shsmsx502.ccr.corp.intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AAB20@irsmsx501.ger.corp.intel.com>
 <5D8008F58939784290FAB48F5497519835247E72AD@shsmsx502.ccr.corp.intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AACCC@irsmsx501.ger.corp.intel.com> <20110120050803.GA5732@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52201 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab1AVVYc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Jan 2011 16:24:32 -0500
Received: by iwn9 with SMTP id 9so2814623iwn.19
        for <linux-mmc@vger.kernel.org>; Sat, 22 Jan 2011 13:24:32 -0800 (PST)
In-Reply-To: <20110120050803.GA5732@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: "Tardy, Pierre" <pierre.tardy@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.ml.walleij@gmail.com>

On Thu, Jan 20, 2011 at 7:08 AM, Chris Ball <cjb@laptop.org> wrote:
> On Wed, Jan 19, 2011 at 09:45:57AM +0000, Tardy, Pierre wrote:
>> Chris,
>> (Sorry for top posting)
>> Seems we have a intel intern disagreement.
>>
>> Could we have maintainer opinion on this ?
>
> Linus W and Ohad, any input here? =A0Thanks,

Personally I prefer the runtime PM approach.

The MMC aggressive clock gating framework is great, but it ended up
duplicating plumbing that already existed in the runtime PM framework
(workqueue, locking, usage refcount, "get/put" API).

Moving to runtime PM should reduce a fair amount of code from the MMC
core, make the code more readable and easier to maintain, and let us
take advantage of standard tools and knobs that are based on runtime
PM's sysfs entries.

But surely we don't want two frameworks doing the same; that would be
too messy. And we want to be sure that any runtime PM approach would
satisfy everyone's requirement.

Chuanxiao, do you think you can come up with a runtime PM-based patch
that provides the aggressive clock gating framework's functionality ?

If functionality and requirements are preserved, I don't think anyone
would complain about moving to an established and well-maintained
kernel subsystem.

Thanks,
Ohad.
