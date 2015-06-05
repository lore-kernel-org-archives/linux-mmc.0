From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: add SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33
 quirk support
Date: Fri, 5 Jun 2015 11:32:21 +0200
Message-ID: <CAPDyKFq6wQ1md1LZ_05KGa2Tn0t7z141cHF4g6ZjV1sS1Jt0Jw@mail.gmail.com>
References: <1433228980-5676-1-git-send-email-yangbo.lu@freescale.com>
	<CAPDyKFqb3y9xV8ouZyK0bapMs0P+gA+KLux10yHz3K8mbitLHw@mail.gmail.com>
	<BY1PR0301MB119204EF6D256D7D7C82925CF2B30@BY1PR0301MB1192.namprd03.prod.outlook.com>
	<CAPDyKFq42d5TeAK9PmzFfWbuKUSN0-KPmPp89zeH8Lk+CNFvCA@mail.gmail.com>
	<BN3PR0301MB1188CE0D699261777B4B030CF2B20@BN3PR0301MB1188.namprd03.prod.outlook.com>
	<CAPDyKFrfizAYpvGyuYL80wttzbd_Ww_K8c4MR++oV_Cxi-JexQ@mail.gmail.com>
	<BN3PR0301MB118808064A13CAC949253151F2B20@BN3PR0301MB1188.namprd03.prod.outlook.com>
	<CAPDyKFq4x_YqN5qUEqq2Kwo=2+AwHYHDNnkyFZB99Z4K_jXTZQ@mail.gmail.com>
	<BN3PR0301MB1188E932F40441475562AF9BF2B20@BN3PR0301MB1188.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36200 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbbFEJcW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2015 05:32:22 -0400
Received: by qkx62 with SMTP id 62so37550276qkx.3
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jun 2015 02:32:21 -0700 (PDT)
In-Reply-To: <BN3PR0301MB1188E932F40441475562AF9BF2B20@BN3PR0301MB1188.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Lu Y.B." <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chrisball@gmail.com>

On 5 June 2015 at 11:09, Lu Y.B. <yangbo.lu@freescale.com> wrote:
>> On 5 June 2015 at 10:49, Lu Y.B. <yangbo.lu@freescale.com> wrote:
>> >> On 5 June 2015 at 10:10, Lu Y.B. <yangbo.lu@freescale.com> wrote:
>> >> >> >> On 2 June 2015 at 09:09, Yangbo Lu <yangbo.lu@freescale.com=
>
>> wrote:
>> >> >> >> > This quirk is used for controllers that can only support =
1.8V
>> >> >> >> > voltage but the peripheral hardware circuit has capabilit=
y to
>> >> >> >> > support 3.3V voltage.
>> >> >> >>
>> >> >> >> Which voltage are you referring to? The I/O voltage or the
>> >> >> >> power to the card? VCC or VCCQ?
>> >> >> >>
>> >> >> >> Kind regards
>> >> >> >> Uffe
>> >> >> >
>> >> >> > The voltage here means I/O voltage.
>> >> >> > Although the controller only supports 1.8v, the hardware cir=
cuit
>> >> >> > has a
>> >> >> level translator for supporting 3.3v.
>> >> >>
>> >> >> Thanks for clarifying.
>> >> >
>> >> > Sorry, it should be power voltage...
>> >> > This quirk is used to set capability register "Voltage Support =
3.3V"
>> >> bit since the controller self doesn=E2=80=99t support but circuit=
 supports.
>> >> >
>> >>
>> >> Okay.
>> >>
>> >> So then please tell me, exactly, how is the power being controlle=
d
>> >> when using this "hardware circuit"?
>> >>
>> >> This patchset only tries to change the content of the ocr_mask, b=
ut
>> >> there is no logic added to support changing voltage levels by usi=
ng
>> >> the "external circuit". At least to my understanding.
>> >>
>> >
>> > As I said, the controller only support 1.8v but we could use adapt=
er
>> card or add level translator on board directly to make sd *only* wor=
k on
>> 3.3v power and 3.3v IO voltage.
>> > Thanks.
>>
>> How does this level translator work? Doesn't it need to be controlle=
d
>> somehow? Do you have a datasheet you can share for it?
>>
>
> I attached a adapter picture for you.
> we would never control the power to change.
> Although the io voltage could be control in design, we would never co=
ntrol it either. Always connect Vccb_SEL to GND.
> Thanks.
>

This make it crystal clear to me, but I think you have some more
homework to do. :-)

This is a commonly used circuit to be able to boost the IO voltage
levels from the SoC, towards the card. According to the SD spec, all
cards needs to support the IO legacy voltage levels (2.7-3.6V).

UHS-I SD cards, are also operate using 1.8V IO voltage, but the early
initialization must be done using the legacy IO voltage level domain.

So, I assume that when grounding Vccb_SEL, the IO voltage will be 2.9
V, which means you will always remain in legacy IO voltage level
domain. That's fine, as long as you don't care about UHS cards.

So, again this patchset really doesn't make sense.

Kind regards
Uffe
