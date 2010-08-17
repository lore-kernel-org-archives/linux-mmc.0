From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: + sdhci-add-no-hi-speed-bit-quirk-support.patch added to -mm tree
Date: Tue, 17 Aug 2010 14:15:51 +0900
Message-ID: <AANLkTikXzMU723M=-ZM-DFnV_MUVCxBiQJ3ZiUA5Dpth@mail.gmail.com>
References: <201006102043.o5AKhJjl022731@imap1.linux-foundation.org>
	<20100611004229.GD3498@trinity.fluff.org>
	<AANLkTik5ANblTvTGh-4f9IL7VW8iPmQtRiN0BIDWjFGc@mail.gmail.com>
	<20100810143434.01bea685.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:39020 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab0HQFPw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Aug 2010 01:15:52 -0400
Received: by wwf26 with SMTP id 26so484554wwf.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2010 22:15:51 -0700 (PDT)
In-Reply-To: <20100810143434.01bea685.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org

On Wed, Aug 11, 2010 at 6:34 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri, 11 Jun 2010 12:25:32 +0900
> Kyungmin Park <kmpark@infradead.org> wrote:
>
>> On Fri, Jun 11, 2010 at 9:42 AM, Ben Dooks <ben-linux@fluff.org> wro=
te:
>> > On Thu, Jun 10, 2010 at 01:43:19PM -0700, akpm@linux-foundation.or=
g wrote:
>> >>
>> >> The patch titled
>> >> __ __ __SDHCI: add no hi-speed bit quirk support
>> >> has been added to the -mm tree. __Its filename is
>> >> __ __ __sdhci-add-no-hi-speed-bit-quirk-support.patch
>> >>
>> >> Before you just go and hit "reply", please:
>> >> __ __a) Consider who else should be cc'ed
>> >> __ __b) Prefer to cc a suitable mailing list as well
>> >> __ __c) Ideally: find the original patch on the mailing list and =
do a
>> >> __ __ __ reply-to-all to that, adding suitable additional cc's
>> >>
>> >> *** Remember to use Documentation/SubmitChecklist when testing yo=
ur code ***
>> >>
>> >> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
>> >> out what to do about this
>> >>
>> >> The current -mm tree may be found at http://userweb.kernel.org/~a=
kpm/mmotm/
>> >>
>> >> ------------------------------------------------------
>> >> Subject: SDHCI: add no hi-speed bit quirk support
>> >> From: Kyungmin Park <kmpark@infradead.org>
>> >>
>> >> Some SDHCI controllers like s5pc110 don't have an HISPD bit in th=
e HOSTCTL
>> >> register.
>> >
>> > It would be nice for someone at Samsung to (a) explain the differe=
nces
>> > from the base SDHCI spec for all their hardware (the databooks are=
 often
>> > vague in this area) and (b) for the information for the extra regi=
sters
>> > this IP block has to be explained in more detail (and the platform=
 code
>> > checked for this too).
>>
>> I hope also.
>
> Going back over this dicussion, I get the impression that nothing
> really got resolved or finished. =A0So it is far from clear that I sh=
ould
> send these:
>
> s5pc110-sdhci-s3c-can-override-host-capabilities.patch
Needed. since current sdhci only support 4-bit. but some board uses
the 8-bit buswidth.

> s5pc110-sdhci-s3c-support-on-s5pc110.patch
Needed. for s5pc110 & s5pc210.

> sdhci-add-no-hi-speed-bit-quirk-support.patch
>
> upstream. =A0Could we please revisit all of this ASAP?

As System LSI don't explain it. we don't have a choice. but to fix the
current 2.6.36-rc1 issue. it should apply the
"sdhci-add-no-hi-speed-bit-quirk-support.patch"
I re-submit the against the latest kernel.

I check it's working on my goni & aquila board.

Thank you,
Kyungmin Park
