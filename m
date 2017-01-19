From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH v10 0/8] Cavium MMC driver
Date: Thu, 19 Jan 2017 09:47:33 -0800
Message-ID: <0f721117-24aa-cb69-56fe-0a48f9012852@caviumnetworks.com>
References: <20161219121552.18316-1-jglauber@cavium.com>
 <CAPDyKFqXDt9zBphrSPqMpbzBJsj1zECGBb5DugOEj1eLs9-xPQ@mail.gmail.com>
 <20170119145041.GA11757@hardcore>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam02on0044.outbound.protection.outlook.com ([104.47.36.44]:48254
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753526AbdASRrj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Jan 2017 12:47:39 -0500
In-Reply-To: <20170119145041.GA11757@hardcore>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Steven J . Hill" <Steven.Hill@cavium.com>

On 01/19/2017 06:50 AM, Jan Glauber wrote:
[...]
>
>> 4) GPIO powers should be modelled as GPIO regulators. I believe we
>> have discussed this earlier as well (I don't really recall in detail
>> about the last things). It gives us the opportunity to via the
>> regulator framework to find out the supported voltage levels. This is
>> the generic method which is used by mmc drivers, you need to adopt to
>> this as well.
>
> I've added a fixed regulator to DT:
>
>         vcc_3v3: regulator-vcc_3v3 {
>                 compatible = "regulator-fixed";
>                 regulator-name = "VCC_3V3";


Very minor point not really directly related to the MMC driver: 
"VCC_3V3" implies a general purpose supply for many things on the board. 
  This is not the case for these boards.  The "regulator" controls power 
only to eMMC and SD devices, so a name that conveys that function should 
be invented.

Actually on some boards GPIO 8 doesn't even control a regulator, but 
instead only activates a bus isolator on the control and data signals to 
the eMMC and SD devices.  In this case we would be using the regulator 
framework only because the code is already there and it happens to work, 
not because we actually have a regulator.

>                 regulator-min-microvolt = <3300000>;
>                 regulator-max-microvolt = <3300000>;
>
>                 gpio = <&gpio_6_0 8 0>;
>                 /* enable-gpio = <&gpio_6_0 8 0>; */
>                 enable-active-high;
>         };
>
> This seems to enable the gpio. Is this sufficient or do I need the
> gpio-regulator?
>

Does the "regulator-fixed" allow us to properly turn it on and off?

If not, we may have to switch to "gpio-regulator".  Which ever is 
simplest should be used.

[...]
