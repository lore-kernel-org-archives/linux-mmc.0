From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [bisect] Merge tag 'mmc-v4.6' of git://git.linaro.org/people/ulf.hansson/mmc
 (was [GIT PULL] MMC for v.4.6)
Date: Mon, 4 Apr 2016 12:49:37 -0700
Message-ID: <CA+55aFzk9iSLWouEmja5=wC6rz75gYTn4ci9iwsa3m16-WKNtA@mail.gmail.com>
References: <CAPDyKFqM1ffAdj7jVJmcPW2Wxy88Mhx_UrAzyuXpKSJg1yUPdg@mail.gmail.com>
	<57008645.4070808@hurleysoftware.com>
	<CA+55aFwjQP25NYfjPMTicO-M8yjm5c0aKFx-1saWmrro0c0NVQ@mail.gmail.com>
	<CAPDyKFr6zCm4wBS97bUCwq4qhsM8u3mEpyBf4uicJ_UQ7L-q5w@mail.gmail.com>
	<CA+55aFwFVBg5joDd0QYjmSA6t8TM7tmZvmcArZu3Ar8u4vDecw@mail.gmail.com>
	<5702C08C.2050301@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38726 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755758AbcDDTti (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2016 15:49:38 -0400
In-Reply-To: <5702C08C.2050301@hurleysoftware.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

On Mon, Apr 4, 2016 at 12:29 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>
> Yeah, a straight revert of 520bd7a8b415 resumes normal service:

Ok, so we have that as an option.

> Should I send a proper revert?

Let's see if somebody can come up with a better serialization model.
We're only at rc2, and we now have a fallback fix, let's wait a week
or two to see if the mmc people can come up with something.

But maybe you can send me a revert patch around rc4 or so if the
problem still remains, ok?

               Linus
