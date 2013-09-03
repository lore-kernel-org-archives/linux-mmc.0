From: Nitin Singla <nitin.akshainie@gmail.com>
Subject: Re: [PATCH] mmc: enable BKOPS for supported eMMC(4.41)
Date: Tue, 3 Sep 2013 15:04:38 +0530
Message-ID: <CAOprVPLx1NR37YJOYzXSkQ7w70o5kWp0dbKdn0OzCr_0B7TkUQ@mail.gmail.com>
References: <loom.20130830T140917-496@post.gmane.org>
	<52242F31.4030103@samsung.com>
	<loom.20130903T105514-341@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:49806 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313Ab3ICJek (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2013 05:34:40 -0400
Received: by mail-lb0-f181.google.com with SMTP id u14so4794380lbd.12
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2013 02:34:38 -0700 (PDT)
In-Reply-To: <loom.20130903T105514-341@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi Prasanna,

MMC-Utils open source utility for enabling and disabling features.
It use ioctl defined in block/card to send commands to host.
git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git

Thanks,
Nitin

On Tue, Sep 3, 2013 at 2:28 PM, Prasanna NAVARATNA
<prasanna.navaratna@gmail.com> wrote:
> Hello Jaehoon,
>
>> Why do you use MMC_CAP2_BKOPS_EN?
> Because BKOPS on eMMC4.41 is optional. So the capability is provided for the
> platform to either enable/disable this feature (its not mandatory to always
> enable BKOPS on 4.41)
>
>> Maybe we had discussed about this point. i know that we can enable the
> BKOPS with the mmc-util.
>> (Actually, This code had included into my first patch. but it's removed.)
> I'm not aware of this discussion and currently I'm running on eMMC4.41 and
> bkops is supported but not enabled. So i suggested this patch.
> Do you mean to say, right now, i can enable it using mmc-utils?
> Will you please elaborate?
>
> Thanks,
> Prasanna
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
