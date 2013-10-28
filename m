From: Yuvaraj Kumar <yuvaraj.cd@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: exynos: Revert the sdr_timing assignment
Date: Mon, 28 Oct 2013 10:48:10 +0530
Message-ID: <CAKuRcOKti_ET=9gXGH-Jm8=TYnxag5Cu+wBZ9Hr8nMk=JDiKqA@mail.gmail.com>
References: <1382433116-22180-1-git-send-email-yuvaraj.cd@samsung.com>
	<871u37l9p0.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:65282 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab3J1FSL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Oct 2013 01:18:11 -0400
Received: by mail-qa0-f42.google.com with SMTP id w8so1837943qac.8
        for <linux-mmc@vger.kernel.org>; Sun, 27 Oct 2013 22:18:11 -0700 (PDT)
In-Reply-To: <871u37l9p0.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, thomas.ab@samsung.com, Grant Grundler <grundler@chromium.org>, Doug Anderson <dianders@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

On Sun, Oct 27, 2013 at 8:08 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Yuvaraj,
>
> On Tue, Oct 22 2013, Yuvaraj Kumar C D wrote:
>> commit 4ad602c9df1e3b04979c260b5612141b4b892257 was wrongly assigning
>> ddr_timing value to sdr_timing.This patch fix's this by reverting
>> the sdr_timing assignment statement to the earlier location.
>
> 4ad602c9df1e3 doesn't exist in mainline.  Do you mean e6c784eded7b3
> ("mmc: dw_mmc: exynos: move the exynos private init")?
Yes Chris, thats the one.
Do you want me to respin this patch with the updated commit message?
>
> Thanks,
>
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
