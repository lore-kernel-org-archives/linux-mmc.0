From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: add SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33
 quirk support
Date: Fri, 5 Jun 2015 10:32:51 +0200
Message-ID: <CAPDyKFrfizAYpvGyuYL80wttzbd_Ww_K8c4MR++oV_Cxi-JexQ@mail.gmail.com>
References: <1433228980-5676-1-git-send-email-yangbo.lu@freescale.com>
	<CAPDyKFqb3y9xV8ouZyK0bapMs0P+gA+KLux10yHz3K8mbitLHw@mail.gmail.com>
	<BY1PR0301MB119204EF6D256D7D7C82925CF2B30@BY1PR0301MB1192.namprd03.prod.outlook.com>
	<CAPDyKFq42d5TeAK9PmzFfWbuKUSN0-KPmPp89zeH8Lk+CNFvCA@mail.gmail.com>
	<BN3PR0301MB1188CE0D699261777B4B030CF2B20@BN3PR0301MB1188.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34536 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964AbbFEIcw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2015 04:32:52 -0400
Received: by qgf75 with SMTP id 75so25276808qgf.1
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jun 2015 01:32:51 -0700 (PDT)
In-Reply-To: <BN3PR0301MB1188CE0D699261777B4B030CF2B20@BN3PR0301MB1188.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Lu Y.B." <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chrisball@gmail.com>

On 5 June 2015 at 10:10, Lu Y.B. <yangbo.lu@freescale.com> wrote:
>> >> On 2 June 2015 at 09:09, Yangbo Lu <yangbo.lu@freescale.com> wrot=
e:
>> >> > This quirk is used for controllers that can only support 1.8V
>> >> > voltage but the peripheral hardware circuit has capability to
>> >> > support 3.3V voltage.
>> >>
>> >> Which voltage are you referring to? The I/O voltage or the power =
to
>> >> the card? VCC or VCCQ?
>> >>
>> >> Kind regards
>> >> Uffe
>> >
>> > The voltage here means I/O voltage.
>> > Although the controller only supports 1.8v, the hardware circuit h=
as a
>> level translator for supporting 3.3v.
>>
>> Thanks for clarifying.
>
> Sorry, it should be power voltage...
> This quirk is used to set capability register "Voltage Support 3.3V" =
bit since the controller self doesn=E2=80=99t support but circuit suppo=
rts.
>

Okay.

So then please tell me, exactly, how is the power being controlled
when using this "hardware circuit"?

This patchset only tries to change the content of the ocr_mask, but
there is no logic added to support changing voltage levels by using
the "external circuit". At least to my understanding.

Kind regards
Uffe
