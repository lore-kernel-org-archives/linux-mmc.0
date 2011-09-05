From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 2/2] arm: samsung: remove sdhci default configuration
 setup platform helper
Date: Mon, 5 Sep 2011 15:43:08 +0530
Message-ID: <CAJuYYwT1tW0XEiwWWpX08OorZw2q2Wce2r0fUvxLmWC8uq6uhQ@mail.gmail.com>
References: <1314976702-19284-1-git-send-email-thomas.abraham@linaro.org>
	<1314976702-19284-2-git-send-email-thomas.abraham@linaro.org>
	<1314976702-19284-3-git-send-email-thomas.abraham@linaro.org>
	<001801cc6b8a$e953bda0$bbfb38e0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <001801cc6b8a$e953bda0$bbfb38e0$%kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

Dear Mr. Kim,

On 5 September 2011 10:46, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Thomas Abraham wrote:
>>
>> The sdhci platform helper function that sets up the default controll=
er
>> configuration is removed for all Samsung platforms since such defaul=
t
>> controller configuration can be handled by the driver.
>>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> =A0arch/arm/mach-exynos4/setup-sdhci.c =A0 =A0 =A0 =A0| =A0 47 -----=
------------------
>> =A0arch/arm/mach-s3c2416/setup-sdhci.c =A0 =A0 =A0 =A0| =A0 37 -----=
-------------
>> =A0arch/arm/mach-s3c64xx/setup-sdhci.c =A0 =A0 =A0 =A0| =A0 48 -----=
------------------
>> =A0arch/arm/mach-s5pc100/setup-sdhci.c =A0 =A0 =A0 =A0| =A0 42 -----=
---------------
>> =A0arch/arm/mach-s5pv210/setup-sdhci.c =A0 =A0 =A0 =A0| =A0 41 -----=
---------------
>> =A0arch/arm/plat-samsung/dev-hsmmc.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 -
>> =A0arch/arm/plat-samsung/dev-hsmmc1.c =A0 =A0 =A0 =A0 | =A0 =A02 -
>> =A0arch/arm/plat-samsung/dev-hsmmc2.c =A0 =A0 =A0 =A0 | =A0 =A02 -
>> =A0arch/arm/plat-samsung/dev-hsmmc3.c =A0 =A0 =A0 =A0 | =A0 =A02 -
>> =A0arch/arm/plat-samsung/include/plat/sdhci.h | =A0 57
> ----------------------------
>> =A010 files changed, 0 insertions(+), 280 deletions(-)
>>

[...]

>
> Hi Thomas,
>
> The arch/arm/plat-samsung/dev-hsmmcX.c files have been changed due to=
 commit
> 61e62fcb ("ARM: SAMSUNG: Consolidate common function to set SDHCI pla=
t
> data"). So if possible please make your patch based on latest my for-=
next :)

Sure. I will base these patches on your for-next, test and resubmit.

Thanks,
Thomas.

>
> If any problems, please let me know.
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
