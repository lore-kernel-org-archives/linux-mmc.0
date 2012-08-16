From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: Add device tree support
Date: Thu, 16 Aug 2012 22:09:31 +0530
Message-ID: <CAJuYYwQ-LgR0vGKDbgKujtxrGkz6ajH_7QhpZ=LvQJ1NMJXDRQ@mail.gmail.com>
References: <CAJuYYwQjN9UtXcfjNXf1Ezw3igfUSQDNEP8X038L4=br6EROUA@mail.gmail.com>
	<1345134914-21635-1-git-send-email-thomas.abraham@linaro.org>
	<87k3wydcl7.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51466 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752474Ab2HPQjd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Aug 2012 12:39:33 -0400
Received: by lagy9 with SMTP id y9so1576793lag.19
        for <linux-mmc@vger.kernel.org>; Thu, 16 Aug 2012 09:39:31 -0700 (PDT)
In-Reply-To: <87k3wydcl7.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org

On 16 August 2012 21:59, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Thu, Aug 16 2012, Thomas Abraham wrote:
>> Add device tree based discovery support for Samsung's sdhci controller
>>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Cc: Chris Ball <cjb@laptop.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> Changes since v3:
>>
>> The patch series that adds device tree support for Samsung sdhci controller
>> had six patches in total, of which, the first five patches have been accepted.
>> The sixth patch in the series was dropped since it was using custom Samsung
>> properties for descrbing the bus-width and card-detect gpio, but had otherwise
>> addressed all the comments.
>>
>> This patch reworks the sixth patch in v3 of the sdhci device tree support
>> patch series. The only change in this patch from the v3 version is the use of
>> generic mmc bindings for descrbing the bus-width and card-detect gpio.
>>
>>  .../devicetree/bindings/mmc/samsung-sdhci.txt      |   51 +++++++
>>  drivers/mmc/host/sdhci-s3c.c                       |  146 +++++++++++++++++++-
>>  2 files changed, 191 insertions(+), 6 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt b/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
>> new file mode 100644
>> index 0000000..398540b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
>> @@ -0,0 +1,51 @@
>> +* Samsung's SDHCI Controller device tree bindings
>> +
>> +Samsung's SDHCI controller is used as a connectivity interface with external
>> +MMC, SD and eMMC storage mediums. This file documents differences between the
>> +core mmc properties described by mmc.txt and the properties used by the
>> +Samsung implmentation of the SDHCI controller.
>> +
>> +Required SoC Specific Properties:
>> +- compatible: should be one of the following
>> +  - "samsung,s3c6410-sdhci": For controllers compatible with s3c6410 sdhci
>> +    controller.
>> +  - "samsung,exynos4210-sdhci": For controllers compatible with Exynos4 sdhci
>> +    controller.
>> +
>> +Required Board Specific Properties:
>> +- gpios: Should specify the gpios used for clock, command and data lines. The
>> +  gpio specifier format depends on the gpio controller.
>> +
>> +Optional Board Specific Properties:
>> +- One of the following properties for card detect type.
>> +  - samsung,sdhci-cd-internal: Card detect line from the card slot  is
>> +    connected to the card detect pad of the sdhci controller. A gpio is
>> +    used for this connection (with possible pin function settings).
>> +  - samsung,sdhci-cd-gpio: A gpio line (with possible pin function settings)
>> +    is used a card detect line. This gpio line is not connected to card detect
>> +    pad of the sdhci controller.
>> +  - samsung,sdhci-cd-none: There is no card detect line. Polling is used to
>> +    detect the presence of the card. (DEFAULT, if no card detect property
>> +    is specified).
>> +  - samsung,sdhci-cd-permanent: There is no card detect line. The card is
>> +    permanently connected to the sdhci controller.
>> +
>> +Example:
>> +     sdhci@12530000 {
>> +             compatible = "samsung,exynos4210-sdhci";
>> +             reg = <0x12530000 0x100>;
>> +             interrupts = <<0 75 0>;
>> +             bus-width = <4>;
>> +             samsung,sdhci-cd-internal;
>> +             cd-gpios = <&gpk2 2 2 3 3>;
>> +             gpios = <&gpk2 0 2 0 3>,  /* clock line */
>> +                     <&gpk2 1 2 0 3>,  /* command line */
>> +                     <&gpk2 3 2 3 3>,  /* data line 0 */
>> +                     <&gpk2 4 2 3 3>,  /* data line 1 */
>> +                     <&gpk2 5 2 3 3>,  /* data line 2 */
>> +                     <&gpk2 6 2 3 3>;  /* data line 3 */
>> +     };
>> +
>> +     Note: This example shows both SoC specific and board specific properties
>> +     in a single device node. The properties can be actually be seperated
>> +     into SoC specific node and board specific node.
>
> Looks good, except the text file doesn't mention anywhere that it describes
> the bindings used by sdhci-s3c.c -- that could be useful information to
> someone reading the binding and trying to discover which driver uses it.
>
> Maybe we can call the text file "sdhci-s3c.txt"?  Or "samsung,sdhci-s3c.txt"
> if you prefer.

Hi Chris,

The assumption here was that the all the binding documentation have to
be generic enough to be useful for non-linux platforms as well. And
there were previous discussions on actually moving the binding
documentation outside of the linux source and maintained separately.

Hence, the text file states that it describes the bindings used by
Samsung's SDHCI controller. If you prefer, I can resubmit this patch
with samsung,sdhci-s3c.txt as the file name for the bindings
documentation file.

Thanks,
Thomas.

>
> Thanks,
>
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
