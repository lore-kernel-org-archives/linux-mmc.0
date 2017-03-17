From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: meson-gx-mmc: 2nd patch set
Date: Fri, 17 Mar 2017 07:44:53 +0100
Message-ID: <b5e36943-ba83-e73e-7df7-d6967aff5886@gmail.com>
References: <d1f4c34c-799c-c76c-4ad8-5c0060f9c71f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34313 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdCQGpI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Mar 2017 02:45:08 -0400
Received: by mail-wr0-f174.google.com with SMTP id l37so45799381wrc.1
        for <linux-mmc@vger.kernel.org>; Thu, 16 Mar 2017 23:45:07 -0700 (PDT)
In-Reply-To: <d1f4c34c-799c-c76c-4ad8-5c0060f9c71f@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Helmut Klein <hgkr.klein@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Am 16.03.2017 um 22:12 schrieb Helmut Klein:
> Hallo Heiner,
> 
> i applied your 2nd patch sets to linux-amlogic. (and of course the older set v5 1...10).
> 
> The performance of the sd-card and the mmc-chip of my minimx is much better now.
> 
> sd-card: from 6.5 to 22.5 MBytes/s
> mmc: from 14.5 to 28.5 MBytes/s (hs200 compatible device)
> 
> But:
> the wifi-adapter is no longer operational. The problem starts with patch 3 and gets worse with patch 5.
> 
> the adapter (ap6330) is attached to the sdio port of the the s905. (=mmc1)
> 
Thanks for testing and sharing the feedback. Much appreciated.
The board I test on supports block devices only.

Could you please share few more details:
- Drivers involved
- All syslog messages related to the device / driver

And please set the relevant mailing lists on cc when providing test feedback.
Others might find your feedback helpful too.

Thanks, Heiner

> so i think it is important to test your patch set asap on an officially supported board with a wifi adapter).
> 
> regards
> Helmut
> 

