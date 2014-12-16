From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: Possible regression with commit 52221610d
Date: Mon, 15 Dec 2014 22:27:52 -0800
Message-ID: <CAJAp7Oh+ziadeEDWsus_k_2w33vPJxGGcGZyMNQkpLemf7SAhg@mail.gmail.com>
References: <54584260.8030602@nvidia.com>
	<CAD7vxxKb668Y0hpYRhwMjQnNrDCQMzn=XGtLEU+ZAtY=OFjHLg@mail.gmail.com>
	<545895B2.2000101@nvidia.com>
	<CAD7vxxLmLsRpxrYqc30nV0m6atO7jyNgv1Wh4R8GCAy3+y-1dw@mail.gmail.com>
	<CAJAp7OgmrEX1XQcwvwf4jzW3eK9TUgde2MQQOp7fOJzvmO=tCQ@mail.gmail.com>
	<CAD7vxxJaCdKiG9h_32OUSUkQMQk6AAwi6d0v01KEnSVTF8cN1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:49557 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbaLPG1x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Dec 2014 01:27:53 -0500
Received: by mail-la0-f46.google.com with SMTP id q1so10728521lam.19
        for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2014 22:27:52 -0800 (PST)
In-Reply-To: <CAD7vxxJaCdKiG9h_32OUSUkQMQk6AAwi6d0v01KEnSVTF8cN1w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Sachin Kamat <spk.linux@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>

On Sun, Dec 14, 2014 at 8:48 PM, Tim Kryger <tim.kryger@gmail.com> wrote:
> On Sat, Dec 13, 2014 at 11:22 PM, Bjorn Andersson <bjorn@kryo.se> wrote:
[..]
>> Or simply; what is vmmc (in the code) supposed to represent?
>
> Hi Bjorn,
>
> VMMC is the supply that delivers power out to the SD card itself (aka VDD).
>
> It is not the internal power rail/power domain of the host controller
> within the SoC.
>

Thanks for you answer Tim, I'll write up a patch for the Qualcomm
driver that add the possibility of specifying an internal supply for
the devices where that uses that.

My only concern is that for any standard compliant sdhci driver we're
supposed to have a info printout that vmmc was not found (but vqmmc is
there). But I guess that's a matter of proper documentation and hoping
people don't pay too much attention to it?

Regards,
Bjorn
