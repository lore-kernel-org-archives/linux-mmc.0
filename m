Return-Path: <SRS0=nQxR=4B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ADAC352A3
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 22:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0774621734
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 22:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8RISYd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgBMWOV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:14:21 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:36028 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMWOV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2020 17:14:21 -0500
Received: by mail-io1-f52.google.com with SMTP id d15so8369082iog.3
        for <linux-mmc@vger.kernel.org>; Thu, 13 Feb 2020 14:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C8clzNXcFBjg9TF/KNQ1s91WSlBbLttUW2klOOZow5Y=;
        b=H8RISYd2xIq+1xk1nzJQiESTaUXHyc4c0AL4eSsjU34dYZL61HfKpyeiSTLnxMzxFt
         ygA50FBAN6b3PuXK4bW6g4C/2/DLgyExxbL6UY/YxyasQ2c29Dn57widYu1YDjae9sMw
         4PIhGyS40kUYkOzQInMJzTE3Nzo4Nes4mCQxXTZFJFER8Isfi6614nr7ruQtfAcXJSml
         En2lYwwUTSV72dHX6VIilWSpu/SHOnnjjOTvQAn7TwmmsKy7UEEioLo5YgYpBb3qAZyQ
         7TVSCKu14epurfXvdZoRwFIIgXABGZcSSmlAMbluGEBkvtMy6wfIE9+bokS4Jo7UWxjc
         CA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C8clzNXcFBjg9TF/KNQ1s91WSlBbLttUW2klOOZow5Y=;
        b=GioHxuBUVLHKbTt93Sa4TJbVrvMXR+42SnE95NgpkvsokCAulywLWcIhQ+EVYL9LsG
         T8TUeybG5NWZvTDcSsAsBb2PSzsaz2jO1kf7Z93eXC6qCLrCfCIbhc/Zlyb20Q1xjKdx
         7ShaqmfQF7B81x4CbsHN1xNO7Nx+o0/7IBoqIgPJ6vN/1vusrmY/ergI432gWxL4PtXA
         i0zuDXQSM+QzZ72B7ysenxxY95e0biHkgmQ7Hc5DVapVPVNMTUw+J67Z0GfxxU/Cz9xW
         YOanmQ76koH6QAIzHrV8rwc3FLaOC1npG3e+ZnV+UOEBGvfPdSU40KOM3WXoPeaBinrH
         05wQ==
X-Gm-Message-State: APjAAAXHpWO3YUADNExkinBoJ4SqyXnusZ64HrZxA8ORCMgDqYxZHZPi
        SAMybxZ5bh49CbS2iysjk+9YCZRw1LLK3Zt6GhDLmA==
X-Google-Smtp-Source: APXvYqx5KE6I/x9kgOUxEdtHIWEJqBrnixKe0gZ0TiDfx0cmlLbdnWe5wyPLK4fJ0C9fyoZjjpbUOQWflXTAfXfy76A=
X-Received: by 2002:a05:6602:22d6:: with SMTP id e22mr23998994ioe.41.1581632060885;
 Thu, 13 Feb 2020 14:14:20 -0800 (PST)
MIME-Version: 1.0
References: <CAEg67GnNdOBgq=gVH9fDTwT0-KM5+3g8Do5ZnW+y6Q0AY_302A@mail.gmail.com>
 <MN2PR04MB6991B0F4431E56BA0C64927AFC1A0@MN2PR04MB6991.namprd04.prod.outlook.com>
In-Reply-To: <MN2PR04MB6991B0F4431E56BA0C64927AFC1A0@MN2PR04MB6991.namprd04.prod.outlook.com>
From:   Patrick Oppenlander <patrick.oppenlander@gmail.com>
Date:   Fri, 14 Feb 2020 09:14:10 +1100
Message-ID: <CAEg67GkTpaV9hbTx3Yt1EcXsPGwavwMiCw9ArM+qq5P0sE6bPg@mail.gmail.com>
Subject: Re: mmc-utils mmc tool reports incorrect cache size
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Avri,

I have resent the patch. Hopefully it looks better now.

Thanks for the reference,

Patrick

On Thu, Feb 13, 2020 at 6:35 PM Avri Altman <Avri.Altman@wdc.com> wrote:
>
> Patrick hi,
> Yes, it is helpful, but you need to submit your patch in a way it can be reviewed.
> Maybe you can look in https://www.kernel.org/doc/html/v5.5/process/5.Posting.html?highlight=submit%20patches#
> For more info.
>
> Thanks,
> Avri
>
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org <linux-mmc-
> > owner@vger.kernel.org> On Behalf Of Patrick Oppenlander
> > Sent: Wednesday, February 12, 2020 11:35 PM
> > To: linux-mmc@vger.kernel.org
> > Subject: mmc-utils mmc tool reports incorrect cache size
> >
> > CAUTION: This email originated from outside of Western Digital. Do not click
> > on links or open attachments unless you recognize the sender and know that
> > the content is safe.
> >
> >
> > Hi,
> >
> > I recently noticed that 'mmc' reports cache size incorrectly. The unit
> > in the extended CSD is kilobits rather than kilobytes, so for a
> > display unit of 'KiB' it needs to be scaled appropriately.
> > Alternatively the unit could change to Kibit, but I think that's less
> > helpful.
> >
> > I've attached a patch which fixes the issue & includes references to
> > the relevant parts of the JEDEC standard.
> >
> > Hope someone finds this helpful,
> >
> > Patrick
