From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V6 00/15] mmc: host: Add facility to support re-tuning
Date: Mon, 4 May 2015 15:13:36 +0200
Message-ID: <CAPDyKFrEqec_ZQxTaBTvgZVpS=oy+wTLCDb_CkXmzpeV4B3=ag@mail.gmail.com>
References: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
	<55474C5F.5070902@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:34036 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbbEDNNh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 May 2015 09:13:37 -0400
Received: by qcyk17 with SMTP id k17so71215127qcy.1
        for <linux-mmc@vger.kernel.org>; Mon, 04 May 2015 06:13:37 -0700 (PDT)
In-Reply-To: <55474C5F.5070902@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 4 May 2015 at 12:39, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 20/04/15 15:09, Adrian Hunter wrote:
>> Hi
>>
>> Here is V6 of some patches to move re-tuning support
>> out of sdhci and into the core, and add support for HS400
>> re-tuning.
>>
>> Currently sdhci does re-tuning transparently by
>> calling sdhci_execute_tuning() from its ->request()
>> function.
>>
>> The problem with HS400 re-tuning is that it must be
>> done in HS200 mode. That means using switch commands
>> and making ios changes. That means it potentially
>> conflicts with other command sequences. The new
>> re-tuning support accomodates that.
>>
>
> Hi
>
> I sent a V7 of patch 2, and a couple of patches that fix the
> brcm custom sleep re-tuning issue. So is there anything else
> that needs to be done?

I am looking through v6/7, I found that there are a few things that I
think you need to address. I will comment on them separately per
patch.

Kind regards
Uffe
