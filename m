From: Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>
Subject: Re: Seeking correct git repo
Date: Thu, 26 Jun 2014 09:08:38 +0800
Message-ID: <CAC1bqKhcnQET-WH-UTRLNj-QoiiZVFF0r=XCB9rNCFTYoMtW8w@mail.gmail.com>
References: <53AB22F9.40503@webtuner.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33827 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757251AbaFZBIk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jun 2014 21:08:40 -0400
Received: by mail-wi0-f179.google.com with SMTP id cc10so146222wib.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2014 18:08:38 -0700 (PDT)
In-Reply-To: <53AB22F9.40503@webtuner.tv>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Derek Simkowiak <derek@webtuner.tv>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

I have the same question too.

I think we can't get a patch from Linux stable, which isn't accepted
by community.

I used a hard way to get a relative patch which i want by copy source
code from URL and recompile...

Best Regards,
Hsinhsiang

2014-06-26 3:28 GMT+08:00 Derek Simkowiak <derek@webtuner.tv>:
>      Hello,
> A while ago, Romain wrote a small eMMC 5.0 patch that Ulf ack'd:
>
> http://comments.gmane.org/gmane.linux.kernel.mmc/23795
>
> I need this patch for my hardware.  But I don't see this patch in Linux
> stable (even though there are more recent patches from Seungwon Jeon in
> there), and I don't see it at the MMC repo either:
>
> $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git
>
> # Where's the patch? I checked all branches...
>
> $ git branch -a
> * master
>   remotes/origin/HEAD -> origin/master
>   remotes/origin/master
>   remotes/origin/mmc-next
>   remotes/origin/mmc-updates-for-3.16-rc1-merged
>
>
> Can you please tell me, what is the repo and branch where this patch was
> submitted?  The only reference I have to this patch is the email archive at
> the URL above.
>
>
> Thank You,
> Derek
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
