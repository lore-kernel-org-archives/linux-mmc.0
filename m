From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 1/4] mmc: core: Initial support for MMC power sequences
Date: Mon, 2 Feb 2015 16:10:29 +0100
Message-ID: <CAPDyKFqjeg0d7r5XSK0d1EYfm2dvET3PQiHsDE_XchqFVYyC6g@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
	<1421658784-11980-2-git-send-email-ulf.hansson@linaro.org>
	<CABxcv==xBNsh+NrVb8PcBVtxQOKDL79YMkwK=wOL0gJZriEUjw@mail.gmail.com>
	<CAPDyKFoze-26fPm+C=D_o3tMSXWeTV4=2ZfOKaC3uLtxCrtjvg@mail.gmail.com>
	<20150131092715.566fa33c@notabene.brown>
	<CAPDyKFo6G+PpV7QpxBEOS_xUxXTQ14v=qVLGpBjT_z6T0vP85A@mail.gmail.com>
	<20150202150537.GE8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:59228 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbbBBPK3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Feb 2015 10:10:29 -0500
Received: by mail-qc0-f180.google.com with SMTP id r5so30333798qcx.11
        for <linux-mmc@vger.kernel.org>; Mon, 02 Feb 2015 07:10:29 -0800 (PST)
In-Reply-To: <20150202150537.GE8656@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: NeilBrown <neilb@suse.de>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org
	<linux-arm-kernel@lists.infradead.org>," <mark.rutland@arm.com>

On 2 February 2015 at 16:05, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Feb 02, 2015 at 03:57:37PM +0100, Ulf Hansson wrote:
>> On 30 January 2015 at 23:27, NeilBrown <neilb@suse.de> wrote:
>> > Shortly before this call is
>> >
>> >         host->ios.power_mode = MMC_POWER_ON;
>> >         mmc_set_ios(host);
>> >
>> > and omap_hsmmc_set_ios() contains:
>> >
>> >                 switch (ios->power_mode) {
>> >                 ....
>> >                 case MMC_POWER_ON:
>> >                         do_send_init_stream = 1;
>> >                         break;
>> >
>> >
>> >         if (do_send_init_stream)
>> >                 send_init_stream(host);
>> >
>> > Which sends the "init stream" to the card.
>> > If the card is still being reset at this time, the stream may not
>> > be effective.
>> >
>> > I find that about 10%-20% of the time when I release the reset line
>> > *after* the sequence is sent, my card fails to initialised.  When I
>> > release *before* the sequence is sent, it never fails.
>>
>> Okay, thanks for providing these details.
>
> The right thing to do then is to pulse the reset line at the pre-power-up
> stage.

I don't think that will work, since the card hasn't yet been powered
and will thus not respond properly to the reset.

Kind regards
Uffe
