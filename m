From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 1/3] mmc: sdhci-s3c: Add support for device tree based probe
Date: Sun, 17 Jul 2011 09:24:59 +0530
Message-ID: <CAJuYYwR8KSFPbn1SzGKekprHB1AGOPFezpkqw4qyw34U29A5vg@mail.gmail.com>
References: <1310730128-4243-1-git-send-email-thomas.abraham@linaro.org>
	<1310730128-4243-2-git-send-email-thomas.abraham@linaro.org>
	<20110715185145.GE2833@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:57242 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab1GQDzA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Jul 2011 23:55:00 -0400
Received: by qyk29 with SMTP id 29so991380qyk.19
        for <linux-mmc@vger.kernel.org>; Sat, 16 Jul 2011 20:54:59 -0700 (PDT)
In-Reply-To: <20110715185145.GE2833@ponder.secretlab.ca>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org

Hi Grant,

Thanks for reviewing the patches. I have done all the changes as you
have suggested and I will submit the v2 patches next.

On 16 July 2011 00:21, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, Jul 15, 2011 at 05:12:06PM +0530, Thomas Abraham wrote:
>> Add of_match_table to enable sdhci-s3c driver to be probed when a co=
mpatible
>> sdhci device node is found in device tree.
>>
>> CC: linux-mmc@vger.kernel.org
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> =A0.../devicetree/bindings/mmc/samsung-s3c-sdhci.txt =A0| =A0 10 +++=
+++++++
>> =A0drivers/mmc/host/sdhci-s3c.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 11 +++++++++++
>> =A02 files changed, 21 insertions(+), 0 deletions(-)
>> =A0create mode 100644 Documentation/devicetree/bindings/mmc/samsung-=
s3c-sdhci.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/samsung-s3c-sdhci=
=2Etxt b/Documentation/devicetree/bindings/mmc/samsung-s3c-sdhci.txt
>> new file mode 100644
>> index 0000000..c2298f8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/samsung-s3c-sdhci.txt
>> @@ -0,0 +1,10 @@
>> +* Samsung's SDHCI controller
>> +
>> +The Samsung's SDHCI controller is used for interfacing with SD/MMC =
cards.
>> +
>> +Required properties:
>> +- compatible : should be "samsung,s3c-sdhci"
>> +- reg : base physical address of the controller and length of memor=
y mapped
>> + =A0 =A0 region.
>> +- interrupts : interrupt number to the cpu.
>> +
>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s=
3c.c
>> index 69e3ee3..5ccbee0 100644
>> --- a/drivers/mmc/host/sdhci-s3c.c
>> +++ b/drivers/mmc/host/sdhci-s3c.c
>> @@ -629,6 +629,16 @@ static int sdhci_s3c_resume(struct platform_dev=
ice *dev)
>> =A0#define sdhci_s3c_resume NULL
>> =A0#endif
>>
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id s3c_sdhci_match[] =3D {
>> + =A0 =A0 { .compatible =3D "samsung,s3c-sdhci" },
>
> Be specific. =A0samsung,exynos4210-sdhci. =A0Newer chips can claim
> compatibility with the older one.

This is changed to "samsung,s3c6410-sdhci" since that is the base
version of all sdhci controllers in Samsung SoC's.

Thanks,
Thomas.

>
> Otherwise,
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
>> + =A0 =A0 {},
>> +};
>> +MODULE_DEVICE_TABLE(of, s3c_sdhci_match);
>> +#else
>> +#define s3c_sdhci_match NULL
>> +#endif
>> +
>> =A0static struct platform_driver sdhci_s3c_driver =3D {
>> =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D sdhci_s3c_probe,
>> =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(sdhci_s3c_remove=
),
>> @@ -637,6 +647,7 @@ static struct platform_driver sdhci_s3c_driver =3D=
 {
>> =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "s3c-sdhci",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D s3c_sdhci_match,
>> =A0 =A0 =A0 },
>> =A0};
>>
>> --
>> 1.7.1
>>
>
