From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH RFC 07/31] mmc: sdhci: push card_tasklet into threaded irq handler
Date: Wed, 19 Feb 2014 15:18:08 +0530
Message-ID: <CAKohpomfHxWBF5m4D6iqod4a3gw2BU1W6nXMkEOg+YA+izYr=g@mail.gmail.com>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
	<E1WFmIk-0006m0-Ah@rmk-PC.arm.linux.org.uk>
	<20140218175703.GJ21483@n2100.arm.linux.org.uk>
	<CAKohpoknX=acZHJeydwv6XRKFHTD4DM84xfCJ=56NrRfJnBOOA@mail.gmail.com>
	<20140219094322.GR21483@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:54736 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbaBSJsJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Feb 2014 04:48:09 -0500
Received: by mail-ob0-f171.google.com with SMTP id wp4so141905obc.30
        for <linux-mmc@vger.kernel.org>; Wed, 19 Feb 2014 01:48:09 -0800 (PST)
In-Reply-To: <20140219094322.GR21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Pratyush Anand <pratyush.anand@st.com>, spear-devel <spear-devel@list.st.com>, Mohit KUMAR <Mohit.KUMAR@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>, Chris Ball <chris@printf.net>

On 19 February 2014 15:13, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Feb 19, 2014 at 11:43:19AM +0530, Viresh Kumar wrote:
>> Adding ST people as well who have access to boards and are working on SPEAr.
>>
>> On 18 February 2014 23:27, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > 1) You're controlling the card power GPIO via the insertion/removal
>> >    interrupt handler?  What's wrong with using a vmmc regulator for
>> >    that, which will be controlled via the MMC subsystem as required?
>>
>> Haven't explored that earlier.. Maybe its possible but no idea.
>> The requirements were like this:
>> - We may or maynot need a GPIO for controlling power
>> - If we need it, we may need to disable/enable power with card removal/
>> insertion Or we may need to keep it enabled for ever..
>
> So how is this any different from any other system which controls power to
> the MMC/SD socket?

I am not claiming it to be different. I am just saying these were the
requirements
and I am not sure if they were satisfied with vmmc regulator. It might
be exactly
same in all other platforms.
