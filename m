From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 6/6] mmc: sdhci-s3c: Add device tree support
Date: Thu, 5 Jan 2012 21:15:12 +0530
Message-ID: <CAJuYYwTMpde-528t=vQnbkJv_gG7xuOr05b1K-+H-RxYRX0iEQ@mail.gmail.com>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
	<1320266163-15292-7-git-send-email-thomas.abraham@linaro.org>
	<20111107211726.GC28491@ponder.secretlab.ca>
	<CAJuYYwSfC5t6xs-TDT2wBOj1RbQYSpH0wjo9uBcYf7bGyi0t9g@mail.gmail.com>
	<4F047235.2090503@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37005 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755374Ab2AEPpN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jan 2012 10:45:13 -0500
In-Reply-To: <4F047235.2090503@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: kgene.kim@samsung.com, Grant Likely <grant.likely@secretlab.ca>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org

Hi Sylwester,

On 4 January 2012 21:07, Sylwester Nawrocki <s.nawrocki@samsung.com> wr=
ote:
> Hi Kgene, Thomas
>
> On 11/08/2011 04:23 PM, Thomas Abraham wrote:
>> Hi Grant,
>>
>> On 8 November 2011 02:47, Grant Likely <grant.likely@secretlab.ca> w=
rote:
>>> On Thu, Nov 03, 2011 at 02:06:03AM +0530, Thomas Abraham wrote:
>>>> Add device tree based discovery support for Samsung's sdhci contro=
ller
>>>>
>>>> Cc: Ben Dooks <ben-linux@fluff.org>
>>>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>>>> ---
>>>> +Example:
>>>> + =A0 =A0 sdhci@12530000 {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "samsung,exynos4210-sdhci=
";
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x12530000 0x100>;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <139>;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 samsung,sdhci-bus-width =3D <4>;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 linux,mmc_cap_4_bit_data;
>>>
>>> Following on from my reply on patch 5, this is an example of exactl=
y
>>> what I'm talking about. =A0This node both sets bus-width to '4', an=
d
>>> sets the 4_bit_data flag. =A0Don't you think that the driver would =
be
>>> smart enough to set the 4_bit_data flag when the bus width was set =
to
>>> 4?
>>
>> Yes, that is true. I will modify the driver based on your comments a=
nd
>> resubmit this patch.
>
> Are we going to have those patches in 3.3-rc1 or only in 3.4 ?

Sorry for the delaying in completing this patchset. I will redo this
patchset and submit it soon. But 3.3-rc1 looks unlikely.

Thanks,
Thomas.

>
> --
> Regards,
> Sylwester
