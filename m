From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v2 0/2] Move sdhci-s3c platform helper into driver
Date: Wed, 21 Sep 2011 16:25:06 +0530
Message-ID: <CAJuYYwQmHbPZiAgD95g5gsMKAy9=vdx2K4d9f55uaogvKTn0yg@mail.gmail.com>
References: <1315984158-29651-1-git-send-email-thomas.abraham@linaro.org>
	<002401cc784c$61e2c180$25a84480$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44264 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763Ab1IUKzH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Sep 2011 06:55:07 -0400
In-Reply-To: <002401cc784c$61e2c180$25a84480$%kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org

On 21 September 2011 16:21, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Thomas Abraham wrote:
>>
>> Changes since v1:
>> - Rebased with 'for-next' branch of
>> =A0 http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsu=
ng.git
>> =A0 (tested with commit id a08b7e19811181309da2306338027fe1d3f8001d =
at the
>> =A0 tip of the for-next branch, not sure if there have been further
>> =A0 commits after that).
>>
>> The platform helper that sets up the default sdhci-s3c controller
>> configuration can be removed and moved into the sdhci-s3c driver.
>> This platform helper is removed for s3c2416, s3c64xx, s5pc100,
>> s5pv210 and Exynos4 platforms.
>>
>> Since the platform helper function pointer was being passed in the
>> platform data of sdhci-s3c driver, the removal of this pointer from
>> the platform data is step closer to complete device tree support for
>> sdhci-s3c driver.
>>
>> This patchset has been tested on the following platforms.
>> SMDK2416, SMDK6410, SMDKC100, SMDKV210 and SMDKV310.
>
> Oh, I found :)
> Looks ok to me, will apply.

Thank you Mr. Kim.

Regards,
Thomas

[...]
