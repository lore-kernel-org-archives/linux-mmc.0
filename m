From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: Fix check for mmc dt node
Date: Tue, 17 Apr 2012 16:05:29 +0530
Message-ID: <CAJe_ZhcTedCeNW=Tq=ftf13+9daOgVfPZJ4DLu9_qOYXXo7jEg@mail.gmail.com>
References: <1334656449-12142-1-git-send-email-jaswinder.singh@linaro.org>
	<4F8D41E7.2050701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38009 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab2DQKfb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Apr 2012 06:35:31 -0400
Received: by lbom4 with SMTP id m4so1194056lbo.19
        for <linux-mmc@vger.kernel.org>; Tue, 17 Apr 2012 03:35:30 -0700 (PDT)
In-Reply-To: <4F8D41E7.2050701@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, cjb@laptop.org

On 17 April 2012 15:41, Rajendra Nayak <rnayak@ti.com> wrote:
> On Tuesday 17 April 2012 03:24 PM, Jassi Brar wrote:
>>
>> Proper check should be if the hsmmc driver got its platform_data
>> via devicetree, and not if the devicetree is populated for the
>> platform.
>
> This one is already fixed here..
> http://www.spinics.net/lists/linux-omap/msg67879.html
>
Your patch looks better.

-j
