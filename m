From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Set SDHCI_POWER_ON with external vmmc
Date: Tue, 10 Feb 2015 17:53:29 +0900
Message-ID: <CAAVeFu+Qnwyrz+_xn4E3c4TBrct_7+5cGsijRqOb+BAmd+FQrQ@mail.gmail.com>
References: <1421216652-348-1-git-send-email-tim.kryger@gmail.com> <CAPDyKFpM_iqteu5pP03-iD2pji6ypeZJ1TA=LON1FVjJWrJk-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:48618 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096AbbBJIxu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Feb 2015 03:53:50 -0500
In-Reply-To: <CAPDyKFpM_iqteu5pP03-iD2pji6ypeZJ1TA=LON1FVjJWrJk-g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tim Kryger <tim.kryger@gmail.com>, Chris Ball <chris@printf.net>, Sachin Kamat <spk.linux@gmail.com>, Linux MMC List <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Wed, Jan 14, 2015 at 5:53 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> + linux-mmc
>
> On 14 January 2015 at 07:24, Tim Kryger <tim.kryger@gmail.com> wrote:
>> Host controllers lacking the required internal vmmc regulator may still
>> follow the spec with regard to the LSB of SDHCI_POWER_CONTROL.  Set the
>> SDHCI_POWER_ON bit when vmmc is enabled to encourage the controller to
>> to drive CMD, DAT, SDCLK.
>>
>> This fixes a regression observed on some Qualcomm and Nvidia boards
>> caused by 5222161 mmc: sdhci: Improve external VDD regulator support.
>>
>> Signed-off-by: Tim Kryger <tim.kryger@gmail.com>
>> Tested-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>
> Thanks! Applied for fixes.
>
> I noticed this wasn't posted to linux-mmc. I am anyway picking it up
> as this change has already been discussed and tested, see:
> https://lkml.org/lkml/2014/11/3/1029

The party is probably over for this patch, but FWIW:

Tested-by: Alexandre Courbot <acourbot@nvidia.com>
