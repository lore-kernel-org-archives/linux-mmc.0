From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: vmmc & vqmmc O2 Micro SD Host Controller
Date: Thu, 27 Aug 2015 16:54:53 +0200
Message-ID: <CAPDyKFrYOKmW5wbOEvrXy1MB+kqMstj9n66fgGhfyyoEKyxy7Q@mail.gmail.com>
References: <CAHhAz+iG82ocsT_jzKDxN4LjQpuE4LKgXi22g0Lgzb6O93Wm9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34541 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbbH0Oyz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2015 10:54:55 -0400
Received: by widdq5 with SMTP id dq5so80677235wid.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2015 07:54:53 -0700 (PDT)
In-Reply-To: <CAHhAz+iG82ocsT_jzKDxN4LjQpuE4LKgXi22g0Lgzb6O93Wm9g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 17 August 2015 at 09:31, Muni Sekhar <munisekharrms@gmail.com> wrote:
> Hi,
>
>
> I need to test the O2 Micro SD Host Controller.
>  Once the driver is loaded, I see the following two power structs
> kernel messages.
>
>  [    2.159972] mmc0: no vqmmc regulator found
>  [    2.159975] mmc0: no vmmc regulator found
>
> I would like to know about vmmc & vqmmc, what are these? Is it okay to
> ignore these messages?

Those regulators are optional. You should be able to cope without them
for your controller/driver.

Kind regards
Uffe
