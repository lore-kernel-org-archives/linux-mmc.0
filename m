From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v13 2/2] ARM: sunxi: Add driver for SD/MMC hosts found on
 Allwinner sunxi SoCs
Date: Wed, 14 May 2014 14:03:14 +0200
Message-ID: <CAPDyKFrq=v1SU0+rC5_tCJ1D5jUOd3vwLXpxgpzB9X5NQd-deg@mail.gmail.com>
References: <1399896288-5826-1-git-send-email-hdegoede@redhat.com>
	<1399896288-5826-3-git-send-email-hdegoede@redhat.com>
	<5370C5D1.2070901@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:58005 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbaENMDP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 May 2014 08:03:15 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so2614359qcx.27
        for <linux-mmc@vger.kernel.org>; Wed, 14 May 2014 05:03:14 -0700 (PDT)
In-Reply-To: <5370C5D1.2070901@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chris Ball <chris@printf.net>, Arend van Spriel <arend@broadcom.com>, Mike Turquette <mturquette@linaro.org>, devicetree <devicetree@vger.kernel.org>, Emilio Lopez <emilio@elopez.com.ar>, linux-mmc <linux-mmc@vger.kernel.org>, linux-sunxi@googlegroups.com, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 12 May 2014 15:00, Arend van Spriel <arend@broadcom.com> wrote:
> On 05/12/2014 02:04 PM, Hans de Goede wrote:
>>
>> From: David Lanzend=C3=B6rfer<david.lanzendoerfer@o2s.ch>
>>
>> The Allwinner sunxi mmc host uses dma in bus-master mode using a bui=
lt-in
>> designware idmac controller, which is identical to the one found in =
the
>> mmc-dw
>> hosts. However the rest of the host is not identical to mmc-dw, it d=
eals
>> with
>> sending stop commands in hardware which makes it significantly diffe=
rent
>> from the mmc-dw devices.
>>
>> HdG: Various cleanups and fixes.
>
>
> Just nitpicking, but usually the above line should be added below the
> original signoff, so:
>
>> Signed-off-by: David Lanzend=C3=B6rfer<david.lanzendoerfer@o2s.ch>
>
> [hdegoede@redhat.com: various cleanups and fixes]
>
>> Signed-off-by: Hans de Goede<hdegoede@redhat.com>
>
>
> As is documented in SubmittingPatches.
>
> Gr. AvS


This looks good to me, thanks Hans!

I will include this in the next PR I send to Chris, I will also take
the liberty to fixup the commit msg as pointed out by Arend.

Kind regards
Ulf Hansson
