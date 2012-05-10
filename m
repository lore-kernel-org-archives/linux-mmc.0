From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 4/7] mmc: dw_mmc: add samsung exynos5250 specific extentions
Date: Thu, 10 May 2012 16:25:59 +0530
Message-ID: <CAJuYYwQsOpDWzsNnnJuNYvD+ag6qO5bTOBt52AYV7V2u9bv9bQ@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
	<1335935266-25289-5-git-send-email-thomas.abraham@linaro.org>
	<CAOesGMiJrfCgLHmBix1WUrpF-0D9tG5r6xi-3zsiM7KQjkO=ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60192 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932170Ab2EJKz7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 May 2012 06:55:59 -0400
Received: by vbbff1 with SMTP id ff1so1355109vbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 03:55:59 -0700 (PDT)
In-Reply-To: <CAOesGMiJrfCgLHmBix1WUrpF-0D9tG5r6xi-3zsiM7KQjkO=ug@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, kgene.kim@samsung.com, cjb@laptop.org, linux-arm-kernel@lists.infradead.org

On 2 May 2012 23:40, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Tue, May 1, 2012 at 10:07 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>> The instantiation of the Synopsis Designware controller on Exynos525=
0
>> include extension for SDR and DDR specific tx/rx phase shift timing
>> and CIU internal divider. In addition to that, the option to skip th=
e
>> command hold stage is also introduced. Add support for these Exynos5=
250
>> specfic extenstions.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> =A0.../devicetree/bindings/mmc/synposis-dw-mshc.txt =A0 | =A0 33 +++=
++++++++++++++++-
>> =A0drivers/mmc/host/dw_mmc-pltfm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A08 +++++
>> =A0drivers/mmc/host/dw_mmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0 32 ++++++++++++++++++-
>> =A0drivers/mmc/host/dw_mmc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0 13 ++++++++
>> =A0include/linux/mmc/dw_mmc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A06 +++
>> =A05 files changed, 89 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.=
txt b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
>> index c1ed70e..465fc31 100644
>> --- a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
>> @@ -7,6 +7,8 @@ Required Properties:
>>
>> =A0* compatible: should be one of the following
>> =A0 =A0 =A0 =A0- synopsis,dw-mshc: for controllers compliant with sy=
nopsis dw-mshc.
>> + =A0 =A0 =A0 - synopsis,dw-mshc-exynos5250: for controllers with Sa=
msung
>> + =A0 =A0 =A0 =A0 Exynos5250 specific extentions.
>
> It makes more sense to use your own manufacturer prefix here:
>
> samsung,exynos5250-dw-mshc
>

Ok. I will modify the compatible value as you have suggested.

Thanks,
Thomas.

>
> -Olof
