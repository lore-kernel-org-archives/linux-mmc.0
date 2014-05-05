From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v10 15/15] ARM: dts: sun7i: Add basic support for the
 Cubietruck WiFi module
Date: Mon, 5 May 2014 12:20:56 +0800
Message-ID: <CAGb2v65egbY5-ZeioLuoTatQ_y6iQ9n=auiiCRNAvTEj1z59hA@mail.gmail.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
 <1399046249-19472-16-git-send-email-hdegoede@redhat.com> <20140505040212.GC11606@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:37788 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbaEEEVR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 May 2014 00:21:17 -0400
In-Reply-To: <20140505040212.GC11606@lukather>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>

On Mon, May 5, 2014 at 12:02 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, May 02, 2014 at 05:57:29PM +0200, Hans de Goede wrote:
>> From: Chen-Yu Tsai <wens@csie.org>
>>
>> The CubieTruck has an AMPAK AP6210 WiFi+Bluetooth module. The WiFi
>> part is a BCM43362 IC connected to MMC3 in the A20 SoC via SDIO.
>> The IC also takes a power enable signal via GPIO.
>>
>> The WiFi module supports out-of-band interrupt signaling via GPIO,
>> but this is not supported in this patch.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> It doesn't have Chen-Yu SoB. Chen-Yu, are you fine with adding it?

My apologies, I didn't notice this patch still had my name on it.
Looks good.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
(or Acked-by, not sure which applies in this situation.)

> No need to respin the set, I'll add it when applying if it's ok.

Thanks!


Cheers,
ChenYu
