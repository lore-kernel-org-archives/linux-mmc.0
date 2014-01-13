From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Fstrim fails on raspberry pi / SD-card
Date: Mon, 13 Jan 2014 11:02:38 +0100
Message-ID: <CAPDyKFrMYQkSvsiUeyN9FUPg4WOs=Fu1frVFvA9MkoyZzD+r=A@mail.gmail.com>
References: <CAFvQSYSG-JBqpgs_YjS6JmP-u-tkEH-4QXcRVPr2TaRhorSBJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f41.google.com ([209.85.128.41]:59802 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbaAMKCj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2014 05:02:39 -0500
Received: by mail-qe0-f41.google.com with SMTP id gh4so6923038qeb.28
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2014 02:02:38 -0800 (PST)
In-Reply-To: <CAFvQSYSG-JBqpgs_YjS6JmP-u-tkEH-4QXcRVPr2TaRhorSBJA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Clemens Eisserer <linuxhippy@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 10 January 2014 21:18, Clemens Eisserer <linuxhippy@gmail.com> wrote:
> Hi,
>
> I've read several reports of raspberry pi users which were able to
> perform batch discards on their SD cards by invoking the "fstrim"
> command, which in turn should be translated to an ERASE command
> (cmd23). I found out some patches where commited to linux-mmc which
> implement this functionality arround linux-2.6.36.
>
> However, all I get on my raspberry (as well as on my laptop) when
> running fstrim is:
>> root@raspberrypi:~# fstrim -v p2/
>> fstrim: mountp2/: FITRIM ioctl failed: Operation not supported
>
> Has this functionality been disabled intentionally, or is it likely an
> issue with the SD card or the driver?
> In case this is hw specific, how can I find out the cause it is disabled?

Have the mmc host driver setup MMC_CAP_ERASE? That is needed,
otherwise the block queue wont be supporting DISCARD operations.

Kind regards
Ulf Hansson

>
> Thank you in advance, Clemens
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
