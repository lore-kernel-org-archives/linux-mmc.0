From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH] mmc: core: debugfs: Add signal_voltage to ios dump
Date: Fri, 26 Oct 2012 13:27:11 +0200
Message-ID: <CA+20K0D2H__UR8kN7RvMt612c2g-JmR8MB7_45YXoNqHcv8owA@mail.gmail.com>
References: <1351243915-30190-1-git-send-email-johan.rudholm@stericsson.com>
	<C5E82048-310E-414C-A772-F05862041AD5@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61918 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336Ab2JZL1M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Oct 2012 07:27:12 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3559310iea.19
        for <linux-mmc@vger.kernel.org>; Fri, 26 Oct 2012 04:27:11 -0700 (PDT)
In-Reply-To: <C5E82048-310E-414C-A772-F05862041AD5@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@nvidia.com>
Cc: Johan Rudholm <johan.rudholm@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>

Hi,

2012/10/26 Philip Rakity <prakity@nvidia.com>:
>
> On Oct 26, 2012, at 11:31 AM, Johan Rudholm <johan.rudholm@stericsson.com> wrote:
>
>> +     default:
>> +             str = "invalid";
>
> would "is unknown"  be a better str ?

Maybe... Actually, I just followed the standard in the function, all
other strings default to "invalid" when the definition is missing. So
if I change this, then I should also change the rest of the strings in
the function. I will do this if we think it's worth the effort, but is
it?

Kind regards, Johan
