From: Matt Ranostay <matt@ranostay.consulting>
Subject: Re: [PATCH 3/4] mmc: pwrseq-simple: allow inverting of off state logic
Date: Thu, 1 Dec 2016 23:28:25 -0800
Message-ID: <313A249C-2BB9-487E-AF75-02ADB8AE83CC@ranostay.consulting>
References: <1480659462-29536-1-git-send-email-matt@ranostay.consulting> <1480659462-29536-4-git-send-email-matt@ranostay.consulting> <CAPDyKFrYVL52N22JVDA3wiWLAwUhht+6-=fi9kbGA8DYu=zPiA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35077 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbcLBH21 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2016 02:28:27 -0500
Received: by mail-pg0-f48.google.com with SMTP id p66so104651838pga.2
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2016 23:28:27 -0800 (PST)
In-Reply-To: <CAPDyKFrYVL52N22JVDA3wiWLAwUhht+6-=fi9kbGA8DYu=zPiA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>





Sent from my iPhone
> On Dec 1, 2016, at 22:57, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>=20
>> On 2 December 2016 at 07:17, Matt Ranostay <matt@ranostay.consulting> wro=
te:
>> Some devices need a logic level low instead of high to be in the
>> off state.
>>=20
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> ---
>> .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt         |  2 ++
>> drivers/mmc/core/pwrseq_simple.c                          | 15 ++++++++++=
+----
>> 2 files changed, 13 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b=
/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
>> index 703a714201d8..bea306d772d1 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
>> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
>> @@ -22,6 +22,8 @@ Optional properties:
>>        the reset-gpios (if any) are asserted
>> - post-power-on-delay-ms : Delay in ms after powering the card and
>>        de-asserting the reset-gpios (if any)
>> +- invert-off-state: Invert the power down state for the reset-gpios (if a=
ny)
>> +       and pwrdn-gpios (if any)
>=20
> We already have DT bindings to describe GPIO pins as active high or
> low. I think we should be able to use that instead, don't you think?

Ah issue is we are using inverse logic in the power down from anything else.=
 But I guess we could read the gpios active high and low stats from device t=
ree and deduce it from that

>=20
> [...]
>=20
> Kind regards
> Uffe
