From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [bisect] Merge tag 'mmc-v4.6' of
 git://git.linaro.org/people/ulf.hansson/mmc (was [GIT PULL] MMC for v.4.6)
Date: Mon, 4 Apr 2016 13:00:34 -0700
Message-ID: <5702C7E2.3040001@hurleysoftware.com>
References: <CAPDyKFqM1ffAdj7jVJmcPW2Wxy88Mhx_UrAzyuXpKSJg1yUPdg@mail.gmail.com>
 <57008645.4070808@hurleysoftware.com>
 <CA+55aFwjQP25NYfjPMTicO-M8yjm5c0aKFx-1saWmrro0c0NVQ@mail.gmail.com>
 <CAPDyKFr6zCm4wBS97bUCwq4qhsM8u3mEpyBf4uicJ_UQ7L-q5w@mail.gmail.com>
 <CA+55aFwFVBg5joDd0QYjmSA6t8TM7tmZvmcArZu3Ar8u4vDecw@mail.gmail.com>
 <5702C08C.2050301@hurleysoftware.com>
 <CA+55aFzk9iSLWouEmja5=wC6rz75gYTn4ci9iwsa3m16-WKNtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33997 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbcDDUAg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2016 16:00:36 -0400
Received: by mail-pf0-f181.google.com with SMTP id c20so42110905pfc.1
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2016 13:00:36 -0700 (PDT)
In-Reply-To: <CA+55aFzk9iSLWouEmja5=wC6rz75gYTn4ci9iwsa3m16-WKNtA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 04/04/2016 12:49 PM, Linus Torvalds wrote:
> On Mon, Apr 4, 2016 at 12:29 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>
>> Yeah, a straight revert of 520bd7a8b415 resumes normal service:
> 
> Ok, so we have that as an option.
> 
>> Should I send a proper revert?
> 
> Let's see if somebody can come up with a better serialization model.
> We're only at rc2, and we now have a fallback fix, let's wait a week
> or two to see if the mmc people can come up with something.
> 
> But maybe you can send me a revert patch around rc4 or so if the
> problem still remains, ok?

Will do.

Regards,
Peter Hurley

