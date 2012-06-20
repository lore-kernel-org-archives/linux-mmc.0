From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v3] mmc: core: Fix the HPI execution sequence
Date: Wed, 20 Jun 2012 23:25:21 +0530
Message-ID: <CANfBPZ9RDK6y0JGmc3qe+wr-h8p=ycRUG+d6vPBoC4FZyhAkxA@mail.gmail.com>
References: <1340184834-12700-1-git-send-email-svenkatr@ti.com> <87y5nh3okt.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:36687 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753366Ab2FTR4A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Jun 2012 13:56:00 -0400
Received: by bkwj4 with SMTP id j4so8713486bkw.22
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jun 2012 10:55:42 -0700 (PDT)
In-Reply-To: <87y5nh3okt.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linkinjeon@gmail.com, jh80.chung@samsung.com, alex.lemberg@sandisk.com, Kostya <kdorfman@codeaurora.org>

On Wed, Jun 20, 2012 at 10:31 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi, trivial style comments,
>
> On Wed, Jun 20 2012, Venkatraman S wrote:
>> =A0 =A0 =A0 switch (R1_CURRENT_STATE(status)) {
>>
>
> No newline here.
>
>> =A0 =A0 =A0 case R1_STATE_IDLE:
>> =A0 =A0 =A0 case R1_STATE_READY:
>> =A0 =A0 =A0 case R1_STATE_STBY: /* intentional fall through */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* In idle states, HPI is not needed and=
 the caller
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0can issue the next intended command i=
mmediately */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> This might just be personal style, but I don't think of this as
> "intentional fall through" -- you're just matching multiple cases.
>
> Case fall-through would be if the code inside the cases didn't call
> goto or break at the end and kept going into the next code block,
> which doesn't happen here. =A0Here's an elegant use of fall-through:
> =A0 http://chris.printf.net/btrfs_parse_size.txt

That's a cool trick !!

>
> I don't think you should bother using break after you've already
> called goto.
>
Thanks - I was circumspect about the goto & break thing myself.
> Also, please use:
> /*
> =A0* comment 1
> =A0* comment 2
> =A0*/
>
> for multiline comments instead of
>
> /* comment 1
> =A0comment 2 */
>
I'll fix these and send a patch now.
