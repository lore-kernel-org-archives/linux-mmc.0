From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 2/2] mmc: mmci: Move ios_handler functionality into the driver
Date: Thu, 24 Jan 2013 13:55:26 +0100
Message-ID: <CAPDyKFpEfids8xdU97US2VNgJKGHQ6Z2vuKo5DgfOjLcCUjN4A@mail.gmail.com>
References: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
	<1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
	<20130122090000.GH6857@gmail.com>
	<CACRpkdatTagYaMqvpe-a8zj_kO3Twjn1r4SqPty8DosNmcxJcQ@mail.gmail.com>
	<20130122100607.GH23505@n2100.arm.linux.org.uk>
	<20130122102010.GL6857@gmail.com>
	<20130122103723.GI23505@n2100.arm.linux.org.uk>
	<20130122105608.GP6857@gmail.com>
	<20130123101349.GH15873@gmail.com>
	<20130123101748.GO23505@n2100.arm.linux.org.uk>
	<20130123111805.GI15873@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:48229 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953Ab3AXMz2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jan 2013 07:55:28 -0500
Received: by mail-la0-f50.google.com with SMTP id ec20so5933885lab.9
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jan 2013 04:55:26 -0800 (PST)
In-Reply-To: <20130123111805.GI15873@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On 23 January 2013 12:18, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 23 Jan 2013, Russell King - ARM Linux wrote:
>
>> On Wed, Jan 23, 2013 at 10:13:49AM +0000, Lee Jones wrote:
>> > On Tue, 22 Jan 2013, Lee Jones wrote:
>> > > Are you saying that you won't do it? :)
>> > >
>> > > Is there anything I can do to make the process easier?
>> >
>> > Thinking about this a little more. Is it easier to remove it from =
your
>> > tree altogether? Only I have a small "ARM: ux500: " patch-set whic=
h
>> > directly relies on this patch. I could take it in via ARM-SoC with=
out
>> > any fear of ordering issues.
>>
>> Thankfully, the patch doesn't conflict with any of the others I have=
, so
>> we can do that (and it's actually easier to do that.)
>>
>> Done.
>
> Brilliant, that's 2 birds with one stone. I'll queue it up for ARM-So=
C.
>
> Thanks Russell.
>
> --
> Lee Jones
> Linaro ST-Ericsson Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

As long as it goes in for 3.9 I am happy. I am also depending on this
to add the UHS support for SD-cards for mmci. :-)

Kind regards
Ulf Hansson
