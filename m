From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: add SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33
 quirk support
Date: Fri, 5 Jun 2015 10:54:05 +0200
Message-ID: <CAPDyKFq4x_YqN5qUEqq2Kwo=2+AwHYHDNnkyFZB99Z4K_jXTZQ@mail.gmail.com>
References: <1433228980-5676-1-git-send-email-yangbo.lu@freescale.com>
	<CAPDyKFqb3y9xV8ouZyK0bapMs0P+gA+KLux10yHz3K8mbitLHw@mail.gmail.com>
	<BY1PR0301MB119204EF6D256D7D7C82925CF2B30@BY1PR0301MB1192.namprd03.prod.outlook.com>
	<CAPDyKFq42d5TeAK9PmzFfWbuKUSN0-KPmPp89zeH8Lk+CNFvCA@mail.gmail.com>
	<BN3PR0301MB1188CE0D699261777B4B030CF2B20@BN3PR0301MB1188.namprd03.prod.outlook.com>
	<CAPDyKFrfizAYpvGyuYL80wttzbd_Ww_K8c4MR++oV_Cxi-JexQ@mail.gmail.com>
	<BN3PR0301MB118808064A13CAC949253151F2B20@BN3PR0301MB1188.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:35481 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313AbbFEIyF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2015 04:54:05 -0400
Received: by qczw4 with SMTP id w4so27466399qcz.2
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jun 2015 01:54:05 -0700 (PDT)
In-Reply-To: <BN3PR0301MB118808064A13CAC949253151F2B20@BN3PR0301MB1188.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Lu Y.B." <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chrisball@gmail.com>

On 5 June 2015 at 10:49, Lu Y.B. <yangbo.lu@freescale.com> wrote:
>> On 5 June 2015 at 10:10, Lu Y.B. <yangbo.lu@freescale.com> wrote:
>> >> >> On 2 June 2015 at 09:09, Yangbo Lu <yangbo.lu@freescale.com> w=
rote:
>> >> >> > This quirk is used for controllers that can only support 1.8=
V
>> >> >> > voltage but the peripheral hardware circuit has capability t=
o
>> >> >> > support 3.3V voltage.
>> >> >>
>> >> >> Which voltage are you referring to? The I/O voltage or the pow=
er
>> >> >> to the card? VCC or VCCQ?
>> >> >>
>> >> >> Kind regards
>> >> >> Uffe
>> >> >
>> >> > The voltage here means I/O voltage.
>> >> > Although the controller only supports 1.8v, the hardware circui=
t
>> >> > has a
>> >> level translator for supporting 3.3v.
>> >>
>> >> Thanks for clarifying.
>> >
>> > Sorry, it should be power voltage...
>> > This quirk is used to set capability register "Voltage Support 3.3=
V"
>> bit since the controller self doesn=E2=80=99t support but circuit su=
pports.
>> >
>>
>> Okay.
>>
>> So then please tell me, exactly, how is the power being controlled w=
hen
>> using this "hardware circuit"?
>>
>> This patchset only tries to change the content of the ocr_mask, but =
there
>> is no logic added to support changing voltage levels by using the
>> "external circuit". At least to my understanding.
>>
>
> As I said, the controller only support 1.8v but we could use adapter =
card or add level translator on board directly to make sd *only* work o=
n 3.3v power and 3.3v IO voltage.
> Thanks.

How does this level translator work? Doesn't it need to be controlled
somehow? Do you have a datasheet you can share for it?

Kind regards
Uffe
