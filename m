From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH 0/2] mmc: core: pre-patch for next eMMC version
Date: Wed, 29 Aug 2012 20:59:32 +0900
Message-ID: <CAH9JG2XwdBao=L3KOxDOtbyhcTuq6rKUEpwWU9+zqhU3HeteQw@mail.gmail.com>
References: <5036C96A.7070300@samsung.com>
	<CAPDyKFqJynoS5d3EmnRi4CxmUyOMYBRzy2spDgUTfT=7+0Xg6Q@mail.gmail.com>
	<503C4A01.2030200@samsung.com>
	<CAPDyKFo0mwkbiQEc8cmPRu9AbB8mUQhuq4AWq=e03fUD1dfKHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:52978 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab2H2L7d (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Aug 2012 07:59:33 -0400
Received: by qcro28 with SMTP id o28so272644qcr.19
        for <linux-mmc@vger.kernel.org>; Wed, 29 Aug 2012 04:59:32 -0700 (PDT)
In-Reply-To: <CAPDyKFo0mwkbiQEc8cmPRu9AbB8mUQhuq4AWq=e03fUD1dfKHg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

Hi Ulf,

On 8/29/12, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Hi Jaehoon,
>
> On 28 August 2012 06:33, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi Ulf,
>>
>> This patch is to support eMMC5.0.(already discussing on eMMC5.0.)
>> Revision value is defined the 0x7 into ext_csd register.(in eMMC5.0's
>> case)
>
> Until the spec is really set we should not add some new code for this,
> it does not make sense to kind of guess.
It's not guess. it's determined and will be discussed at JEDEC soon.

Revision 1.7 (for MMC V5.0)

Thank you,
Kyungmin Park
>
>>
>> And case of Quirks is preparation patch to prevent the problem that should
>> exist.
>> That Quirks can also use for backward compatibility.
>> (if card is greater version than eMMC4.5 and need to use only eMMC4.5
>> feature?
>>  then can use quirks and known_rev.)
>
> It is just speculations about potential problems with eMMC 5.0. I
> think we can leave this to later, if/when we see a need for it.
>
> Kind regards
> Ulf Hansson
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
