From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 1/4] mmc: core: Initial support for MMC power sequences
Date: Tue, 3 Feb 2015 13:39:13 +0100
Message-ID: <CAPDyKFpv4joU54tnO6N7zWmVV_021KFjQsscfpHHLjdqCCe8Xw@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
	<1421658784-11980-2-git-send-email-ulf.hansson@linaro.org>
	<CABxcv==xBNsh+NrVb8PcBVtxQOKDL79YMkwK=wOL0gJZriEUjw@mail.gmail.com>
	<CAPDyKFoze-26fPm+C=D_o3tMSXWeTV4=2ZfOKaC3uLtxCrtjvg@mail.gmail.com>
	<20150131092715.566fa33c@notabene.brown>
	<CAPDyKFo6G+PpV7QpxBEOS_xUxXTQ14v=qVLGpBjT_z6T0vP85A@mail.gmail.com>
	<20150202150537.GE8656@n2100.arm.linux.org.uk>
	<CAPDyKFqjeg0d7r5XSK0d1EYfm2dvET3PQiHsDE_XchqFVYyC6g@mail.gmail.com>
	<20150203091042.379c7948@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:45541 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbbBCMjN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Feb 2015 07:39:13 -0500
Received: by mail-qg0-f52.google.com with SMTP id z107so52032887qgd.11
        for <linux-mmc@vger.kernel.org>; Tue, 03 Feb 2015 04:39:13 -0800 (PST)
In-Reply-To: <20150203091042.379c7948@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org
	<linux-arm-kernel@lists.infradead.org>," <mark.rutland@arm.com>

On 2 February 2015 at 23:10, NeilBrown <neilb@suse.de> wrote:
> On Mon, 2 Feb 2015 16:10:29 +0100 Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> On 2 February 2015 at 16:05, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Mon, Feb 02, 2015 at 03:57:37PM +0100, Ulf Hansson wrote:
>> >> On 30 January 2015 at 23:27, NeilBrown <neilb@suse.de> wrote:
>> >> > Shortly before this call is
>> >> >
>> >> >         host->ios.power_mode = MMC_POWER_ON;
>> >> >         mmc_set_ios(host);
>> >> >
>> >> > and omap_hsmmc_set_ios() contains:
>> >> >
>> >> >                 switch (ios->power_mode) {
>> >> >                 ....
>> >> >                 case MMC_POWER_ON:
>> >> >                         do_send_init_stream = 1;
>> >> >                         break;
>> >> >
>> >> >
>> >> >         if (do_send_init_stream)
>> >> >                 send_init_stream(host);
>> >> >
>> >> > Which sends the "init stream" to the card.
>> >> > If the card is still being reset at this time, the stream may not
>> >> > be effective.
>> >> >
>> >> > I find that about 10%-20% of the time when I release the reset line
>> >> > *after* the sequence is sent, my card fails to initialised.  When I
>> >> > release *before* the sequence is sent, it never fails.
>> >>
>> >> Okay, thanks for providing these details.
>> >
>> > The right thing to do then is to pulse the reset line at the pre-power-up
>> > stage.
>>
>> I don't think that will work, since the card hasn't yet been powered
>> and will thus not respond properly to the reset.
>
> My understanding, at least in the case of my hardware, is that the power-on
> is sufficient to reset the device.
> In my case, the one supply is shared between two devices (wifi and bluetooth)
> so if the bluetooth is on, then the wifi cannot be power-cycled.  That is
> when the reset is particularly needed.
>
> I'll try to arrange some testing to confirm this is the case.  Of course,
> this would not be general result, it would only be relevant for my hardware.

I refreshed my memory for how the cw1200 WLAN device works on the
ux500 SOC. I decided to post the complete information here, also for
my own reference.

These resources need to be controlled during the power sequence of CW1200:
There are two GPIOs (one reset and one for SPI/SDIO selection), one LP
(low power) clock and a few power supplies.

The sequence for power up that needs to be followed are:
1. Keep reset GPIO asserted.
2. Enable power supplies.
3. Enable LP clock.
4. Wait a few LP clock cycles to let power/clock stabilize.
5. Make sure SPI/SDIO select pin is in SDIO mode. The value will be
sampled by the WLAN device when reset GPIO is de-asserted.
6. De-assert reset GPIO.
7. Wait 30 ms for the WLAN device to power up.

The power supplies may also be shared with a bluetooth device. That
also means the reset GPIO must be kept asserted in power off state, to
prevent power up of the WLAN device.

>From the above, it's clear that toggling the reset GPIOs in the
->pre_power_on() phase won't work for CW1200/UX500 case.  That in
conjunction with the "init stream" issue tells me that we need to
progress with the below patch:

"mmc: core: Invoke mmc_pwrseq_post_power_on() prior MMC_POWER_ON state"
http://www.spinics.net/lists/arm-kernel/msg396592.html

Kind regards
Uffe
