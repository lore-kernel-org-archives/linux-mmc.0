From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Fstrim fails on raspberry pi / SD-card
Date: Wed, 15 Jan 2014 11:20:09 +0100
Message-ID: <CAPDyKFp26f-2p4+ce1+wh1WXH9knJK+ZjTnnu2ai=3vyMQecpg@mail.gmail.com>
References: <CAFvQSYSG-JBqpgs_YjS6JmP-u-tkEH-4QXcRVPr2TaRhorSBJA@mail.gmail.com>
	<CAPDyKFrMYQkSvsiUeyN9FUPg4WOs=Fu1frVFvA9MkoyZzD+r=A@mail.gmail.com>
	<CAFvQSYT8fDApmhxr2mSXS53dYVp9Aw7dc2=z77T_gCd+YBGqhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:38779 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbaAOKUJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 05:20:09 -0500
Received: by mail-qe0-f46.google.com with SMTP id 8so797901qea.5
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2014 02:20:09 -0800 (PST)
In-Reply-To: <CAFvQSYT8fDApmhxr2mSXS53dYVp9Aw7dc2=z77T_gCd+YBGqhA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Clemens Eisserer <linuxhippy@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 15 January 2014 09:50, Clemens Eisserer <linuxhippy@gmail.com> wrote:
> Hi Ulf,
>
>> Have the mmc host driver setup MMC_CAP_ERASE? That is needed,
>> otherwise the block queue wont be supporting DISCARD operations.
>
> Thanks a lot for your reply. Indeed it seems MMC_CAP_ERASE is not
> supported by the raspberry pi driver.
> Just to be curious: Is the erease command also supported on SD cards
> or only on eMMC?

Both SD cards and eMMC supports it.

Kind regards
Ulf Hansson

>
> Thanks, Clemens
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
