From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmc_spi: Add Card Detect comments and fix CD GPIO case
Date: Wed, 16 Mar 2016 13:34:51 +0100
Message-ID: <CAPDyKFoDmXVXaULKA4nXgZgK--aBLiMkQxFxFsBBczm2fqWdXQ@mail.gmail.com>
References: <20160216040641.31979.6202.sendpatchset@little-apple>
	<CAPDyKFo-+OWq1S7jD+j8e8fBOgL3A7igtp_rG5qFBwjgJF5U9A@mail.gmail.com>
	<CAPDyKFrKGnvFgDS_jwHAE3Jb36Vkp0JaexOVb_8KF1HVi+8OvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37054 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbcCPMew (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 08:34:52 -0400
Received: by mail-wm0-f47.google.com with SMTP id p65so70323667wmp.0
        for <linux-mmc@vger.kernel.org>; Wed, 16 Mar 2016 05:34:51 -0700 (PDT)
In-Reply-To: <CAPDyKFrKGnvFgDS_jwHAE3Jb36Vkp0JaexOVb_8KF1HVi+8OvA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Esben Haabendal <eha@doredevelopment.dk>, Adrian Hunter <adrian.hunter@intel.com>

On 4 March 2016 at 10:41, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 3 March 2016 at 16:28, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 16 February 2016 at 05:06, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> From: Magnus Damm <damm+renesas@opensource.se>
>>>
>>> This patch adds comments to describe the various ways card detection
>>> may be implemented and when polling is needed. Also a fix is included
>>> to prevent the MMC SPI driver from polling when a CD GPIO that supports
>>> interrupts is specified using the gpios DT property (case 1).
>>>
>>> Without this patch the DT node below results in the following output:
>>>
>>>  spi_gpio: spi-gpio { /* SD2 @ CN12 */
>>>          compatible = "spi-gpio";
>>>          #address-cells = <1>;
>>>          #size-cells = <0>;
>>>          gpio-sck = <&gpio6 16 GPIO_ACTIVE_HIGH>;
>>>          gpio-mosi = <&gpio6 17 GPIO_ACTIVE_HIGH>;
>>>          gpio-miso = <&gpio6 18 GPIO_ACTIVE_HIGH>;
>>>          num-chipselects = <1>;
>>>          cs-gpios = <&gpio6 21 GPIO_ACTIVE_LOW>;
>>>          status = "okay";
>>>
>>>          spi@0 {
>>>                  compatible = "mmc-spi-slot";
>>>                  reg = <0>;
>>>                  voltage-ranges = <3200 3400>;
>>>                  spi-max-frequency = <25000000>;
>>>                  gpios = <&gpio6 22 GPIO_ACTIVE_LOW>;   /* CD */
>>>          };
>>>  };
>>>
>>>  # dmesg | grep mmc
>>>  mmc_spi spi32766.0: SD/MMC host mmc0, no WP, no poweroff, cd polling
>>>  mmc0: host does not support reading read-only switch, assuming write-enable
>>>  mmc0: new SDHC card on SPI
>>>  mmcblk0: mmc0:0000 SU04G 3.69 GiB
>>>  mmcblk0: p1
>>>
>>>  With this patch applied the "cd polling" portion above disappears.
>>>
>>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>>
>> This looks good to me. Although do you think we need this for @stable as well?
>
> Ehh, as I am soon will be travelling and wanted this to be tested in
> linux next, I took the liberty to remove the comments, updated the
> change log and applied a stable tag.
>
> If think the comments are useful, please send a separate patch on top.
>
> So applied for fixes! Please have a look to make sure I looks okay to you.

Unfortunate I failed to send this in a PR to Linus within the 4.5 rc
cycle, apologize for the inconvenience!
Instead I have this queued for 4.6 and I have added a stable tag to it.

[...]

Kind regards
Uffe
