From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 0/4] mmc: core and queue cleanups
Date: Wed, 9 May 2012 19:45:51 +0530
Message-ID: <CANfBPZ-E8agCnBdCYjtbkdg4DR6s-e2ULdUCWk7gbS=dvm0mKg@mail.gmail.com>
References: <1334319854-5989-1-git-send-email-svenkatr@ti.com> <877gwlo34g.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:40324 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759481Ab2EIOQO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 May 2012 10:16:14 -0400
Received: by bkty5 with SMTP id y5so378904bkt.30
        for <linux-mmc@vger.kernel.org>; Wed, 09 May 2012 07:16:11 -0700 (PDT)
In-Reply-To: <877gwlo34g.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Wed, May 9, 2012 at 7:41 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Venkat,
>
> On Fri, Apr 13 2012, Venkatraman S wrote:
>> =A0 =A0 =A0 The first 3 are straight forward / trivial fixes.
>> The last one is a functional change on how HPI should be invoked
>> on the card. This is required for my future foreground HPI series
>> that'll follow.
>>
>> Also available at git://github.com/svenkatr/linux.git my/mmc/cleanup=
s-v2
>>
>> Venkatraman S (4):
>> =A0 mmc: queue: rename mmc_request function
>> =A0 mmc: include cd-gpio.h in the source file
>> =A0 mmc: queue: remove redundant memsets
>> =A0 mmc: core: Send HPI only till it is successful
>
> I've pushed patches 1 and 3 to mmc-next for 3.5; 2 is already applied
> via H Hartley Sweeten, and I'm waiting on a final resend of 4.
>

Thanks Chris !! Actually 4 is superseded by another patch with a
different subject -
"mmc: core: fix HPI execution sequence". I had sent the most correct
version to you - but meanwhile
it is receiving further reviews as I type this. I'll check and send a
final version after answering the
questions.

~Venkat.
