From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/2] dt: bindings: Add binding for ESP8089 wifi chips
Date: Mon, 8 Aug 2016 11:59:25 +0800
Message-ID: <CAGb2v67+QrOxPd4KeLb9F67A0mSaBqn14PynzCyK=ovRnKA6EQ@mail.gmail.com>
References: <1470596269-20572-1-git-send-email-hdegoede@redhat.com>
 <1470596269-20572-2-git-send-email-hdegoede@redhat.com> <2936779.FAiO1bqUWV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:40066 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcHHD7w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Aug 2016 23:59:52 -0400
In-Reply-To: <2936779.FAiO1bqUWV@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Icenowy Zheng <icenowy@aosc.xyz>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>

Hi Arnd,

On Mon, Aug 8, 2016 at 3:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday, August 7, 2016 8:57:49 PM CEST Hans de Goede wrote:
>> +Espressif ESP8089 wireless SDIO devices
>> +
>> +This node provides properties for controlling the ESP8089 wireless device.
>> +The node is expected to be specified as a child node to the SDIO controller
>> +that connects the device to the system.
>> +
>> +Required properties:
>> +
>> + - compatible : Should be "esp,esp8089".
>
> I think it would be good to standardize a compatible string for sdio
> like we have it for other discoverable buses, based on the
> vendor/device ID (or whatever this uses), using something like
>
> compatible = "sdio1234,5678", "esp,esp8089";

Is there a central repository for SDIO vendor/device IDs similar to
PCI or USB IDs?

The vendor ID Espressif uses is 0x6666, which seems kind of bogus to me.

ChenYu

>
>> +Optional properties:
>> + - esp,crystal_26M_en: Integer value for the crystal_26M_en firmware parameter
>
> better use '-' instead of '_' for property names.
>
>         Arnd
>
>
