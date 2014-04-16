From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Set ocr_avail directly based on vmmc
Date: Wed, 16 Apr 2014 09:20:57 +0200
Message-ID: <CAPDyKFp+xTbLtMip847wn1XM_ZJNix_TgQ6Psjq4RrB9=CWThw@mail.gmail.com>
References: <1397172708-19735-1-git-send-email-tim.kryger@linaro.org>
	<CAPDyKFrFyBLtL6dVgFy6DkY0gdCjiVpk1OhsfUXD0nhajCetxg@mail.gmail.com>
	<CAAYSxho=S5TqSU4uOiSuH-yh-O6tQxbKEzCn6ow=PLDBKPiSpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:53669 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738AbaDPHU5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Apr 2014 03:20:57 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so11722862qcx.27
        for <linux-mmc@vger.kernel.org>; Wed, 16 Apr 2014 00:20:57 -0700 (PDT)
In-Reply-To: <CAAYSxho=S5TqSU4uOiSuH-yh-O6tQxbKEzCn6ow=PLDBKPiSpQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tim Kryger <tim.kryger@linaro.org>
Cc: Chris Ball <chris@printf.net>, Linux MMC Mailing List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 15 April 2014 19:09, Tim Kryger <tim.kryger@linaro.org> wrote:
> On Fri, Apr 11, 2014 at 1:15 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> I have seen some patches around lately touching the code for handling
>> the regulators (vcc and vccq) in sdhci.
>
> Was it this patch you were thinking of or something else?
>
> http://www.spinics.net/lists/linux-mmc/msg25640.html

Yes, that's one of them. I am not sure I remember correct, but I think
there were patches for converting to devm_* API as well.

>
>> A few times I have suggested to switch to use the
>> mmc_regulator_get_supply() API to simplify and consolidate code. Could
>> you please have a look at that?
>
> This function will solve my problem but it also suggests that SDHCI
> drivers should use the vmmc/vqmmc pointers in the mmc_host struct
> rather than the ones in the sdhci_host struct.
>
> Is this your intent?  Do you want to see the regulator pointers in the
> sdhci_host struct removed once all drivers are modified to use the
> mmc_host ones?

Correct. That will consolidate code!

Then if sdhci has some special needs for regulators, let's first see
if we can adopt the API to handle it, before we decide to put that
code in sdhci driver.

Kind regards
Uffe

>
> -Tim
